#!/usr/bin/env bash
set -x

if ! [ -x "$(command -v psql)" ]; then
elif ! [ -x "$(command -v psql-6)" ]; then
    echo >&2 "Error: psql is not installed."
    exit 1
fi

if ! [ -x "$(command -v sqlx)" ]; then
    echo >&2 "Error: sqlx is not installed."
    echo >&2 "Use:"
    echo >&2 "    cargo install --version='~0.7' sqlx-cli \
--no-default-features --features rustls,postgres"
    echo >&2 "to install it."
    exit 1
fi

POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
POSTGRES_DB=lims
POSTGRES_PORT=5432
POSTGRES_HOST=localhost

# Check if a custom user has been set, otherwise default to 'postgres'
DB_USER="${POSTGRES_USER:=postgres}"
# Check if a custom password has been set, otherwise default to 'password'
DB_PASSWORD="${POSTGRES_PASSWORD:=password}"
# Check if a custom database name has been set, otherwise default to 'newsletter'
DB_NAME="${POSTGRES_DB:=newsletter}"
# Check if a custom port has been set, otherwise default to '5432'
DB_PORT="${POSTGRES_PORT:=5432}"
# Check if a custom host has been set, otherwise default to 'localhost'
DB_HOST="${POSTGRES_HOST:=localhost}"

OS_TYPE="$(uname -s)"

case "${OS_TYPE}" in
    Linux)
        echo "Detect OS as Linux."
        
        # Launch postgres using Docker
        docker run \
            -e POSTGRES_USER=${DB_USER} \
            -e POSTGRES_PASSWORD=${DB_PASSWORD} \
            -e POSTGRES_DB=${DB_NAME} \
            -p "${DB_PORT}":5432 \
            -d postgres \
            postgres -N 1000
            # ^ Increased maximum number of connections for testing purposes
        ;;
    Darwin)
        echo "Detect OS as MacOSX."

        brew install postgresql@16
        brew services start postgresql@16
        createuser-16 -P -c1000 -d ${DB_USER}

        # Keep pinging Postgres until it's ready to accept commands
        export PGPASSWORD="${DB_PASSWORD}"
        until /usr/local/Cellar/postgresql@16/16.1_3/bin/psql -h "${DB_HOST}" -U "${DB_USER}" -p "${DB_PORT}" -d "${DB_NAME}" -c '\q'; do
            >&2 echo "Postgres is still unavailable - sleeping"
            sleep 1
        done
        
        >&2 echo "Postgres is up and running on port ${DB_PORT}!"
        ;;
esac

>&2 echo "Postgres is up and running on port ${DB_PORT} - running migrations now!"

DATABASE_URL=postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}
export DATABASE_URL
sqlx database create
sqlx migrate run