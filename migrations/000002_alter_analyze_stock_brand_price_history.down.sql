-- stock_brand_id を leftmost に持つ unique が FK 支援インデックスを兼ねているため、
-- FK を先に外してから unique を削除し、最後に FK を復元する
ALTER TABLE `analyze_stock_brand_price_history`
  DROP FOREIGN KEY `analyze_stock_brand_price_history_ibfk_1`;

ALTER TABLE `analyze_stock_brand_price_history`
  DROP INDEX `uq_analyze_stock_brand_price_history_stock_ticker_method`;

-- 元のユニークキーを復元
ALTER TABLE `analyze_stock_brand_price_history`
  ADD UNIQUE KEY `unique_symbol_action_method_created_at`
    (`ticker_symbol`, `action`, `method`, `created_at`);

-- FK を復元（MySQL が stock_brand_id に自動インデックスを作成する）
ALTER TABLE `analyze_stock_brand_price_history`
  ADD CONSTRAINT `analyze_stock_brand_price_history_ibfk_1`
    FOREIGN KEY (`stock_brand_id`) REFERENCES `stock_brand` (`id`);
