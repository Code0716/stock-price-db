-- topix_daily_price TOPIX 代理（1306.T = NEXT FUNDS TOPIX連動ETF）日足
-- Yahoo Finance に TOPIX 指数がないため 1306.T を代理として使用する
CREATE TABLE IF NOT EXISTS `stock_price_repository`.`topix_daily_price` (
  `date` DATETIME NOT NULL COMMENT 'date',
  `open_price` DECIMAL(10, 4) NOT NULL COMMENT '始値',
  `close_price` DECIMAL(10, 4) NOT NULL COMMENT '終値',
  `high_price` DECIMAL(10, 4) NOT NULL COMMENT '高値',
  `low_price` DECIMAL(10, 4) NOT NULL COMMENT '安値',
  `adj_close_price` DECIMAL(10, 4) NOT NULL COMMENT '配当や株式分割を考慮した終値',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`date`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
