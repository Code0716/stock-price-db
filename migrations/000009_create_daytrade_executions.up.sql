CREATE TABLE daytrade_executions (
    id            BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    executed_on   DATE          NOT NULL  COMMENT '約定日',
    trade_kind    VARCHAR(16)   NOT NULL  COMMENT '取引区分 (売建/買建/現物買付/現物売却 等)',
    margin_kind   VARCHAR(16)   NOT NULL DEFAULT '' COMMENT '信用区分 (返済売/返済買/新規買/新規売/空)',
    ticker_symbol VARCHAR(10)   NOT NULL  COMMENT '銘柄コード (4桁)',
    brand_name    VARCHAR(255)  NOT NULL  COMMENT '銘柄名',
    quantity      INT UNSIGNED  NOT NULL  COMMENT '数量',
    trade_amount  BIGINT        NOT NULL  COMMENT '約定代金 (円)',
    unit_price    DECIMAL(15,4) NOT NULL  COMMENT '単価',
    average_cost  DECIMAL(15,4) NOT NULL  COMMENT '平均取得単価',
    profit_loss   BIGINT        NOT NULL  COMMENT '売買損益 (税引前・円)',
    source        VARCHAR(16)   NOT NULL DEFAULT 'sbi' COMMENT 'CSV 出力元',
    created_at    DATETIME      NOT NULL,
    updated_at    DATETIME      NOT NULL,
    UNIQUE KEY uk_daytrade_natural (
        executed_on, ticker_symbol, trade_kind, margin_kind,
        quantity, trade_amount, unit_price, profit_loss
    ),
    INDEX idx_daytrade_executed_on (executed_on),
    INDEX idx_daytrade_executed_on_symbol (executed_on, ticker_symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
