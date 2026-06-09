ALTER TABLE analyze_stock_brand_price_history
    ADD COLUMN score       DECIMAL(10,4) NULL COMMENT '複合スコア（出す手法のみ。analyze_diamonds等）' AFTER memo,
    ADD COLUMN signal_rank INT           NULL COMMENT '手法内ランク（1始まり）' AFTER score,
    ADD INDEX idx_analyze_history_created_at_method (created_at, method);
