-- quiz_daily_universe クイズ出題ユニバース（1日300銘柄）。この行自体が「設問」レコードを兼ねる
CREATE TABLE IF NOT EXISTS `stock_price_repository`.`quiz_daily_universe` (
  `quiz_date` DATE NOT NULL COMMENT 'クイズ対象日（この日の終値までチャート表示、翌営業日終値を予想）',
  `stock_brand_id` CHAR(36) NOT NULL COMMENT 'stock_brand.id',
  `ticker_symbol` VARCHAR(10) NOT NULL COMMENT '銘柄コード',
  `question_order` INT UNSIGNED NOT NULL COMMENT '出題順 1..300',
  `avg_trading_value` DECIMAL(24, 4) NOT NULL COMMENT '直近20営業日平均売買代金 volume*close',
  `avg_daily_range` DECIMAL(12, 6) NOT NULL COMMENT '直近20営業日平均値幅率 (high-low)/close',
  `base_close_price` DECIMAL(10, 4) NOT NULL COMMENT 'quiz_date終値（採点基準のスナップショット）',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`quiz_date`, `stock_brand_id`),
  UNIQUE KEY `uk_quiz_daily_universe_date_order` (`quiz_date`, `question_order`),
  KEY `idx_quiz_daily_universe_stock_brand_id` (`stock_brand_id`),
  FOREIGN KEY (`stock_brand_id`) REFERENCES stock_brand (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- quiz_answer 回答＋採点結果（採点カラムは grading バッチが埋める）
CREATE TABLE IF NOT EXISTS `stock_price_repository`.`quiz_answer` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `quiz_date` DATE NOT NULL COMMENT 'クイズ対象日',
  `stock_brand_id` CHAR(36) NOT NULL COMMENT 'stock_brand.id',
  `ticker_symbol` VARCHAR(10) NOT NULL COMMENT '銘柄コード',
  `prediction` VARCHAR(16) NOT NULL COMMENT '回答: strong_down/down/up/strong_up',
  `answered_at` DATETIME NOT NULL COMMENT '回答日時',
  `next_close_price` DECIMAL(10, 4) NULL COMMENT '翌営業日終値（採点時に確定）',
  `actual_return` DECIMAL(12, 6) NULL COMMENT '(翌営業日終値-基準終値)/基準終値',
  `outcome` VARCHAR(16) NULL COMMENT '採点結果: correct/incorrect/draw/void',
  `score` TINYINT NULL COMMENT '獲得スコア +2/+1/0/-1/-2',
  `graded_at` DATETIME NULL COMMENT '採点日時',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_quiz_answer_date_brand` (`quiz_date`, `stock_brand_id`),
  KEY `idx_quiz_answer_quiz_date` (`quiz_date`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
