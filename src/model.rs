use serde::{Deserialize, Serialize};

// enum for user role
pub enum Role {
    Admin,
    User,
    Guest,
}

// enum for asset status
pub enum AssetStatus {
    Active,
    Working,
    Broken,
    Repairing,
    Borrowed,
    Retired,
    Lost,
}

// enum for operation type
pub enum OperationType {
    Create,
    Update,
    Delete,
}

// enum for operation table
pub enum OperationTable {
    Laboratory,
    User,
    AssetCategory,
    AssetGroup,
    Label,
    FileInfo,
    AssetLocation,
    DeviceInfo,
    DeviceInventory,
    PartsInfo,
    PartsInventory,
    BorrowRecord,
    UserLoginLog,
    OperationLog,
}

// struct for laboratory
#[derive(Debug, Serialize, Deserialize)]
pub struct Laboratory {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for user account
#[derive(Debug, Serialize, Deserialize)]
pub struct User {
    pub id: uuid::Uuid,
    pub username: String,
    pub password: String, // password is encrypted into md5
    pub email: Option<String>,
    pub phone: Option<String>,
    pub role: Role,
    pub laboratory_id: Option<uuid::Uuid>,
    pub note: Option<String>,
    pub last_login: Option<chrono::NaiveDateTime>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for asset category
#[derive(Debug, Serialize, Deserialize)]
pub struct AssetCategory {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for asset group
#[derive(Debug, Serialize, Deserialize)]
pub struct AssetGroup {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for label
#[derive(Debug, Serialize, Deserialize)]
pub struct Label {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for file information
#[derive(Debug, Serialize, Deserialize)]
pub struct FileInfo {
    pub id: uuid::Uuid,
    pub name: String,
    pub path: String,
    pub size: u64,
    pub mime_type: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for asset location
#[derive(Debug, Serialize, Deserialize)]
pub struct AssetLocation {
    pub id: uuid::Uuid,
    pub name: String,
    pub sub_location: Option<serde_json::Value>,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for device information
#[derive(Debug, Serialize, Deserialize)]
pub struct DeviceInfo {
    pub id: uuid::Uuid,
    pub name: String,
    pub model: Option<String>,
    pub category_id: Option<uuid::Uuid>,
    pub group_id: Option<serde_json::Value>,
    pub label_id: Option<serde_json::Value>,
    pub web_url: Option<String>,
    pub note: Option<String>,
    pub cover_image_id: Option<uuid::Uuid>,
    pub resource: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for device inventory
#[derive(Debug, Serialize, Deserialize)]
pub struct DeviceInventory {
    pub id: uuid::Uuid,
    pub info_id: uuid::Uuid,
    pub serial_number: String,
    pub status: String,
    pub storage_location: Option<String>,
    pub current_location: Option<String>,
    pub purchase_date: Option<chrono::NaiveDate>,
    pub responsible_person_id: Option<uuid::Uuid>,
    pub label_id: Option<serde_json::Value>,
    pub note: Option<String>,
    pub resource: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for parts information
#[derive(Debug, Serialize, Deserialize)]
pub struct PartsInfo {
    pub id: uuid::Uuid,
    pub name: String,
    pub model: Option<String>,
    pub category_id: Option<uuid::Uuid>,
    pub group_id: Option<serde_json::Value>,
    pub label_id: Option<serde_json::Value>,
    pub web_url: Option<String>,
    pub note: Option<String>,
    pub cover_image_id: Option<uuid::Uuid>,
    pub resource: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for parts inventory
#[derive(Debug, Serialize, Deserialize)]
pub struct PartsInventory {
    pub id: uuid::Uuid,
    pub info_id: uuid::Uuid,
    pub status: Option<String>,
    pub count: Option<u32>,
    pub batch_number: Option<String>,
    pub storage_location: Option<String>,
    pub current_location: Option<String>,
    pub purchase_date: Option<chrono::NaiveDateTime>,
    pub responsible_person_id: Option<uuid::Uuid>,
    pub label_id: Option<serde_json::Value>,
    pub note: Option<String>,
    pub resource: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for borrow record
#[derive(Debug, Serialize, Deserialize)]
pub struct BorrowRecord {
    pub id: uuid::Uuid,
    pub asset_inventory_id: Option<uuid::Uuid>,
    pub asset_name: String,
    pub borrower_id: Option<uuid::Uuid>,
    pub borrower_name: String,
    pub contact: Option<String>,
    pub borrower_laboratory_id: Option<uuid::Uuid>,
    pub borrow_date: chrono::NaiveDateTime,
    pub expected_return_date: Option<chrono::NaiveDateTime>,
    pub return_date: Option<chrono::NaiveDateTime>,
    pub note: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for user login log
#[derive(Debug, Serialize, Deserialize)]
pub struct UserLoginLog {
    pub id: uuid::Uuid,
    pub user_id: Option<uuid::Uuid>,
    pub login_time: chrono::NaiveDateTime,
    pub login_ip: Option<String>,
    pub user_agent: Option<String>,
    pub note: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}

// struct for operation log
#[derive(Debug, Serialize, Deserialize)]
pub struct OperationLog {
    pub id: u64,
    pub user_id: uuid::Uuid,
    pub operation_type: OperationType,
    pub operation_table: OperationTable,
    pub value_before: Option<serde_json::Value>,
    pub value_after: Option<serde_json::Value>,
    pub operation_time: chrono::NaiveDateTime,
    pub operation_note: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: chrono::NaiveDateTime,
    pub active: bool,
}
