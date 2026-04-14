/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: cgrates
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0+deb12u2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `billing_transactions`
--

DROP TABLE IF EXISTS `billing_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `type` enum('charge','topup','adjustment') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `balance_after` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `reference_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_account` (`account_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_transactions`
--

LOCK TABLES `billing_transactions` WRITE;
/*!40000 ALTER TABLE `billing_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdrs`
--

DROP TABLE IF EXISTS `cdrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cdrs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cgrid` varchar(40) NOT NULL,
  `run_id` varchar(64) NOT NULL,
  `origin_host` varchar(64) NOT NULL,
  `source` varchar(64) NOT NULL,
  `origin_id` varchar(128) NOT NULL,
  `tor` varchar(16) NOT NULL,
  `request_type` varchar(24) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `category` varchar(64) NOT NULL,
  `account` varchar(128) NOT NULL,
  `subject` varchar(128) NOT NULL,
  `destination` varchar(128) NOT NULL,
  `setup_time` datetime NOT NULL,
  `answer_time` datetime DEFAULT NULL,
  `usage` bigint(20) NOT NULL,
  `extra_fields` text NOT NULL,
  `cost_source` varchar(64) NOT NULL,
  `cost` decimal(20,4) NOT NULL,
  `cost_details` mediumtext DEFAULT NULL,
  `extra_info` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cdrrun` (`cgrid`,`run_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdrs`
--

LOCK TABLES `cdrs` WRITE;
/*!40000 ALTER TABLE `cdrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate_profile_assignments`
--

DROP TABLE IF EXISTS `rate_profile_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_profile_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `rate_profile_id` bigint(20) unsigned NOT NULL,
  `effective_date` timestamp NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `deactivated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_account_active` (`account_id`,`is_active`),
  KEY `rate_profile_id` (`rate_profile_id`),
  KEY `idx_account` (`account_id`),
  KEY `idx_active` (`is_active`),
  CONSTRAINT `rate_profile_assignments_ibfk_1` FOREIGN KEY (`rate_profile_id`) REFERENCES `rate_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_profile_assignments`
--

LOCK TABLES `rate_profile_assignments` WRITE;
/*!40000 ALTER TABLE `rate_profile_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `rate_profile_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate_profile_rates`
--

DROP TABLE IF EXISTS `rate_profile_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_profile_rates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rate_profile_id` bigint(20) unsigned NOT NULL,
  `destination_prefix` varchar(50) NOT NULL,
  `destination_name` varchar(255) NOT NULL,
  `rate_per_minute` decimal(10,4) NOT NULL,
  `setup_fee` decimal(10,4) DEFAULT 0.0000,
  `currency` varchar(3) DEFAULT 'USD',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_profile` (`rate_profile_id`),
  CONSTRAINT `rate_profile_rates_ibfk_1` FOREIGN KEY (`rate_profile_id`) REFERENCES `rate_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_profile_rates`
--

LOCK TABLES `rate_profile_rates` WRITE;
/*!40000 ALTER TABLE `rate_profile_rates` DISABLE KEYS */;
INSERT INTO `rate_profile_rates` VALUES
(1,1,'8880','bd',0.0230,0.0000,'USD',NULL);
/*!40000 ALTER TABLE `rate_profile_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate_profiles`
--

DROP TABLE IF EXISTS `rate_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_profiles`
--

LOCK TABLES `rate_profiles` WRITE;
/*!40000 ALTER TABLE `rate_profiles` DISABLE KEYS */;
INSERT INTO `rate_profiles` VALUES
(1,'admin','hh',1,'2026-04-08 02:20:39','2026-04-08 02:20:39');
/*!40000 ALTER TABLE `rate_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_costs`
--

DROP TABLE IF EXISTS `session_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_costs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cgrid` varchar(40) NOT NULL,
  `run_id` varchar(64) NOT NULL,
  `origin_host` varchar(64) NOT NULL,
  `origin_id` varchar(128) NOT NULL,
  `cost_source` varchar(64) NOT NULL,
  `usage` bigint(20) NOT NULL,
  `cost_details` mediumtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `costid` (`cgrid`,`run_id`),
  KEY `origin_idx` (`origin_host`,`origin_id`),
  KEY `run_origin_idx` (`run_id`,`origin_id`),
  KEY `deleted_at_idx` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_costs`
--

LOCK TABLES `session_costs` WRITE;
/*!40000 ALTER TABLE `session_costs` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_account_actions`
--

DROP TABLE IF EXISTS `tp_account_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_account_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `loadid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `account` varchar(64) NOT NULL,
  `action_plan_tag` varchar(64) DEFAULT NULL,
  `action_triggers_tag` varchar(64) DEFAULT NULL,
  `allow_negative` tinyint(1) NOT NULL,
  `disabled` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_tp_account` (`tpid`,`loadid`,`tenant`,`account`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_account_actions`
--

LOCK TABLES `tp_account_actions` WRITE;
/*!40000 ALTER TABLE `tp_account_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_account_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_action_plans`
--

DROP TABLE IF EXISTS `tp_action_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_action_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `actions_tag` varchar(64) NOT NULL,
  `timing_tag` varchar(64) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_action_schedule` (`tpid`,`tag`,`actions_tag`,`timing_tag`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_action_plans`
--

LOCK TABLES `tp_action_plans` WRITE;
/*!40000 ALTER TABLE `tp_action_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_action_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_action_triggers`
--

DROP TABLE IF EXISTS `tp_action_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_action_triggers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `unique_id` varchar(64) NOT NULL,
  `threshold_type` char(64) NOT NULL,
  `threshold_value` decimal(20,4) NOT NULL,
  `recurrent` tinyint(1) NOT NULL,
  `min_sleep` varchar(16) NOT NULL,
  `expiry_time` varchar(26) NOT NULL,
  `activation_time` varchar(26) NOT NULL,
  `balance_tag` varchar(64) NOT NULL,
  `balance_type` varchar(24) NOT NULL,
  `balance_categories` varchar(32) NOT NULL,
  `balance_destination_tags` varchar(64) NOT NULL,
  `balance_rating_subject` varchar(64) NOT NULL,
  `balance_shared_groups` varchar(64) NOT NULL,
  `balance_expiry_time` varchar(26) NOT NULL,
  `balance_timing_tags` varchar(128) NOT NULL,
  `balance_weight` varchar(10) NOT NULL,
  `balance_blocker` varchar(5) NOT NULL,
  `balance_disabled` varchar(5) NOT NULL,
  `actions_tag` varchar(64) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_trigger_definition` (`tpid`,`tag`,`balance_tag`,`balance_type`,`threshold_type`,`threshold_value`,`balance_destination_tags`,`actions_tag`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_action_triggers`
--

LOCK TABLES `tp_action_triggers` WRITE;
/*!40000 ALTER TABLE `tp_action_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_action_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_actions`
--

DROP TABLE IF EXISTS `tp_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `action` varchar(24) NOT NULL,
  `extra_parameters` varchar(256) NOT NULL,
  `filters` varchar(256) NOT NULL,
  `balance_tag` varchar(64) NOT NULL,
  `balance_type` varchar(24) NOT NULL,
  `categories` varchar(32) NOT NULL,
  `destination_tags` varchar(64) NOT NULL,
  `rating_subject` varchar(64) NOT NULL,
  `shared_groups` varchar(64) NOT NULL,
  `expiry_time` varchar(26) NOT NULL,
  `timing_tags` varchar(128) NOT NULL,
  `units` varchar(256) NOT NULL,
  `balance_weight` varchar(10) NOT NULL,
  `balance_blocker` varchar(5) NOT NULL,
  `balance_disabled` varchar(24) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_action` (`tpid`,`tag`,`action`,`balance_tag`,`balance_type`,`expiry_time`,`timing_tags`,`destination_tags`,`shared_groups`,`balance_weight`,`weight`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_actions`
--

LOCK TABLES `tp_actions` WRITE;
/*!40000 ALTER TABLE `tp_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_attributes`
--

DROP TABLE IF EXISTS `tp_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_attributes` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `contexts` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `attribute_filter_ids` varchar(64) NOT NULL,
  `path` varchar(64) NOT NULL,
  `type` varchar(64) NOT NULL,
  `value` varchar(64) NOT NULL,
  `blocker` tinyint(1) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_attributes` (`tpid`,`tenant`,`id`,`filter_ids`,`path`,`value`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_attributes`
--

LOCK TABLES `tp_attributes` WRITE;
/*!40000 ALTER TABLE `tp_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_chargers`
--

DROP TABLE IF EXISTS `tp_chargers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_chargers` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `run_id` varchar(64) NOT NULL,
  `attribute_ids` varchar(64) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_chargers` (`tpid`,`tenant`,`id`,`filter_ids`,`run_id`,`attribute_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_chargers`
--

LOCK TABLES `tp_chargers` WRITE;
/*!40000 ALTER TABLE `tp_chargers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_chargers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_destination_rates`
--

DROP TABLE IF EXISTS `tp_destination_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_destination_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `destinations_tag` varchar(64) NOT NULL,
  `rates_tag` varchar(64) NOT NULL,
  `rounding_method` varchar(255) NOT NULL,
  `rounding_decimals` tinyint(4) NOT NULL,
  `max_cost` decimal(7,4) NOT NULL,
  `max_cost_strategy` varchar(16) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tpid_drid_dstid` (`tpid`,`tag`,`destinations_tag`),
  KEY `tpid` (`tpid`),
  KEY `tpid_drid` (`tpid`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_destination_rates`
--

LOCK TABLES `tp_destination_rates` WRITE;
/*!40000 ALTER TABLE `tp_destination_rates` DISABLE KEYS */;
INSERT INTO `tp_destination_rates` VALUES
(4,'kazitel','DestinationRate_Kazitel','Dest_Local','Rate_Local','*up',4,0.0000,'','2026-04-06 03:23:33'),
(5,'kazitel','DestinationRate_Kazitel','Dest_Mobile','Rate_Mobile','*up',4,0.0000,'','2026-04-06 03:23:33'),
(6,'kazitel','DestinationRate_Kazitel','Dest_TollFree','Rate_TollFree','*up',4,0.0000,'','2026-04-06 03:23:33');
/*!40000 ALTER TABLE `tp_destination_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_destinations`
--

DROP TABLE IF EXISTS `tp_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_destinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `prefix` varchar(24) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tpid_dest_prefix` (`tpid`,`tag`,`prefix`),
  KEY `tpid` (`tpid`),
  KEY `tpid_dstid` (`tpid`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_destinations`
--

LOCK TABLES `tp_destinations` WRITE;
/*!40000 ALTER TABLE `tp_destinations` DISABLE KEYS */;
INSERT INTO `tp_destinations` VALUES
(8,'kazitel','Dest_Local','612','2026-04-06 03:23:33'),
(9,'kazitel','Dest_Local','613','2026-04-06 03:23:33'),
(10,'kazitel','Dest_Local','617','2026-04-06 03:23:33'),
(11,'kazitel','Dest_Local','618','2026-04-06 03:23:33'),
(12,'kazitel','Dest_Mobile','614','2026-04-06 03:23:33'),
(13,'kazitel','Dest_TollFree','6113','2026-04-06 03:23:33'),
(14,'kazitel','Dest_TollFree','6118','2026-04-06 03:23:33'),
(15,'kazitel','ghh','98',NULL),
(16,'abc','654','777',NULL);
/*!40000 ALTER TABLE `tp_destinations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_dispatcher_hosts`
--

DROP TABLE IF EXISTS `tp_dispatcher_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_dispatcher_hosts` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `address` varchar(64) NOT NULL,
  `transport` varchar(64) NOT NULL,
  `connect_attempts` int(11) NOT NULL,
  `reconnects` int(11) NOT NULL,
  `max_reconnect_interval` varchar(64) NOT NULL,
  `connect_timeout` varchar(64) NOT NULL,
  `reply_timeout` varchar(64) NOT NULL,
  `tls` tinyint(1) NOT NULL,
  `client_key` varchar(64) NOT NULL,
  `client_certificate` varchar(64) NOT NULL,
  `ca_certificate` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_dispatchers_hosts` (`tpid`,`tenant`,`id`,`address`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_dispatcher_hosts`
--

LOCK TABLES `tp_dispatcher_hosts` WRITE;
/*!40000 ALTER TABLE `tp_dispatcher_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_dispatcher_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_dispatcher_profiles`
--

DROP TABLE IF EXISTS `tp_dispatcher_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_dispatcher_profiles` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `subsystems` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `strategy` varchar(64) NOT NULL,
  `strategy_parameters` varchar(64) NOT NULL,
  `conn_id` varchar(64) NOT NULL,
  `conn_filter_ids` varchar(64) NOT NULL,
  `conn_weight` decimal(8,2) NOT NULL,
  `conn_blocker` tinyint(1) NOT NULL,
  `conn_parameters` varchar(64) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_dispatcher_profiles` (`tpid`,`tenant`,`id`,`filter_ids`,`strategy`,`conn_id`,`conn_filter_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_dispatcher_profiles`
--

LOCK TABLES `tp_dispatcher_profiles` WRITE;
/*!40000 ALTER TABLE `tp_dispatcher_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_dispatcher_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_filters`
--

DROP TABLE IF EXISTS `tp_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_filters` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `type` varchar(16) NOT NULL,
  `element` varchar(64) NOT NULL,
  `values` varchar(256) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_filters` (`tpid`,`tenant`,`id`,`type`,`element`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_filters`
--

LOCK TABLES `tp_filters` WRITE;
/*!40000 ALTER TABLE `tp_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_ips`
--

DROP TABLE IF EXISTS `tp_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_ips` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `ttl` varchar(32) NOT NULL,
  `type` varchar(64) NOT NULL,
  `address_pool` varchar(64) NOT NULL,
  `allocation` varchar(64) NOT NULL,
  `stored` tinyint(1) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_ip` (`tpid`,`tenant`,`id`,`filter_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_ips`
--

LOCK TABLES `tp_ips` WRITE;
/*!40000 ALTER TABLE `tp_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_rankings`
--

DROP TABLE IF EXISTS `tp_rankings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_rankings` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `schedule` varchar(32) NOT NULL,
  `stat_ids` varchar(64) NOT NULL,
  `metric_ids` varchar(64) NOT NULL,
  `sorting` varchar(32) NOT NULL,
  `sorting_parameters` varchar(64) NOT NULL,
  `stored` tinyint(1) NOT NULL,
  `threshold_ids` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_rankings` (`tpid`,`tenant`,`id`,`stat_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_rankings`
--

LOCK TABLES `tp_rankings` WRITE;
/*!40000 ALTER TABLE `tp_rankings` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_rankings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_rates`
--

DROP TABLE IF EXISTS `tp_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `connect_fee` decimal(7,4) NOT NULL,
  `rate` decimal(10,4) NOT NULL,
  `rate_unit` varchar(16) NOT NULL,
  `rate_increment` varchar(16) NOT NULL,
  `group_interval_start` varchar(16) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_tprate` (`tpid`,`tag`,`group_interval_start`),
  KEY `tpid` (`tpid`),
  KEY `tpid_rtid` (`tpid`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_rates`
--

LOCK TABLES `tp_rates` WRITE;
/*!40000 ALTER TABLE `tp_rates` DISABLE KEYS */;
INSERT INTO `tp_rates` VALUES
(4,'kazitel','Rate_Local',0.0000,0.1400,'60s','60s','0s','2026-04-06 03:23:33'),
(5,'kazitel','Rate_Mobile',0.0000,0.2200,'60s','60s','0s','2026-04-06 03:23:33'),
(6,'kazitel','Rate_TollFree',0.2500,0.0000,'60s','60s','0s','2026-04-06 03:23:33');
/*!40000 ALTER TABLE `tp_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_rating_plans`
--

DROP TABLE IF EXISTS `tp_rating_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_rating_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `destrates_tag` varchar(64) NOT NULL,
  `timing_tag` varchar(64) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tpid_rplid_destrates_timings_weight` (`tpid`,`tag`,`destrates_tag`,`timing_tag`),
  KEY `tpid` (`tpid`),
  KEY `tpid_rpl` (`tpid`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_rating_plans`
--

LOCK TABLES `tp_rating_plans` WRITE;
/*!40000 ALTER TABLE `tp_rating_plans` DISABLE KEYS */;
INSERT INTO `tp_rating_plans` VALUES
(2,'kazitel','RatingPlan_Kazitel','DestinationRate_Kazitel','*any',10.00,'2026-04-06 03:23:33'),
(3,'test','test','ffd','*any',10.00,NULL);
/*!40000 ALTER TABLE `tp_rating_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_rating_profiles`
--

DROP TABLE IF EXISTS `tp_rating_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_rating_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `loadid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `category` varchar(32) NOT NULL,
  `subject` varchar(64) NOT NULL,
  `activation_time` varchar(26) NOT NULL,
  `rating_plan_tag` varchar(64) NOT NULL,
  `fallback_subjects` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tpid_loadid_tenant_category_subj_atime` (`tpid`,`loadid`,`tenant`,`category`,`subject`,`activation_time`),
  KEY `tpid` (`tpid`),
  KEY `tpid_loadid` (`tpid`,`loadid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_rating_profiles`
--

LOCK TABLES `tp_rating_profiles` WRITE;
/*!40000 ALTER TABLE `tp_rating_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_rating_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_resources`
--

DROP TABLE IF EXISTS `tp_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_resources` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `usage_ttl` varchar(32) NOT NULL,
  `limit` varchar(64) NOT NULL,
  `allocation_message` varchar(64) NOT NULL,
  `blocker` tinyint(1) NOT NULL,
  `stored` tinyint(1) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `threshold_ids` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_resource` (`tpid`,`tenant`,`id`,`filter_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_resources`
--

LOCK TABLES `tp_resources` WRITE;
/*!40000 ALTER TABLE `tp_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_routes`
--

DROP TABLE IF EXISTS `tp_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_routes` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `sorting` varchar(32) NOT NULL,
  `sorting_parameters` varchar(64) NOT NULL,
  `route_id` varchar(32) NOT NULL,
  `route_filter_ids` varchar(64) NOT NULL,
  `route_account_ids` varchar(64) NOT NULL,
  `route_ratingplan_ids` varchar(64) NOT NULL,
  `route_rate_profile_ids` varchar(64) NOT NULL,
  `route_resource_ids` varchar(64) NOT NULL,
  `route_stat_ids` varchar(64) NOT NULL,
  `route_weight` decimal(8,2) NOT NULL,
  `route_blocker` tinyint(1) NOT NULL,
  `route_parameters` varchar(64) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `sandbox_mode` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_routes` (`tpid`,`tenant`,`id`,`filter_ids`,`route_id`,`route_filter_ids`,`route_account_ids`,`route_ratingplan_ids`,`route_resource_ids`,`route_stat_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_routes`
--

LOCK TABLES `tp_routes` WRITE;
/*!40000 ALTER TABLE `tp_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_shared_groups`
--

DROP TABLE IF EXISTS `tp_shared_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_shared_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `account` varchar(64) NOT NULL,
  `strategy` varchar(24) NOT NULL,
  `rating_subject` varchar(24) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_shared_group` (`tpid`,`tag`,`account`,`strategy`,`rating_subject`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_shared_groups`
--

LOCK TABLES `tp_shared_groups` WRITE;
/*!40000 ALTER TABLE `tp_shared_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_shared_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_stats`
--

DROP TABLE IF EXISTS `tp_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_stats` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `queue_length` int(11) NOT NULL,
  `ttl` varchar(32) NOT NULL,
  `min_items` int(11) NOT NULL,
  `metric_ids` varchar(128) NOT NULL,
  `metric_filter_ids` varchar(64) NOT NULL,
  `stored` tinyint(1) NOT NULL,
  `blocker` tinyint(1) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `threshold_ids` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_stats` (`tpid`,`tenant`,`id`,`filter_ids`,`metric_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_stats`
--

LOCK TABLES `tp_stats` WRITE;
/*!40000 ALTER TABLE `tp_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_thresholds`
--

DROP TABLE IF EXISTS `tp_thresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_thresholds` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `filter_ids` varchar(64) NOT NULL,
  `activation_interval` varchar(64) NOT NULL,
  `max_hits` int(11) NOT NULL,
  `min_hits` int(11) NOT NULL,
  `min_sleep` varchar(16) NOT NULL,
  `blocker` tinyint(1) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `action_ids` varchar(64) NOT NULL,
  `async` tinyint(1) NOT NULL,
  `ee_ids` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_thresholds` (`tpid`,`tenant`,`id`,`filter_ids`,`action_ids`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_thresholds`
--

LOCK TABLES `tp_thresholds` WRITE;
/*!40000 ALTER TABLE `tp_thresholds` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_thresholds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_timings`
--

DROP TABLE IF EXISTS `tp_timings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_timings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `years` varchar(255) NOT NULL,
  `months` varchar(255) NOT NULL,
  `month_days` varchar(255) NOT NULL,
  `week_days` varchar(255) NOT NULL,
  `time` varchar(32) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tpid_tag` (`tpid`,`tag`),
  KEY `tpid` (`tpid`),
  KEY `tpid_tmid` (`tpid`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_timings`
--

LOCK TABLES `tp_timings` WRITE;
/*!40000 ALTER TABLE `tp_timings` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_timings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tp_trends`
--

DROP TABLE IF EXISTS `tp_trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_trends` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `id` varchar(64) NOT NULL,
  `schedule` varchar(64) NOT NULL,
  `stat_id` varchar(64) NOT NULL,
  `metrics` varchar(128) NOT NULL,
  `ttl` varchar(32) NOT NULL,
  `queue_length` int(11) NOT NULL,
  `min_items` int(11) NOT NULL,
  `correlation_type` varchar(64) NOT NULL,
  `tolerance` decimal(8,2) NOT NULL,
  `stored` tinyint(1) NOT NULL,
  `threshold_ids` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `unique_tp_trends` (`tpid`,`tenant`,`id`,`stat_id`),
  KEY `tpid` (`tpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tp_trends`
--

LOCK TABLES `tp_trends` WRITE;
/*!40000 ALTER TABLE `tp_trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(64) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_item` (`id`,`item`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
INSERT INTO `versions` VALUES
(27,'TpRatingPlan',1),
(28,'TpChargers',1),
(29,'TpDispatchers',1),
(30,'TpDestinationRates',1),
(31,'TpSharedGroups',1),
(32,'TpResources',1),
(33,'TpRatingProfile',1),
(34,'CostDetails',2),
(35,'SessionSCosts',3),
(36,'CDRs',2),
(37,'TpAccountActions',1),
(38,'TpActionPlans',1),
(39,'TpRoutes',1),
(40,'TpRatingProfiles',1),
(41,'TpIPs',1),
(42,'TpRatingPlans',1),
(43,'TpFilters',1),
(44,'TpThresholds',1),
(45,'TpStats',1),
(46,'TpRates',1),
(47,'TpResource',1),
(48,'TpIP',1),
(49,'TpDestinations',1),
(50,'TpActionTriggers',1),
(51,'TpActions',1),
(52,'TpTiming',1);
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-13 14:51:33
