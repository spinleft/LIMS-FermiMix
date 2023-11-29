use serde::{Deserialize, Serialize};

pub enum Role {
    Admin,
    User,
    Guest,
}

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
}

// struct for user account
#[derive(Debug, Serialize, Deserialize)]
pub struct User {
    pub id: uuid::Uuid,
    pub username: String,
    pub password: String,
    pub email: Option<String>,
    pub phone: Option<String>,
    pub role: String,
    pub laboratory_id: uuid::Uuid,
    pub active: bool,
    pub last_login: Option<chrono::NaiveDateTime>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
}

// struct for asset category
#[derive(Debug, Serialize, Deserialize)]
pub struct AssetCategory {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
}

// struct for asset group
#[derive(Debug, Serialize, Deserialize)]
pub struct AssetGroup {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
}

pub struct Label {
    pub id: uuid::Uuid,
    pub name: String,
    pub description: Option<String>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
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
    pub documents: Option<serde_json::Value>,
    pub images: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
}

// struct for device inventory
#[derive(Debug, Serialize, Deserialize)]
pub struct DeviceInventory {
    pub id: uuid::Uuid,
    pub device_id: uuid::Uuid,
    pub serial_number: Option<String>,
    pub status: Option<String>,
    pub storage_location: Option<String>,
    pub current_location: Option<String>,
    pub purchase_date: Option<chrono::NaiveDateTime>,
    pub responsible_person_id: Option<uuid::Uuid>,
    pub label_id: Option<serde_json::Value>,
    pub note: Option<String>,
    pub documents: Option<serde_json::Value>,
    pub images: Option<serde_json::Value>,
    pub created_at: chrono::NaiveDateTime,
    pub updated_at: Option<chrono::NaiveDateTime>,
}