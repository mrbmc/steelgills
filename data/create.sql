-- MySQL dump 10.11
--
-- Host: localhost    Database: scubalog
-- ------------------------------------------------------
-- Server version	5.0.67-community-nt

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
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `asset` (
  `asset_id` int(10) unsigned NOT NULL auto_increment,
  `asset_fk_user_id` int(10) unsigned NOT NULL,
  `asset_path` varchar(250) default NULL,
  `asset_filename` varchar(100) default NULL,
  `asset_filetype` varchar(50) default NULL,
  `asset_width` int(10) unsigned default NULL,
  `asset_height` int(10) unsigned default NULL,
  `asset_length` varchar(50) default NULL,
  PRIMARY KEY  (`asset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_link`
--

DROP TABLE IF EXISTS `asset_link`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `asset_link` (
  `link_id` int(10) unsigned NOT NULL auto_increment,
  `link_fk_asset_id` int(10) unsigned NOT NULL,
  `link_object_id` int(10) unsigned NOT NULL,
  `link_object_type` varchar(45) NOT NULL,
  PRIMARY KEY  (`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `asset_link`
--

LOCK TABLES `asset_link` WRITE;
/*!40000 ALTER TABLE `asset_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dive`
--

DROP TABLE IF EXISTS `dive`;
CREATE TABLE `dive` (
  `diveid` int(11) NOT NULL auto_increment,
  `fk_user_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `country` varchar(45) default NULL,
  `dateline` date default NULL,
  `bottom_time` int(11) default NULL,
  `deco_time` int(11) default NULL,
  `max_depth` int(11) default NULL,
  `time_start` datetime default NULL,
  `time_end` datetime default NULL,
  `air_start` int(11) default NULL,
  `air_end` int(11) default NULL,
  `weight` int(11) default NULL,
  `temperature` int(11) default '0',
  `current` int(11) default '0',
  `visibility` int(11) default '0',
  `wind_speed` int(11) default NULL,
  `air_temperature` int(11) default NULL,
  `wave_height` int(11) default NULL,
  `description` text,
  `created_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`diveid`),
  KEY `idx_user_id` (`fk_user_id`),
  KEY `idx_depth` (`max_depth`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `dive`
--

INSERT INTO `dive` VALUES (6,9,'Santa rosa wall','Cozumel, MX',NULL,'2009-01-13',20,3,56,'2009-01-11 10:16:00','2009-01-11 10:44:00',3000,1400,6,78,3,150,0,82,0,'','2009-01-23 21:11:50','2009-01-23 21:11:50'),(7,9,'Palancar Gardens','Cozumel, Mexico',NULL,'2009-01-12',40,4,40,'2009-01-11 12:00:00','2009-01-11 12:58:00',3000,1350,6,78,1,150,0,0,0,'','2009-01-25 02:41:43','2009-01-25 02:41:43'),(8,9,'Temple of Doom','Tulum, MX',NULL,'2009-01-15',44,3,60,'2009-01-15 10:38:00','2009-01-15 11:25:00',3000,1650,8,70,0,300,0,0,0,'Cenote with a halocline at 12M. \r\n\r\nCavern walls exhibited a delicate latice structure in limestone due to erosion. The eroded stone settled as a ultra-fine silt on the cavern floor. Many people had left their imprint in the silt.\r\n','2009-01-25 02:45:11','2009-01-25 02:45:11'),(12,9,'Gran Cenote','Tulum, Mexico',NULL,'2009-01-15',40,0,37,'2009-01-15 09:12:00','2009-01-15 09:58:00',2850,1500,8,70,0,300,0,0,0,'','2009-01-25 02:58:37','2009-01-25 02:58:37'),(13,9,'Mama Pina Wreck','Playa Del Carmen, MX',NULL,NULL,24,3,88,'2009-01-10 09:10:00','2009-01-10 09:42:00',3000,1100,6,78,4,100,15,80,3,'Sunken shrimp boat. Swim throughs on all 3 decks.\r\n\r\nStrong current from the starboard bow pushing us aft along the hull.\r\n\r\nMax got hung up on the fire coral and had to drift back from the bridge swim through.\r\n\r\nCounted about 8 barracudas drifting in the current on the starboard hull. Possible hyper-oxygenating.\r\n\r\nSpotted a large southern gray sting-ray on the ascent.\r\n\r\nTom from Nebraska had 150psi left and had to tandem breath with me. He held the octopus upside down and sucked some water.','2009-01-27 05:47:22','2009-01-27 05:47:22'),(14,9,'Barracuda Reef','Playa Del Carmen, MX',NULL,NULL,45,3,45,'2009-01-10 10:15:00','2009-01-10 11:05:00',3000,1400,6,78,2,100,15,81,3,'Coral fingers running perpendicular to shore. Light surf drift pushing us around.\r\n\r\n2\' Turtle, 8\" skate, schools of yellow jacks and snappers.','2009-01-27 05:53:00','2009-01-27 05:53:00');
/*!40000 ALTER TABLE `dive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `divesite`
--

DROP TABLE IF EXISTS `divesite`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `divesite` (
  `divesiteid` int(11) NOT NULL auto_increment,
  `title` varchar(128) default NULL,
  `city` varchar(128) default NULL,
  `country` varchar(45) default NULL,
  `latitude` float default NULL,
  `longitude` float default NULL,
  `max_depth` int(11) default NULL,
  `description` text,
  `created_at` datetime default NULL,
  `modified_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `f_user_id` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`divesiteid`),
  KEY `idx_name` (`title`),
  KEY `idx_geocode` (`latitude`,`longitude`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `divesite`
--

LOCK TABLES `divesite` WRITE;
/*!40000 ALTER TABLE `divesite` DISABLE KEYS */;
INSERT INTO `divesite` VALUES (1,'Santa Rosa Wall','Cozumel','Mexico',20.3349,-87.0275,130,'','2009-01-29 17:14:38','2009-01-29 22:14:39'),(2,'Temple of Doom','Tulum','Mexico',20.2292,-87.4573,50,'','2009-01-29 19:44:26','2009-01-30 00:44:26'),(3,'Hol Chan','Ambergris','Belize',17.8718,-87.9756,30,'','2009-01-29 20:55:19','2009-01-30 01:55:19');
/*!40000 ALTER TABLE `divesite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `status` varchar(10) character set latin1 collate latin1_bin default 'pending',
  `created_at` timestamp NOT NULL default '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `username` varchar(50) default NULL,
  `password` varchar(50) default NULL,
  `email` varchar(200) default NULL,
  `phone` varchar(45) default NULL,
  `address` varchar(200) default NULL,
  `address_2` varchar(200) default NULL,
  `city` varchar(200) default NULL,
  `state` varchar(200) default NULL,
  `zipcode` varchar(15) default NULL,
  `first_name` varchar(50) default NULL,
  `last_name` varchar(100) default NULL,
  `confirmation` varchar(50) default NULL,
  PRIMARY KEY  USING BTREE (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','2009-01-20 05:00:00','2008-10-28 16:03:17','admin','qwerty','admin@kageki.com','917-744-7689','45-08 40TH STREET','APT. F43','SUNNYSIDE','NY','11104','Dive','Bug','fa1ae12eacb657b1a26c0a6cd53c157b'),(9,'member','2009-01-26 16:27:06','2009-01-26 16:27:06','mrbmc','notadj','brian@mrbmc.com',NULL,'','','Long Island City','NY','','Brian','McConnell','8e0b8048db');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-01-30 20:57:42
