-- market_calendar J-Quants V2 /markets/calendar の取引カレンダー。デイトレカレンダーで営業日・休場日を判定するために保存する。
CREATE TABLE IF NOT EXISTS `stock_price_repository`.`market_calendar` (
  `calendar_date` DATE NOT NULL COMMENT '日付',
  `hol_div` TINYINT NOT NULL COMMENT '休日区分（J-Quants HolDiv）: 0=休場 / 1=営業 / 2=半日取引 / 3=休場だが祝日取引あり',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`calendar_date`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
