
-- ============================================================
--  AUTO REPAIR SHOP — TRIGGERS
--  Запускать после: 1_ddl.sql, 2_fk_rules.sql
--  Database: PostgreSQL
-- ============================================================

SET search_path TO public;


-- ============================================================
--  TRIGGER 1: Менеджер должен быть сотрудником своего филиала
-- ============================================================

CREATE OR REPLACE FUNCTION check_manager_branch()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.manager_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM employee
            WHERE id = NEW.manager_id AND branch_id = NEW.id
        ) THEN
            RAISE EXCEPTION
                'Менеджер (employee.id=%) не является сотрудником филиала (id=%)',
                NEW.manager_id, NEW.id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_manager_branch ON auto_repair_shop_branch;
CREATE TRIGGER trg_check_manager_branch
BEFORE INSERT OR UPDATE OF manager_id ON auto_repair_shop_branch
FOR EACH ROW EXECUTE FUNCTION check_manager_branch();


-- ============================================================
--  TRIGGER 2: Остаток на складе не может уйти в минус
-- ============================================================

CREATE OR REPLACE FUNCTION check_inventory_quantity()
RETURNS TRIGGER AS $$
DECLARE
    available INTEGER;
BEGIN
    SELECT quantity INTO available
    FROM inventory WHERE id = NEW.inventory_id;

    IF available < NEW.quantity THEN
        RAISE EXCEPTION
            'Недостаточно деталей на складе: доступно %, запрошено %',
            available, NEW.quantity;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_inventory_quantity ON detail_usage;
CREATE TRIGGER trg_check_inventory_quantity
BEFORE INSERT OR UPDATE OF quantity ON detail_usage
FOR EACH ROW EXECUTE FUNCTION check_inventory_quantity();


-- ============================================================
--  TRIGGER 3: Деталь в заказе должна быть у этого поставщика
-- ============================================================

CREATE OR REPLACE FUNCTION check_order_supplier()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM detail_supplier
        WHERE detail_id  = NEW.detail_id
          AND supplier_id = NEW.supplier_id
    ) THEN
        RAISE EXCEPTION
            'Поставщик (id=%) не поставляет деталь (id=%)',
            NEW.supplier_id, NEW.detail_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_order_supplier ON detail_order;
CREATE TRIGGER trg_check_order_supplier
BEFORE INSERT OR UPDATE OF detail_id, supplier_id ON detail_order
FOR EACH ROW EXECUTE FUNCTION check_order_supplier();


-- ============================================================
--  TRIGGER 4: Механик не может выполнять две услуги одновременно
-- ============================================================

CREATE OR REPLACE FUNCTION check_mechanic_schedule()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM execution
        WHERE mechanic_id = NEW.mechanic_id
          AND NOT (mechanic_id = NEW.mechanic_id AND service_id = NEW.service_id)
          AND NEW.date_start <= COALESCE(date_end, 'infinity'::DATE)
          AND COALESCE(NEW.date_end, 'infinity'::DATE) >= date_start
    ) THEN
        RAISE EXCEPTION
            'Механик (id=%) уже занят в указанный период',
            NEW.mechanic_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_mechanic_schedule ON execution;
CREATE TRIGGER trg_check_mechanic_schedule
BEFORE INSERT OR UPDATE OF date_start, date_end ON execution
FOR EACH ROW EXECUTE FUNCTION check_mechanic_schedule();


-- ============================================================
--  TRIGGER 5: Деталь должна быть совместима с моделью машины
-- ============================================================

CREATE OR REPLACE FUNCTION check_detail_compatibility()
RETURNS TRIGGER AS $$
DECLARE
    v_detail_id INTEGER;
    v_model_id  INTEGER;
