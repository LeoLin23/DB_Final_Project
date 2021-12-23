-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 192.168.56.101    Database: db_107403519
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_Seat`
--

DROP TABLE IF EXISTS `tbl_Seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_Seat` (
  `seat_id` varchar(64) NOT NULL,
  PRIMARY KEY (`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Seat`
--

LOCK TABLES `tbl_Seat` WRITE;
/*!40000 ALTER TABLE `tbl_Seat` DISABLE KEYS */;
INSERT INTO `tbl_Seat` VALUES ('10A'),('10B'),('10C'),('10D'),('1A'),('1B'),('1C'),('1D'),('2A'),('2B'),('2C'),('2D'),('3A'),('3B'),('3C'),('3D'),('4A'),('4B'),('4C'),('4D'),('5A'),('5B'),('5C'),('5D'),('6A'),('6B'),('6C'),('6D'),('7A'),('7B'),('7C'),('7D'),('8A'),('8B'),('8C'),('8D'),('9A'),('9B'),('9C'),('9D');
/*!40000 ALTER TABLE `tbl_Seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Station`
--

DROP TABLE IF EXISTS `tbl_Station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_Station` (
  `station_id` int(11) NOT NULL,
  `station_name` varchar(100) NOT NULL,
  `location_marker` int(11) NOT NULL,
  `time_marker` int(11) NOT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Station`
--

