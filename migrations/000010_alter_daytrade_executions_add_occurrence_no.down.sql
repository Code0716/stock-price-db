ALTER TABLE daytrade_executions
    DROP COLUMN occurrence_no,
    DROP INDEX uk_daytrade_natural,
    ADD UNIQUE KEY uk_daytrade_natural (
        executed_on, ticker_symbol, trade_kind, margin_kind,
        quantity, trade_amount, unit_price, profit_loss
    );
