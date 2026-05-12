#!/usr/bin/env bash
# CI script: apply migrations, dump schema, diff against committed schema/schema.sql.
# Exits non-zero if drift is detected.
set -euo pipefail

CONTAINER=stock-price-db-verify
DB=stock_price_repository
PORT=13307
TMPFILE=$(mktemp)

cleanup() {
  docker rm -f "$CONTAINER" &>/dev/null || true
  rm -f "$TMPFILE"
}
trap cleanup EXIT

docker run -d --name "$CONTAINER" \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE="$DB" \
  -v "$(pwd)/charset.cnf:/etc/mysql/conf.d/charset.cnf:ro" \
  -p "${PORT}:3306" \
  mysql:8.0

echo "Waiting for MySQL..."
until docker exec "$CONTAINER" mysqladmin ping -uroot -proot --silent 2>/dev/null; do sleep 1; done

migrate -path ./migrations -database "mysql://root:root@tcp(127.0.0.1:${PORT})/${DB}" up

docker exec "$CONTAINER" mysqldump -uroot -proot \
  --no-data --skip-comments --skip-add-drop-table \
  "$DB" > "$TMPFILE"

if diff -u schema/schema.sql "$TMPFILE"; then
  echo "No schema drift detected."
else
  echo "SCHEMA DRIFT DETECTED. Run scripts/dump-schema.sh and commit schema/schema.sql."
  exit 1
fi
