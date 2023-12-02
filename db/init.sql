-- Create database lims
CREATE EXTENSION "sequential-uuids";

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
    role VARCHAR(255) NOT NULL,
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

CREATE TABLE location {
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
    group_id UUID REFERENCES asset_category(id),
    label_id UUID REFERENCES label(id)
    web_url TEXT,
    note TEXT,
    couver_image_id UUID REFERENCES file_info(id),
    resource JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_device_info_name_model UNIQUE(name, model)
);

CREATE TABLE device_inventory (
    id UUID PRIMARY KEY DEFAULT uuid_time_nextval(),
    info_id UUID REFERENCES device_info(id),
    serial_number VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    storage_location UUID REFERENCES location(id),
    current_location UUID REFERENCES location(id),
    purchase_date DATE,
    responsible_person UUID REFERENCES user(id),
    label_id UUID REFERENCES label(id),
    note TEXT,
    resource JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT uk_device_inventory_info_id_serial_number UNIQUE(info_id, serial_number)
);

-- 创建零件信息表
CREATE TABLE parts_info (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    category_id UUID REFERENCES asset_category(id),
    website_url TEXT,
    notes TEXT,
    documents JSON,
    image_urls JSON
);

-- 创建零件库存表
CREATE TABLE parts_inventory (
    id UUID PRIMARY KEY,
    part_id UUID REFERENCES parts_info(id),
    status VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL,
    storage_location VARCHAR(255),
    current_location VARCHAR(255),
    responsible_person VARCHAR(255),
    tags TEXT,
    notes TEXT,
    documents JSON,
    image_urls JSON
);

-- 创建借出记录表
CREATE TABLE borrow_records (
    id UUID PRIMARY KEY,
    inventory_id UUID REFERENCES device_inventory(id) ON DELETE SET NULL,
    borrower_name VARCHAR(255) NOT NULL,
    borrow_date DATE NOT NULL,
    expected_return_date DATE,
    return_date DATE
);
