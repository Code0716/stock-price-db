-- notification_history Slack へ送信した通知の記録。SlackAPIClient のデコレータが送信成功時に書き込む。
-- dev_notification（エラー・実行時間通知）チャンネル宛は記録対象外。
CREATE TABLE IF NOT EXISTS `stock_price_repository`.`notification_history` (
  `id` CHAR(36) NOT NULL COMMENT 'UUID',
  `source` VARCHAR(16) NOT NULL COMMENT '送信元サービス: spr/stt',
  `channel_id` VARCHAR(64) NOT NULL COMMENT 'Slack チャンネル ID または #名前（既存 SlackChannelName 定数の値そのまま）',
  `channel_label` VARCHAR(64) NOT NULL COMMENT 'チャンネル表示名。front が名前解決せず表示するため送信時に確定させて保存',
  `title` TEXT NOT NULL COMMENT '通知タイトル（親メッセージ本文）',
  `body` MEDIUMTEXT NULL COMMENT 'スレッド本文。SendMessage 系（固定文言のみ）は NULL',
  `sent_at` DATETIME NOT NULL COMMENT 'Slack 送信日時',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  PRIMARY KEY (`id`),
  KEY `idx_notification_history_sent_at` (`sent_at`),
  KEY `idx_notification_history_channel_sent_at` (`channel_id`, `sent_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
