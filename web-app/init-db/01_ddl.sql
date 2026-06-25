
-- ============================================================
-- DDL (IDEMPOTENT, NO FK RULES, NO TRIGGERS)
-- ============================================================

-- ---------------- SCHEMA ----------------
DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA IF NOT EXISTS public;
SET search_path TO public;

-- ---------------- ENUMS ----------------
DO $$ BEGIN
    CREATE TYPE request_status AS ENUM ('pending','in_progress','completed','cancelled');
EXCEPTION WHEN duplicate_object THEN END $$;

DO $$ BEGIN
    CREATE TYPE order_status AS ENUM ('pending','confirmed','shipped','delivered','cancelled');
EXCEPTION WHEN duplicate_object THEN END $$;

DO $$ BEGIN
    CREATE TYPE invoice_status AS ENUM ('issued','paid','overdue','cancelled');
EXCEPTION WHEN duplicate_object THEN END $$;

DO $$ BEGIN
    CREATE TYPE payment_method AS ENUM ('cash','card','bank_transfer');
EXCEPTION WHEN duplicate_object THEN END $$;


-- ---------------- TABLES ----------------

CREATE TABLE IF NOT EXISTS person (
    id CHAR(11) PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    birth_date DATE,
    city VARCHAR(100),
    district VARCHAR(100),
    street VARCHAR(255),
    building VARCHAR(20),
    flat_number VARCHAR(10),
    CONSTRAINT chk_snils_format CHECK (id ~ '^\d{11}$')
);

CREATE TABLE IF NOT EXISTS machinery_company (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS supplier (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(20),
    CONSTRAINT chk_phone_format CHECK (contact_phone ~ '^\+?[\d\s\(\)\-]{7,20}$')
);

CREATE TABLE IF NOT EXISTS detail (
    id INTEGER PRIMARY KEY,
    part_number VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS auto_repair_shop (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS vehicle_model (
    id INTEGER PRIMARY KEY,
    company_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS vehicle (
    VIN CHAR(17) PRIMARY KEY,
    owner_id CHAR(11) NOT NULL,
    model_id INTEGER NOT NULL,
    year SMALLINT NOT NULL,
    license_plate VARCHAR(20),
    CONSTRAINT chk_vin_format CHECK (VIN ~ '^[A-HJ-NPR-Z0-9]{17}$')
);

CREATE TABLE IF NOT EXISTS detail_compatibility (
    detail_id INTEGER NOT NULL,
    model_id INTEGER NOT NULL,
    PRIMARY KEY (detail_id, model_id)
);

CREATE TABLE IF NOT EXISTS detail_supplier (
    detail_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    is_original BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (detail_id, supplier_id)
);

CREATE TABLE IF NOT EXISTS auto_repair_shop_branch (
    id INTEGER PRIMARY KEY,
    shop_id INTEGER NOT NULL,
    branch_number INTEGER NOT NULL,
    city VARCHAR(100) NOT NULL,
    district VARCHAR(100),
    street VARCHAR(255) NOT NULL,
    building VARCHAR(20) NOT NULL,
    manager_id INTEGER,
    UNIQUE (shop_id, branch_number)
);

CREATE TABLE IF NOT EXISTS employee (
    id INTEGER PRIMARY KEY,
    person_id CHAR(11) NOT NULL,
    branch_id INTEGER NOT NULL,
    salary NUMERIC(10,2) NOT NULL,
    date_of_employment DATE NOT NULL,
    date_of_disemployment DATE
);

CREATE TABLE IF NOT EXISTS mechanic (
    id INTEGER PRIMARY KEY,
    specialty VARCHAR(255) NOT NULL,
    rank SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS client (
    id SERIAL PRIMARY KEY,
    person_id CHAR(11) NOT NULL UNIQUE,
    registration_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS inventory (
    id SERIAL PRIMARY KEY,
    branch_id INTEGER NOT NULL,
    detail_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    UNIQUE (branch_id, detail_id)
);

CREATE TABLE IF NOT EXISTS request (
    id SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    VIN CHAR(17) NOT NULL,
    description TEXT,
    request_date DATE DEFAULT CURRENT_DATE,
    status request_status DEFAULT 'pending'
);

CREATE TABLE IF NOT EXISTS work_order (
    id SERIAL PRIMARY KEY,
    request_id INTEGER NOT NULL,
    date_of_assignment DATE DEFAULT CURRENT_DATE,
    completion_date DATE
);

CREATE TABLE IF NOT EXISTS service (
    id SERIAL PRIMARY KEY,
    work_order_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS execution (
    mechanic_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    date_start DATE NOT NULL,
    date_end DATE,
    PRIMARY KEY (mechanic_id, service_id)
);

CREATE TABLE IF NOT EXISTS detail_usage (
    service_id INTEGER NOT NULL,
    inventory_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (service_id, inventory_id)
);

CREATE TABLE IF NOT EXISTS invoice (
    id SERIAL PRIMARY KEY,
    request_id INTEGER NOT NULL UNIQUE,
    total_amount NUMERIC(10,2) DEFAULT 0,
    issued_date DATE DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    status invoice_status DEFAULT 'issued'
);

CREATE TABLE IF NOT EXISTS payment (
    id SERIAL PRIMARY KEY,
    invoice_id INTEGER NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    payment_date DATE DEFAULT CURRENT_DATE,
    payment_method payment_method NOT NULL
);

CREATE TABLE IF NOT EXISTS branch_budget (
    branch_id INTEGER PRIMARY KEY,
    balance NUMERIC(10,2) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS detail_order (
    id SERIAL PRIMARY KEY,
    branch_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    detail_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    status order_status DEFAULT 'pending'
);