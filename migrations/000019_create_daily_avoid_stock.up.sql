-- daily_avoid_stock 流動性ユニバース（平均売買代金1億円/日以上）内で、直近12ヶ月の実現ボラティリティが
-- 上位20%に入る「避けるべき銘柄」。買い候補(daily_stock_pick)とは独立に毎営業日フル生成する。
-- 根拠: 当該群は5.9年で累積-40.5%(年率-8.4%)、7年中6年がマイナス。過学習排除の7つの独立検証を通過済み
-- （期間分割・暦年別・ボラ計算期間の感度・サイズ分解・執行遅延・情報係数・生存者バイアスの方向）。
-- 「儲かる戦略」ではなく「大負けを避けるフィルタ」。Slack通知(notification_history)には一切書かない。
CREATE TABLE IF NOT EXISTS `stock_price_repository`.`daily_avoid_stock` (
  `as_of_date` DATE NOT NULL COMMENT '判定基準日（この日の引け値までの直近12ヶ月の日次リターンで算出）',
  `stock_brand_id` CHAR(36) NOT NULL COMMENT 'stock_brand.id',
  `ticker_symbol` VARCHAR(10) NOT NULL COMMENT '銘柄コード',
  `avoid_rank` INT UNSIGNED NOT NULL COMMENT 'ボラ降順の順位 1..N（rank は MySQL8 予約語のため avoid_rank）',
  `severity` VARCHAR(16) NOT NULL COMMENT '重大度: high(上位10%以内) / elevated(上位10-20%)',
  `reason` VARCHAR(32) NOT NULL COMMENT '判定理由。現状は high_volatility 固定。将来の判定軸追加に備えた識別子',
  `rule_version` VARCHAR(16) NOT NULL COMMENT '判定ルール定義バージョン。閾値変更時にインクリメントし過去分と混ぜて集計しない',
  `volatility_12m` DECIMAL(10, 6) NOT NULL COMMENT '直近252営業日の日次リターン標準偏差を年率換算した値（0.62=62%）',
  `volatility_percentile` DECIMAL(6, 4) NOT NULL COMMENT 'ユニバース内の上位比率 0.0000-1.0000（0.0500=上位5%）',
  `universe_size` INT UNSIGNED NOT NULL COMMENT '判定対象の流動性ユニバース銘柄数（パーセンタイルの分母。同一as_of_dateの全行で同値）',
  `threshold_volatility` DECIMAL(10, 6) NOT NULL COMMENT '当日の上位20%ラインの年率ボラ（同一as_of_dateの全行で同値）',
  `avg_trading_value` DECIMAL(24, 4) NOT NULL COMMENT '直近20営業日平均売買代金 volume*close（ユニバース判定に使った値）',
  `base_close_price` DECIMAL(10, 4) NOT NULL COMMENT 'as_of_date の終値（目視確認用スナップショット）',
  `sector_33_code_name` VARCHAR(64) NULL COMMENT '33業種名。高ボラ群の業種偏りを後から検証するため保存',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`as_of_date`, `stock_brand_id`),
  UNIQUE KEY `uk_daily_avoid_stock_date_rank` (`as_of_date`, `avoid_rank`),
  KEY `idx_daily_avoid_stock_brand_date` (`stock_brand_id`, `as_of_date`),
  KEY `idx_daily_avoid_stock_ticker_date` (`ticker_symbol`, `as_of_date`),
  FOREIGN KEY (`stock_brand_id`) REFERENCES stock_brand (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
