-- Create database lims

CREATE TABLE IF NOT EXISTS laboratory (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS user (
    id UUID PRIMARY KEY,
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
    UNIQUE(username)
);

CREATE TABLE IF NOT EXISTS asset_category (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS asset_group (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS label (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS file_info (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    size BIGINT NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE(path)
);

CREATE TABLE device_info (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    category_id UUID REFERENCES asset_category(id),
    website_url TEXT,
    notes TEXT,
    documents JSON,
    image_urls JSON
);

-- Create device inventory table
CREATE TABLE device_inventory (
    id UUID PRIMARY KEY,
    device_id UUID REFERENCES device_info(id),
    serial_number VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    purchase_date DATE,
    storage_location VARCHAR(255),
    current_location VARCHAR(255),
    responsible_person VARCHAR(255),
    tags TEXT,
    notes TEXT,
    documents JSON,
    image_urls JSON
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
