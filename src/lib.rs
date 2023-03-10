use actix_web::dev::Server;
use actix_web::{
    web::{get, post, Form},
    App, HttpResponse, HttpServer,
};
use serde::Deserialize;
use std::net::TcpListener;

#[derive(Deserialize)]
struct FormData {
    _email: String,
    _name: String,
}

async fn health_check() -> HttpResponse {
    HttpResponse::Ok().finish()
}

async fn subscribe(_form: Form<FormData>) -> HttpResponse {
    HttpResponse::Ok().finish()
}

pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(|| {
        App::new()
            .route("/health_check", get().to(health_check))
            .route("/subscriptions", post().to(subscribe))
    })
    .listen(listener)?
    .run();

    Ok(server)
}
