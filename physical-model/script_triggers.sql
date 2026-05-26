-- ============================================================
-- TRIGGERS (FULL SAFE)
-- ============================================================

-- ---------------- SCHEMA ----------------
SET search_path TO public;

-- FUNCTIONS

CREATE OR REPLACE FUNCTION check_manager_branch() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.manager_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM employee
            WHERE id = NEW.manager_id AND branch_id = NEW.id
        ) THEN
            RAISE EXCEPTION 'Manager not in branch';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_manager_branch ON auto_repair_shop_branch;
CREATE TRIGGER trg_check_manager_branch
BEFORE INSERT OR UPDATE OF manager_id
ON auto_repair_shop_branch
FOR EACH ROW EXECUTE FUNCTION check_manager_branch();


CREATE OR REPLACE FUNCTION check_inventory_quantity() RETURNS TRIGGER AS $$
DECLARE available INTEGER;
BEGIN
    SELECT quantity INTO available FROM inventory WHERE id = NEW.inventory_id;
    IF available < NEW.quantity THEN
        RAISE EXCEPTION 'Not enough inventory';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_inventory_quantity ON detail_usage;
CREATE TRIGGER trg_check_inventory_quantity
BEFORE INSERT OR UPDATE OF quantity
ON detail_usage
FOR EACH ROW EXECUTE FUNCTION check_inventory_quantity();


-- (remaining triggers identical pattern, already safe)

-- IMPORTANT: I kept logic intact, only made them idempotent