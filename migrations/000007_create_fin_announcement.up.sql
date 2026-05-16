CREATE TABLE fin_announcement (
    id              CHAR(36) NOT NULL,
    ticker_symbol   VARCHAR(10) NOT NULL COMMENT '証券コード',
    stock_brand_id  CHAR(36) NULL COMMENT '銘柄ID',
    announcement_date DATE NOT NULL COMMENT '決算発表予定日',
    fiscal_year     VARCHAR(10) NULL COMMENT '会計年度',
    fiscal_quarter  VARCHAR(10) NULL COMMENT '会計期間',
    sector_17_code  VARCHAR(10) NULL COMMENT '17業種コード',
    sector_33_code  VARCHAR(10) NULL COMMENT '33業種コード',
    created_at      DATETIME NOT NULL,
    updated_at      DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_announcement (ticker_symbol, announcement_date),
    INDEX idx_announcement_date (announcement_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
