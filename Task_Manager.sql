CREATE DATABASE  IF NOT EXISTS `task_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `task_management`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: task_management
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_by` int NOT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  KEY `uploaded_by` (`uploaded_by`),
  CONSTRAINT `attachment_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`),
  CONSTRAINT `attachment_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment`
--

LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
INSERT INTO `attachment` VALUES (7,26,'document - 2025-04-10T162440.122.pdf','uploads\\1751748112241_document - 2025-04-10T162440.122.pdf',1,'2025-07-05 13:41:52'),(8,27,'sequence diagram.pdf','uploads\\1751748192924_sequence diagram.pdf',1,'2025-07-05 13:43:13'),(9,28,'TestingSystem.sql','uploads\\1751748273856_TestingSystem.sql',1,'2025-07-05 13:44:34');
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `details` text,
  `entity` varchar(255) DEFAULT NULL,
  `entity_id` int DEFAULT NULL,
  `timestamp` datetime(6) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,'CREATE','Tạo mới project ID 13: test3-audit log','Project',13,'2025-06-29 19:19:54.855117','admin1'),(2,'CREATE','Thêm user ID 6 vào project ID 13','ProjectMember',NULL,'2025-06-29 19:20:34.117724','admin1'),(3,'STATUS_CHANGE','Cập nhật trạng thái task ID 4 thành IN_PROGRESS','Task',4,'2025-07-05 09:02:41.990380','employee1'),(4,'STATUS_CHANGE','Cập nhật trạng thái task ID 4 thành TODO','Task',4,'2025-07-05 09:02:45.744352','employee1'),(5,'STATUS_CHANGE','Cập nhật trạng thái task ID 4 thành DONE','Task',4,'2025-07-05 09:02:49.057950','employee1'),(6,'STATUS_CHANGE','Cập nhật trạng thái task ID 4 thành IN_PROGRESS','Task',4,'2025-07-05 09:18:00.847101','employee1'),(7,'CREATE','Cập nhật tiến độ task ID 4: 20% – \"null\"','ProgressLog',2,'2025-07-05 09:22:12.641480','employee1'),(8,'CREATE','Cập nhật tiến độ task ID 4: 30% – \"null\"','ProgressLog',3,'2025-07-05 09:22:22.025893','employee1'),(9,'CREATE','Cập nhật tiến độ task ID 4: 10% – \"test\"','ProgressLog',4,'2025-07-05 09:57:23.097699','employee1'),(10,'CREATE','Cập nhật tiến độ task ID 4: 20% – \"\"','ProgressLog',5,'2025-07-05 09:57:29.071274','employee1'),(11,'CREATE','Thêm comment vào task ID 4: \"abc\"','Comment',3,'2025-07-05 10:00:48.464313','employee1'),(12,'CREATE','Upload file \"Lesson10.pdf\" vào task ID 4','Attachment',2,'2025-07-05 10:04:54.259085','employee1'),(13,'CREATE','Cập nhật tiến độ task ID 4: 100% – \"done\"','ProgressLog',6,'2025-07-05 10:29:19.796988','employee1'),(14,'DELETE','Xoá file đính kèm ID 2','Attachment',2,'2025-07-05 10:29:44.771117','employee1'),(15,'CREATE','Cập nhật tiến độ task ID 4: 50% – \"\"','ProgressLog',7,'2025-07-05 10:30:24.875753','employee1'),(16,'CREATE','Cập nhật tiến độ task ID 4: 50% – \"half-done\"','ProgressLog',8,'2025-07-05 10:30:36.905907','employee1'),(17,'CREATE','Upload file \"1-PL1-Hướng dẫn báo cáo tổng kết-mẫu bia 2025.doc\" vào task ID 4','Attachment',3,'2025-07-05 10:33:43.377206','employee1'),(18,'UPDATE','Sửa comment ID 3: \"123\"','Comment',3,'2025-07-05 10:34:51.830871','employee1'),(19,'CREATE','Cập nhật tiến độ task ID 4: 50% – \"\"','ProgressLog',9,'2025-07-05 10:35:16.695401','employee1'),(20,'UPDATE','Cập nhật task ID 4: Task 1','Task',4,'2025-07-05 10:46:48.173526','admin'),(21,'UPDATE','Cập nhật task ID 4: Task 2','Task',4,'2025-07-05 10:46:52.791324','admin'),(22,'UPDATE','Cập nhật task ID 4: Task 3','Task',4,'2025-07-05 10:46:58.138328','admin'),(23,'UPDATE','Cập nhật task ID 4: Task 1','Task',4,'2025-07-05 11:08:51.548933','admin'),(24,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:26:09.489662','admin'),(25,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:26:12.867870','admin'),(26,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:26:24.945030','admin'),(27,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:40:35.394470','admin'),(28,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:44:32.287469','admin'),(29,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:45:58.963488','admin'),(30,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:49:11.967307','admin'),(31,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:49:36.566820','admin'),(32,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:50:20.380027','admin'),(33,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:56:30.612057','admin'),(34,'UPDATE','Cập nhật task ID 4: Task 1','Task',4,'2025-07-05 11:56:40.115379','admin'),(35,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 11:57:22.220473','admin'),(36,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:20:30.348218','admin'),(37,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:20:43.577467','admin'),(38,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:21:33.510310','admin'),(39,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:22:11.529779','admin'),(40,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:26:53.976668','admin'),(41,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:28:15.666308','admin'),(42,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:30:13.020945','admin'),(43,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:33:43.210343','admin'),(44,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:33:48.203322','admin'),(45,'STATUS_CHANGE','Cập nhật trạng thái task ID 4 thành IN_PROGRESS','Task',4,'2025-07-05 12:36:07.593847','employee1'),(46,'STATUS_CHANGE','Cập nhật trạng thái task ID 4 thành TODO','Task',4,'2025-07-05 12:36:14.358655','employee1'),(47,'CREATE','Thêm comment vào task ID 4: \"abc\"','Comment',4,'2025-07-05 12:56:33.039454','admin'),(48,'UPDATE','Cập nhật task ID 4: Task test','Task',4,'2025-07-05 12:56:45.593526','admin'),(49,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 12:56:53.457107','admin'),(50,'STATUS_CHANGE','Cập nhật trạng thái task ID 4 thành IN_PROGRESS','Task',4,'2025-07-05 12:57:19.480786','employee1'),(51,'DELETE','Xoá project ID 5','Project',5,'2025-07-05 13:19:46.392954','admin'),(52,'DELETE','Xoá project ID 8','Project',8,'2025-07-05 13:22:15.729743','admin'),(53,'CREATE','Tạo task ID 6: test trong project ID 4','Task',6,'2025-07-05 14:36:08.671534','admin'),(54,'CREATE','Tạo task ID 7: test trong project ID 4','Task',7,'2025-07-05 15:21:37.759148','admin'),(55,'CREATE','Tạo task ID 8: s trong project ID 4','Task',8,'2025-07-05 15:33:26.385480','admin'),(56,'CREATE','Tạo task ID 9: test trong project ID 4','Task',9,'2025-07-05 16:03:27.083848','admin'),(57,'ASSIGN','Phân công user cho task ID 9','Task',9,'2025-07-05 16:04:14.536773','admin'),(58,'CREATE','Tạo task ID 10: t trong project ID 4','Task',10,'2025-07-05 16:04:55.505228','admin'),(59,'CREATE','Tạo task ID 11: 21 trong project ID 4','Task',11,'2025-07-05 16:06:10.510977','admin'),(60,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 16:10:13.659186','admin'),(61,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 16:10:38.319676','admin'),(62,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 16:15:22.492886','admin'),(63,'DELETE','Xoá task ID 11','Task',11,'2025-07-05 16:40:47.718523','admin'),(64,'DELETE','Xoá task ID 9','Task',9,'2025-07-05 16:40:51.651089','admin'),(65,'DELETE','Xoá task ID 10','Task',10,'2025-07-05 16:41:23.608530','admin'),(66,'CREATE','Tạo task ID 12: s trong project ID 4','Task',12,'2025-07-05 16:44:13.895026','admin'),(67,'ASSIGN','Phân công user cho task ID 5','Task',5,'2025-07-05 16:47:03.093030','admin'),(68,'CREATE','Tạo task ID 13: s trong project ID 4','Task',13,'2025-07-05 16:49:26.944447','admin'),(69,'CREATE','Tạo task ID 14: d trong project ID 4','Task',14,'2025-07-05 16:50:58.029639','admin'),(70,'CREATE','Tạo task ID 15: s trong project ID 4','Task',15,'2025-07-05 16:57:06.409007','admin'),(71,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 16:59:02.619851','admin'),(72,'CREATE','Tạo task ID 16: t trong project ID 4','Task',16,'2025-07-05 17:02:41.122924','admin'),(73,'DELETE','Xoá task ID 16','Task',16,'2025-07-05 17:03:20.508033','admin'),(74,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 17:03:38.210783','admin'),(75,'CREATE','Tạo task ID 17: s trong project ID 4','Task',17,'2025-07-05 17:12:30.801785','admin'),(76,'CREATE','Tạo task ID 18: s trong project ID 4','Task',18,'2025-07-05 17:15:29.437590','admin'),(77,'ASSIGN','Phân công user cho task ID 4','Task',4,'2025-07-05 17:16:37.508731','admin'),(78,'CREATE','Tạo task ID 19: s trong project ID 4','Task',19,'2025-07-05 17:18:18.147983','admin'),(79,'CREATE','Tạo task ID 20: t trong project ID 4','Task',20,'2025-07-05 17:19:40.440961','admin'),(80,'CREATE','Thêm comment vào task ID 20: \"abc\"','Comment',5,'2025-07-05 17:19:54.684855','admin'),(81,'ASSIGN','Phân công user cho task ID 20','Task',20,'2025-07-05 17:20:08.669118','admin'),(82,'ASSIGN','Phân công user cho task ID 20','Task',20,'2025-07-05 17:20:15.915033','admin'),(83,'DELETE','Xoá comment ID 5','Comment',5,'2025-07-05 17:20:44.315446','admin'),(84,'DELETE','Xoá task ID 20','Task',20,'2025-07-05 17:20:46.262112','admin'),(85,'DELETE','Xoá task ID 19','Task',19,'2025-07-05 17:20:57.199271','admin'),(86,'DELETE','Xoá project ID 6','Project',6,'2025-07-05 17:24:37.352375','admin'),(87,'DELETE','Xoá project ID 9','Project',9,'2025-07-05 17:24:51.389207','admin'),(88,'DELETE','Xoá project ID 13','Project',13,'2025-07-05 17:37:34.697835','admin'),(89,'CREATE','Tạo task ID 21: task trong project ID 4','Task',21,'2025-07-05 17:38:20.195140','admin'),(90,'CREATE','Thêm comment vào task ID 21: \"sd\"','Comment',6,'2025-07-05 17:38:27.257838','admin'),(91,'CREATE','Upload file \"Lesson10.pdf\" vào task ID 21','Attachment',4,'2025-07-05 17:38:37.745484','admin'),(92,'DELETE','Xoá file đính kèm ID 4','Attachment',4,'2025-07-05 17:42:51.513209','admin'),(93,'DELETE','Xoá task ID 21','Task',21,'2025-07-05 17:43:54.923126','admin'),(94,'CREATE','Tạo task ID 22: s trong project ID 4','Task',22,'2025-07-05 17:46:18.824083','admin'),(95,'CREATE','Thêm comment vào task ID 22: \"s\"','Comment',7,'2025-07-05 17:46:23.482328','admin'),(96,'CREATE','Upload file \"1-PL1-Hướng dẫn báo cáo tổng kết-mẫu bia 2024.doc\" vào task ID 22','Attachment',5,'2025-07-05 17:46:30.688116','admin'),(97,'DELETE','Xoá task ID 22','Task',22,'2025-07-05 17:46:44.866844','admin'),(98,'DELETE','Xoá project ID 10','Project',10,'2025-07-05 17:47:04.263662','admin'),(99,'DELETE','Xoá project ID 11','Project',11,'2025-07-05 17:47:07.549569','admin'),(100,'CREATE','Tạo task ID 23: s trong project ID 4','Task',23,'2025-07-05 17:47:29.324248','admin'),(101,'CREATE','Thêm comment vào task ID 23: \"s\"','Comment',8,'2025-07-05 17:47:33.847648','admin'),(102,'UPDATE','Sửa comment ID 8: \"d\"','Comment',8,'2025-07-05 17:47:37.039090','admin'),(103,'DELETE','Xoá task ID 23','Task',23,'2025-07-05 17:51:36.805761','admin'),(104,'CREATE','Tạo task ID 24: s trong project ID 4','Task',24,'2025-07-05 18:00:49.210061','admin'),(105,'CREATE','Thêm comment vào task ID 24: \"sd\"','Comment',9,'2025-07-05 18:03:41.238361','admin'),(106,'CREATE','Upload file \"1-PL1-Hướng dẫn báo cáo tổng kết-mẫu bia 2024.doc\" vào task ID 24','Attachment',6,'2025-07-05 18:03:50.003331','admin'),(107,'UPDATE','Sửa comment ID 9: \"sdsd\"','Comment',9,'2025-07-05 18:03:53.630257','admin'),(108,'DELETE','Xoá task ID 24','Task',24,'2025-07-05 18:03:56.977808','admin'),(109,'DELETE','Xoá project ID 12','Project',12,'2025-07-05 18:11:23.930885','admin'),(110,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:04:48.181279','admin'),(111,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:05:41.189993','admin'),(112,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:09:30.400662','admin'),(113,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:10:10.886800','admin'),(114,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:11:22.343172','admin'),(115,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:11:23.231689','admin'),(116,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:11:44.333653','admin'),(117,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:16:17.090218','admin'),(118,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:18:56.931487','admin'),(119,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:20:03.969410','admin'),(120,'UPDATE','Cập nhật thành viên cho project ID 4','ProjectMember',NULL,'2025-07-05 19:20:04.061285','admin'),(121,'UPDATE','Cập nhật project ID 4: Dự án A','Project',4,'2025-07-05 19:20:08.781838','admin'),(122,'UPDATE','Cập nhật thành viên cho project ID 4','ProjectMember',NULL,'2025-07-05 19:20:08.806100','admin'),(123,'UPDATE','Cập nhật project ID 4: Dự án B','Project',4,'2025-07-05 19:20:30.298651','admin'),(124,'UPDATE','Cập nhật thành viên cho project ID 4','ProjectMember',NULL,'2025-07-05 19:20:30.330614','admin'),(125,'CREATE','Tạo mới project ID 14: A','Project',14,'2025-07-05 19:56:20.829695','admin'),(126,'CREATE','Thêm user ID 2 vào project ID 14','ProjectMember',NULL,'2025-07-05 19:56:20.891206','admin'),(127,'CREATE','Thêm user ID 3 vào project ID 14','ProjectMember',NULL,'2025-07-05 19:56:20.927380','admin'),(128,'CREATE','Thêm user ID 5 vào project ID 14','ProjectMember',NULL,'2025-07-05 19:56:20.959219','admin'),(129,'CREATE','Tạo task ID 25: Công việc 1 trong project ID 14','Task',25,'2025-07-05 19:56:48.516455','admin'),(130,'ASSIGN','Phân công user cho task ID 25','Task',25,'2025-07-05 19:57:20.548538','admin'),(131,'UPDATE','Cập nhật project ID 14: A','Project',14,'2025-07-05 19:57:29.637781','admin'),(132,'UPDATE','Cập nhật thành viên cho project ID 14','ProjectMember',NULL,'2025-07-05 19:57:29.675598','admin'),(133,'UPDATE','Cập nhật project ID 14: A','Project',14,'2025-07-05 19:57:43.220339','admin'),(134,'UPDATE','Cập nhật thành viên cho project ID 14','ProjectMember',NULL,'2025-07-05 19:57:43.238807','admin'),(135,'ASSIGN','Phân công user cho task ID 25','Task',25,'2025-07-05 19:57:47.226386','admin'),(136,'CREATE','Tạo mới project ID 15: C','Project',15,'2025-07-05 20:29:47.036487','admin'),(137,'CREATE','Thêm user ID 4 vào project ID 15','ProjectMember',NULL,'2025-07-05 20:29:47.089024','admin'),(138,'CREATE','Thêm user ID 5 vào project ID 15','ProjectMember',NULL,'2025-07-05 20:29:47.120013','admin'),(139,'DELETE','Xoá project ID 14','Project',14,'2025-07-05 20:36:24.937783','admin'),(140,'DELETE','Xoá project ID 15','Project',15,'2025-07-05 20:36:27.845549','admin'),(141,'DELETE','Xoá project ID 4','Project',4,'2025-07-05 20:36:47.887692','admin'),(142,'CREATE','Tạo mới project ID 16: Website Quản lý Công việc','Project',16,'2025-07-05 20:37:40.104634','admin'),(143,'CREATE','Thêm user ID 2 vào project ID 16','ProjectMember',NULL,'2025-07-05 20:37:40.130668','admin'),(144,'CREATE','Thêm user ID 3 vào project ID 16','ProjectMember',NULL,'2025-07-05 20:37:40.150932','admin'),(145,'CREATE','Thêm user ID 4 vào project ID 16','ProjectMember',NULL,'2025-07-05 20:37:40.172243','admin'),(146,'CREATE','Tạo task ID 26: Frontend trong project ID 16','Task',26,'2025-07-05 20:40:25.041256','admin'),(147,'CREATE','Tạo task ID 27: Backend trong project ID 16','Task',27,'2025-07-05 20:40:46.695198','admin'),(148,'CREATE','Thêm comment vào task ID 26: \"Hoàn thành trước 14/7\"','Comment',10,'2025-07-05 20:41:14.076527','admin'),(149,'CREATE','Upload file \"document - 2025-04-10T162440.122.pdf\" vào task ID 26','Attachment',7,'2025-07-05 20:41:52.279868','admin'),(150,'CREATE','Thêm comment vào task ID 27: \"Sử dụng Spring Security để quản lý đăng ký/đăng nhập\"','Comment',11,'2025-07-05 20:42:49.948800','admin'),(151,'CREATE','Upload file \"sequence diagram.pdf\" vào task ID 27','Attachment',8,'2025-07-05 20:43:12.947350','admin'),(152,'CREATE','Tạo task ID 28: Xây dựng Database trong project ID 16','Task',28,'2025-07-05 20:44:05.810389','admin'),(153,'CREATE','Thêm comment vào task ID 28: \"Sử dụng MySQL Workbench\"','Comment',12,'2025-07-05 20:44:21.045769','admin'),(154,'CREATE','Upload file \"TestingSystem.sql\" vào task ID 28','Attachment',9,'2025-07-05 20:44:33.881265','admin'),(155,'STATUS_CHANGE','Cập nhật trạng thái task ID 27 thành IN_PROGRESS','Task',27,'2025-07-05 20:45:15.722503','employee1'),(156,'CREATE','Thêm comment vào task ID 27: \"Đã hoàn thành 50%\"','Comment',13,'2025-07-05 20:45:30.646720','employee1'),(157,'CREATE','Thêm comment vào task ID 28: \"Done\"','Comment',14,'2025-07-05 20:45:47.576534','employee1'),(158,'STATUS_CHANGE','Cập nhật trạng thái task ID 28 thành DONE','Task',28,'2025-07-05 20:45:49.070225','employee1'),(159,'UPDATE','Cập nhật project ID 16: Website Quản lý Công việc','Project',16,'2025-07-05 20:46:51.162878','admin'),(160,'UPDATE','Cập nhật thành viên cho project ID 16','ProjectMember',NULL,'2025-07-05 20:46:51.185440','admin'),(161,'ASSIGN','Phân công user cho task ID 26','Task',26,'2025-07-05 20:46:58.462105','admin'),(162,'CREATE','Thêm comment vào task ID 26: \"Chậm tiến độ, có thể không hoàn thành đúng hạn\"','Comment',15,'2025-07-05 20:47:32.099711','employee3'),(163,'CREATE','Tạo mới project ID 17: Dự án A','Project',17,'2025-07-05 20:48:13.823591','admin'),(164,'CREATE','Thêm user ID 4 vào project ID 17','ProjectMember',NULL,'2025-07-05 20:48:13.848472','admin'),(165,'CREATE','Thêm user ID 5 vào project ID 17','ProjectMember',NULL,'2025-07-05 20:48:13.868947','admin'),(166,'CREATE','Thêm user ID 6 vào project ID 17','ProjectMember',NULL,'2025-07-05 20:48:13.886663','admin'),(167,'CREATE','Tạo task ID 29: Công việc 1 trong project ID 17','Task',29,'2025-07-05 20:48:35.678544','admin'),(168,'CREATE','Thêm comment vào task ID 29: \"Đã quá hạn\"','Comment',16,'2025-07-05 20:48:46.078257','admin'),(169,'STATUS_CHANGE','Cập nhật trạng thái task ID 29 thành IN_PROGRESS','Task',29,'2025-07-05 21:24:44.739095','employee3'),(170,'DELETE','Xoá user ID 7','User',7,'2025-07-05 22:14:08.625784','admin'),(171,'UPDATE','Cập nhật thông tin user ID 1','User',1,'2025-07-05 23:32:59.794507','admin'),(172,'UPDATE','Cập nhật thông tin user ID 4','User',4,'2025-07-05 23:38:27.253912','admin'),(173,'UPDATE','Cập nhật thông tin user ID 4','User',4,'2025-07-05 23:38:35.171536','admin'),(174,'UPDATE','Cập nhật thông tin user ID 2','User',2,'2025-07-05 23:38:48.163200','admin'),(175,'DELETE','Xoá user ID 9','User',9,'2025-07-05 23:39:55.524310','admin'),(176,'UPDATE','Cập nhật project ID 16: ','Project',16,'2025-07-05 23:44:20.509806','admin'),(177,'UPDATE','Cập nhật thành viên cho project ID 16','ProjectMember',NULL,'2025-07-05 23:44:20.559494','admin'),(178,'UPDATE','Cập nhật project ID 16: Website Quản lý Công việc','Project',16,'2025-07-05 23:44:43.671928','admin'),(179,'UPDATE','Cập nhật thành viên cho project ID 16','ProjectMember',NULL,'2025-07-05 23:44:43.693548','admin');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  KEY `fk_comment_created_by` (`created_by`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`),
  CONSTRAINT `fk_comment_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (10,26,'Hoàn thành trước 14/7','2025-07-05 13:41:14',1),(11,27,'Sử dụng Spring Security để quản lý đăng ký/đăng nhập','2025-07-05 13:42:50',1),(12,28,'Sử dụng MySQL Workbench','2025-07-05 13:44:21',1),(13,27,'Đã hoàn thành 50%','2025-07-05 13:45:31',3),(14,28,'Done','2025-07-05 13:45:48',3),(15,26,'Chậm tiến độ, có thể không hoàn thành đúng hạn','2025-07-05 13:47:32',5),(16,29,'Đã quá hạn','2025-07-05 13:48:46',1);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_history`
--

DROP TABLE IF EXISTS `comment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `edited_at` datetime(6) DEFAULT NULL,
  `previous_content` text NOT NULL,
  `comment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6kwcknjqpn84lsvw37cg5d4ya` (`comment_id`),
  CONSTRAINT `FK6kwcknjqpn84lsvw37cg5d4ya` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_history`
--

LOCK TABLES `comment_history` WRITE;
/*!40000 ALTER TABLE `comment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,3,'Nguyen Van C đã cập nhật tiến độ task \'Task 1\' lên 60%',1,'2025-06-29 11:02:54'),(2,4,'Bạn đã được thêm vào project: test2-Thong bao',0,'2025-06-29 11:05:13'),(3,3,'Bạn đã được giao task: Task test',1,'2025-06-29 11:06:04'),(4,4,'Bạn đã được giao task: Task test',0,'2025-06-29 11:06:04'),(5,4,'admin1 đã thêm 1 bình luận vào task: Task test',0,'2025-06-29 11:06:39'),(6,3,'admin1 đã thêm 1 bình luận vào task: Task test',1,'2025-06-29 11:06:39'),(7,6,'Bạn đã được thêm vào project: test3-audit log',0,'2025-06-29 12:20:34'),(8,4,'Task \"Task 1\" đã đổi trạng thái từ TODO sang IN_PROGRESS',0,'2025-07-05 02:02:42'),(9,3,'Task \"Task 1\" đã đổi trạng thái từ TODO sang IN_PROGRESS',1,'2025-07-05 02:02:42'),(10,3,'Task \"Task 1\" đã đổi trạng thái từ IN_PROGRESS sang TODO',1,'2025-07-05 02:02:46'),(11,4,'Task \"Task 1\" đã đổi trạng thái từ IN_PROGRESS sang TODO',0,'2025-07-05 02:02:46'),(12,4,'Task \"Task 1\" đã đổi trạng thái từ TODO sang DONE',0,'2025-07-05 02:02:49'),(13,3,'Task \"Task 1\" đã đổi trạng thái từ TODO sang DONE',1,'2025-07-05 02:02:49'),(14,4,'Task \"Task 1\" đã đổi trạng thái từ DONE sang IN_PROGRESS',0,'2025-07-05 02:18:01'),(15,3,'Task \"Task 1\" đã đổi trạng thái từ DONE sang IN_PROGRESS',1,'2025-07-05 02:18:01'),(16,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 20%',0,'2025-07-05 02:22:13'),(17,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 30%',0,'2025-07-05 02:22:22'),(18,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 10%',0,'2025-07-05 02:57:23'),(19,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 20%',0,'2025-07-05 02:57:29'),(20,4,'employee1 đã thêm 1 bình luận vào task: Task 1',0,'2025-07-05 03:00:48'),(21,4,'employee1 đã thêm 1 file vào task: Task 1',0,'2025-07-05 03:04:54'),(22,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 100%',0,'2025-07-05 03:29:20'),(23,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 50%',0,'2025-07-05 03:30:25'),(24,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 50%',0,'2025-07-05 03:30:37'),(25,4,'employee1 đã thêm 1 file vào task: Task 1',0,'2025-07-05 03:33:43'),(26,4,'Tran Minh B đã cập nhật tiến độ task \'Task 1\' lên 50%',0,'2025-07-05 03:35:17'),(27,3,'Bạn đã được giao task: Task 1',1,'2025-07-05 04:40:35'),(28,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 04:40:35'),(29,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 04:50:20'),(30,3,'Bạn đã được giao task: Task 1',1,'2025-07-05 04:50:20'),(31,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 04:57:22'),(32,3,'Bạn đã được giao task: Task 1',1,'2025-07-05 04:57:22'),(33,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:20:30'),(35,6,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:20:44'),(36,6,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:21:34'),(37,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:22:12'),(39,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:26:54'),(40,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:28:16'),(43,6,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:30:13'),(45,6,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:33:43'),(46,4,'Bạn đã được giao task: Task 1',0,'2025-07-05 05:33:48'),(47,3,'Bạn đã được giao task: Task 1',1,'2025-07-05 05:33:48'),(48,4,'Task \"Task 1\" đã đổi trạng thái từ IN_PROGRESS sang TODO',0,'2025-07-05 05:36:14'),(49,3,'Task \"Task 1\" đã đổi trạng thái từ IN_PROGRESS sang TODO',1,'2025-07-05 05:36:14'),(50,3,'admin đã thêm 1 bình luận vào task: Task 1',1,'2025-07-05 05:56:33'),(51,4,'admin đã thêm 1 bình luận vào task: Task 1',0,'2025-07-05 05:56:33'),(52,4,'Bạn đã được giao task: Task test',0,'2025-07-05 05:56:53'),(54,3,'Bạn đã được giao task: Task test',1,'2025-07-05 05:56:53'),(55,4,'Task \"Task test\" đã đổi trạng thái từ TODO sang IN_PROGRESS',0,'2025-07-05 05:57:19'),(57,3,'Task \"Task test\" đã đổi trạng thái từ TODO sang IN_PROGRESS',1,'2025-07-05 05:57:19'),(58,4,'Bạn đã được giao task: test',0,'2025-07-05 08:21:38'),(59,3,'Bạn đã được giao task: test',1,'2025-07-05 08:21:38'),(60,3,'Bạn đã được giao task: s',1,'2025-07-05 08:33:26'),(61,4,'Bạn đã được giao task: test',0,'2025-07-05 09:04:15'),(62,4,'Bạn đã được giao task: 21',0,'2025-07-05 09:06:10'),(63,3,'Bạn đã được giao task: 21',1,'2025-07-05 09:06:11'),(64,3,'Bạn đã được giao task: Task test',1,'2025-07-05 09:10:14'),(65,4,'Bạn đã được giao task: Task test',0,'2025-07-05 09:10:14'),(66,3,'Bạn đã được giao task: Task test',1,'2025-07-05 09:10:38'),(67,4,'Bạn đã được giao task: Task test',0,'2025-07-05 09:10:38'),(68,4,'Bạn đã được giao task: Task test',0,'2025-07-05 09:15:22'),(69,3,'Bạn đã được giao task: Task test',1,'2025-07-05 09:15:22'),(70,3,'Bạn đã được giao task: s',1,'2025-07-05 09:44:14'),(71,3,'Bạn đã được giao task: d',1,'2025-07-05 09:50:58'),(72,4,'Bạn đã được giao task: d',0,'2025-07-05 09:50:58'),(73,3,'Bạn đã được giao task: s',1,'2025-07-05 09:57:06'),(74,4,'Bạn đã được giao task: s',0,'2025-07-05 09:57:06'),(75,3,'Bạn đã được giao task: Task test',1,'2025-07-05 09:59:03'),(76,3,'Bạn đã được giao task: t',1,'2025-07-05 10:02:41'),(77,4,'Bạn đã được giao task: t',0,'2025-07-05 10:02:41'),(78,3,'Bạn đã được giao task: s',1,'2025-07-05 10:12:31'),(79,4,'Bạn đã được giao task: s',0,'2025-07-05 10:12:31'),(80,4,'Bạn đã được giao task: s',0,'2025-07-05 10:15:29'),(81,3,'Bạn đã được giao task: s',1,'2025-07-05 10:15:29'),(82,3,'Bạn đã được giao task: Task test',1,'2025-07-05 10:16:37'),(83,4,'Bạn đã được giao task: Task test',0,'2025-07-05 10:16:37'),(84,3,'Bạn đã được giao task: s',1,'2025-07-05 10:18:18'),(85,4,'Bạn đã được giao task: s',0,'2025-07-05 10:18:18'),(86,3,'Bạn đã được giao task: t',1,'2025-07-05 10:19:40'),(87,3,'admin đã thêm 1 bình luận vào task: t',1,'2025-07-05 10:19:55'),(88,4,'Bạn đã được giao task: t',0,'2025-07-05 10:20:09'),(89,3,'Bạn đã được giao task: t',1,'2025-07-05 10:20:09'),(90,3,'Bạn đã được giao task: task',1,'2025-07-05 10:38:20'),(91,4,'Bạn đã được giao task: task',0,'2025-07-05 10:38:20'),(92,3,'admin đã thêm 1 bình luận vào task: task',1,'2025-07-05 10:38:27'),(93,4,'admin đã thêm 1 bình luận vào task: task',0,'2025-07-05 10:38:27'),(94,3,'admin đã thêm 1 file vào task: task',1,'2025-07-05 10:38:38'),(95,4,'admin đã thêm 1 file vào task: task',0,'2025-07-05 10:38:38'),(96,3,'Bạn đã được giao task: s',1,'2025-07-05 10:46:19'),(97,4,'Bạn đã được giao task: s',0,'2025-07-05 10:46:19'),(98,3,'admin đã thêm 1 bình luận vào task: s',1,'2025-07-05 10:46:23'),(99,4,'admin đã thêm 1 bình luận vào task: s',0,'2025-07-05 10:46:23'),(100,4,'admin đã thêm 1 file vào task: s',0,'2025-07-05 10:46:31'),(101,3,'admin đã thêm 1 file vào task: s',1,'2025-07-05 10:46:31'),(102,3,'Bạn đã được giao task: s',1,'2025-07-05 10:47:29'),(103,3,'admin đã thêm 1 bình luận vào task: s',1,'2025-07-05 10:47:34'),(104,3,'Bạn đã được giao task: s',1,'2025-07-05 11:00:49'),(105,4,'Bạn đã được giao task: s',0,'2025-07-05 11:00:49'),(106,4,'admin đã thêm 1 bình luận vào task: s',0,'2025-07-05 11:03:41'),(109,4,'admin đã thêm 1 file vào task: s',0,'2025-07-05 11:03:50'),(110,2,'Bạn đã được thêm vào project: A',0,'2025-07-05 12:56:21'),(118,4,'Bạn đã được thêm vào project: C',0,'2025-07-05 13:29:47'),(120,2,'Bạn đã được thêm vào project: Website Quản lý Công việc',0,'2025-07-05 13:37:40'),(121,3,'Bạn đã được thêm vào project: Website Quản lý Công việc',0,'2025-07-05 13:37:40'),(122,4,'Bạn đã được thêm vào project: Website Quản lý Công việc',0,'2025-07-05 13:37:40'),(123,2,'Bạn đã được giao task: Frontend',0,'2025-07-05 13:40:25'),(124,4,'Bạn đã được giao task: Backend',0,'2025-07-05 13:40:47'),(125,3,'Bạn đã được giao task: Backend',0,'2025-07-05 13:40:47'),(126,2,'admin đã thêm 1 bình luận vào task: Frontend',0,'2025-07-05 13:41:14'),(127,2,'admin đã thêm 1 file vào task: Frontend',0,'2025-07-05 13:41:52'),(128,3,'admin đã thêm 1 bình luận vào task: Backend',0,'2025-07-05 13:42:50'),(129,4,'admin đã thêm 1 bình luận vào task: Backend',0,'2025-07-05 13:42:50'),(130,3,'admin đã thêm 1 file vào task: Backend',0,'2025-07-05 13:43:13'),(131,4,'admin đã thêm 1 file vào task: Backend',0,'2025-07-05 13:43:13'),(132,3,'Bạn đã được giao task: Xây dựng Database',0,'2025-07-05 13:44:06'),(133,2,'Bạn đã được giao task: Xây dựng Database',0,'2025-07-05 13:44:06'),(134,4,'Bạn đã được giao task: Xây dựng Database',0,'2025-07-05 13:44:06'),(135,2,'admin đã thêm 1 bình luận vào task: Xây dựng Database',0,'2025-07-05 13:44:21'),(136,3,'admin đã thêm 1 bình luận vào task: Xây dựng Database',0,'2025-07-05 13:44:21'),(137,4,'admin đã thêm 1 bình luận vào task: Xây dựng Database',0,'2025-07-05 13:44:21'),(138,3,'admin đã thêm 1 file vào task: Xây dựng Database',0,'2025-07-05 13:44:34'),(139,4,'admin đã thêm 1 file vào task: Xây dựng Database',0,'2025-07-05 13:44:34'),(140,2,'admin đã thêm 1 file vào task: Xây dựng Database',0,'2025-07-05 13:44:34'),(141,4,'Task \"Backend\" đã đổi trạng thái từ TODO sang IN_PROGRESS',0,'2025-07-05 13:45:16'),(142,3,'Task \"Backend\" đã đổi trạng thái từ TODO sang IN_PROGRESS',0,'2025-07-05 13:45:16'),(143,4,'employee1 đã thêm 1 bình luận vào task: Backend',0,'2025-07-05 13:45:31'),(144,4,'employee1 đã thêm 1 bình luận vào task: Xây dựng Database',0,'2025-07-05 13:45:48'),(145,2,'employee1 đã thêm 1 bình luận vào task: Xây dựng Database',0,'2025-07-05 13:45:48'),(146,3,'Task \"Xây dựng Database\" đã đổi trạng thái từ TODO sang DONE',0,'2025-07-05 13:45:49'),(147,2,'Task \"Xây dựng Database\" đã đổi trạng thái từ TODO sang DONE',0,'2025-07-05 13:45:49'),(148,4,'Task \"Xây dựng Database\" đã đổi trạng thái từ TODO sang DONE',0,'2025-07-05 13:45:49'),(149,5,'Bạn đã được giao task: Frontend',1,'2025-07-05 13:46:58'),(150,4,'Bạn đã được thêm vào project: Dự án A',0,'2025-07-05 13:48:14'),(151,5,'Bạn đã được thêm vào project: Dự án A',1,'2025-07-05 13:48:14'),(152,6,'Bạn đã được thêm vào project: Dự án A',0,'2025-07-05 13:48:14'),(153,4,'Bạn đã được giao task: Công việc 1',0,'2025-07-05 13:48:36'),(154,5,'Bạn đã được giao task: Công việc 1',1,'2025-07-05 13:48:36'),(155,5,'admin đã thêm 1 bình luận vào task: Công việc 1',1,'2025-07-05 13:48:46'),(156,4,'admin đã thêm 1 bình luận vào task: Công việc 1',0,'2025-07-05 13:48:46'),(157,5,'Task \"Công việc 1\" đã đổi trạng thái từ TODO sang IN_PROGRESS',1,'2025-07-05 14:24:45'),(158,4,'Task \"Công việc 1\" đã đổi trạng thái từ TODO sang IN_PROGRESS',0,'2025-07-05 14:24:45');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `created_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (16,'Website Quản lý Công việc','Backend: Spring Boot\nFrontend: html/css/js',1,'2025-07-05 13:37:40'),(17,'Dự án A','Dự án đầu tiên',1,'2025-07-05 13:48:14');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectmember`
--

DROP TABLE IF EXISTS `projectmember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectmember` (
  `project_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`project_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `projectmember_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `projectmember_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectmember`
--

LOCK TABLES `projectmember` WRITE;
/*!40000 ALTER TABLE `projectmember` DISABLE KEYS */;
INSERT INTO `projectmember` VALUES (16,3),(16,4),(17,4),(16,5),(17,5),(17,6);
/*!40000 ALTER TABLE `projectmember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `status` enum('TODO','IN_PROGRESS','DONE') DEFAULT 'TODO',
  `deadline` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (26,16,'Frontend','html/css/js','TODO','2025-07-14'),(27,16,'Backend','Spring Boot','IN_PROGRESS','2025-07-16'),(28,16,'Xây dựng Database','MySql','DONE','2025-07-12'),(29,17,'Công việc 1','Mô tả đơn giản','IN_PROGRESS','2025-07-05');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_assignment`
--

DROP TABLE IF EXISTS `task_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_assignment` (
  `task_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`task_id`,`user_id`),
  KEY `FKgnn1uvmfhp33nah67wooyuyx6` (`user_id`),
  CONSTRAINT `FKgnn1uvmfhp33nah67wooyuyx6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKl6y92anypt7k8sso0qtij3lj7` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_assignment`
--

LOCK TABLES `task_assignment` WRITE;
/*!40000 ALTER TABLE `task_assignment` DISABLE KEYS */;
INSERT INTO `task_assignment` VALUES (28,2),(27,3),(28,3),(27,4),(28,4),(29,4),(26,5),(29,5);
/*!40000 ALTER TABLE `task_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `role` enum('ADMIN','EMPLOYEE') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `employee_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `employee_id_UNIQUE` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2a$12$a0PSgSXULvzzxq5z3IbLwe7ZmVkvCbiNfuLTwfve31O44SC1pGTga','Admin One','ADMIN','2025-06-11 06:44:03','AD001'),(2,'admin1','$2a$10$jq4jfRb7OcPFa722m/t1nun3nj3nEMn0FDBVr5BoB.jhPkRhEInoW','Nguyễn Văn A','ADMIN','2025-06-16 01:18:46','AD002'),(3,'employee1','$2a$10$tkL7V2rYWBBxo5ztCAQ/weV.xjqAvkScnrBkxPTxkkaLMhESwHCTW','Tran Minh B','EMPLOYEE','2025-06-16 03:32:22','NV002'),(4,'employee2','$2a$10$DP9WtgyAh3BSPXCHLuYpEevOCRCAkfrWlEjerafJGNExk4hCRGr.a','Nguyen Van C','EMPLOYEE','2025-06-16 04:33:13','NV003'),(5,'employee3','$2a$10$Cc9FjMP6p3Yvb392UlotzuiwhYeYA7qBaE8MRpJ9tVJXUPeq.sW9O','Nguyen Van D','EMPLOYEE','2025-06-16 05:50:08','NV004'),(6,'employee4','$2a$10$T6Z00Jmu5dMiB86tILP2heYpgUtthH1iZhzOYOVWQjQ5KL6CdWehW','Tran Ngoc Hai','EMPLOYEE','2025-06-29 11:24:48','NV005'),(8,'employee5','$2a$10$oC8wPwXM/FqQVFLFDqcs/uvS.RcwIEwhr6Pth8rUyq8BC/4ojsW9.','Hoang Nam T','EMPLOYEE','2025-07-05 16:32:30','NV006');
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

-- Dump completed on 2025-07-06  7:04:29
