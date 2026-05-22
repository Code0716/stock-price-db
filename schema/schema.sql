
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analyze_stock_brand_price_history` (
  `id` char(36) NOT NULL COMMENT 'uuid',
  `stock_brand_id` char(36) NOT NULL COMMENT 'uuid',
  `ticker_symbol` varchar(36) NOT NULL COMMENT '証券コード',
  `trade_price` decimal(10,4) NOT NULL COMMENT 'トレード金額',
  `action` varchar(10) NOT NULL COMMENT '売り/買いの別',
  `method` varchar(255) NOT NULL COMMENT '分析方法',
  `memo` text COMMENT 'メモ',
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_analyze_stock_brand_price_history_stock_ticker_method_date` (`stock_brand_id`,`ticker_symbol`,`method`,`created_at`),
  KEY `ticker_symbol` (`ticker_symbol`),
  KEY `idx_analyze_stock_brand_price_history_stock_brand_id` (`stock_brand_id`),
  CONSTRAINT `analyze_stock_brand_price_history_ibfk_1` FOREIGN KEY (`stock_brand_id`) REFERENCES `stock_brand` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applied_stock_consolidations_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(5) NOT NULL COMMENT '銘柄コード',
  `consolidation_date` date NOT NULL COMMENT '併合実施日',
  `ratio` decimal(10,4) NOT NULL COMMENT '併合比率（旧株数/新株数。例: 5株を1株に併合なら 5.0000）',
  `applied_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '適用日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_symbol_consolidation_date` (`symbol`,`consolidation_date`),
  KEY `idx_applied_stock_consolidations_history_symbol_date` (`symbol`,`consolidation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applied_stock_splits_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(5) NOT NULL COMMENT '銘柄コード',
  `split_date` date NOT NULL COMMENT '分割実施日',
  `ratio` decimal(10,4) NOT NULL COMMENT '分割比率',
  `applied_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '適用日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_symbol_split_date` (`symbol`,`split_date`),
  KEY `idx_applied_stock_splits_history_symbol_split_date` (`symbol`,`split_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daytrade_executions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `executed_on` date NOT NULL COMMENT '約定日',
  `trade_kind` varchar(16) NOT NULL COMMENT '取引区分 (売建/買建/現物買付/現物売却 等)',
  `margin_kind` varchar(16) NOT NULL DEFAULT '' COMMENT '信用区分 (返済売/返済買/新規買/新規売/空)',
  `ticker_symbol` varchar(10) NOT NULL COMMENT '銘柄コード (4桁)',
  `brand_name` varchar(255) NOT NULL COMMENT '銘柄名',
  `quantity` int unsigned NOT NULL COMMENT '数量',
  `trade_amount` bigint NOT NULL COMMENT '約定代金 (円)',
  `unit_price` decimal(15,4) NOT NULL COMMENT '単価',
  `average_cost` decimal(15,4) NOT NULL COMMENT '平均取得単価',
  `profit_loss` bigint NOT NULL COMMENT '売買損益 (税引前・円)',
  `source` varchar(16) NOT NULL DEFAULT 'sbi' COMMENT 'CSV 出力元',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_daytrade_natural` (`executed_on`,`ticker_symbol`,`trade_kind`,`margin_kind`,`quantity`,`trade_amount`,`unit_price`,`profit_loss`),
  KEY `idx_daytrade_executed_on` (`executed_on`),
  KEY `idx_daytrade_executed_on_symbol` (`executed_on`,`ticker_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dji_stock_average_daily_stock_price` (
  `date` datetime NOT NULL COMMENT 'date',
  `open_price` decimal(10,4) NOT NULL COMMENT '始値',
  `close_price` decimal(10,4) NOT NULL COMMENT '終値',
  `high_price` decimal(10,4) NOT NULL COMMENT '高値',
  `low_price` decimal(10,4) NOT NULL COMMENT '安値',
  `adj_close_price` decimal(10,4) NOT NULL COMMENT '配当や株式分割を考慮した終値',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fin_announcement` (
  `id` char(36) NOT NULL,
  `ticker_symbol` varchar(10) NOT NULL COMMENT '証券コード',
  `stock_brand_id` char(36) DEFAULT NULL COMMENT '銘柄ID',
  `announcement_date` date NOT NULL COMMENT '決算発表予定日',
  `fiscal_year` varchar(10) DEFAULT NULL COMMENT '会計年度',
  `fiscal_quarter` varchar(10) DEFAULT NULL COMMENT '会計期間',
  `sector_17_code` varchar(10) DEFAULT NULL COMMENT '17業種コード',
  `sector_33_code` varchar(10) DEFAULT NULL COMMENT '33業種コード',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_announcement` (`ticker_symbol`,`announcement_date`),
  KEY `idx_announcement_date` (`announcement_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fin_statement` (
  `id` char(36) NOT NULL,
  `ticker_symbol` varchar(10) NOT NULL COMMENT '証券コード',
  `stock_brand_id` char(36) DEFAULT NULL COMMENT '銘柄ID',
  `disclosed_date` date NOT NULL COMMENT '開示日',
  `fiscal_year_end` date DEFAULT NULL COMMENT '当期末日',
  `type_of_document` varchar(64) DEFAULT NULL COMMENT '開示書類種別',
  `type_of_current_period` varchar(10) DEFAULT NULL COMMENT '当会計期間の種類',
  `net_sales` decimal(20,2) DEFAULT NULL COMMENT '売上高',
  `operating_profit` decimal(20,2) DEFAULT NULL COMMENT '営業利益',
  `ordinary_profit` decimal(20,2) DEFAULT NULL COMMENT '経常利益',
  `profit` decimal(20,2) DEFAULT NULL COMMENT '当期純利益',
  `earnings_per_share` decimal(20,4) DEFAULT NULL COMMENT 'EPS',
  `book_value_per_share` decimal(20,4) DEFAULT NULL COMMENT 'BPS',
  `forecast_net_sales` decimal(20,2) DEFAULT NULL COMMENT '通期予想売上高',
  `forecast_operating_profit` decimal(20,2) DEFAULT NULL COMMENT '通期予想営業利益',
  `forecast_profit` decimal(20,2) DEFAULT NULL COMMENT '通期予想純利益',
  `forecast_eps` decimal(20,4) DEFAULT NULL COMMENT '通期予想EPS',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_statement` (`ticker_symbol`,`disclosed_date`,`type_of_document`),
  KEY `idx_statement_symbol` (`ticker_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `high_volume_stock_brands` (
  `stock_brand_id` char(36) NOT NULL COMMENT 'uuid',
  `ticker_symbol` varchar(5) NOT NULL COMMENT '証券コード',
  `volume_average` bigint unsigned NOT NULL COMMENT '一ヶ月間の出来高平均',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  PRIMARY KEY (`stock_brand_id`),
  CONSTRAINT `high_volume_stock_brands_ibfk_1` FOREIGN KEY (`stock_brand_id`) REFERENCES `stock_brand` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nikkei_stock_average_daily_price` (
  `date` datetime NOT NULL COMMENT 'date',
  `open_price` decimal(10,4) NOT NULL COMMENT '始値',
  `close_price` decimal(10,4) NOT NULL COMMENT '終値',
  `high_price` decimal(10,4) NOT NULL COMMENT '高値',
  `low_price` decimal(10,4) NOT NULL COMMENT '安値',
  `adj_close_price` decimal(10,4) NOT NULL COMMENT '配当や株式分割を考慮した終値',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` bigint NOT NULL,
  `dirty` tinyint(1) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sector_17_average_daily_price` (
  `id` char(36) NOT NULL COMMENT 'uuid',
  `date` date NOT NULL COMMENT 'date',
  `sector_33_code` varchar(4) DEFAULT NULL COMMENT '33業種コード',
  `sector_17_code` varchar(4) DEFAULT NULL COMMENT '17業種コード',
  `open_price` decimal(10,4) NOT NULL COMMENT '始値',
  `close_price` decimal(10,4) NOT NULL COMMENT '終値',
  `high_price` decimal(10,4) NOT NULL COMMENT '高値',
  `low_price` decimal(10,4) NOT NULL COMMENT '安値',
  `adj_close_price` decimal(10,4) NOT NULL COMMENT '配当や株式分割を考慮した終値',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sector_17_average_date_and_sector_code` (`date`,`sector_17_code`),
  UNIQUE KEY `idx_sector_17_average_date_and_17_and_33_code` (`date`,`sector_17_code`,`sector_33_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sector_33_average_daily_price` (
  `id` char(36) NOT NULL COMMENT 'uuid',
  `date` date NOT NULL COMMENT 'date',
  `sector_33_code` varchar(4) DEFAULT NULL COMMENT '33業種コード',
  `open_price` decimal(10,4) NOT NULL COMMENT '始値',
  `close_price` decimal(10,4) NOT NULL COMMENT '終値',
  `high_price` decimal(10,4) NOT NULL COMMENT '高値',
  `low_price` decimal(10,4) NOT NULL COMMENT '安値',
  `adj_close_price` decimal(10,4) NOT NULL COMMENT '配当や株式分割を考慮した終値',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sector_33_average_date_and_code` (`date`,`sector_33_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_brand` (
  `id` char(36) NOT NULL DEFAULT (lower(uuid())) COMMENT 'uuid',
  `ticker_symbol` varchar(5) NOT NULL COMMENT '証券コード',
  `name` varchar(255) NOT NULL COMMENT '銘柄名',
  `market_code` varchar(255) NOT NULL COMMENT '市場コード',
  `market_name` varchar(255) NOT NULL COMMENT '市場名',
  `sector_33_code` varchar(4) DEFAULT NULL COMMENT '33業種コード',
  `sector_33_code_name` varchar(255) DEFAULT NULL COMMENT '33業種区分',
  `sector_17_code` varchar(4) DEFAULT NULL COMMENT '17業種コード',
  `sector_17_code_name` varchar(255) DEFAULT NULL COMMENT '17業種区分',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  `deleted_at` datetime DEFAULT NULL COMMENT 'deleted_at',
  PRIMARY KEY (`id`),
  KEY `idx_stock_brand_ticker_symbol` (`ticker_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_brands_daily_price` (
  `id` char(36) NOT NULL COMMENT 'uuid',
  `stock_brand_id` char(36) NOT NULL COMMENT 'uuid',
  `ticker_symbol` varchar(36) NOT NULL COMMENT 'ticker symbol',
  `date` date NOT NULL COMMENT 'date',
  `open_price` decimal(10,4) NOT NULL COMMENT '始値',
  `close_price` decimal(10,4) NOT NULL COMMENT '終値',
  `high_price` decimal(10,4) NOT NULL COMMENT '高値',
  `low_price` decimal(10,4) NOT NULL COMMENT '安値',
  `adj_close_price` decimal(10,4) NOT NULL COMMENT '配当や株式分割を考慮した終値',
  `volume` bigint unsigned NOT NULL COMMENT '出来高',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  `deleted_at` datetime DEFAULT NULL COMMENT 'deleted_at',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_stock_brands_daily_stock_price_stock_brand_id_and_date` (`stock_brand_id`,`date`),
  KEY `idx_stock_brands_daily_stock_price_ticker_symbol` (`ticker_symbol`),
  KEY `idx_stock_brands_daily_stock_price_date` (`date`),
  KEY `idx_stock_brands_daily_stock_price_stock_brand_id_and_date` (`stock_brand_id`,`date`),
  CONSTRAINT `stock_brands_daily_price_ibfk_1` FOREIGN KEY (`stock_brand_id`) REFERENCES `stock_brand` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_brands_daily_price_for_analyze` (
  `id` char(36) NOT NULL COMMENT 'uuid',
  `ticker_symbol` varchar(36) NOT NULL COMMENT 'ticker symbol',
  `date` date NOT NULL COMMENT 'date',
  `open_price` decimal(10,4) NOT NULL COMMENT '始値',
  `close_price` decimal(10,4) NOT NULL COMMENT '終値',
  `high_price` decimal(10,4) NOT NULL COMMENT '高値',
  `low_price` decimal(10,4) NOT NULL COMMENT '安値',
  `adj_close_price` decimal(10,4) NOT NULL COMMENT '配当や株式分割を考慮した終値',
  `volume` bigint unsigned NOT NULL COMMENT '出来高',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'created_at',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'updated_at',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_stock_brands_daily_price_ticker_symbol_and_date` (`ticker_symbol`,`date`),
  KEY `idx_stock_brands_daily_price_ticker_symbol` (`ticker_symbol`),
  KEY `idx_stock_brands_daily_price_date` (`date`),
  KEY `idx_stock_brands_daily_price_ticker_symbol_and_date` (`ticker_symbol`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