BEGIN
    SELECT detail_id INTO v_detail_id
    FROM inventory WHERE id = NEW.inventory_id;

    SELECT v.model_id INTO v_model_id
    FROM service s
    JOIN work_order wo ON wo.id  = s.work_order_id
    JOIN request r     ON r.id   = wo.request_id
    JOIN vehicle v     ON v.VIN  = r.VIN
    WHERE s.id = NEW.service_id;

    IF NOT EXISTS (
        SELECT 1 FROM detail_compatibility
        WHERE detail_id = v_detail_id AND model_id = v_model_id
    ) THEN
        RAISE EXCEPTION
            'Деталь (id=%) несовместима с моделью автомобиля (id=%)',
            v_detail_id, v_model_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_detail_compatibility ON detail_usage;
CREATE TRIGGER trg_check_detail_compatibility
BEFORE INSERT OR UPDATE ON detail_usage
FOR EACH ROW EXECUTE FUNCTION check_detail_compatibility();


-- ============================================================
--  TRIGGER 6: Авто-расчёт total_amount при создании инвойса
-- ============================================================

CREATE OR REPLACE FUNCTION calculate_invoice_total()
RETURNS TRIGGER AS $$
BEGIN
    SELECT COALESCE(SUM(s.price), 0) INTO NEW.total_amount
    FROM work_order wo
    JOIN service s ON s.work_order_id = wo.id
    WHERE wo.request_id = NEW.request_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_calculate_invoice_total ON invoice;
CREATE TRIGGER trg_calculate_invoice_total
BEFORE INSERT ON invoice
FOR EACH ROW EXECUTE FUNCTION calculate_invoice_total();


-- ============================================================
--  TRIGGER 7: Оплата → пополняет бюджет и обновляет статус инвойса
-- ============================================================

CREATE OR REPLACE FUNCTION process_payment()
RETURNS TRIGGER AS $$
DECLARE
    v_branch_id INTEGER;
    v_total     NUMERIC(10, 2);
    v_paid      NUMERIC(10, 2);
BEGIN
    SELECT r.branch_id INTO v_branch_id
    FROM invoice i
    JOIN request r ON r.id = i.request_id
    WHERE i.id = NEW.invoice_id;

    INSERT INTO branch_budget (branch_id, balance)
    VALUES (v_branch_id, NEW.amount)
    ON CONFLICT (branch_id)
    DO UPDATE SET balance = branch_budget.balance + NEW.amount;

    SELECT i.total_amount,
           COALESCE(SUM(p.amount), 0) + NEW.amount
    INTO v_total, v_paid
    FROM invoice i
    LEFT JOIN payment p ON p.invoice_id = i.id
    WHERE i.id = NEW.invoice_id
    GROUP BY i.total_amount;

    IF v_paid >= v_total THEN
        UPDATE invoice SET status = 'paid' WHERE id = NEW.invoice_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_process_payment ON payment;
CREATE TRIGGER trg_process_payment
AFTER INSERT ON payment
FOR EACH ROW EXECUTE FUNCTION process_payment();


-- ============================================================
--  TRIGGER 8: Проверка бюджета при подтверждении заказа деталей
-- ============================================================

CREATE OR REPLACE FUNCTION check_budget_on_order()
RETURNS TRIGGER AS $$
DECLARE
    v_order_cost NUMERIC(10, 2);
    v_balance    NUMERIC(10, 2);
BEGIN
    IF NEW.status = 'confirmed'
       AND (OLD.status IS NULL OR OLD.status <> 'confirmed') THEN

        SELECT NEW.quantity * ds.unit_price INTO v_order_cost
        FROM detail_supplier ds
        WHERE ds.detail_id   = NEW.detail_id
          AND ds.supplier_id = NEW.supplier_id;

        SELECT COALESCE(balance, 0) INTO v_balance
        FROM branch_budget WHERE branch_id = NEW.branch_id;

        IF v_balance < v_order_cost THEN
            RAISE EXCEPTION
                'Недостаточно средств: баланс филиала %, стоимость заказа %',
                v_balance, v_order_cost;
        END IF;

        UPDATE branch_budget
        SET balance = balance - v_order_cost
        WHERE branch_id = NEW.branch_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_budget_on_order ON detail_order;
CREATE TRIGGER trg_check_budget_on_order
BEFORE UPDATE OF status ON detail_order
FOR EACH ROW EXECUTE FUNCTION check_budget_on_order();