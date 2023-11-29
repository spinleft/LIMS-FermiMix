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

// struct for laboratory
#[derive(Debug, Serialize, Deserialize)]
pub struct Laboratory {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for user account
#[derive(Debug, Serialize, Deserialize)]
pub struct User {
    pub id: uuid::Uuid,
    pub username: String,
    pub password: String,   // password is encrypted into md5
    pub email: Option<String>,
    pub phone: Option<String>,
    pub role: String,
    pub laboratory_id: uuid::Uuid,
    pub note: Option<String>,
    pub last_login: Option<chrono::NaiveDateTime>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for asset category
#[derive(Debug, Serialize, Deserialize)]
pub struct AssetCategory {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for asset group
#[derive(Debug, Serialize, Deserialize)]
pub struct AssetGroup {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

pub struct Label {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for file information
#[derive(Debug, Serialize, Deserialize)]
pub struct FileInfo {
    pub id: uuid::Uuid,
    pub name: String,
    pub path: String,
    pub size: u64,
    pub mime_type: String,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for device information
#[derive(Debug, Serialize, Deserialize)]
pub struct DeviceInfo {
    pub id: uuid::Uuid,
    pub name: String,
    pub model: Option<String>,
    pub category_id: uuid::Uuid,
    pub group_id: uuid::Uuid,
    pub web_url: Option<String>,
    pub label_id: Option<serde_json::Value>,
    pub note: Option<String>,
    pub cover_image_id: Option<uuid::Uuid>,
    pub resource: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for device inventory
#[derive(Debug, Serialize, Deserialize)]
pub struct DeviceInventory {
    pub id: uuid::Uuid,
    pub device_info_id: uuid::Uuid,
    pub serial_number: Option<String>,
    pub status: Option<String>,
    pub storage_location: Option<String>,
    pub current_location: Option<String>,
    pub purchase_date: Option<chrono::NaiveDateTime>,
    pub responsible_person_id: Option<uuid::Uuid>,
    pub label_id: Option<serde_json::Value>,
    pub note: Option<String>,
    pub resource: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for material information
#[derive(Debug, Serialize, Deserialize)]
pub struct MaterialInfo {
    pub id: uuid::Uuid,
    pub name: String,
    pub model: Option<String>,
    pub category_id: uuid::Uuid,
    pub group_id: uuid::Uuid,
    pub web_url: Option<String>,
    pub label_id: Option<serde_json::Value>,
    pub note: Option<String>,
    pub cover_image_id: Option<uuid::Uuid>,
    pub resource: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for material inventory
#[derive(Debug, Serialize, Deserialize)]
pub struct MaterialInventory {
    pub id: uuid::Uuid,
    pub material_info_id: uuid::Uuid,
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
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for borrow record
#[derive(Debug, Serialize, Deserialize)]
pub struct BorrowRecord {
    pub id: uuid::Uuid,
    pub asset_inventory_id: Option<uuid::Uuid>,
    pub asset_name: Option<String>,
    pub borrower_id: Option<uuid::Uuid>,
    pub borrower_name: Option<String>,
    pub contact: Option<String>,
    pub borrower_laboratory_id: Option<uuid::Uuid>,
    pub borrow_date: chrono::NaiveDateTime,
    pub expected_return_date: Option<chrono::NaiveDateTime>,
    pub return_date: Option<chrono::NaiveDateTime>,
    pub note: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// struct for user login log
#[derive(Debug, Serialize, Deserialize)]
pub struct UserLoginLog {
    pub id: uuid::Uuid,
    pub user_id: Option<uuid::Uuid>,
    pub user_name: Option<String>,
    pub login_time: chrono::NaiveDateTime,
    pub login_ip: Option<String>,
    pub login_device: Option<String>,
    pub login_result: Option<String>,
    pub login_note: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}

// enum for operation type
pub enum OperationType {
    Create,
    Update,
    Delete,
}

// enum for operation table
pub enum OperationTable{
    Laboratory,
    User,
    AssetCategory,
    AssetGroup,
    Label,
    FileInfo,
    DeviceInfo,
    DeviceInventory,
    MaterialInfo,
    MaterialInventory,
    BorrowRecord,
    UserLoginLog,
    OperationLog,
}

// struct for operation log
#[derive(Debug, Serialize, Deserialize)]
pub struct OperationLog {
    pub id: u64,
    pub operator_id: Option<uuid::Uuid>,
    pub operation_type: Option<OperationType>,
    pub operation_table: Option<OperationTable>,
    pub value_before: Option<serde_json::Value>,
    pub value_after: Option<serde_json::Value>,
    pub operation_time: chrono::NaiveDateTime,
    pub operation_note: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
    pub active: bool,
}




