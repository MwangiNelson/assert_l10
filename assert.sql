-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: protests
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

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

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `protest_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `volunteer_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alerts_volunteer_id_foreign` (`volunteer_id`),
  KEY `alerts_protest_id_foreign` (`protest_id`),
  CONSTRAINT `alerts_protest_id_foreign` FOREIGN KEY (`protest_id`) REFERENCES `protests` (`protest_id`) ON DELETE CASCADE,
  CONSTRAINT `alerts_volunteer_id_foreign` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (1,'6XJDMJcEbf4kMMeU','LoInyY62je5bsPwyG9qKt0sY34mO6GMf','2023-07-16 10:02:48','2023-07-16 10:02:48');
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `protest_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_protest_id_foreign` (`protest_id`),
  CONSTRAINT `comments_protest_id_foreign` FOREIGN KEY (`protest_id`) REFERENCES `protests` (`protest_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (13,'6XJDMJcEbf4kMMeU','But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because','2023-07-15 14:40:54','2023-07-15 14:40:54');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_100000_create_password_reset_tokens_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2023_06_20_101458_roles',1),(5,'2023_06_27_195755_users',1),(6,'2023_06_28_074947_protests',1),(7,'2024_07_09_111105_volunteers',1),(8,'2024_07_11_182141_volunteer_book',1),(9,'2024_07_15_130132_comments',1),(10,'2024_07_15_175236_protest_photos',2),(11,'2024_07_16_124620_alerts',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `protest_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `photos_protest_id_foreign` (`protest_id`),
  CONSTRAINT `photos_protest_id_foreign` FOREIGN KEY (`protest_id`) REFERENCES `protests` (`protest_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,'rMuQmm1oSG9UXNSX','https://firebasestorage.googleapis.com/v0/b/assert-f4412.appspot.com/o/assertImages%2FWhatsApp%20Image%202023-07-08%20at%2012.31.46%20PM.jpeg?alt=media&token=42c65b2e-0b33-4adf-8657-68ed1993e1a3','2023-07-15 16:14:49','2023-07-15 16:14:49'),(5,'6XJDMJcEbf4kMMeU','https://firebasestorage.googleapis.com/v0/b/assert-f4412.appspot.com/o/assertImages%2F07_09_23DRWBLE.jpeg?alt=media&token=d53743d5-0547-4b47-b088-9be26c06f8bc','2023-07-15 16:44:59','2023-07-15 16:44:59');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protests`
--

DROP TABLE IF EXISTS `protests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `protests` (
  `protest_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `venue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_date` date NOT NULL,
  `is_validated` tinyint(1) NOT NULL,
  `creator_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `protests_protest_id_unique` (`protest_id`),
  KEY `protests_creator_token_foreign` (`creator_token`),
  CONSTRAINT `protests_creator_token_foreign` FOREIGN KEY (`creator_token`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protests`
--

LOCK TABLES `protests` WRITE;
/*!40000 ALTER TABLE `protests` DISABLE KEYS */;
INSERT INTO `protests` VALUES ('6XJDMJcEbf4kMMeU','Change Prices','At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.','Ndurumo RD','2023-07-19',1,'z4whY8Uqk3O2bjjBHGGPm332aAdbLc4D','2023-07-15 11:23:23','2023-07-15 11:24:49'),('rMuQmm1oSG9UXNSX','Bruno Mars','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tempus vestibulum massa, et tincidunt ligula consectetur vitae. Praesent lectus libero, euismod vel mollis in, vestibulum quis nulla. Aenean quis arcu a velit elementum consectetur. Curabitur nec nisl nec purus blandit fringilla. Mauris convallis elit a dui fringilla sodales. Nullam tristique enim id est aliquet, vitae imperdiet purus mattis. Quisque gravida ligula ac nisl tincidunt, et interdum ipsum varius. Fusce ex magna, lobortis nec finibus pellentesque, aliquet rhoncus nunc. Ut pretium arcu lobortis neque iaculis aliquam.\n\nDonec non sagittis magna. Suspendisse vulputate ipsum nunc, in aliquam eros aliquam et. Nulla efficitur sollicitudin iaculis. Donec lectus libero, pulvinar sit amet ipsum vitae, dapibus bibendum quam. Fusce eu gravida est. Quisque id nulla congue, ultrices augue at, malesuada mauris. Curabitur justo turpis, feugiat a tellus id, tincidunt consequat leo. Etiam ornare, dolor volutpat lacinia rutrum, nisi est egestas diam, non sagittis ante orci ut dui.\n\nPellentesque mattis erat et ornare pulvinar. Nam dapibus massa vitae nulla aliquam dictum. Integer et quam non velit iaculis egestas. Quisque sed bibendum tellus. Nullam vel maximus velit, nec mollis risus. Proin rutrum luctus justo quis ornare. Suspendisse malesuada diam sed viverra maximus. In convallis ante arcu, vel pretium lacus laoreet quis. Curabitur a lobortis ipsum, eget efficitur quam. Aliquam fermentum aliquam tellus eget ornare. Duis accumsan elit at pulvinar rutrum. Donec scelerisque, massa ac tincidunt mattis, nunc diam tincidunt orci, non laoreet diam magna et felis. Phasellus ac cursus mauris.\n\nNam malesuada, ipsum condimentum vehicula aliquet, felis massa convallis lacus, ac tincidunt elit libero ut tellus. Ut egestas iaculis lorem, sed aliquet nibh pharetra eget. Cras quis diam id ipsum hendrerit placerat.','Mars','2023-07-21',1,'z4whY8Uqk3O2bjjBHGGPm332aAdbLc4D','2023-07-15 10:40:39','2023-07-15 11:24:44');
/*!40000 ALTER TABLE `protests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_role_name_index` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'volunteer','2023-07-15 10:39:13','2023-07-15 10:39:13'),(2,'administrator','2023-07-15 10:39:22','2023-07-15 10:39:22'),(3,'protestor','2023-07-15 10:39:30','2023-07-15 10:39:30');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_banned` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `users_id_unique` (`id`),
  KEY `users_role_index` (`role`),
  CONSTRAINT `users_role_foreign` FOREIGN KEY (`role`) REFERENCES `roles` (`role_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('baGG4LInTw43tfMc23T5JbOfBj4XtMoV','Idi Admin','admin@assert.app','$2y$10$DXTbdUFh.LPpA8/psL34DuApWrsG01Bgngh/jMh0c3hmlRK81gzA.','administrator',0,'2023-07-15 11:24:09','2023-07-15 11:24:09'),('eELfXzZs6OZNWXvf46Ye5cDw28oWNA7X','Group Therapy','group@assert.app','$2y$10$C35uNz0bewFl2idwDq9a4OF15C4Ce8FXkjbiyVMxaSpEndQiiA2nO','protestor',0,'2023-07-15 12:35:03','2023-07-15 12:35:03'),('z4whY8Uqk3O2bjjBHGGPm332aAdbLc4D','Mojo Jojo','mojojo@assert.app','$2y$10$0eljMVpZMzE90BODJm6IWOdoP1fZqJX3PZrXqCu0F0Ed8x2o91WQe','protestor',0,'2023-07-15 10:39:46','2023-07-15 10:39:46');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volunteer_book`
--

DROP TABLE IF EXISTS `volunteer_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volunteer_book` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `volunteer_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `protest_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_validated` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volunteer_book_volunteer_id_foreign` (`volunteer_id`),
  KEY `volunteer_book_protest_id_foreign` (`protest_id`),
  CONSTRAINT `volunteer_book_protest_id_foreign` FOREIGN KEY (`protest_id`) REFERENCES `protests` (`protest_id`) ON DELETE CASCADE,
  CONSTRAINT `volunteer_book_volunteer_id_foreign` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteer_book`
--

LOCK TABLES `volunteer_book` WRITE;
/*!40000 ALTER TABLE `volunteer_book` DISABLE KEYS */;
INSERT INTO `volunteer_book` VALUES (3,'LoInyY62je5bsPwyG9qKt0sY34mO6GMf','6XJDMJcEbf4kMMeU',0,'2023-07-16 10:10:28','2023-07-16 10:10:28');
/*!40000 ALTER TABLE `volunteer_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volunteers`
--

DROP TABLE IF EXISTS `volunteers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volunteers` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` int NOT NULL,
  `national_id` blob,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'volunteer',
  `conduct_certificate` blob,
  `is_validated` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `volunteers_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteers`
--

LOCK TABLES `volunteers` WRITE;
/*!40000 ALTER TABLE `volunteers` DISABLE KEYS */;
INSERT INTO `volunteers` VALUES ('LoInyY62je5bsPwyG9qKt0sY34mO6GMf','John Doe','jondoe@assert.app','EXOdoJV9',111111118,NULL,'volunteer',NULL,1,'2023-07-16 06:48:50','2023-07-16 06:48:55'),('xxPgZY1DQbejdwRy9wpE1HQkHgcVT6Y9','Nelson','nelsonmwangi197@gmail.com','SADpgjEx',1111111111,NULL,'volunteer',NULL,0,'2023-07-16 06:48:07','2023-07-16 06:48:07');
/*!40000 ALTER TABLE `volunteers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-16 20:53:47
