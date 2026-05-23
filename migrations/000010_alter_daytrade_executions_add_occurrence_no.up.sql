-- occurrence_no: 同一自然キー内での CSV 出現順序 (0 始まり)。
-- 板寄せ・連続成行で約定単価が偶然同値になる独立約定を区別するために追加。
ALTER TABLE daytrade_executions
    ADD COLUMN occurrence_no TINYINT UNSIGNED NOT NULL DEFAULT 0
        COMMENT '同一自然キー内での出現順序 (0始まり)' AFTER profit_loss,
    DROP INDEX uk_daytrade_natural,
    ADD UNIQUE KEY uk_daytrade_natural (
        executed_on, ticker_symbol, trade_kind, margin_kind,
        quantity, trade_amount, unit_price, profit_loss, occurrence_no
    );
