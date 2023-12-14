-- Create database lims
CREATE EXTENSION "sequential-uuids";

CREATE TYPE user_role AS ENUM ('admin', 'user', 'guest');
CREATE TYPE asset_status AS ENUM ('active', 'working', 'broken', 'repairing', 'borrowed', 'retired', 'lost');
CREATE TYPE operation_type AS ENUM ('create', 'update', 'delete');
CREATE TYPE operation_table AS ENUM ('laboratory', 'user', 'asset_category', 'asset_group', 'label', 'file_info', 'asset_location', 'device_info', 'device_inventory', 'parts_info', 'parts_inventory', 'borrow_record', 'user_login_log', 'operation_log');

CREATE TABLE IF NOT EXISTS laboratory (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_laboratory_name UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS user (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(255),
    role user_role NOT NULL,
    laboratory_id UUID REFERENCES laboratory(id),
    notes TEXT,
    last_login TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_user_username UNIQUE(username)
);

CREATE TABLE IF NOT EXISTS asset_category (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_asset_category_name UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS asset_group (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_asset_group_name UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS label (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_label_name UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS file_info (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    size BIGINT NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_file_info_path UNIQUE(path)
);

CREATE TABLE IF NOT EXISTS asset_location {
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    sub_location JSON,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_location_name UNIQUE(name)
};

CREATE TABLE IF NOT EXISTS device_info (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255),
    category_id UUID REFERENCES asset_category(id),
    group_id JSON,
    label_id JSON,
    web_url TEXT,
    note TEXT,
    couver_image_id UUID REFERENCES file_info(id),
    resource JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_device_info_name_model UNIQUE(name, model)
);

CREATE TABLE IF NOT EXISTS device_inventory (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    info_id UUID REFERENCES device_info(id),
    serial_number VARCHAR(255) NOT NULL,
    status asset_status NOT NULL,
    storage_location UUID REFERENCES location(id),
    current_location UUID REFERENCES location(id),
    purchase_date DATE,
    responsible_person UUID REFERENCES user(id),
    label_id JSON,
    note TEXT,
    resource JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_device_inventory_info_id_serial_number UNIQUE(info_id, serial_number)
);

CREATE TABLE IF NOT EXISTS parts_info (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255),
    category_id UUID REFERENCES asset_category(id),
    group_id JSON,
    label_id JSON,
    web_url TEXT,
    note TEXT,
    couver_image_id UUID REFERENCES file_info(id),
    resource JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_parts_info_name_model UNIQUE(name, model)
);

CREATE TABLE IF NOT EXISTS parts_inventory (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    info_id UUID REFERENCES parts_info(id),
    status asset_status NOT NULL,
    count INTEGER,
    batch_number VARCHAR(255),
    storage_location UUID REFERENCES location(id),
    current_location UUID REFERENCES location(id),
    purchase_date DATE,
    responsible_person UUID REFERENCES user(id),
    label_id JSON,
    note TEXT,
    resource JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS borrow_record (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    asset_inventory_id UUID,
    asset_name VARCHAR(255) NOT NULL,
    borrower_id UUID REFERENCES user(id),
    borrower_name VARCHAR(255) NOT NULL,
    contact VARCHAR(255),
    borrower_laboratory_id UUID REFERENCES laboratory(id),
    borrow_date DATE NOT NULL,
    expected_return_date DATE,
    return_date DATE,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS user_login_log (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    user_id UUID REFERENCES user(id),
    login_time TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    login_ip VARCHAR(255),
    user_agent VARCHAR(255),
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_user_login_log_user_id_login_time UNIQUE(user_id, login_time)
);

CREATE TABLE IF NOT EXISTS operation_log (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID REFERENCES user(id),
    operation_type operation_type NOT NULL,
    operation_table operation_table NOT NULL,
    value_before JSON,
    value_after JSON,
    operation_time TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    operation_note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE
);