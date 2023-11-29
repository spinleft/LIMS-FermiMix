use axum::{
    routing::get,
    Router,
    http::StatusCode,
    response::IntoResponse,
};

async fn hello_world() -> impl IntoResponse {
    (StatusCode::OK, "Hello, World!")
}

#[tokio::main]
async fn main() {
    let app = Router::new().route("/", get(hello_world));

    // 我们将在localhost的3000端口运行我们的应用
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
