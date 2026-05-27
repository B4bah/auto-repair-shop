
-- ============================================================
-- FK RULES (FULL RESET SAFE)
-- ============================================================

-- ---------------- SCHEMA ----------------
SET search_path TO public;

-- PERSON relations
ALTER TABLE vehicle DROP CONSTRAINT IF EXISTS vehicle_owner_id_fkey;
ALTER TABLE vehicle ADD CONSTRAINT vehicle_owner_id_fkey
FOREIGN KEY (owner_id) REFERENCES person(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE client DROP CONSTRAINT IF EXISTS client_person_id_fkey;
ALTER TABLE client ADD CONSTRAINT client_person_id_fkey
FOREIGN KEY (person_id) REFERENCES person(id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE employee DROP CONSTRAINT IF EXISTS employee_person_id_fkey;
ALTER TABLE employee ADD CONSTRAINT employee_person_id_fkey
FOREIGN KEY (person_id) REFERENCES person(id)
ON DELETE CASCADE ON UPDATE CASCADE;

-- hierarchy
ALTER TABLE mechanic DROP CONSTRAINT IF EXISTS mechanic_id_fkey;
ALTER TABLE mechanic ADD CONSTRAINT mechanic_id_fkey
FOREIGN KEY (id) REFERENCES employee(id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE auto_repair_shop_branch DROP CONSTRAINT IF EXISTS auto_repair_shop_branch_manager_id_fkey;
ALTER TABLE auto_repair_shop_branch ADD CONSTRAINT auto_repair_shop_branch_manager_id_fkey
FOREIGN KEY (manager_id) REFERENCES employee(id)
ON DELETE SET NULL ON UPDATE CASCADE;

-- chain protection
ALTER TABLE request DROP CONSTRAINT IF EXISTS request_client_id_fkey;
ALTER TABLE request ADD CONSTRAINT request_client_id_fkey
FOREIGN KEY (client_id) REFERENCES client(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE request DROP CONSTRAINT IF EXISTS request_vin_fkey;
ALTER TABLE request ADD CONSTRAINT request_vin_fkey
FOREIGN KEY (VIN) REFERENCES vehicle(VIN)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE work_order DROP CONSTRAINT IF EXISTS work_order_request_id_fkey;
ALTER TABLE work_order ADD CONSTRAINT work_order_request_id_fkey
FOREIGN KEY (request_id) REFERENCES request(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE service DROP CONSTRAINT IF EXISTS service_work_order_id_fkey;
ALTER TABLE service ADD CONSTRAINT service_work_order_id_fkey
FOREIGN KEY (work_order_id) REFERENCES work_order(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE execution DROP CONSTRAINT IF EXISTS execution_mechanic_id_fkey;
ALTER TABLE execution ADD CONSTRAINT execution_mechanic_id_fkey
FOREIGN KEY (mechanic_id) REFERENCES mechanic(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE execution DROP CONSTRAINT IF EXISTS execution_service_id_fkey;
ALTER TABLE execution ADD CONSTRAINT execution_service_id_fkey
FOREIGN KEY (service_id) REFERENCES service(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE detail_usage DROP CONSTRAINT IF EXISTS detail_usage_service_id_fkey;
ALTER TABLE detail_usage ADD CONSTRAINT detail_usage_service_id_fkey
FOREIGN KEY (service_id) REFERENCES service(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- cascade refs
ALTER TABLE detail_supplier DROP CONSTRAINT IF EXISTS detail_supplier_detail_id_fkey;
ALTER TABLE detail_supplier ADD CONSTRAINT detail_supplier_detail_id_fkey
FOREIGN KEY (detail_id) REFERENCES detail(id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE detail_supplier DROP CONSTRAINT IF EXISTS detail_supplier_supplier_id_fkey;
ALTER TABLE detail_supplier ADD CONSTRAINT detail_supplier_supplier_id_fkey
FOREIGN KEY (supplier_id) REFERENCES supplier(id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE detail_compatibility DROP CONSTRAINT IF EXISTS detail_compatibility_detail_id_fkey;
ALTER TABLE detail_compatibility ADD CONSTRAINT detail_compatibility_detail_id_fkey
FOREIGN KEY (detail_id) REFERENCES detail(id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE detail_compatibility DROP CONSTRAINT IF EXISTS detail_compatibility_model_id_fkey;
ALTER TABLE detail_compatibility ADD CONSTRAINT detail_compatibility_model_id_fkey
FOREIGN KEY (model_id) REFERENCES vehicle_model(id)
ON DELETE CASCADE ON UPDATE CASCADE;

-- finance
ALTER TABLE invoice DROP CONSTRAINT IF EXISTS invoice_request_id_fkey;
ALTER TABLE invoice ADD CONSTRAINT invoice_request_id_fkey
FOREIGN KEY (request_id) REFERENCES request(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE payment DROP CONSTRAINT IF EXISTS payment_invoice_id_fkey;
ALTER TABLE payment ADD CONSTRAINT payment_invoice_id_fkey
FOREIGN KEY (invoice_id) REFERENCES invoice(id)
ON DELETE CASCADE ON UPDATE CASCADE;