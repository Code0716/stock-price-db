ALTER TABLE analyze_stock_brand_price_history
    DROP INDEX idx_analyze_history_created_at_method,
    DROP COLUMN signal_rank,
    DROP COLUMN score;
