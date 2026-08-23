-- stock_brands_daily_price_for_analyze の価格5列を DECIMAL(10,4) から DECIMAL(14,4) に拡張する。
-- 株式併合（逆分割）で調整後価格が既存上限(999,999.9999)を超えうるため
-- （実測raw最大値389,500円に対し、5倍併合等で桁あふれし得る）。
ALTER TABLE `stock_price_repository`.`stock_brands_daily_price_for_analyze`
  MODIFY COLUMN `open_price` DECIMAL(14, 4) NOT NULL COMMENT '始値',
  MODIFY COLUMN `close_price` DECIMAL(14, 4) NOT NULL COMMENT '終値',
  MODIFY COLUMN `high_price` DECIMAL(14, 4) NOT NULL COMMENT '高値',
  MODIFY COLUMN `low_price` DECIMAL(14, 4) NOT NULL COMMENT '安値',
  MODIFY COLUMN `adj_close_price` DECIMAL(14, 4) NOT NULL COMMENT '配当や株式分割を考慮した終値';
