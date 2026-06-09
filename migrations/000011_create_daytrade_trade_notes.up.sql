CREATE TABLE daytrade_trade_notes (
    id                  BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ticker_symbol       VARCHAR(10)   NOT NULL COMMENT '銘柄コード',
    executed_on         DATE          NOT NULL COMMENT '約定日（近似キー）',
    direction           VARCHAR(16)   NOT NULL COMMENT '正規化済み売買方向（近似キー）',
    memo                TEXT          NULL     COMMENT '自由メモ',
    tags                JSON          NULL     COMMENT 'タグ配列（例: ["高値掴み","ナンピン"]）',
    declared_stop_price DECIMAL(15,4) NULL     COMMENT '損切りライン宣言価格（自動判定はしない・記録のみ）',
    created_at          DATETIME      NOT NULL,
    updated_at          DATETIME      NOT NULL,
    UNIQUE KEY uk_daytrade_trade_note (executed_on, ticker_symbol, direction)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
