-- MySQL dump 10.13  Distrib 8.0.40, for macos14 (arm64)
--
-- Host: localhost    Database: aplikacija
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `administrator_username_IDX` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES (1,'Adrian','80511108AFB0F965A336651BBA51BCF4A8A476901FAB1AB5EB5FD5709A9CBE5D78F12D641888B590BEDC6D3C1A99E5EF10F085A8C42EDB8D9F8121E915533524'),(2,'test','DAEF4953B9783365CAD6615223720506CC46C5167CD16AB500FA597AA08FF964EB24FB19687F34D7665F778FCB6C5358FC0A5B81E1662CF90F73A2671C53F991'),(3,'peric','68076CA59B3569F762FE80118BAC26A1F3CD95F465DCFCF290B9FC370192BAE964CFE895878AF85D356003BA084FB86D1D15A16B2962DF170B119C2AC947EC05'),(5,'juric','DD455981DB0A3B75D910034E01E0FB8BBDADBD0DD7DFFC4D21A5AB77619317A75EF4E9F8EBB7942837B63013BE11A81F6894A60E710A338E5EA19A473B084DD1');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administrator_token`
--

DROP TABLE IF EXISTS `administrator_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`),
  KEY `administrator_token_administrator_FK` (`administrator_id`),
  CONSTRAINT `administrator_token_administrator_FK` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator_token`
--

