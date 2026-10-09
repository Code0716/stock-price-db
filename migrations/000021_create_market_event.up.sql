-- market_event デイトレカレンダーに表示する市場イベント（SQ・日銀会合・FOMC・米CPI・米雇用統計）。
-- 取得元ごとに同期バッチが kind 単位で洗い替えるため、(event_date, kind) で一意にする。
CREATE TABLE IF NOT EXISTS `stock_price_repository`.`market_event` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `event_date` DATE NOT NULL COMMENT 'カレンダー上に表示する日付（FOMCは結果発表の日本時間の日付）',
  `kind` VARCHAR(32) NOT NULL COMMENT 'イベント種別: sq_major / sq_mini / boj / fomc / us_cpi / us_nfp',
  `label` VARCHAR(64) NOT NULL COMMENT '表示ラベル',
  `source` VARCHAR(32) NOT NULL COMMENT '取得元: jquants_calc / boj_html / fed_html / bls_ics / manual',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_market_event_date_kind` (`event_date`, `kind`),
  KEY `idx_market_event_date` (`event_date`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
