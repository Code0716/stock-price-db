#!/usr/bin/env bash
# Usage: ./scripts/dump-schema.sh
# Applies all migrations to a temporary MySQL container and dumps the schema.
set -euo pipefail

CONTAINER=stock-price-db-schema-dump
DB=stock_price_repository
PORT=13306

cleanup() { docker rm -f "$CONTAINER" &>/dev/null || true; }
trap cleanup EXIT

docker run -d --name "$CONTAINER" \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE="$DB" \
  -v "$(pwd)/charset.cnf:/etc/mysql/conf.d/charset.cnf:ro" \
  -p "${PORT}:3306" \
  mysql:8.0

echo "Waiting for MySQL..."
until docker exec "$CONTAINER" mysqladmin ping -uroot -proot --silent 2>/dev/null; do sleep 1; done

# Apply migrations with golang-migrate (requires 'migrate' binary)
migrate -path ./migrations -database "mysql://root:root@tcp(127.0.0.1:${PORT})/${DB}" up

# Dump schema only (no data) using container's mysqldump
docker exec "$CONTAINER" mysqldump -uroot -proot \
  --no-data --skip-comments --skip-add-drop-table \
  "$DB" > schema/schema.sql

echo "schema/schema.sql updated."
