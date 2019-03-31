-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: fp_schema
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.16.04.2

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
-- Table structure for table `attendance_log`
--

DROP TABLE IF EXISTS `attendance_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance_log` (
  `attn_id` int(11) NOT NULL AUTO_INCREMENT,
  `stud_id` int(11) DEFAULT NULL,
  `regi_no` int(11) DEFAULT NULL,
  `entrance_time` time DEFAULT NULL,
  `attendance` tinyint(1) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`attn_id`),
  KEY `stud_id_idx` (`stud_id`),
  KEY `class_id_idx` (`class_id`),
  CONSTRAINT `class_id` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `stud_id` FOREIGN KEY (`stud_id`) REFERENCES `student` (`stud_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_log`
--

LOCK TABLES `attendance_log` WRITE;
/*!40000 ALTER TABLE `attendance_log` DISABLE KEYS */;
INSERT INTO `attendance_log` VALUES (1,1,2015331559,'05:00:00',1,1),(2,2,2015331550,'05:00:00',1,2),(3,1,2015331559,'05:00:00',1,2),(4,3,2015331551,'11:00:00',1,3),(5,4,201533140,'05:00:00',1,4),(6,1,2015331559,'05:00:00',1,5),(7,2,2015331550,'05:00:00',1,6),(8,6,201533115,'05:00:00',1,7),(9,10,201533146,'05:00:00',1,8),(10,1,2015331559,'05:00:00',1,9);
/*!40000 ALTER TABLE `attendance_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `allowance_time` time DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'2019-02-02','array','02:00:00','00:10:00'),(2,'2019-01-05','loop','03:00:00','00:15:00'),(3,'2019-02-10','function','11:00:00','00:05:00'),(4,'2019-03-01','js','05:00:00','00:00:00'),(5,'2019-04-01','nodejs','05:00:00','00:00:00'),(6,'2019-05-01','reactjs','05:00:00','00:00:00'),(7,'2019-05-01','framework','11:00:00','00:00:00'),(8,'2019-05-01','intro to db','08:00:00','00:00:00'),(9,'2019-06-01','indexing','08:00:00','00:00:00'),(10,'2019-06-01','transaction','09:00:00','00:00:00');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `stud_id` int(11) NOT NULL AUTO_INCREMENT,
  `regi_no` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `fp_url` varchar(255) DEFAULT NULL,
  `fp_signature` varchar(255) DEFAULT NULL,
  `register_date` datetime DEFAULT NULL,
  PRIMARY KEY (`stud_id`),
  UNIQUE KEY `regi_no_UNIQUE` (`regi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,2015331559,'jak','f','/.jak.jpg','2019-02-02 02:00:00','2019-01-01 02:00:00'),(2,2015331550,'mak','m','/.mak.jpg','2019-01-01 01:00:00',NULL),(3,2015331551,'rak','m','/.rak.jpg','2019-01-01 06:30:00',NULL),(4,201533140,'mol','m','','2019-01-01 01:00:00',NULL),(5,2015331556,'tay','f',NULL,NULL,NULL),(6,2015533115,'raka','f',NULL,NULL,NULL),(7,201533116,'jimi','f',NULL,NULL,NULL),(8,201533118,'lim','m',NULL,NULL,NULL),(9,201533145,'yin','m',NULL,NULL,NULL),(10,201533146,'tina','f',NULL,NULL,NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-10 18:19:36
