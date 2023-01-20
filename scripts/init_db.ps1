# Check if a custom user has been set, otherwise default to 'postgres'
$DB_USER = if ($env:POSTGRES_USER) { $env:POSTGRES_USER } else { "postgres" }
# Check if a custom password has been set, otherwise default to 'password'
$DB_PASSWORD = if ($env:POSTGRES_PASSWORD) { $env:POSTGRES_PASSWORD } else { "password" }
# Check if a custom database name has been set, otherwise default to 'newsletter'
$DB_NAME = if ($env:POSTGRES_DB) { $env:POSTGRES_DB } else { "newsletter" }
# Check if a custom port has been set, otherwise default to '5432'
# Launch postgres using Docker
docker run `
    -e POSTGRES_USER=$DB_USER `
    -e POSTGRES_PASSWORD=$DB_PASSWORD `
    -e POSTGRES_DB=$DB_NAME `
    -p "5432:5432" `
    -d postgres -N 1000

Write-Host "Postgres is up and running on port 5432!"


$DATABASE_URL = "postgres://${DB_USER}:$DB_PASSWORD@localhost:5432/$DB_NAME"
sqlx database create --database-url $DATABASE_URL
