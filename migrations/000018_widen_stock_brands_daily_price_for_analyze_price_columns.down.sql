ALTER TABLE `stock_price_repository`.`stock_brands_daily_price_for_analyze`
  MODIFY COLUMN `open_price` DECIMAL(10, 4) NOT NULL COMMENT '始値',
  MODIFY COLUMN `close_price` DECIMAL(10, 4) NOT NULL COMMENT '終値',
  MODIFY COLUMN `high_price` DECIMAL(10, 4) NOT NULL COMMENT '高値',
  MODIFY COLUMN `low_price` DECIMAL(10, 4) NOT NULL COMMENT '安値',
  MODIFY COLUMN `adj_close_price` DECIMAL(10, 4) NOT NULL COMMENT '配当や株式分割を考慮した終値';