LOCK TABLES `tbl_Station` WRITE;
/*!40000 ALTER TABLE `tbl_Station` DISABLE KEYS */;
INSERT INTO `tbl_Station` VALUES (1,'台北',1,0),(2,'桃園',3,20),(3,'新竹',4,30),(4,'台中',8,60),(5,'高雄',15,120);
/*!40000 ALTER TABLE `tbl_Station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Ticket`
--

DROP TABLE IF EXISTS `tbl_Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_Ticket` (
  `ticket_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `train_date` date NOT NULL,
  `train_id` int(11) NOT NULL,
  `departure_station` int(11) NOT NULL,
  `arrival_station` int(11) NOT NULL,
  `seat_id` varchar(64) NOT NULL,
  `price` int(11) NOT NULL,
  `book_time` datetime NOT NULL,
  `pay_time` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`,`user_id`,`departure_station`,`arrival_station`),
  KEY `user_id_idx` (`user_id`),
  KEY `ticket_seat_id_idx` (`seat_id`),
  KEY `ticket_train_id_idx` (`train_id`),
  KEY `ticket_to_station_id_idx` (`departure_station`),
  KEY `ticket_arr_station_idx` (`arrival_station`),
  CONSTRAINT `ticket_arr_station` FOREIGN KEY (`arrival_station`) REFERENCES `tbl_Station` (`station_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_dep_station` FOREIGN KEY (`departure_station`) REFERENCES `tbl_Station` (`station_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `tbl_Seat` (`seat_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_train_id` FOREIGN KEY (`train_id`) REFERENCES `tbl_Train` (`train_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Ticket`
--

LOCK TABLES `tbl_Ticket` WRITE;
/*!40000 ALTER TABLE `tbl_Ticket` DISABLE KEYS */;
INSERT INTO `tbl_Ticket` VALUES (1,1,'2020-06-10',1,1,2,'1D',200,'2020-06-10 07:00:00','2020-06-10 07:15:00'),(2,1,'2020-06-10',1,2,5,'3B',1200,'2020-06-10 07:00:00','2020-06-10 07:15:00'),(3,2,'2020-06-10',2,2,5,'2A',1200,'2020-06-10 07:00:00','2020-06-10 07:15:00'),(4,2,'2020-06-12',2,3,4,'2A',400,'2020-06-11 17:30:00','2020-06-11 17:35:00'),(5,3,'2020-06-13',3,1,5,'3D',1400,'2020-06-12 20:30:00','2020-06-13 07:35:00'),(6,4,'2020-06-13',3,2,3,'4B',100,'2020-06-12 14:30:00','2020-06-12 17:35:00'),(8,6,'2020-06-15',4,5,1,'2A',1400,'2020-06-11 17:30:00','2020-06-11 17:35:00'),(9,7,'2020-06-16',5,4,2,'5A',500,'2020-06-12 10:31:00',NULL),(10,7,'2020-06-16',5,4,2,'5B',500,'2020-06-11 10:31:00',NULL),(11,7,'2020-06-16',5,4,2,'5C',500,'2020-06-11 10:31:00','2020-06-11 11:35:00'),(12,8,'2020-06-16',6,3,2,'6C',500,'2020-06-16 10:30:00','2020-06-16 10:36:00');
/*!40000 ALTER TABLE `tbl_Ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_Train`
--

DROP TABLE IF EXISTS `tbl_Train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_Train` (
  `train_id` int(11) NOT NULL,
  `arrival_time` time DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `departure_station` int(11) NOT NULL,
  PRIMARY KEY (`train_id`,`departure_station`),
  KEY `departure_station_idx` (`departure_station`),
  CONSTRAINT `departure_station` FOREIGN KEY (`departure_station`) REFERENCES `tbl_Station` (`station_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_Train`
--

LOCK TABLES `tbl_Train` WRITE;
/*!40000 ALTER TABLE `tbl_Train` DISABLE KEYS */;
INSERT INTO `tbl_Train` VALUES (1,NULL,'07:00:00',1),(1,'07:20:00','07:22:00',2),(1,'07:32:00','07:34:00',3),(1,'08:04:00','08:06:00',4),(1,'09:06:00',NULL,5),(2,NULL,'10:00:00',1),(2,'10:20:00','10:22:00',2),(2,'10:32:00','10:34:00',3),(2,'11:04:00',NULL,4),(3,NULL,'13:00:00',1),(3,'13:20:00','13:22:00',2),(3,'13:32:00','13:34:00',3),(3,'14:04:00','14:06:00',4),(3,'15:06:00',NULL,5),(4,'10:06:00',NULL,1),(4,'09:44:00','09:46:00',2),(4,'09:32:00','09:34:00',3),(4,'09:00:00','09:02:00',4),(4,NULL,'08:00:00',5),(5,'13:04:00',NULL,1),(5,'12:42:00','12:44:00',2),(5,'12:30:00','12:32:00',3),(5,NULL,'12:00:00',4),(6,'19:06:00',NULL,1),(6,'18:44:00','18:46:00',2),(6,'18:32:00','18:34:00',3),(6,'18:00:00','18:02:00',4),(6,NULL,'17:00:00',5);
/*!40000 ALTER TABLE `tbl_Train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_User`
--

DROP TABLE IF EXISTS `tbl_User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_User` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `salt` char(64) DEFAULT NULL,
  `register_date` date NOT NULL,
  `is_deleted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `salt_UNIQUE` (`salt`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_User`
--

LOCK TABLES `tbl_User` WRITE;
/*!40000 ALTER TABLE `tbl_User` DISABLE KEYS */;
INSERT INTO `tbl_User` VALUES (1,'Marvel_Steve@gmail.com','Steve','Rogers','1918-07-04','63652315D22919A8EC76F58F982EC08A6244474F8082B8E75A1271B3C63948E9','2019-06-06',0),(2,'Marvel_Tony@gmail.com','Tony','Stark','1970-05-29','AA52032EAB8CC92F7B77CCE828940F95C2369F18DDF1C6B3A80A8A6195D137FB','2019-06-07',0),(3,'Marvel_Thor@gmail.com','Thor','God','1911-01-01','3C567E0EA40F26755BB221C96AB02CC726DE673E85016EC1D949D14E5B16B223','2019-06-08',0),(4,'Marvel_Peter@gmail.com','Peter','Parker','2000-08-10','95B79B147E492681F98C749E3AC329C1A975D3F4000FF25D0643D8D55A4E4E2B','2019-06-09',0),(5,'Marvel_David @gmail.com','David','Banner','1980-11-22','EB7F11AE33003238D3FF14094E3BC569F077B8F39DF472423FD339CE22B5F050','2019-06-10',0),(6,'Marvel_Natasha@gmail.com','Natasha','Romanoff','1984-11-22','5F79D14FB8A43CA9350E781EA1067B14B197D36671182C4C15E9EDBD921791DD','2019-06-11',0),(7,'Marvel_Wanda@gmail.com','Wanda','Maximoff','1980-08-02','9C681B6D73E80D3C1F10E06BDEB48914ABE207ADA83405DC14485B6AD060C021','2019-06-12',0),(8,'Marvel_Carol@gmail.com','Carol','Danvers','1980-08-01','6C40F0CC5D46DCE7D1A0E1D118E0750A7874087FC7199DDA34D171131002DCA9','2019-06-13',0),(9,'Marvel_Stephen@gmail.com','Stephen','Strange','1930-07-01','039FB5567A6B559BE9999BF854BEF1699A14CB912AF431CCF90D9941900D8788','2019-06-14',0),(10,'Marvel_Clint@gmail.com','Clint','Barton','1971-01-07','ABC1523C0333408EFF2B8CCF4248A0B2175723EBC65C8D05940B9D434B7A39A2','2019-06-15',0);
/*!40000 ALTER TABLE `tbl_User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_UserCredential`
--

DROP TABLE IF EXISTS `tbl_UserCredential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl_UserCredential` (
  `user_credential` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `hashedPwd` char(200) DEFAULT NULL,
  `createDate` date NOT NULL,
  PRIMARY KEY (`user_credential`,`user_id`),
  KEY `fk_tbl_UserCredential_tbl_User1_idx` (`user_id`),
  CONSTRAINT `userCredential_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_UserCredential`
--

LOCK TABLES `tbl_UserCredential` WRITE;
/*!40000 ALTER TABLE `tbl_UserCredential` DISABLE KEYS */;
INSERT INTO `tbl_UserCredential` VALUES (1,1,'pfNFnTx50OjhU','2019-06-06'),(2,2,'brpgOmotwsnkA','2019-06-07'),(3,3,'brCHXrfmx/hRs','2019-06-08'),(4,4,'broklWTNGanYM','2019-06-09'),(5,5,'brrQ/CUvMgDMI','2019-06-10'),(6,6,'brCAXrfmx/hRs','2019-06-11'),(7,7,'bretXExZ676DI','2019-06-12'),(8,8,'brhAsn.S9pHfM','2019-06-13'),(9,9,'brv2uIUQT8QN2','2019-06-14'),(10,10,'brtnGNHRCIzXY','2019-06-15');
/*!40000 ALTER TABLE `tbl_UserCredential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_107403519'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_BookTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_BookTicket`(
	in in_user_id int(10),
    in in_train_id int(11),
	in in_departure_station int,
	in in_arrival_station int,
	in in_train_date date,
    out num_row int(100)
)
BEGIN
	select seat_id into @seat_id from tbl_Seat
    order by rand()
    limit 1;
    
    while (
		exists 
			(select seat_id from tbl_Ticket 
			where
				@seat_id = seat_id
            and
				in_train_id = train_id
			and
				in_train_date = train_date)
    ) do
		select seat_id into @seat_id from tbl_Seat
		order by rand()
		limit 1;
    end while; -- end while
    
    set @price = 100 * abs(
		(select location_marker from tbl_Station where in_departure_station = station_id)
		- (select location_marker from tbl_Station where in_arrival_station = station_id));
    
    insert into tbl_Ticket
    values (
		null,
        in_user_id,
        in_train_date,
        in_train_id,
        in_departure_station,
        in_arrival_station,
        @seat_id,
        @price,
        now(),
        null
	);
    
    select ticket_id, user_id, train_id, departure_station, arrival_station, seat_id,
		book_time, train_date
	from tbl_Ticket
    where ticket_id = last_insert_id();
    
    select count(*) from tbl_Ticket 
    where
		in_user_id = user_id
	and in_train_id = train_id
    and @seat_id = seat_id
    and in_departure_station = departure_station
    and in_arrival_station = arrival_station
    into num_row;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_DeleteUserByUserID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_DeleteUserByUserID`(
	in in_user_id int(10),
    out affected_row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_user_id = user_id) then
        /* if there exists any ticket booked by this user, it is paid,
        so both the ticket and the user cannot be deleted */
        if not exists (select user_id from tbl_Ticket where in_user_id = user_id) then
			-- clear user data
			update tbl_User
			set
				email = null,
				firstname = null,
				lastname = null,
				dob = null,
				salt = null,
				is_deleted = 1
			where
				user_id = in_user_id;
			
			-- clear user credential data
			update tbl_UserCredential
			set
				hashedPwd = null
			where
				user_id = in_user_id;
        end if; -- end if
	end if; -- end if
    
    set affected_row_num = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Delete_bookticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_Delete_bookticket`(
	in in_user_id int(10),
    in in_ticket_id int(11),
    out affected_row_num int(100)
)
BEGIN
	-- only delete the ticket if it is not paid
	delete from tbl_Ticket where
	in_user_id = user_id and
    in_ticket_id = ticket_id and
	pay_time is null;
    
    set affected_row_num = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetBookTicketByUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_GetBookTicketByUser`(
	in in_user_id int(10),
    out num_row int(100)
)
BEGIN
	-- return the unpaid tickets
	select
		ticket_id,
		user_id as userID,
		train_id,
		seat_id,
		book_time
	from tbl_Ticket
	where 
	in_user_id = user_id and
	pay_time is null;
	
    select count(*) from tbl_Ticket where
    in_user_id = user_id and
	pay_time is null
    into num_row;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetStation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_GetStation`(
	out number_of_row int
)
BEGIN
	SELECT station_id, station_name FROM tbl_Station;
    SELECT COUNT(*) FROM tbl_Station INTO number_of_row;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_PayTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_PayTicket`(
	in in_user_id int(10),
	in in_ticket_id int(11),
    out affected_row_num int(100)
)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS `result_set`;
	create temporary table result_set
	select ticket_id, train_id, user_id, tbl_Ticket.departure_station, arrival_station,
	seat_id, book_time, departure_time, arrival_time, price, pay_time from tbl_Train
	inner join tbl_Ticket
	using (train_id)
	where in_ticket_id = ticket_id
	and tbl_Ticket.departure_station = tbl_Train.departure_station;
	
    alter table result_set
    add primary key (ticket_id);
    
    select departure_station into @dep_station from result_set;
    select arrival_station into @arr_station from result_set;
    
	set @time_offset = sec_to_time(60*abs(
		(select time_marker from tbl_Station where station_id = @dep_station)
		- (select time_marker from tbl_Station where station_id = @arr_station)));
	
    update result_set
    set arrival_time = addtime(departure_time, @time_offset)
    where in_ticket_id = ticket_id;
    
	-- validate time
    if curdate() <= (
		select date_add(date(book_time), interval 2 day) from tbl_Ticket
		where in_ticket_id = ticket_id
	) then
		if curdate() = ( -- if current date is the same as book_time
				select train_date from tbl_Ticket
				where in_ticket_id = ticket_id
			) then -- check if is out of the 30 min limitation
				if curtime() <= (
					select subtime(departure_time, "0:30") from result_set
				) then
					update tbl_Ticket
					set pay_time = now()
					where in_ticket_id = ticket_id;
					set affected_row_num = row_count();
                    
					update result_set
					set pay_time = now()
					where in_ticket_id = ticket_id;
                    select * from result_set;
				else
					set affected_row_num = 0;
				end if; -- end if
		else 
			update tbl_Ticket
			set pay_time = now()
			where in_ticket_id = ticket_id;
			set affected_row_num = row_count();
            
			update result_set
			set pay_time = now()
			where in_ticket_id = ticket_id;
            select * from result_set;
        end if; -- end if
	else
		set affected_row_num = 0;
    end if; -- end if
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_QueryTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_QueryTicket`(
	in in_departure_time datetime,
    in in_departure_station int,
    in in_arrival_station int,
    out num_row int(100)
)
BEGIN
	set @dep_date = date(in_departure_time);
    set @dep_time = date_format(in_departure_time, "%H:%i:%s");
    
	-- to store the trains which will departure from in_departure_station
    DROP TEMPORARY TABLE IF EXISTS `temp_1`;
	create temporary table temp_1 select train_id, departure_time from tbl_Train limit 0;
    
    insert into temp_1
    select train_id, departure_time from tbl_Train
    where in_departure_station = departure_station
    and @dep_time >= departure_time;
    
    -- to store the trains that will arrive at in_arrival_station
    DROP TEMPORARY TABLE IF EXISTS `temp_2`;
    create temporary table temp_2 select train_id from tbl_Train limit 0;
    
    insert into temp_2
    select train_id from tbl_Train
    where train_id in(select train_id from temp_1)
    and in_arrival_station = departure_station;
    
	-- to store the trains that will arrive at in_arrival_station
    DROP TEMPORARY TABLE IF EXISTS `valid_train`;
    create temporary table valid_train(
		train_id int primary key
    );
    
    -- check if there is any available seat
    insert into valid_train
	select train_id
    from tbl_Ticket
    where train_date = @dep_date
    and train_id in (select train_id from temp_2)
    group by train_id
    having count(*) < 40;
    
    alter table valid_train add column departure_station int default 1;
	update valid_train set departure_station = in_departure_station
    where train_id > 0;
    
	alter table valid_train add column arrival_station int default 1;
	update valid_train set arrival_station = in_arrival_station
    where train_id > 0;
    
    alter table valid_train add column departure_time time default null;
	update valid_train set departure_time = (
		select departure_time from temp_1 where
		valid_train.train_id = temp_1.train_id
	)
    where train_id > 0;
    
    set @time_offset = abs(
		(select time_marker from tbl_Station where in_departure_station = station_id)
		- (select time_marker from tbl_Station where in_arrival_station = station_id));
    
    alter table valid_train add column time_offset time default null;
	update valid_train set time_offset = sec_to_time(@time_offset*60)
    where train_id > 0;
    
    alter table valid_train add column arrival_time time generated always as (
		addtime(departure_time, time_offset)
    );
    
    -- price
    set @price = 100 * abs(
		(select location_marker from tbl_Station where in_departure_station = station_id)
		- (select location_marker from tbl_Station where in_arrival_station = station_id));
	alter table valid_train add column price int default 0;
	update valid_train set price = @price
    where train_id > 0;
    
	select train_id, departure_station, arrival_station, departure_time, arrival_time, price from valid_train;
        
    select count(*) into num_row from valid_train;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegisterUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_RegisterUser`(
	in in_email varchar(255),
    in in_firstname varchar(100),
    in in_lastname varchar(100),
    in in_dob date,
    in in_salt char(64),
    in in_hashedPwd char(255),
    out affected_row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_email = email) then
		set affected_row_num = 0;
	else
		-- User table
		INSERT INTO tbl_User
		VALUES (
			null, -- user_id
			in_email,
			in_firstname,
			in_lastname,
			in_dob,
			in_salt,
            CURDATE(),
            0
		);
        
        -- UserCredential table
        select user_id, register_date into @uid, @r_date from tbl_User where in_email = email;
        
        insert into tbl_UserCredential
        values (
			null, -- user_credential
            @uid,
            in_hashedPwd,
            @r_date
        );
        
		set affected_row_num = ROW_COUNT();
	end if; -- end if
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ResetNewPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_ResetNewPassword`(
	in in_user_id int(10),
    in in_salt char(64),
    in in_hashedPwd char(255),
    out affected_row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_user_id = user_id) then
		update tbl_UserCredential
        set
			hashedPwd = in_hashedPwd
		where
			user_id = in_user_id;
		update tbl_User
        set
			salt = in_salt
		where
			user_id = in_user_id;
	end if; -- end if
    set affected_row_num = ROW_COUNT();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UserLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_UserLogin`(
	in in_email varchar(255),
    in in_hashedPwd char(255),
	out row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_email = email) then
		select user_id into @query_user_id from tbl_User 
        where in_email = email;
        
		select hashedPwd into @validPwd from tbl_UserCredential
        where user_id = @query_user_id;
        if (@validPwd = in_hashedPwd) then
			set row_num = @query_user_id;
		else
			set row_num = 0;
		end if; -- end if
	end if; -- end if
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-26  1:03:00