LOCK TABLES `administrator_token` WRITE;
/*!40000 ALTER TABLE `administrator_token` DISABLE KEYS */;
INSERT INTO `administrator_token` VALUES (1,2,'2024-12-20 12:46:09','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzczNzcxNjkuOTEyLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40My4wIiwiaWF0IjoxNzM0Njk4NzY5fQ.Sp65_aRFiKU-O-H7xzoY5KuNdIpb1__r2t8PPKLs-V8','2025-01-20 12:46:09',1),(2,2,'2024-12-20 12:50:10','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzczNzc0MTAuNzg4LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40My4wIiwiaWF0IjoxNzM0Njk5MDEwfQ.doWTjZ2K0p5sjQVdTJcYdYXy0gW5XODvpyIAD2_dPiw','2025-01-20 12:50:10',1),(3,2,'2024-12-20 12:54:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzczNzc2NzQuNTU5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0Njk5Mjc0fQ.wI4cAymUa3zWNKKbqp9WmPaibmRBdXPiznStSBCmjNs','2025-01-20 12:54:34',1),(4,2,'2024-12-20 12:55:41','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzczNzc3NDEuMTgsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV83KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTguMSBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE3MzQ2OTkzNDF9.HXCOGqP7pflEKlAQxVf8bZ7JoW03oOU7-INXp0luT6Y','2025-01-20 12:55:41',1),(5,2,'2024-12-20 13:23:40','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzczNzk0MjAuOTUzLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0NzAxMDIwfQ.u7VWzHmSqu4VSOPdySGzMzaBWB39ilbkr84TH2N_3k8','2025-01-20 13:23:40',1),(6,2,'2024-12-20 13:36:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzczODAyMTYuNjk0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0NzAxODE2fQ.beUI2jmIHEz0TQmzXi1mR3ysoSNhlDNP-imJdTKPymw','2025-01-20 13:36:56',1),(7,2,'2024-12-20 13:37:20','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzczODAyNDAuNjk4LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0NzAxODQwfQ.nQQ2Esb8Okmmm0VDx2XbyFNADEMHkBjd1zuBsXTcvhA','2025-01-20 13:37:20',1),(8,2,'2024-12-23 16:09:11','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc2NDg1NTEuNTI0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0OTcwMTUxfQ.5nY9GTi5hlcvcExmK6UIvZmMU9_LONmRPMuWLPlhcYM','2025-01-23 16:09:11',1),(9,2,'2024-12-24 15:10:58','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc3MzE0NTguMDE3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MDUzMDU4fQ.giSch5w3tFlnGs7Spx72lR6NrvDEmrQGkX1d6-7QThM','2025-01-24 15:10:58',1),(10,2,'2024-12-24 16:06:49','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc3MzQ4MDkuODY5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MDU2NDA5fQ.Tm7OT5j4l-w7r_c6dUQbp6chHoP-h1Y0syRCeKU2xWo','2025-01-24 16:06:49',1),(11,2,'2024-12-24 16:35:09','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc3MzY1MDkuNzE2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MDU4MTA5fQ.v6OgDExZ2Ta-mmpU5AqlKX1LjBKtCFHMIPnjZABbvzY','2025-01-24 16:35:09',1),(12,2,'2024-12-24 22:43:54','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc3NTg2MzQuMzk1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MDgwMjM0fQ.p8vkmUkPdgTnhXVw1jDIgePcl2pwJDazfK5yg97NCMs','2025-01-24 22:43:54',1),(13,2,'2024-12-24 23:13:55','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc3NjA0MzUuNDI3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MDgyMDM1fQ.i1c9vgPA0oPOo3dWRMpDFqy-WLQYlHVWaogM5QyzTuI','2025-01-24 23:13:55',1),(14,2,'2024-12-25 00:53:12','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc3NjYzOTIuNTk5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MDg3OTkyfQ.zWW1434c8eqcVYPxHXPhL2XAez09UO_KotXDnWCuaV4','2025-01-25 00:53:12',1),(15,2,'2024-12-25 15:52:35','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc4MjAzNTUuMTkyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MTQxOTU1fQ.or8Cz2S1EZsrsqrAxUmGOzmn0PW_tFu32_Jncml6mVI','2025-01-25 15:52:35',1),(16,2,'2024-12-25 17:04:48','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc4MjQ2ODguNTg2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MTQ2Mjg4fQ.AQLEqieKB6cJ3KiSbs29SBlOHCJCTPKt_x8p2Ax2PNg','2025-01-25 17:04:48',1),(17,2,'2024-12-26 15:25:15','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MDUxMTUuMDgsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV83KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTguMSBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE3MzUyMjY3MTV9.1sSEEx9v9RIbdzTKeEMFO1feTqAw_AIri_66uNUdsgk','2025-01-26 15:25:15',1),(18,2,'2024-12-26 16:16:41','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MDgyMDEuMjE0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MjI5ODAxfQ.cX1GE1LW6fpAGvZ5j6JSD_kyqDKIM2f7Tl2YvQaB2Eg','2025-01-26 16:16:41',1),(19,2,'2024-12-26 16:31:25','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MDkwODUuNDgsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjQzLjAiLCJpYXQiOjE3MzUyMzA2ODV9.z2_b-9m75Q8GhdlvahDyEf8oGeSjls3IBh0qg9ayfZM','2025-01-26 16:31:25',1),(20,2,'2024-12-26 16:42:14','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MDk3MzQuMTY3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MjMxMzM0fQ.KRHSkH3WImilMAcHGKzoGTvi3BbxVDe-jUix0r5w0zs','2025-01-26 16:42:14',1),(21,2,'2024-12-26 17:28:57','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MTI1MzcuNTEzLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MjM0MTM3fQ.PqpdrF-_89846aoGfvMXATFlLyS6L-g8pxslzmcKrhs','2025-01-26 17:28:57',1),(22,2,'2024-12-26 18:35:32','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MTY1MzIuOTQxLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MjM4MTMyfQ.zz5IE3JSPJJXs4bR3AF-lNtHo4OvPluxx897U7HucP8','2025-01-26 18:35:32',1),(23,2,'2024-12-26 23:09:18','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MzI5NTguNDk1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MjU0NTU4fQ.GD5cfCjaoOEoWG0HBXCeVl3RtJGB7-45raaxjp0jjS0','2025-01-26 23:09:18',1),(24,2,'2024-12-27 00:07:02','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5MzY0MjIuNTQyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MjU4MDIyfQ.aZpCnZNONO6m7cKqwYBMDQGrvhJiJTz1W83DpP18LdI','2025-01-27 00:07:02',1),(25,2,'2024-12-27 16:28:13','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzc5OTUyOTMuNDg2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1MzE2ODkzfQ.BbQPJrsnOd1aVhEswz-fvLzQwTtBxkLWeql0acTlMcw','2025-01-27 16:28:13',1),(26,2,'2024-12-30 15:43:03','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzgyNTE3ODMuODYyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTczMzgzfQ.nkmuwxYTVOYvv22KeLxCdexHfVsx96WrMopaiNyv9Jo','2025-01-30 15:43:03',1),(27,2,'2024-12-30 15:46:15','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzgyNTE5NzUuNTcxLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTczNTc1fQ.UD-7kU7cN4flyPGYXm87Ue0VSCzt6pEeMdZ8onSxrEo','2025-01-30 15:46:15',1),(28,2,'2024-12-30 15:47:06','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzgyNTIwMjYuMzI5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTczNjI2fQ.3MQG0fQ9y50P3y-b-rUb_tJP47bHu073FclXX5obtRU','2025-01-30 15:47:06',1),(29,2,'2024-12-30 15:48:34','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzgyNTIxMTQuNTUyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTczNzE0fQ.qX1-46MZj_fe3MoklvE7PyR07BnxEYReLkplIHIjEUM','2025-01-30 15:48:34',1),(30,2,'2024-12-30 15:48:49','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzgyNTIxMjkuMDIzLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTczNzI5fQ.irHb66LtsTFFI3lxl4ghOAyqEhNdaITVUy9V8W0OHMw','2025-01-30 15:48:49',1),(31,2,'2024-12-30 15:53:33','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzgyNTI0MTMuMjUsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV83KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTguMSBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE3MzU1NzQwMTN9.3Ta2zEPRMgmB4-30MdOCHr-jn_huHVjQHfzSgIZGbX4','2025-01-30 15:53:33',1),(32,2,'2024-12-30 15:53:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3MzgyNTI0MzYuNTYyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTc0MDM2fQ.HZtnRt3gy_JDVDXOGncpbo2TWCa5PagMdn0M8ILtqwo','2025-01-30 15:53:56',1),(33,2,'2025-01-01 18:29:05','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg0MzQ1NDUuOTU5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NzU2MTQ1fQ.j5o--xz_MCFAAEClE2y_mWADAHVzMxy3npp2_Uciryo','2025-02-01 18:29:05',1),(34,2,'2025-01-01 18:29:52','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg0MzQ1OTIuMzE1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NzU2MTkyfQ.bqDA1hp-FE8H3A9aeLUM-S95LvPGF09xEMJr6WsJBMc','2025-02-01 18:29:52',1),(35,2,'2025-01-01 18:32:38','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg0MzQ3NTguODg4LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NzU2MzU4fQ.sBkRtX2gH1dGp6ReC5VXbm5bGcI3VMabqqzRJ2CX48Q','2025-02-01 18:32:38',1),(36,2,'2025-01-02 17:19:18','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg1MTY3NTguNywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xOC4xIFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTczNTgzODM1OH0.EZY01ltEFnwxrw8rOSgwBZJYST9lGbu71jDtcChHFO4','2025-02-02 17:19:18',1),(37,2,'2025-01-02 17:25:19','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg1MTcxMTkuODc3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1ODM4NzE5fQ.4YsB61iZZnF92mL5778ZywWBYiwKyE9_wFHcTkfxMaQ','2025-02-02 17:25:19',1),(38,2,'2025-01-02 17:25:30','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg1MTcxMzAuNywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xOC4xIFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTczNTgzODczMH0.0MaaEt0ihs5VQF_MGGmwamLPa7dPzXNObVeSBY4SIb0','2025-02-02 17:25:30',1),(39,2,'2025-01-02 22:54:29','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg1MzY4NjkuOTA4LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1ODU4NDY5fQ.6-QJdSYOOD-g03GvDuGcDai6IPCWne_fXARqVek6aXk','2025-02-02 22:54:29',1),(40,2,'2025-01-07 17:34:28','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoyLCJpZGVudGl0eSI6InRlc3QiLCJleHAiOjE3Mzg5NDk2NjguNDgyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM2MjcxMjY4fQ.FnL85CQNgNaEDyBBkXcaV59jbMyU8Iy3iRJgQlJWiqc','2025-02-07 17:34:28',1);
/*!40000 ALTER TABLE `administrator_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `excerpt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('available','visible','hidden') COLLATE utf8mb4_unicode_ci DEFAULT 'available',
  `is_promoted` tinyint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `article_category_FK` (`category_id`),
  CONSTRAINT `article_category_FK` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'ACME HD11',5,'Neki kratak tekst 2...','Neki detaljniji sadrzaj 2..udvhkasdvgbasdkjv. udvhkasdvgbasdkjv udvhkasdvgbasdkjv udvhkasdvgbasdkjv','available',1,'2024-11-05 14:15:52'),(4,'Apple Macbook Air M1',3,'M2 cip....','Neki detaljan opis...dnvbdsvkmdsbvkmdsbvujzthgrfdesavdsavsva dnvbdsvkmdsbvkmdsbvujzthgrfdesavdsavsva dnvbdsvkmdsbvkmdsbvujzthgrfdesavdsavsva dnvbdsvkmdsbvkmdsbvujzthgrfdesavdsavsva','available',1,'2024-11-20 14:44:37'),(5,'ACME HD12',5,'Neki kratak opis...','Detaljan opis ce da bude ovdje....','available',1,'2024-12-12 14:42:05'),(6,'ACME HDDY',5,'Neki kratak tekst 2...','Neki detaljniji sadrzaj 3 fasgfagd jkesdbvsjkbvakjfbakjfbfdfag ...','available',0,'2024-12-27 00:23:02'),(7,'ACME HDDX',5,'Neki kratak tekst 2...','Neki detaljniji sadrzaj 3 fasgfagd jkesdbvsjkbvakjfbakjfbfdfag ...','available',1,'2024-12-27 00:23:23'),(8,'ACME HD13',5,'Neki kratak tekst 2...','Neki detaljniji sadrzaj 3 fasgfagd jkesdbvsjkbvakjfbakjfbfdfag ...','available',0,'2024-12-27 00:23:25'),(9,'Apple Macbook Air M2',3,'djvgfjsdkvbdkjvbdVJK','JHGVDFBLHNFDJKLBHDK FDSHFSKLGHDL LDHGLDSHDGLHJASOFHLDGHLOGHLHLFHDLVHDSDHDKSGH','available',0,'2024-12-27 00:28:18'),(10,'AppleMacbook Pro M1',3,'jhgnfbdvdsc','dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj dfhdhjtsftjfj','hidden',1,'2024-12-27 00:45:27');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_feature`
--

DROP TABLE IF EXISTS `article_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `feature_id` int unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `article_feature_article_id_IDX` (`article_id`,`feature_id`) USING BTREE,
  KEY `article_feature_feature_FK` (`feature_id`),
  CONSTRAINT `article_feature_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `article_feature_feature_FK` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_feature`
--

LOCK TABLES `article_feature` WRITE;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` VALUES (11,5,1,'512GB'),(12,5,2,'SATA 3.0'),(21,7,1,'1024GB'),(22,7,2,'SATA 3.0'),(36,8,1,'1024GB'),(37,8,2,'SATA 3.0'),(44,1,1,'1024GB'),(45,1,2,'SATA 3.0'),(46,6,1,'1024GB'),(47,6,2,'SATA 3.0'),(48,9,5,'Apple'),(49,9,6,'15.6\"'),(50,9,7,'iOS'),(51,4,5,'Apple'),(52,4,6,'13.6\"'),(53,4,7,'iOS');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_price`
--

DROP TABLE IF EXISTS `article_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_price` (
  `article_price_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_price_id`),
  KEY `article_price_article_FK` (`article_id`),
  CONSTRAINT `article_price_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_price`
--

LOCK TABLES `article_price` WRITE;
/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` VALUES (1,1,57.11,'2024-11-12 21:08:01'),(2,1,54.56,'2024-11-12 21:14:57'),(4,4,1800.00,'2024-11-20 14:45:28'),(5,5,59.15,'2024-12-12 14:43:09'),(6,4,1750.00,'2024-12-18 23:14:56'),(7,4,1720.00,'2024-12-18 23:21:10'),(8,4,1600.00,'2024-12-20 12:20:40'),(9,6,54.56,'2024-12-27 00:23:02'),(10,7,54.56,'2024-12-27 00:23:23'),(11,8,54.56,'2024-12-27 00:23:25'),(12,9,1900.00,'2024-12-27 00:28:18'),(13,10,100.00,'2024-12-27 00:45:27'),(14,9,2000.00,'2024-12-27 01:41:03'),(15,4,1700.00,'2024-12-27 01:45:21');
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `cart_user_FK` (`user_id`),
  CONSTRAINT `cart_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1,'2024-11-18 13:54:14'),(2,1,'2024-11-18 14:04:41'),(3,1,'2024-11-19 13:31:17'),(4,1,'2024-11-21 15:36:55'),(5,1,'2024-11-21 16:23:40'),(6,1,'2024-11-21 16:26:31'),(7,1,'2024-11-21 16:30:16'),(8,1,'2024-11-21 16:32:27'),(9,1,'2024-11-21 16:33:23'),(10,1,'2024-11-21 16:33:39'),(11,1,'2024-11-21 16:33:59'),(12,1,'2024-11-21 16:35:55'),(13,1,'2024-11-21 16:41:21'),(14,1,'2024-11-21 16:44:39'),(15,1,'2024-11-21 17:04:24'),(16,1,'2024-11-21 17:11:13'),(17,1,'2024-11-21 17:11:37'),(18,1,'2024-11-21 17:13:25'),(19,1,'2024-11-21 17:15:32'),(20,1,'2024-11-21 17:16:39'),(21,1,'2024-11-21 17:22:14'),(22,8,'2024-12-13 14:48:49'),(23,8,'2024-12-13 14:48:49'),(24,8,'2024-12-16 15:29:44'),(25,8,'2024-12-16 15:30:51'),(26,8,'2024-12-18 22:28:08'),(27,8,'2024-12-18 22:28:08'),(28,8,'2024-12-18 22:31:17'),(29,8,'2024-12-18 23:58:28'),(30,8,'2024-12-18 23:59:18'),(31,8,'2024-12-19 00:21:47'),(32,8,'2024-12-19 00:28:19'),(33,8,'2024-12-20 12:20:53'),(34,8,'2024-12-20 12:19:43'),(35,8,'2024-12-20 12:39:05'),(36,7,'2024-12-23 16:10:47'),(37,6,'2024-12-30 16:03:54'),(38,6,'2024-12-30 16:06:16'),(39,6,'2024-12-30 16:10:01'),(40,6,'2024-12-30 16:09:43'),(41,6,'2025-01-02 16:56:21'),(42,6,'2025-01-02 16:56:52');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_article`
--

DROP TABLE IF EXISTS `cart_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL,
  `article_id` int unsigned DEFAULT NULL,
  `quantity` int unsigned NOT NULL,
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `cart_article_article_id_IDX` (`article_id`,`cart_id`) USING BTREE,
  KEY `cart_article_cart_FK` (`cart_id`),
  CONSTRAINT `cart_article_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cart_article_cart_FK` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_article`
--

LOCK TABLES `cart_article` WRITE;
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
INSERT INTO `cart_article` VALUES (1,1,1,7),(4,2,1,2),(5,3,1,1),(6,4,1,3),(7,5,1,3),(8,6,1,3),(9,7,1,3),(10,8,1,3),(11,9,1,3),(12,10,1,3),(13,11,1,3),(14,12,1,3),(15,13,1,3),(16,14,1,3),(17,15,1,3),(18,16,1,3),(19,17,1,3),(20,18,1,3),(21,19,1,3),(22,20,1,3),(23,21,1,3),(27,22,4,1),(28,24,1,2),(29,24,5,1),(33,25,5,2),(34,25,1,1),(35,25,4,2),(36,26,1,1),(37,28,4,1),(38,29,4,1),(39,30,4,1),(40,31,1,1),(41,31,4,1),(42,32,4,1),(43,33,4,1),(44,37,6,1),(45,38,10,1),(46,39,10,2),(47,41,9,3);
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name_IDX` (`name`) USING BTREE,
  UNIQUE KEY `category_image_path_IDX` (`image_path`) USING BTREE,
  KEY `category_category_FK` (`parent__category_id`),
  CONSTRAINT `category_category_FK` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Računarske komponente','assets/pc.jpg',NULL),(2,'Kućna elektronika','assets/home.jpg',NULL),(3,'Laptop/računari','assets/pc/laptp.jpg',1),(4,'Memorijski medij','assets/pc/memory.jpg',1),(5,'Hard diskovi','assets/pc/memory/hdd.jpg',4),(6,'Tastatura','http://slike.com/tastatura.png',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_name_IDX` (`name`,`category_id`) USING BTREE,
  KEY `feature_category_FK` (`category_id`),
  CONSTRAINT `feature_category_FK` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (6,' Dijegonala ekrana',3),(14,'Dozvoljena jacina struje',2),(1,'Kapacitet',5),(4,'Naponi',2),(7,'Operativni sistem',3),(5,'Proizvođač',3),(3,'Tehnologija',5),(2,'Tip',5);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL,
  `status` enum('rejected','accepted','shipped','pending') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_cart_id_IDX` (`cart_id`) USING BTREE,
  CONSTRAINT `order_cart_FK` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2024-11-18 14:04:07',1,'shipped'),(3,'2024-11-19 13:30:15',2,'rejected'),(4,'2024-11-19 13:31:46',3,'shipped'),(5,'2024-11-21 16:22:57',4,'shipped'),(6,'2024-11-21 16:23:56',5,'shipped'),(7,'2024-11-21 16:26:38',6,'rejected'),(8,'2024-11-21 16:30:19',7,'shipped'),(9,'2024-11-21 16:32:30',8,'shipped'),(10,'2024-11-21 16:33:26',9,'shipped'),(11,'2024-11-21 16:33:42',10,'shipped'),(12,'2024-11-21 16:34:09',11,'rejected'),(13,'2024-11-21 16:35:58',12,'rejected'),(14,'2024-11-21 16:41:25',13,'rejected'),(15,'2024-11-21 16:44:49',14,'rejected'),(16,'2024-11-21 17:04:32',15,'rejected'),(17,'2024-11-21 17:11:17',16,'rejected'),(18,'2024-11-21 17:11:40',17,'rejected'),(19,'2024-11-21 17:13:28',18,'rejected'),(20,'2024-11-21 17:15:35',19,'rejected'),(21,'2024-11-21 17:17:43',20,'rejected'),(22,'2024-11-21 17:22:17',21,'rejected'),(23,'2024-12-16 15:29:08',22,'rejected'),(24,'2024-12-16 15:29:49',24,'pending'),(25,'2024-12-18 16:34:30',25,'pending'),(26,'2024-12-18 22:28:56',26,'pending'),(27,'2024-12-18 23:23:45',28,'pending'),(28,'2024-12-18 23:58:27',29,'pending'),(29,'2024-12-18 23:59:17',30,'pending'),(30,'2024-12-19 00:21:47',31,'pending'),(31,'2024-12-19 00:28:18',32,'pending'),(32,'2024-12-20 12:20:52',33,'pending'),(33,'2024-12-30 16:03:53',37,'accepted'),(34,'2024-12-30 16:06:16',38,'rejected'),(35,'2024-12-30 16:10:00',39,'rejected'),(36,'2025-01-02 16:56:20',41,'pending');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `image_path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `photo_image_path_IDX` (`image_path`) USING BTREE,
  KEY `photo_article_FK` (`article_id`),
  CONSTRAINT `photo_article_FK` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (13,1,'20241226-4730246617-harddisk.jpg'),(14,5,'20241226-8109916088-harddisk.jpg'),(15,4,'20241226-8837264310-laptop.jpg'),(19,9,'20241227-2527834055-laptop.jpg'),(23,10,'202517-5162889853-laptop.jpg'),(24,8,'202517-7321636982-harddisk.jpg'),(25,7,'202517-8215766766-hard-disk-slika.jpg'),(26,6,'202517-7379537468-hardddisk.jpg');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forename` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surname` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_adress` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_IDX` (`email`) USING BTREE,
  UNIQUE KEY `user_phone_number_IDX` (`phone_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin12adi','216EF4D3F52C80E3A6DCBE6BF071071B0FD1243D1C91D01D29EB337941A9B9F0365D09C784EBB5BACEEDEF573A9949DFC088FFC9EC0C67736B661537599E7598','Neko','Nekic','061/455-455','Gradacacka 31, 71000 Sarajevo'),(6,'test1234@test.ba','DAEF4953B9783365CAD6615223720506CC46C5167CD16AB500FA597AA08FF964EB24FB19687F34D7665F778FCB6C5358FC0A5B81E1662CF90F73A2671C53F991','Nekola','Nekic','+3811130065000','nova adresa 33, 71000 Sarajevo'),(7,'test12345@test.ba','DAEF4953B9783365CAD6615223720506CC46C5167CD16AB500FA597AA08FF964EB24FB19687F34D7665F778FCB6C5358FC0A5B81E1662CF90F73A2671C53F991','Nekola','Nekic','+38111300765000','nova adresa 33, 71000 Sarajevo'),(8,'proba@proba1.com','DAEF4953B9783365CAD6615223720506CC46C5167CD16AB500FA597AA08FF964EB24FB19687F34D7665F778FCB6C5358FC0A5B81E1662CF90F73A2671C53F991','Proba','Probic','+38761255255','Sarajevska1,\nZenica\n72000');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_token`
--

DROP TABLE IF EXISTS `user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `is_valid` tinyint DEFAULT '1',
  PRIMARY KEY (`user_token_id`),
  KEY `user_token_user_FK` (`user_id`),
  CONSTRAINT `user_token_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_token`
--

LOCK TABLES `user_token` WRITE;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` VALUES (2,6,'2024-11-25 14:45:24','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzI1NDYyMjQuMDYzLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40Mi4wIiwiaWF0IjoxNzMyNTQ1OTI0fQ.e0k5tfM-w5DcfGAvOY52N-1zdFZfxf3ZifCEqbHnQNE','2024-11-25 14:50:00',0),(3,6,'2024-11-25 14:46:25','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzI1NDYyODUuMTUyLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40Mi4wIiwiaWF0IjoxNzMyNTQ1OTg1fQ.1_49q3O-htsiTQ7ZP3Bwvf-sEJlnOXsI-QUhmImrNZg','2024-11-25 14:51:25',0),(4,6,'2024-11-25 15:25:53','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzI1NDg2NTMuOTA1LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40Mi4wIiwiaWF0IjoxNzMyNTQ4MzUzfQ.Wq4pKCL-QA-K7XLuwuS6MpRj531ejfCVF1ByTakvn2o','2024-11-25 15:30:53',0),(5,6,'2024-11-25 15:30:51','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzI1NjY2NTEuOTQ3LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40Mi4wIiwiaWF0IjoxNzMyNTQ4NjUxfQ.K75ari8wXOXZm0hv9y2YkMhI5Vo6HhdT0gr-VIDDnYY','2024-11-25 20:30:51',0),(6,6,'2024-11-25 15:37:36','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzUyMjc0NTYuMzUyLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40Mi4wIiwiaWF0IjoxNzMyNTQ5MDU2fQ.f25hjWrNm5zm6Ju0Q6W49H6sRCxnxOyQ7IaIDq5vtbc','2024-12-26 15:37:36',1),(7,6,'2024-12-02 18:01:08','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzU4NDA4NjguODU4LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzMzMTYyNDY4fQ.b0W877aWN1Jk-tTwzoowCXFJ1zxq2IvSXtRauLfsDyI','2025-01-02 18:01:08',1),(8,6,'2024-12-02 18:02:32','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzU4NDA5NTIuMjA2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzMzMTYyNTUyfQ.hspiGSPeGCFWmKKred48s6XUHN5jeZfTM9fcsdjINm8','2025-01-02 18:02:32',1),(9,8,'2024-12-05 13:15:45','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo4LCJpZGVudGl0eSI6InByb2JhQHByb2JhMS5jb20iLCJleHAiOjE3MzYwODI5NDUuNDg0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzMzNDA0NTQ1fQ.FmzHZXbRORYIDIZSPNCw8j6iGDImRcMPw4ndso3fKDM','2025-01-05 13:15:45',1),(10,6,'2024-12-09 13:07:54','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzY0MjgwNzQuNjk3LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40My4wIiwiaWF0IjoxNzMzNzQ5Njc0fQ.0repe7e4JwZdgEWvUuNzpNIlCJa-u5456hDz9yi0jLo','2025-01-09 13:07:54',1),(11,6,'2024-12-09 13:13:32','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzY0Mjg0MTIuOTg2LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40My4wIiwiaWF0IjoxNzMzNzUwMDEyfQ.msOHainrdKdY7Wl7R6JJnVE9TzvjVQGnV7K7_mjq4a8','2025-01-09 13:13:32',1),(12,6,'2024-12-12 15:19:56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzY2OTUxOTYuNzU5LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40My4wIiwiaWF0IjoxNzM0MDE2Nzk2fQ.lULmEr3-p1JWQAjpFgV5uyISIw7l9kDXEh1eiOCCLZA','2025-01-12 15:19:56',1),(13,6,'2024-12-12 15:25:05','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzY2OTU1MDUuMTMyLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy40My4wIiwiaWF0IjoxNzM0MDE3MTA1fQ.jFXK2H3XVTs8SWxsK1i89QBlnGwam8pEQecei1cxHw4','2025-01-12 15:25:05',1),(14,8,'2024-12-18 16:36:43','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo4LCJpZGVudGl0eSI6InByb2JhQHByb2JhMS5jb20iLCJleHAiOjE3MzcyMTgyMDMuNjc2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0NTM5ODAzfQ.5-G5dsY2FxBYlFeBjTT3081rvi4au57SZbBWyqymhNQ','2025-01-18 16:36:43',1),(15,8,'2024-12-18 16:37:20','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo4LCJpZGVudGl0eSI6InByb2JhQHByb2JhMS5jb20iLCJleHAiOjE3MzcyMTgyNDAuMzQ2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0NTM5ODQwfQ.V_7mxpY6MktlrkQpw_BcG87ALLOKwslh-p6eu6J-vVY','2025-01-18 16:37:20',1),(16,8,'2024-12-23 16:10:18','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo4LCJpZGVudGl0eSI6InByb2JhQHByb2JhMS5jb20iLCJleHAiOjE3Mzc2NDg2MTguNzI3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM0OTcwMjE4fQ.u2JEkBsdAWWlZLipZ-uYbVCD_o9klHaW_HdBOlpFP3U','2025-01-23 16:10:18',1),(17,7,'2024-12-23 16:10:47','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo3LCJpZGVudGl0eSI6InRlc3QxMjM0NUB0ZXN0LmJhIiwiZXhwIjoxNzM3NjQ4NjQ3Ljc4MSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xOC4xIFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTczNDk3MDI0N30.Y8O0rKziiDIVyo2JYV1TpdA5FxRisNdI_cJkEI_03rA','2025-01-23 16:10:47',1),(18,6,'2024-12-30 15:58:14','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzgyNTI2OTQuMDY4LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTc0Mjk0fQ.0fBFmg41XC6OlK-2kDK36puJ8Mb36HKgaQif62rBWjo','2025-01-30 15:58:14',1),(19,6,'2024-12-30 16:03:16','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3MzgyNTI5OTYuNDM1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1NTc0NTk2fQ.iB2q1gYN3kvXy7u9u-a3yrgd5XUqkZoVGayfTivZn_A','2025-01-30 16:03:16',1),(20,6,'2025-01-02 14:55:21','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3Mzg1MDgxMjEuMjE4LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1ODI5NzIxfQ.oBmP2kgp53FjFaW0CqA5uEnIb_Z1t0Ia1HoNeXGkWqs','2025-02-02 14:55:21',1),(21,6,'2025-01-02 23:37:11','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3Mzg1Mzk0MzEuNTY4LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1ODYxMDMxfQ.qThPZw1gwQRrXiF-SXkPBqFaxyM20kFmCG_7wWFNhXk','2025-02-02 23:37:11',1),(22,6,'2025-01-02 23:39:41','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo2LCJpZGVudGl0eSI6InRlc3QxMjM0QHRlc3QuYmEiLCJleHAiOjE3Mzg1Mzk1ODEuMjY3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE4LjEgU2FmYXJpLzYwNS4xLjE1IiwiaWF0IjoxNzM1ODYxMTgxfQ.wBSa3iLR62nPfVoN9PdGHyAwf9fqvZbqmEOGVKzSb48','2025-02-02 23:39:41',1);
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'aplikacija'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-07 18:42:44
