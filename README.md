# stock-price-db

MySQL migrations (Source of Truth) for stock-price-* services.

## Structure

```
migrations/   golang-migrate format (.up.sql / .down.sql)
schema/       schema.sql — committed snapshot after all migrations
scripts/      dump-schema.sh, verify-drift.sh
charset.cnf   utf8mb4 / utf8mb4_0900_ai_ci config for local Docker
```

## Usage in other repos (git submodule)

```bash
git submodule add git@github.com:Code0716/stock-price-db.git vendor/db-migrations
git submodule update --init
```

## Apply migrations locally

```bash
migrate -path vendor/db-migrations/migrations \
  -database "mysql://root:root@tcp(127.0.0.1:3306)/stock_price_repository" up
```

## Update schema.sql

After adding a new migration, run:

```bash
./scripts/dump-schema.sh
git add schema/schema.sql
git commit -m "update schema snapshot"
```
