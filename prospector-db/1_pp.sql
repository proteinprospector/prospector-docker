-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: ppsd
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aborted_jobs`
--

USE ppsd;

DROP TABLE IF EXISTS `aborted_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aborted_jobs` (
  `aborted_job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `error_message` varchar(512) DEFAULT NULL,
  `search_job_key` char(16) DEFAULT NULL,
  `search_program` varchar(31) DEFAULT NULL,
  `search_stage` tinyint(4) DEFAULT NULL,
  `search_number` smallint(6) DEFAULT NULL,
  `num_serial` smallint(6) DEFAULT NULL,
  `results_name` varchar(63) DEFAULT NULL,
  `results_file` varchar(63) DEFAULT NULL,
  `results_path` varchar(255) DEFAULT NULL,
  `priority` tinyint(4) DEFAULT NULL,
  `job_status` smallint(6) DEFAULT NULL,
  `job_signal` tinyint(4) DEFAULT NULL,
  `job_segment` int(11) DEFAULT NULL,
  `node_name` varchar(128) DEFAULT NULL,
  `node_pid` int(11) DEFAULT NULL,
  `percent_complete` tinyint(4) DEFAULT NULL,
  `search_submitted` datetime DEFAULT NULL,
  `search_started` datetime DEFAULT NULL,
  `project_id` int(10) unsigned DEFAULT NULL,
  `project_name` varchar(63) DEFAULT NULL,
  `project_file` varchar(63) DEFAULT NULL,
  `project_path` varchar(255) DEFAULT NULL,
  `instrument` varchar(64) DEFAULT NULL,
  `calibration_index` smallint(6) DEFAULT NULL,
  `pp_user_id` int(10) unsigned DEFAULT NULL,
  `user_name` varchar(63) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `directory_name` char(10) DEFAULT NULL,
  `max_search_time` int(10) unsigned DEFAULT NULL,
  `allow_raw` tinyint(4) DEFAULT NULL,
  `record_created` datetime DEFAULT NULL,
  `record_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aborted_job_id`),
  UNIQUE KEY `search_job_key_idx` (`search_job_key`)
) ENGINE=InnoDB AUTO_INCREMENT=5383 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pp_users`
--

DROP TABLE IF EXISTS `pp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_users` (
  `pp_user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(63) NOT NULL,
  `secret_phrase` varchar(63) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `directory_name` char(10) NOT NULL,
  `first_name` varchar(63) DEFAULT NULL,
  `last_name` varchar(63) DEFAULT NULL,
  `is_inactive` tinyint(4) DEFAULT '0',
  `max_spectra` int(10) unsigned DEFAULT '0',
  `max_search_time` int(10) unsigned DEFAULT '0',
  `delete_search_days` smallint(6) DEFAULT '0',
  `allow_raw` tinyint(4) DEFAULT '1',
  `record_created` datetime DEFAULT NULL,
  `record_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pp_user_id`),
  UNIQUE KEY `user_name_idx` (`user_name`),
  UNIQUE KEY `directory_name` (`directory_name`),
  KEY `email_idx` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pp_version`
--

DROP TABLE IF EXISTS `pp_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_version` (
  `application_version` varchar(24) DEFAULT NULL,
  `database_version` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `project_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pp_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `project_name` varchar(63) NOT NULL,
  `project_file` varchar(63) NOT NULL DEFAULT 'project.xml',
  `project_path` varchar(255) NOT NULL,
  `instrument` varchar(64) DEFAULT NULL,
  `calibration_index` smallint(6) NOT NULL DEFAULT '0',
  `record_created` datetime DEFAULT NULL,
  `record_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `pp_user_id` (`pp_user_id`,`project_name`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`pp_user_id`) REFERENCES `pp_users` (`pp_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42303 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_jobs`
--

DROP TABLE IF EXISTS `search_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_jobs` (
  `search_job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `search_job_key` char(16) DEFAULT NULL,
  `search_program` varchar(31) NOT NULL,
  `search_stage` tinyint(4) NOT NULL DEFAULT '0',
  `search_number` smallint(6) NOT NULL DEFAULT '0',
  `num_serial` smallint(6) NOT NULL DEFAULT '0',
  `project_id` int(10) unsigned NOT NULL,
  `results_name` varchar(63) NOT NULL,
  `results_file` varchar(63) DEFAULT NULL,
  `results_path` varchar(255) DEFAULT NULL,
  `priority` tinyint(4) NOT NULL DEFAULT '1',
  `job_status` smallint(6) NOT NULL DEFAULT '0',
  `job_signal` tinyint(4) NOT NULL DEFAULT '0',
  `job_segment` int(10) unsigned DEFAULT NULL,
  `node_name` varchar(128) DEFAULT NULL,
  `node_pid` int(11) DEFAULT NULL,
  `percent_complete` tinyint(4) NOT NULL DEFAULT '0',
  `search_submitted` datetime DEFAULT NULL,
  `search_started` datetime DEFAULT NULL,
  `search_finished` datetime DEFAULT NULL,
  `record_created` datetime DEFAULT NULL,
  `record_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`search_job_id`),
  UNIQUE KEY `search_job_key_idx` (`search_job_key`),
  KEY `project_id` (`project_id`),
  KEY `job_status_idx` (`job_status`),
  CONSTRAINT `search_jobs_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63984 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_key` char(32) DEFAULT NULL,
  `pp_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `record_created` datetime DEFAULT NULL,
  `record_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_key_idx` (`session_key`),
  KEY `pp_user_id` (`pp_user_id`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`pp_user_id`) REFERENCES `pp_users` (`pp_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9662 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-17 11:09:12

INSERT INTO pp_version (application_version, database_version) VALUES("5.0.0beta3", NULL);
INSERT INTO pp_version (application_version, database_version) VALUES(NULL, "0.9.9.3");
