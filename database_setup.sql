-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: e_grad
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `duration_minutes` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` VALUES (1,'Database Management Systems (DBMS)','Test your knowledge on SQL, Normalization, Keys, and ACID properties.',2,'2026-04-14 13:44:18'),(2,'Data Structures and Algorithms (DSA)','Assess your skills in Arrays, Linked Lists, Trees, Graphs, and Sorting.',2,'2026-04-14 13:44:18'),(3,'Core Java Programming','A comprehensive quiz on OOPs concepts, Exception Handling, and Multithreading.',2,'2026-04-14 13:44:18');
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int DEFAULT NULL,
  `question_text` text NOT NULL,
  `option_a` varchar(255) NOT NULL,
  `option_b` varchar(255) NOT NULL,
  `option_c` varchar(255) NOT NULL,
  `option_d` varchar(255) NOT NULL,
  `correct_option` enum('A','B','C','D') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_id` (`exam_id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (7,1,'What does DBMS stand for?','Data Backup Management System','Database Management System','Data Base Monitoring System','Database Mapping System','B'),(8,1,'Which language is used to interact with databases?','HTML','SQL','Java','Python','B'),(9,1,'Which normal form removes partial dependency?','1NF','2NF','3NF','BCNF','B'),(10,1,'Primary key is:','Duplicate value','Unique identifier','Optional field','Foreign reference','B'),(11,1,'Which command is used to remove a table?','DELETE','REMOVE','DROP','ERASE','C'),(12,1,'Which is not a DBMS?','MySQL','Oracle','MongoDB','Google Chrome','D'),(13,1,'Foreign key is used to:','Delete data','Link tables','Create table','Insert data','B'),(14,1,'Which clause is used to filter rows?','GROUP BY','ORDER BY','WHERE','HAVING','C'),(15,1,'ACID property \"A\" stands for:','Accuracy','Atomicity','Access','Action','B'),(16,1,'Which join returns matching rows only?','LEFT JOIN','RIGHT JOIN','INNER JOIN','FULL JOIN','C'),(17,2,'Which data structure uses FIFO?','Stack','Queue','Tree','Graph','B'),(18,2,'Which uses LIFO?','Queue','Stack','Array','Linked List','B'),(19,2,'Time complexity of binary search?','O(n)','O(log n)','O(n²)','O(1)','B'),(20,2,'Which is non-linear DS?','Array','Stack','Tree','Queue','C'),(21,2,'Which traversal uses recursion?','BFS','DFS','Both','None','B'),(22,2,'Worst case of quicksort?','O(n)','O(log n)','O(n²)','O(n log n)','C'),(23,2,'Which DS is used in recursion?','Queue','Stack','Tree','Graph','B'),(24,2,'Heap is a:','Linear DS','Non-linear DS','Static DS','Primitive DS','B'),(25,2,'Which search is fastest for sorted array?','Linear','Binary','Jump','Hash','B'),(26,2,'Graph uses:','Nodes and edges','Keys only','Values only','Arrays only','A'),(27,3,'Java is:','Platform dependent','Platform independent','OS dependent','None','B'),(28,3,'Which keyword is used to inherit a class?','implement','extends','inherit','super','B'),(29,3,'JVM stands for:','Java Virtual Machine','Java Variable Method','Just Virtual Machine','Java Verified Machine','A'),(30,3,'Which is not a primitive type?','int','float','String','char','C'),(31,3,'Which method is entry point?','start()','main()','run()','init()','B'),(32,3,'Which keyword is used for abstraction?','class','abstract','final','static','B'),(33,3,'Which is used to handle exceptions?','try-catch','if-else','switch','loop','A'),(34,3,'Which collection allows duplicates?','Set','List','Map','None','B'),(35,3,'Which keyword prevents inheritance?','static','final','private','protected','B'),(36,3,'Which loop executes at least once?','for','while','do-while','foreach','C');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `score` int NOT NULL,
  `total_questions` int NOT NULL,
  `taken_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `exam_id` (`exam_id`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` VALUES (1,1,1,5,10,'2026-04-21 11:43:38'),(2,1,2,2,10,'2026-04-21 11:45:00'),(3,2,1,3,10,'2026-04-22 08:21:30'),(4,2,1,3,10,'2026-04-22 08:27:58'),(5,2,1,4,10,'2026-04-24 14:47:13'),(6,2,3,7,10,'2026-04-24 14:48:23'),(7,4,1,7,10,'2026-04-28 11:46:18'),(8,4,2,4,10,'2026-04-28 11:50:52'),(9,4,3,6,10,'2026-04-28 11:52:37'),(10,4,1,0,10,'2026-04-29 08:26:43'),(11,4,1,2,10,'2026-04-29 09:02:10'),(12,4,1,2,10,'2026-05-03 17:16:26');
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','admin') DEFAULT 'student',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `program` varchar(100) DEFAULT 'Not Assigned',
  `semester` varchar(50) DEFAULT 'Semester 1',
  `mobile` varchar(15) DEFAULT NULL,
  `dob` varchar(20) DEFAULT NULL,
  `blood_group` varchar(10) DEFAULT NULL,
  `fathers_name` varchar(100) DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Aneesh','aneesh@gmail.com','123','student','2026-04-08 17:23:04','Not Assigned','Semester 1',NULL,NULL,NULL,NULL,NULL),(2,'OMM','omm@gmail.com','123','student','2026-04-21 12:31:59','B.Tech CSE','Semester 4','9881635279','2005-02-14','O+','Unknown','Dhenkanal'),(3,'Kundan','kd@gmail.com','Kundan@12','student','2026-04-24 14:07:04','B.Tech CSE','Semester 4',NULL,NULL,NULL,NULL,NULL),(4,'DEMO','demo12@gmail.com','Demo@1234','student','2026-04-28 11:34:54','B.Tech CSE','Semester 4',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-07 22:53:56
