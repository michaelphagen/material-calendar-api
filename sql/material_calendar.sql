/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allotment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `slots` int DEFAULT NULL,
  `studio_id` int DEFAULT NULL,
  `bookable` tinyint DEFAULT '1',
  `description` text,
  `locked` tinyint DEFAULT '0',
  `lock_id` int DEFAULT NULL,
  `locked_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `start_studio_idx` (`start`,`studio_id`),
  KEY `studio_id_idx` (`studio_id`),
  KEY `user_foreign_key` (`lock_id`),
  CONSTRAINT `allotment_studio_id_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`),
  CONSTRAINT `user_foreign_key` FOREIGN KEY (`lock_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4100 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `booked_sessions` AS SELECT 
 1 AS `id`,
 1 AS `start`,
 1 AS `end`,
 1 AS `studio`,
 1 AS `students`,
 1 AS `phone`,
 1 AS `project`,
 1 AS `tape`,
 1 AS `dolby`,
 1 AS `live room`,
 1 AS `gear`*/;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `allotment_id` int DEFAULT NULL,
  `group_id` int NOT NULL,
  `project_id` int DEFAULT NULL,
  `confirmed` tinyint DEFAULT '1',
  `confirmed_time` datetime DEFAULT NULL,
  `reject_reason` text,
  `purpose` text,
  `checkin` datetime DEFAULT NULL,
  `checkout` datetime DEFAULT NULL,
  `absent_logtime` datetime DEFAULT NULL,
  `cancelled` tinyint DEFAULT '0',
  `cancelled_time` datetime DEFAULT NULL,
  `cancel_request` tinyint DEFAULT '0',
  `cancel_request_userid` int DEFAULT NULL,
  `cancel_request_time` datetime DEFAULT NULL,
  `cancel_request_comment` text,
  `cancelled_approval` int DEFAULT NULL,
  `living_room` tinyint DEFAULT '0',
  `multitrack` tinyint DEFAULT '0',
  `format_analog` tinyint DEFAULT '0',
  `format_dolby` tinyint DEFAULT '0',
  `contact_phone` varchar(20) DEFAULT NULL,
  `guests` text,
  `refundable` tinyint DEFAULT '0',
  `checked_in` tinyint DEFAULT '0',
  `checked_out` tinyint DEFAULT '0',
  `absent` tinyint DEFAULT '0',
  `checkin_comment` text,
  `checkout_comment` text,
  `checkin_id` int DEFAULT NULL,
  `checkout_id` int DEFAULT NULL,
  `absent_id` int DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id_idx` (`group_id`),
  KEY `allotment_id_idx` (`allotment_id`),
  KEY `project_id_idx` (`project_id`),
  KEY `cancelled_approval_idx` (`cancelled_approval`),
  KEY `cancel_request_userid_idx` (`cancel_request_userid`),
  KEY `checkin_id_idx` (`checkin_id`),
  KEY `checkout_id_idx` (`checkout_id`),
  KEY `absent_id_idx` (`absent_id`),
  CONSTRAINT `booking_absent_id_user_id` FOREIGN KEY (`absent_id`) REFERENCES `user` (`id`),
  CONSTRAINT `booking_allotment_id_allotment_id` FOREIGN KEY (`allotment_id`) REFERENCES `allotment` (`id`),
  CONSTRAINT `booking_cancel_request_userid_user_id` FOREIGN KEY (`cancel_request_userid`) REFERENCES `user` (`id`),
  CONSTRAINT `booking_cancelled_approval_user_id` FOREIGN KEY (`cancelled_approval`) REFERENCES `user` (`id`),
  CONSTRAINT `booking_checkin_id_user_id` FOREIGN KEY (`checkin_id`) REFERENCES `user` (`id`),
  CONSTRAINT `booking_checkout_id_user_id` FOREIGN KEY (`checkout_id`) REFERENCES `user` (`id`),
  CONSTRAINT `booking_group_id_rm_group_id` FOREIGN KEY (`group_id`) REFERENCES `rm_group` (`id`),
  CONSTRAINT `booking_project_id_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=469 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_guest` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `guest` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_id_idx` (`booking_id`),
  CONSTRAINT `booking_guest_booking_id_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_trading_request` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `request_time` datetime DEFAULT NULL,
  `request_id` int DEFAULT NULL,
  `request_comment` text,
  `reject_reason` text,
  `request_status` tinyint DEFAULT '0',
  `confirm_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `request_id_idx` (`request_id`),
  KEY `booking_id_idx` (`booking_id`),
  KEY `confirm_id_idx` (`confirm_id`),
  KEY `project_id_idx` (`project_id`),
  CONSTRAINT `booking_trading_request_booking_id_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `booking_trading_request_confirm_id_user_id` FOREIGN KEY (`confirm_id`) REFERENCES `user` (`id`),
  CONSTRAINT `booking_trading_request_project_id_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `booking_trading_request_request_id_user_id` FOREIGN KEY (`request_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bookings_view` AS SELECT 
 1 AS `id`,
 1 AS `start`,
 1 AS `end`,
 1 AS `studio`,
 1 AS `student_IDs`,
 1 AS `students`,
 1 AS `phone`,
 1 AS `project`,
 1 AS `tape`,
 1 AS `dolby`,
 1 AS `live room`,
 1 AS `gear`*/;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `is_open` tinyint DEFAULT '1',
  `course_type` int DEFAULT NULL,
  `original_course_name` varchar(128) DEFAULT NULL,
  `instructor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_type_idx` (`course_type`),
  CONSTRAINT `course_course_type_course_type_id` FOREIGN KEY (`course_type`) REFERENCES `course_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_type` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `model_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `status` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `model_id_idx` (`model_id`),
  CONSTRAINT `equipment_model_id_equipment_model_id` FOREIGN KEY (`model_id`) REFERENCES `equipment_model` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_model` (
  `id` int NOT NULL AUTO_INCREMENT,
  `model` varchar(255) DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id_idx` (`category_id`),
  CONSTRAINT `equipment_model_category_id_equipment_category_id` FOREIGN KEY (`category_id`) REFERENCES `equipment_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_reservation` (
  `equipment_id` int NOT NULL DEFAULT '0',
  `booking_id` int NOT NULL DEFAULT '0',
  `quantity` int DEFAULT '1',
  `checkin_status` tinyint DEFAULT '1',
  `checkout_status` tinyint DEFAULT '1',
  PRIMARY KEY (`equipment_id`,`booking_id`),
  KEY `equipment_reservation_booking_id_booking_id` (`booking_id`),
  CONSTRAINT `equipment_reservation_booking_id_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `equipment_reservation_equipment_id_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `full_calendar` AS SELECT 
 1 AS `id`,
 1 AS `start`,
 1 AS `end`,
 1 AS `studio`,
 1 AS `description`,
 1 AS `students`,
 1 AS `email`,
 1 AS `phone`,
 1 AS `project`,
 1 AS `tape`,
 1 AS `dolby`,
 1 AS `live room`,
 1 AS `purpose`,
 1 AS `guests`,
 1 AS `cancel_request`,
 1 AS `cancel_request_time`,
 1 AS `cancel_request_comment`,
 1 AS `gear`,
 1 AS `open`,
 1 AS `studioId`,
 1 AS `reservationId`,
 1 AS `projectGroupId`*/;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gear_studio` (
  `equipment_id` int NOT NULL DEFAULT '0',
  `studio_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`equipment_id`,`studio_id`),
  KEY `gear_studio_studio_id_studio_id` (`studio_id`),
  CONSTRAINT `gear_studio_equipment_id_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `gear_studio_studio_id_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_project_hours` (
  `group_id` int NOT NULL DEFAULT '0',
  `project_id` int NOT NULL DEFAULT '0',
  `hours` int DEFAULT NULL,
  PRIMARY KEY (`group_id`,`project_id`),
  KEY `group_project_hours_project_id_project_id` (`project_id`),
  CONSTRAINT `group_project_hours_group_id_rm_group_id` FOREIGN KEY (`group_id`) REFERENCES `rm_group` (`id`),
  CONSTRAINT `group_project_hours_project_id_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requestor` int DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `message` text,
  `status` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `requestor_idx` (`requestor`),
  KEY `group_id_idx` (`group_id`),
  CONSTRAINT `group_request_group_id_rm_group_id` FOREIGN KEY (`group_id`) REFERENCES `rm_group` (`id`),
  CONSTRAINT `group_request_requestor_user_id` FOREIGN KEY (`requestor`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invitation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invitor` int DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `hash` varchar(32) DEFAULT NULL,
  `message` text,
  `project_id` int DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invitor_idx` (`invitor`),
  KEY `group_id_idx` (`group_id`),
  KEY `project_id_idx` (`project_id`),
  CONSTRAINT `invitation_group_id_rm_group_id` FOREIGN KEY (`group_id`) REFERENCES `rm_group` (`id`),
  CONSTRAINT `invitation_invitor_user_id` FOREIGN KEY (`invitor`) REFERENCES `user` (`id`),
  CONSTRAINT `invitation_project_id_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invitee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invitation_id` int DEFAULT NULL,
  `invitee` int DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `sent_timestamp` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitation_invitee_idx` (`invitation_id`,`invitee`,`status`),
  KEY `invitee_idx` (`invitee`),
  KEY `invitation_id_idx` (`invitation_id`),
  CONSTRAINT `invitee_invitation_id_invitation_id` FOREIGN KEY (`invitation_id`) REFERENCES `invitation` (`id`),
  CONSTRAINT `invitee_invitee_user_id` FOREIGN KEY (`invitee`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `message` text,
  `sender` int DEFAULT NULL,
  `broadcast` tinyint DEFAULT '0',
  `sent_time` datetime NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_idx` (`sender`),
  CONSTRAINT `message_sender_user_id` FOREIGN KEY (`sender`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_receiver` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `receiver_group` int DEFAULT NULL,
  `receiver_user` int DEFAULT '0',
  `message_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `receiver_group_idx` (`receiver_group`),
  KEY `receiver_user_idx` (`receiver_user`),
  KEY `message_id_idx` (`message_id`),
  CONSTRAINT `message_receiver_message_id_message_id` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`),
  CONSTRAINT `message_receiver_receiver_group_rm_group_id` FOREIGN KEY (`receiver_group`) REFERENCES `rm_group` (`id`),
  CONSTRAINT `message_receiver_receiver_user_user_id` FOREIGN KEY (`receiver_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migration_version` (
  `version` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `studio_time` int DEFAULT NULL,
  `studio_balance` int DEFAULT NULL,
  `group_hours` decimal(18,2) DEFAULT NULL,
  `is_open` tinyint DEFAULT '1',
  `course_id` int DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  `book_start` date DEFAULT NULL,
  `book_end` date DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `start_index` int DEFAULT NULL,
  `brief` varchar(255) DEFAULT NULL,
  `description` text,
  `bgcolor` varchar(10) DEFAULT NULL,
  `font_color` varchar(10) DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `studio_id` int DEFAULT NULL,
  `group_size` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id_idx` (`course_id`),
  KEY `section_id_idx` (`section_id`),
  KEY `parent_id_idx` (`parent_id`),
  KEY `studio_id_idx` (`studio_id`),
  CONSTRAINT `project_course_id_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `project_parent_id_project_id` FOREIGN KEY (`parent_id`) REFERENCES `project` (`id`),
  CONSTRAINT `project_section_id_section_id` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`),
  CONSTRAINT `project_studio_id_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_allotment` (
  `project_id` int NOT NULL DEFAULT '0',
  `start` date NOT NULL DEFAULT '0000-00-00',
  `end` date DEFAULT NULL,
  `start_index` int DEFAULT NULL,
  `end_index` int DEFAULT NULL,
  `hour` int DEFAULT NULL,
  `bgcolor` varchar(10) DEFAULT NULL,
  `font_color` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`project_id`,`start`),
  CONSTRAINT `project_allotment_project_id_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `project_info` AS SELECT 
 1 AS `id`,
 1 AS `title`,
 1 AS `course`,
 1 AS `start`,
 1 AS `end`,
 1 AS `reservationStart`,
 1 AS `allotments`,
 1 AS `groupSize`,
 1 AS `groupAllottedHours`,
 1 AS `open`,
 1 AS `managers`*/;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rm_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `project_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `creator` int DEFAULT NULL,
  `status` tinyint DEFAULT '0',
  `byadmin` tinyint DEFAULT '0',
  `admin_id` int DEFAULT NULL,
  `group_type` tinyint DEFAULT '1',
  `group_size` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_idx` (`creator`),
  KEY `project_id_idx` (`project_id`),
  KEY `admin_id_idx` (`admin_id`),
  CONSTRAINT `rm_group_admin_id_user_id` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`),
  CONSTRAINT `rm_group_creator_user_id` FOREIGN KEY (`creator`) REFERENCES `user` (`id`),
  CONSTRAINT `rm_group_project_id_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roster` (
  `roster_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `semester_id` int DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  PRIMARY KEY (`roster_id`),
  UNIQUE KEY `student_course_idx` (`student_id`,`course_id`,`semester_id`,`section_id`),
  KEY `student_id_idx` (`student_id`),
  KEY `course_id_idx` (`course_id`),
  KEY `semester_id_idx` (`semester_id`),
  KEY `section_id_idx` (`section_id`),
  CONSTRAINT `roster_course_id_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `roster_section_id_section_id` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`),
  CONSTRAINT `roster_semester_id_semester_id` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`),
  CONSTRAINT `roster_student_id_user_id` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2678 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `roster_current_view` AS SELECT 
 1 AS `Course`,
 1 AS `Section.`,
 1 AS `Instructor`,
 1 AS `Student`,
 1 AS `NetID`,
 1 AS `RMSS Course`*/;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_sheet` (
  `studio_id` int NOT NULL DEFAULT '0',
  `semester_id` int NOT NULL DEFAULT '0',
  `course_id` int NOT NULL DEFAULT '0',
  `status` tinyint DEFAULT '1',
  PRIMARY KEY (`studio_id`,`semester_id`,`course_id`),
  KEY `scheduler_sheet_semester_id_semester_id` (`semester_id`),
  KEY `scheduler_sheet_course_id_course_id` (`course_id`),
  CONSTRAINT `scheduler_sheet_course_id_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `scheduler_sheet_semester_id_semester_id` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`),
  CONSTRAINT `scheduler_sheet_studio_id_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `section_course_id_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_group` (
  `student_id` int NOT NULL DEFAULT '0',
  `group_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`student_id`,`group_id`),
  KEY `student_group_group_id_rm_group_id` (`group_id`),
  CONSTRAINT `student_group_group_id_rm_group_id` FOREIGN KEY (`group_id`) REFERENCES `rm_group` (`id`),
  CONSTRAINT `student_group_student_id_user_id` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_project_hours` (
  `student_id` int NOT NULL DEFAULT '0',
  `project_id` int NOT NULL DEFAULT '0',
  `hours` int DEFAULT NULL,
  PRIMARY KEY (`student_id`,`project_id`),
  KEY `student_project_hours_project_id_project_id` (`project_id`),
  CONSTRAINT `student_project_hours_project_id_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `student_project_hours_student_id_user_id` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `max_time` decimal(18,2) DEFAULT NULL,
  `mon_hour` smallint DEFAULT NULL,
  `tue_hour` smallint DEFAULT NULL,
  `wed_hour` smallint DEFAULT NULL,
  `thur_hour` smallint DEFAULT NULL,
  `fri_hour` smallint DEFAULT NULL,
  `sat_hour` smallint DEFAULT NULL,
  `sun_hour` smallint DEFAULT NULL,
  `equipment_reservation` tinyint DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(20) DEFAULT NULL,
  `email` varchar(252) DEFAULT NULL,
  `user_type` tinyint DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_login` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4146 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_week` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `start_index` int DEFAULT NULL,
  `end_index` int DEFAULT NULL,
  `studio_id` int DEFAULT NULL,
  `semester` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `start_studio_idx` (`start`,`studio_id`),
  KEY `studio_id_idx` (`studio_id`),
  KEY `semester_idx` (`semester`),
  CONSTRAINT `virtual_week_semester_semester_id` FOREIGN KEY (`semester`) REFERENCES `semester` (`id`),
  CONSTRAINT `virtual_week_studio_id_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `week_name` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `studio_id` int DEFAULT NULL,
  `semester` int DEFAULT NULL,
  `background` varchar(10) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `start_studio_idx` (`start`,`studio_id`),
  KEY `studio_id_idx` (`studio_id`),
  KEY `semester_idx` (`semester`),
  CONSTRAINT `week_name_semester_semester_id` FOREIGN KEY (`semester`) REFERENCES `semester` (`id`),
  CONSTRAINT `week_name_studio_id_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weekday_hour` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hour` int DEFAULT NULL,
  `week_date` date DEFAULT NULL,
  `semester_id` int DEFAULT NULL,
  `studio_id` int DEFAULT NULL,
  `grid_index` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `week_date_idx` (`semester_id`,`studio_id`,`week_date`),
  KEY `semester_id_idx` (`semester_id`),
  KEY `studio_id_idx` (`studio_id`),
  CONSTRAINT `weekday_hour_semester_id_semester_id` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`),
  CONSTRAINT `weekday_hour_studio_id_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2341 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50001 DROP VIEW IF EXISTS `booked_sessions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dm187`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `booked_sessions` AS select `a`.`id` AS `id`,`a`.`start` AS `start`,`a`.`end` AS `end`,`s`.`name` AS `studio`,group_concat(distinct concat(`u`.`first_name`,' ',`u`.`last_name`) separator ', ') AS `students`,`b`.`contact_phone` AS `phone`,`p`.`name` AS `project`,`b`.`format_analog` AS `tape`,`b`.`format_dolby` AS `dolby`,`b`.`living_room` AS `live room`,group_concat(distinct concat(`e`.`model`,';',`e`.`serial`,';',`r`.`quantity`) separator ',') AS `gear` from ((((((((`allotment` `a` left join `booking` `b` on(((`a`.`id` = `b`.`allotment_id`) and (`b`.`confirmed` = 1)))) left join `rm_group` `g` on((`b`.`group_id` = `g`.`id`))) left join `student_group` `sg` on((`g`.`id` = `sg`.`group_id`))) left join `user` `u` on((`sg`.`student_id` = `u`.`id`))) left join `studio` `s` on((`a`.`studio_id` = `s`.`id`))) left join `equipment_reservation` `r` on((`r`.`booking_id` = `b`.`id`))) left join `equipment` `e` on((`e`.`id` = `r`.`equipment_id`))) left join `project` `p` on((`p`.`id` = `g`.`project_id`))) where (`g`.`name` is not null) group by `a`.`id` order by `a`.`start` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `bookings_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`rmss`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bookings_view` AS select `a`.`id` AS `id`,`a`.`start` AS `start`,`a`.`end` AS `end`,`s`.`name` AS `studio`,group_concat(distinct substring_index(`u`.`email`,'@',1) separator ',') AS `student_IDs`,group_concat(distinct concat(`u`.`first_name`,' ',`u`.`last_name`) separator ', ') AS `students`,`b`.`contact_phone` AS `phone`,`p`.`name` AS `project`,`b`.`format_analog` AS `tape`,`b`.`format_dolby` AS `dolby`,`b`.`living_room` AS `live room`,group_concat(distinct concat(`e`.`model`,';',`e`.`serial`,';',`r`.`quantity`) separator ',') AS `gear` from ((((((((`allotment` `a` left join `booking` `b` on(((`a`.`id` = `b`.`allotment_id`) and (`b`.`confirmed` = 1)))) left join `rm_group` `g` on((`b`.`group_id` = `g`.`id`))) left join `student_group` `sg` on((`g`.`id` = `sg`.`group_id`))) left join `user` `u` on((`sg`.`student_id` = `u`.`id`))) left join `studio` `s` on((`a`.`studio_id` = `s`.`id`))) left join `equipment_reservation` `r` on((`r`.`booking_id` = `b`.`id`))) left join `equipment` `e` on((`e`.`id` = `r`.`equipment_id`))) left join `project` `p` on((`p`.`id` = `g`.`project_id`))) where (`g`.`name` is not null) group by `a`.`id` order by `a`.`start` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `full_calendar`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dm187`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `full_calendar` AS select `a`.`id` AS `id`,`a`.`start` AS `start`,`a`.`end` AS `end`,`s`.`name` AS `studio`,(case when (`g`.`name` is null) then `a`.`description` else `g`.`name` end) AS `description`,(case when (`g`.`name` is not null) then group_concat(distinct concat(`u`.`first_name`,' ',`u`.`last_name`) separator ', ') else NULL end) AS `students`,group_concat(distinct `u`.`email` separator ', ') AS `email`,`b`.`contact_phone` AS `phone`,`p`.`name` AS `project`,`b`.`format_analog` AS `tape`,`b`.`format_dolby` AS `dolby`,`b`.`living_room` AS `live room`,`b`.`purpose` AS `purpose`,`b`.`guests` AS `guests`,`b`.`cancel_request` AS `cancel_request`,`b`.`cancel_request_time` AS `cancel_request_time`,`b`.`cancel_request_comment` AS `cancel_request_comment`,group_concat(distinct concat(`e`.`model`,';',`e`.`serial`,';',`r`.`quantity`) separator ',') AS `gear`,`a`.`bookable` AS `open`,`s`.`id` AS `studioId`,`b`.`id` AS `reservationId`,`g`.`id` AS `projectGroupId` from ((((((((`allotment` `a` left join `booking` `b` on(((`a`.`id` = `b`.`allotment_id`) and (`b`.`confirmed` = 1)))) left join `rm_group` `g` on((`b`.`group_id` = `g`.`id`))) left join `student_group` `sg` on((`g`.`id` = `sg`.`group_id`))) left join `user` `u` on((`sg`.`student_id` = `u`.`id`))) left join `studio` `s` on((`a`.`studio_id` = `s`.`id`))) left join `equipment_reservation` `r` on((`r`.`booking_id` = `b`.`id`))) left join `equipment` `e` on((`e`.`id` = `r`.`equipment_id`))) left join `project` `p` on((`p`.`id` = `g`.`project_id`))) where (`s`.`name` <> 'Staff Only') group by `a`.`id` order by `studio`,`a`.`start` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `project_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dm187`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `project_info` AS select `p1`.`id` AS `id`,`p1`.`name` AS `title`,json_object('title',`c`.`original_course_name`) AS `course`,`p1`.`start` AS `start`,`p1`.`end` AS `end`,`p1`.`book_start` AS `reservationStart`,json_arrayagg(json_object('locationId',`p2`.`studio_id`,'hours',`pa`.`hour`,'start',`pa`.`start`,'end',`pa`.`end`)) AS `allotments`,`p1`.`group_size` AS `groupSize`,`p1`.`group_hours` AS `groupAllottedHours`,`p1`.`is_open` AS `open`,json_array(`c`.`instructor`) AS `managers` from (((`project` `p1` left join `project` `p2` on((`p1`.`id` = `p2`.`parent_id`))) left join `course` `c` on((`p1`.`course_id` = `c`.`id`))) left join `project_allotment` `pa` on((`p2`.`id` = `pa`.`project_id`))) where (`p2`.`studio_id` is not null) group by `p1`.`name` union select `p3`.`id` AS `id`,`p3`.`name` AS `title`,json_object('title',`c`.`original_course_name`) AS `course`,`p3`.`start` AS `start`,`p3`.`end` AS `end`,`p3`.`book_start` AS `reservationStart`,json_arrayagg(json_object('locationId',`p3`.`studio_id`,'hours',`pa`.`hour`,'start',`pa`.`start`,'end',`pa`.`end`)) AS `allotments`,`p3`.`group_size` AS `groupSize`,`p3`.`group_hours` AS `groupAllottedHours`,`p3`.`is_open` AS `open`,json_array(`c`.`instructor`) AS `managers` from ((`project` `p3` left join `course` `c` on((`p3`.`course_id` = `c`.`id`))) left join `project_allotment` `pa` on((`p3`.`id` = `pa`.`project_id`))) where ((`p3`.`parent_id` is null) and (`p3`.`studio_id` is not null)) group by `p3`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `roster_current_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dm187`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `roster_current_view` AS select `c`.`original_course_name` AS `Course`,`s`.`name` AS `Section.`,`c`.`instructor` AS `Instructor`,concat_ws(' ',`u`.`first_name`,`u`.`last_name`) AS `Student`,`u`.`user_id` AS `NetID`,`c`.`name` AS `RMSS Course` from (((`course` `c` join `section` `s`) join `user` `u`) join `roster` `r`) where ((`r`.`student_id` = `u`.`id`) and (`r`.`course_id` = `c`.`id`) and (`r`.`section_id` = `s`.`id`) and (`r`.`semester_id` = (select max(`semester`.`id`) from `semester`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
