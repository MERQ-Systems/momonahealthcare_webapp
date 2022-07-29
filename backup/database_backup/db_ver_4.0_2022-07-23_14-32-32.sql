#
# TABLE STRUCTURE FOR: ambulance_call
#

DROP TABLE IF EXISTS `ambulance_call`;

CREATE TABLE `ambulance_call` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `vehicle_model` varchar(20) DEFAULT NULL,
  `driver` varchar(100) NOT NULL,
  `date` datetime DEFAULT NULL,
  `call_from` varchar(200) NOT NULL,
  `call_to` varchar(200) NOT NULL,
  `charge_category_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` int(11) DEFAULT NULL,
  `tax_percentage` float(10,2) DEFAULT NULL,
  `amount` float(10,2) DEFAULT 0.00,
  `net_amount` float(10,2) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `generated_by` (`generated_by`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `ambulance_call_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_4` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ambulance_call_ibfk_5` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `ambulance_call` (`id`, `patient_id`, `case_reference_id`, `vehicle_id`, `contact_no`, `address`, `vehicle_model`, `driver`, `date`, `call_from`, `call_to`, `charge_category_id`, `charge_id`, `standard_charge`, `tax_percentage`, `amount`, `net_amount`, `transaction_id`, `note`, `generated_by`, `created_at`) VALUES (1, 1, NULL, 1, NULL, NULL, NULL, 'Bekele Kebede', '2022-04-08 17:24:00', '', '', NULL, 1, 2000, '0.00', '2000.00', '2000.00', 3, 'Go with HEW for Abebech on Friday to Piassa', 1, '2022-04-03 14:26:24');


#
# TABLE STRUCTURE FOR: appoint_priority
#

DROP TABLE IF EXISTS `appoint_priority`;

CREATE TABLE `appoint_priority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appoint_priority` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO `appoint_priority` (`id`, `appoint_priority`, `created_at`) VALUES (1, 'Normal', '0000-00-00 00:00:00');
INSERT INTO `appoint_priority` (`id`, `appoint_priority`, `created_at`) VALUES (2, 'Urgent', '0000-00-00 00:00:00');
INSERT INTO `appoint_priority` (`id`, `appoint_priority`, `created_at`) VALUES (3, 'Very Urgent', '0000-00-00 00:00:00');
INSERT INTO `appoint_priority` (`id`, `appoint_priority`, `created_at`) VALUES (5, 'Low', '2021-09-24 13:28:40');


#
# TABLE STRUCTURE FOR: appointment
#

DROP TABLE IF EXISTS `appointment`;

CREATE TABLE `appointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `time` time DEFAULT NULL,
  `priority` varchar(100) NOT NULL,
  `specialist` varchar(100) NOT NULL,
  `doctor` int(11) DEFAULT NULL,
  `amount` varchar(200) NOT NULL,
  `message` text DEFAULT NULL,
  `appointment_status` varchar(11) DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `is_opd` varchar(10) NOT NULL,
  `is_ipd` varchar(10) NOT NULL,
  `global_shift_id` int(11) DEFAULT NULL,
  `shift_id` int(11) DEFAULT NULL,
  `is_queue` int(11) DEFAULT NULL,
  `live_consult` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor` (`doctor`),
  KEY `case_reference_id` (`case_reference_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (1, 3, NULL, NULL, '2022-04-08 15:45:00', '15:45:00', '', '2', 5, '', 'Dear Dr I would Like to to make an appointment for my pregnancy consultation', 'pending', 'Online', '', '', 1, 4, 0, 'yes', '2022-04-03 13:01:56');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (2, 3, NULL, NULL, '2022-04-08 15:45:00', '15:45:00', '2', '2', 5, '', 'Check Up on My pregnancy', 'pending', 'Online', '', '', 1, 4, 0, 'yes', '2022-04-03 13:16:51');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (3, 1, NULL, NULL, '2022-04-08 16:15:00', '16:15:00', '1', '2', 5, '', 'Maternal Appointment for Ababech', 'pending', 'Online', '', '', 1, 4, 0, 'yes', '2022-04-03 13:24:22');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (4, 4, NULL, NULL, '2022-04-22 15:00:00', '15:00:00', '', '1', 5, '', 'dying', 'pending', 'Online', '', '', 1, 4, 0, 'yes', '2022-04-06 08:14:50');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (5, 1, NULL, NULL, '2022-04-20 11:00:00', '11:00:00', '', '2', 5, '', 'Hello', 'pending', 'Online', '', '', 1, 3, 0, 'no', '2022-04-19 14:48:56');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (6, 1, NULL, NULL, '2022-05-04 11:15:00', '11:15:00', '', '1', 5, '', 'Head ache', 'pending', 'Online', '', '', 1, 3, 0, 'no', '2022-05-02 11:27:12');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (7, 1, 3, 3, '2022-05-04 19:54:00', NULL, '3', '', 5, '', 'New Symptoms', 'approved', 'Offline', '', '', 1, 3, 0, 'yes', '2022-05-02 16:55:08');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (8, 1, NULL, NULL, '2022-05-18 09:30:00', '09:30:00', '', '2', 5, '', 'Fever', 'pending', 'Online', '', '', 1, 3, 0, 'yes', '2022-05-17 14:55:17');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (9, 1, NULL, NULL, '2022-06-23 15:15:00', '15:15:00', '', '2', 5, '', 'head', 'pending', 'Online', '', '', 2, 6, 0, 'yes', '2022-06-23 08:37:43');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (10, 1, NULL, NULL, '2022-07-13 10:15:00', '10:15:00', '', '2', 5, '', 'amognal', 'pending', 'Online', '', '', 1, 3, 0, 'yes', '2022-07-08 09:36:21');
INSERT INTO `appointment` (`id`, `patient_id`, `case_reference_id`, `visit_details_id`, `date`, `time`, `priority`, `specialist`, `doctor`, `amount`, `message`, `appointment_status`, `source`, `is_opd`, `is_ipd`, `global_shift_id`, `shift_id`, `is_queue`, `live_consult`, `created_at`) VALUES (11, 1, NULL, NULL, '2022-07-11 10:00:00', '10:00:00', '', '2', 5, '', 'Pregnacy', 'pending', 'Online', '', '', 1, 1, 0, 'yes', '2022-07-09 13:24:29');


#
# TABLE STRUCTURE FOR: appointment_payment
#

DROP TABLE IF EXISTS `appointment_payment`;

CREATE TABLE `appointment_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `paid_amount` float(10,2) NOT NULL,
  `payment_mode` varchar(50) DEFAULT NULL,
  `payment_type` varchar(100) NOT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `appointment_payment_ibfk_2` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_payment_ibfk_3` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `appointment_payment` (`id`, `appointment_id`, `charge_id`, `paid_amount`, `payment_mode`, `payment_type`, `transaction_id`, `note`, `date`) VALUES (1, 7, 2, '57.50', NULL, 'Offline', NULL, NULL, '2022-05-02 19:55:08');


#
# TABLE STRUCTURE FOR: appointment_queue
#

DROP TABLE IF EXISTS `appointment_queue`;

CREATE TABLE `appointment_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `shift_id` int(11) DEFAULT NULL,
  `date` date NOT NULL DEFAULT '2021-01-11',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `staff_id` (`staff_id`),
  KEY `global_shift_id` (`shift_id`),
  CONSTRAINT `appointment_queue_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_queue_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_queue_ibfk_3` FOREIGN KEY (`shift_id`) REFERENCES `doctor_shift` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: bed
#

DROP TABLE IF EXISTS `bed`;

CREATE TABLE `bed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `bed_type_id` int(11) DEFAULT NULL,
  `bed_group_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `bed_type_id` (`bed_type_id`),
  KEY `bed_group_id` (`bed_group_id`),
  CONSTRAINT `bed_ibfk_1` FOREIGN KEY (`bed_type_id`) REFERENCES `bed_type` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bed_ibfk_2` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: bed_group
#

DROP TABLE IF EXISTS `bed_group`;

CREATE TABLE `bed_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `color` varchar(50) NOT NULL DEFAULT '#f4f4f4',
  `description` varchar(200) NOT NULL,
  `floor` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: bed_type
#

DROP TABLE IF EXISTS `bed_type`;

CREATE TABLE `bed_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: birth_report
#

DROP TABLE IF EXISTS `birth_report`;

CREATE TABLE `birth_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `child_name` varchar(200) NOT NULL,
  `child_pic` varchar(200) NOT NULL,
  `gender` varchar(200) NOT NULL,
  `birth_date` datetime DEFAULT NULL,
  `weight` varchar(200) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `contact` varchar(20) NOT NULL,
  `mother_pic` varchar(200) NOT NULL,
  `father_name` varchar(200) NOT NULL,
  `father_pic` varchar(200) NOT NULL,
  `birth_report` mediumtext DEFAULT NULL,
  `document` varchar(200) NOT NULL,
  `address` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `birth_report_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `birth_report_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `birth_report` (`id`, `child_name`, `child_pic`, `gender`, `birth_date`, `weight`, `patient_id`, `case_reference_id`, `contact`, `mother_pic`, `father_name`, `father_pic`, `birth_report`, `document`, `address`, `is_active`, `created_at`) VALUES (1, 'baby', 'uploads/patient_images/no_image.png', 'Female', '1970-01-01 03:00:00', '3', 1, 1, '', 'uploads/patient_images/no_image.png', 'Endalk', 'uploads/patient_images/no_image.png', '', '', '', 'yes', '2022-04-05 07:08:05');


#
# TABLE STRUCTURE FOR: blood_bank_products
#

DROP TABLE IF EXISTS `blood_bank_products`;

CREATE TABLE `blood_bank_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blood_group` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (1, 'A-', 1, '2022-05-06 16:16:03');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (2, 'AB-', 1, '2022-05-06 16:15:21');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (3, 'A+', 1, '2022-05-06 16:15:31');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (4, 'B-', 1, '2022-05-06 16:15:44');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (5, 'B+', 1, '2022-05-06 16:16:16');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (6, 'O-', 1, '2022-05-06 16:16:28');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (7, 'O+', 1, '2022-05-06 16:16:40');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (8, 'Cryo', 2, '2022-05-06 16:47:57');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (9, 'Red Cells', 2, '2022-05-06 16:48:33');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (10, 'White Cells & Granulocytes', 2, '2022-05-06 16:48:49');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (11, 'Plasma', 2, '2022-05-06 16:49:15');
INSERT INTO `blood_bank_products` (`id`, `name`, `is_blood_group`, `created_at`) VALUES (12, 'Platelets', 2, '2022-05-06 16:49:28');


#
# TABLE STRUCTURE FOR: blood_donor
#

DROP TABLE IF EXISTS `blood_donor`;

CREATE TABLE `blood_donor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `blood_bank_product_id` int(11) DEFAULT NULL,
  `gender` varchar(11) DEFAULT NULL,
  `father_name` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `blood_bank_product_id` (`blood_bank_product_id`),
  CONSTRAINT `blood_donor_ibfk_1` FOREIGN KEY (`blood_bank_product_id`) REFERENCES `blood_bank_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: blood_donor_cycle
#

DROP TABLE IF EXISTS `blood_donor_cycle`;

CREATE TABLE `blood_donor_cycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blood_donor_cycle_id` int(11) NOT NULL,
  `blood_bank_product_id` int(11) DEFAULT NULL,
  `blood_donor_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `donate_date` date DEFAULT NULL,
  `bag_no` varchar(11) DEFAULT NULL,
  `lot` varchar(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) DEFAULT NULL,
  `apply_charge` float(10,2) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `institution` varchar(100) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `tax_percentage` float(10,2) DEFAULT 0.00,
  `volume` varchar(100) DEFAULT NULL,
  `unit` int(11) DEFAULT NULL,
  `available` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `blood_bank_product_id` (`blood_bank_product_id`),
  KEY `blood_donor_id` (`blood_donor_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `blood_donor_cycle_ibfk_1` FOREIGN KEY (`blood_bank_product_id`) REFERENCES `blood_bank_products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_donor_cycle_ibfk_2` FOREIGN KEY (`blood_donor_id`) REFERENCES `blood_donor` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_donor_cycle_ibfk_3` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: blood_issue
#

DROP TABLE IF EXISTS `blood_issue`;

CREATE TABLE `blood_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `blood_donor_cycle_id` int(11) DEFAULT NULL,
  `date_of_issue` datetime DEFAULT NULL,
  `hospital_doctor` int(11) DEFAULT NULL,
  `reference` varchar(200) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` int(11) NOT NULL,
  `tax_percentage` float(10,2) NOT NULL,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT NULL,
  `net_amount` float(10,2) NOT NULL,
  `institution` varchar(100) DEFAULT NULL,
  `technician` varchar(50) DEFAULT NULL,
  `remark` mediumtext DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `blood_donor_cycle_id` (`blood_donor_cycle_id`),
  KEY `patient_id` (`patient_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `blood_issue_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_2` FOREIGN KEY (`blood_donor_cycle_id`) REFERENCES `blood_donor_cycle` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_3` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blood_issue_ibfk_4` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: captcha
#

DROP TABLE IF EXISTS `captcha`;

CREATE TABLE `captcha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `captcha` (`id`, `name`, `status`, `created_at`) VALUES (1, 'userlogin', 0, '2021-10-22 05:21:32');
INSERT INTO `captcha` (`id`, `name`, `status`, `created_at`) VALUES (2, 'login', 0, '2021-10-22 05:21:38');
INSERT INTO `captcha` (`id`, `name`, `status`, `created_at`) VALUES (3, 'appointment', 0, '2021-10-22 05:21:40');


#
# TABLE STRUCTURE FOR: case_references
#

DROP TABLE IF EXISTS `case_references`;

CREATE TABLE `case_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `case_references` (`id`, `created_at`) VALUES (1, '2021-12-17 17:06:33');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (2, '2022-01-17 08:01:38');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (3, '2022-05-02 16:55:08');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (4, '2022-05-06 15:57:03');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (5, '2022-05-06 16:25:45');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (6, '2022-05-07 11:37:25');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (7, '2022-06-13 07:43:29');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (8, '2022-06-23 08:43:46');
INSERT INTO `case_references` (`id`, `created_at`) VALUES (9, '2022-07-09 13:40:06');


#
# TABLE STRUCTURE FOR: certificates
#

DROP TABLE IF EXISTS `certificates`;

CREATE TABLE `certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `certificate_name` varchar(100) NOT NULL,
  `certificate_text` text DEFAULT NULL,
  `left_header` varchar(100) NOT NULL,
  `center_header` varchar(100) NOT NULL,
  `right_header` varchar(100) NOT NULL,
  `left_footer` varchar(100) NOT NULL,
  `right_footer` varchar(100) NOT NULL,
  `center_footer` varchar(100) NOT NULL,
  `background_image` varchar(100) NOT NULL,
  `created_for` tinyint(1) NOT NULL COMMENT '1 = staff, 2 = patients',
  `status` tinyint(1) NOT NULL,
  `header_height` int(11) NOT NULL,
  `content_height` int(11) NOT NULL,
  `footer_height` int(11) NOT NULL,
  `content_width` int(11) NOT NULL,
  `enable_patient_image` tinyint(1) NOT NULL COMMENT '0=no,1=yes',
  `enable_image_height` int(11) NOT NULL,
  `updated_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO `certificates` (`id`, `certificate_name`, `certificate_text`, `left_header`, `center_header`, `right_header`, `left_footer`, `right_footer`, `center_footer`, `background_image`, `created_for`, `status`, `header_height`, `content_height`, `footer_height`, `content_width`, `enable_patient_image`, `enable_image_height`, `updated_at`, `created_at`) VALUES (12, 'Sample Patient File Cover', '<table class=\"table table-bordered\" width=\"100%\">\r\n <tr>\r\n  <td width=\"50%\">Patient Name  </td>\r\n  <td width=\"50%\">[name] ([patient_id]) </td>\r\n </tr>\r\n <tr>\r\n  <td>Date of birth</td>\r\n  <td valign=\"top\">[dob]</td>\r\n </tr>\r\n <tr>\r\n  <td>Age</td>\r\n  <td valign=\"top\">[age]</td>\r\n </tr>\r\n <tr>\r\n  <td>Gender</td>\r\n  <td valign=\"top\">[gender]</td>\r\n </tr>\r\n \r\n <tr>\r\n  <td>Phone</td>\r\n  <td valign=\"top\">[phone]</td>\r\n </tr>\r\n <tr>\r\n  <td>Guardian Name</td>\r\n  <td valign=\"top\">[guardian_name]</td>\r\n </tr>\r\n <tr>\r\n  <td>Address</td>\r\n  <td valign=\"top\">[address]</td>\r\n </tr>\r\n <tr>\r\n  <td>Email</td>\r\n  <td valign=\"top\">[email]</td>\r\n </tr>\r\n <tr>\r\n  <td>OPD/IPD NO</td>\r\n  <td valign=\"top\">[opd_ipd_no]</td>\r\n </tr>\r\n  <tr>\r\n  <td>OPD Checkup Id</td>\r\n  <td valign=\"top\">[opd_checkup_id]</td>\r\n </tr>\r\n <tr>\r\n  <td>Consultant Doctor</td>\r\n  <td valign=\"top\">[consultant_doctor]</td>\r\n </tr>\r\n</table>', '<h2>Patient Detail</h2>', '', '', '', '', '', 'merq-emr-cert_bg.png', 2, 1, 140, 300, 700, 600, 1, 200, NULL, '2021-12-17 16:13:09');


#
# TABLE STRUCTURE FOR: charge_categories
#

DROP TABLE IF EXISTS `charge_categories`;

CREATE TABLE `charge_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_type_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `short_code` varchar(30) DEFAULT NULL,
  `is_default` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_type_id` (`charge_type_id`),
  CONSTRAINT `charge_categories_ibfk_1` FOREIGN KEY (`charge_type_id`) REFERENCES `charge_type_master` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `charge_categories` (`id`, `charge_type_id`, `name`, `description`, `short_code`, `is_default`, `created_at`) VALUES (1, 13, 'HEW', 'Health Extension Program Visit', NULL, '', NULL);
INSERT INTO `charge_categories` (`id`, `charge_type_id`, `name`, `description`, `short_code`, `is_default`, `created_at`) VALUES (2, 1, 'Maternal Health Charge', 'Maternal Health Charging Category', NULL, '', NULL);
INSERT INTO `charge_categories` (`id`, `charge_type_id`, `name`, `description`, `short_code`, `is_default`, `created_at`) VALUES (3, 2, 'OPD Charge Category', 'OPD Charge Category', NULL, '', NULL);


#
# TABLE STRUCTURE FOR: charge_type_master
#

DROP TABLE IF EXISTS `charge_type_master`;

CREATE TABLE `charge_type_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_type` varchar(200) NOT NULL,
  `is_default` varchar(10) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (1, 'Appointment', 'yes', 'yes', '2021-09-24 14:10:32');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (2, 'OPD', 'yes', 'yes', '2021-09-24 14:10:02');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (3, 'IPD', 'yes', 'yes', '2021-09-24 14:10:47');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (4, 'Pathology', 'yes', 'yes', '2021-10-22 21:40:03');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (5, 'Radiology', 'yes', 'yes', '2021-10-22 22:10:21');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (6, 'Blood Bank', 'yes', 'yes', '2021-10-22 22:10:33');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (7, 'Ambulance', 'yes', 'yes', '2021-10-22 22:10:44');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (8, 'Procedures', 'yes', 'yes', '2018-08-17 13:40:07');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (9, 'Investigations', 'yes', 'yes', '2018-08-17 13:40:07');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (10, 'Supplier', 'yes', 'yes', '2018-08-17 13:40:07');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (11, 'Operations', 'yes', 'yes', '2018-08-17 13:40:07');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (12, 'Others', 'yes', 'yes', '2018-08-17 13:40:07');
INSERT INTO `charge_type_master` (`id`, `charge_type`, `is_default`, `is_active`, `created_at`) VALUES (13, 'HEW-Visit_OPD', 'no', 'yes', '2021-12-12 17:58:42');


#
# TABLE STRUCTURE FOR: charge_type_module
#

DROP TABLE IF EXISTS `charge_type_module`;

CREATE TABLE `charge_type_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_type_master_id` int(11) DEFAULT NULL,
  `module_shortcode` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_type_master_id` (`charge_type_master_id`),
  CONSTRAINT `charge_type_module_ibfk_1` FOREIGN KEY (`charge_type_master_id`) REFERENCES `charge_type_master` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (2, 1, 'appointment', '2021-10-23 03:52:42');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (4, 2, 'opd', '2021-10-23 03:52:45');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (5, 3, 'ipd', '2021-10-23 03:52:49');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (6, 4, 'pathology', '2021-10-23 03:52:52');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (7, 5, 'radiology', '2021-10-23 03:52:54');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (8, 6, 'blood_bank', '2021-10-23 03:52:56');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (9, 7, 'ambulance', '2021-10-23 03:52:59');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (10, 8, 'opd', '2021-10-23 03:53:03');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (11, 8, 'ipd', '2021-10-23 03:53:04');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (13, 9, 'pathology', '2021-10-23 03:53:09');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (14, 9, 'radiology', '2021-10-23 03:53:11');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (15, 10, 'opd', '2021-10-23 03:53:14');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (16, 10, 'ipd', '2021-10-23 03:53:16');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (17, 11, 'opd', '2021-10-23 03:53:18');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (18, 11, 'ipd', '2021-10-23 03:53:18');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (19, 12, 'appointment', '2021-10-23 03:53:20');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (20, 12, 'opd', '2021-10-23 03:53:21');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (21, 12, 'ipd', '2021-10-23 03:53:21');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (24, 12, 'pathology', '2021-10-23 03:53:25');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (25, 12, 'radiology', '2021-10-23 03:53:27');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (26, 12, 'blood_bank', '2021-10-23 03:53:30');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (27, 12, 'ambulance', '2021-10-23 03:53:31');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (28, 13, 'appointment', '2021-12-12 17:58:42');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (29, 13, 'opd', '2021-12-12 17:58:42');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (30, 13, 'ipd', '2021-12-12 17:58:42');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (31, 13, 'pathology', '2021-12-12 17:58:42');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (32, 13, 'radiology', '2021-12-12 17:58:42');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (33, 13, 'blood_bank', '2021-12-12 17:58:42');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (35, 13, 'ambulance', '2021-12-17 17:02:26');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (36, 2, 'appointment', '2022-05-06 14:58:29');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (37, 2, 'ipd', '2022-05-06 14:58:35');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (38, 2, 'pathology', '2022-05-06 14:58:36');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (39, 2, 'radiology', '2022-05-06 14:58:38');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (40, 2, 'blood_bank', '2022-05-06 14:58:40');
INSERT INTO `charge_type_module` (`id`, `charge_type_master_id`, `module_shortcode`, `created_at`) VALUES (41, 2, 'ambulance', '2022-05-06 14:58:41');


#
# TABLE STRUCTURE FOR: charge_units
#

DROP TABLE IF EXISTS `charge_units`;

CREATE TABLE `charge_units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(50) DEFAULT NULL,
  `is_active` int(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (1, '01', 0, '2021-12-17 17:03:05');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (2, '02', 0, '2022-04-03 12:36:21');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (3, 'OPD-01', 0, '2022-05-06 14:59:55');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (4, 'mg', 0, '2022-05-06 16:54:44');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (5, 'Hour', 0, '2022-05-06 16:56:05');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (6, 'Day', 0, '2022-05-06 16:56:39');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (7, 'Minute', 0, '2022-05-06 16:56:52');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (8, 'Liter', 0, '2022-05-06 16:57:07');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (9, 'ml', 0, '2022-05-06 16:57:14');
INSERT INTO `charge_units` (`id`, `unit`, `is_active`, `created_at`) VALUES (10, '-', 0, '2022-05-06 16:57:33');


#
# TABLE STRUCTURE FOR: charges
#

DROP TABLE IF EXISTS `charges`;

CREATE TABLE `charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_category_id` int(11) DEFAULT NULL,
  `tax_category_id` int(11) DEFAULT NULL,
  `charge_unit_id` int(10) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `standard_charge` float(10,2) DEFAULT 0.00,
  `date` date DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_category_id` (`charge_category_id`),
  KEY `tax_category_id` (`tax_category_id`),
  KEY `charge_unit_id` (`charge_unit_id`),
  CONSTRAINT `charges_ibfk_1` FOREIGN KEY (`charge_category_id`) REFERENCES `charge_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `charges_ibfk_2` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `charges_ibfk_3` FOREIGN KEY (`charge_unit_id`) REFERENCES `charge_units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `charges` (`id`, `charge_category_id`, `tax_category_id`, `charge_unit_id`, `name`, `standard_charge`, `date`, `description`, `status`, `created_at`) VALUES (1, 1, 1, 1, 'HEW-Charge', '0.00', NULL, '', '', '2021-12-17 17:04:39');
INSERT INTO `charges` (`id`, `charge_category_id`, `tax_category_id`, `charge_unit_id`, `name`, `standard_charge`, `date`, `description`, `status`, `created_at`) VALUES (2, 2, 2, 2, 'Maternal Consultation', '50.00', NULL, 'Maternal Health Consultation Charges', '', '2022-04-03 12:37:53');
INSERT INTO `charges` (`id`, `charge_category_id`, `tax_category_id`, `charge_unit_id`, `name`, `standard_charge`, `date`, `description`, `status`, `created_at`) VALUES (3, 3, 3, 3, 'OPD Charge', '99.99', NULL, 'OPD-01 Payment', '', '2022-05-06 15:01:04');


#
# TABLE STRUCTURE FOR: chat_connections
#

DROP TABLE IF EXISTS `chat_connections`;

CREATE TABLE `chat_connections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_user_one` int(11) NOT NULL,
  `chat_user_two` int(11) NOT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_user_one` (`chat_user_one`),
  KEY `chat_user_two` (`chat_user_two`),
  CONSTRAINT `chat_connections_ibfk_1` FOREIGN KEY (`chat_user_one`) REFERENCES `chat_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_connections_ibfk_2` FOREIGN KEY (`chat_user_two`) REFERENCES `chat_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `chat_connections` (`id`, `chat_user_one`, `chat_user_two`, `ip`, `time`, `created_at`, `updated_at`) VALUES (1, 1, 2, NULL, NULL, '2021-12-17 17:57:58', NULL);
INSERT INTO `chat_connections` (`id`, `chat_user_one`, `chat_user_two`, `ip`, `time`, `created_at`, `updated_at`) VALUES (2, 1, 3, NULL, NULL, '2022-01-17 08:09:28', NULL);
INSERT INTO `chat_connections` (`id`, `chat_user_one`, `chat_user_two`, `ip`, `time`, `created_at`, `updated_at`) VALUES (3, 2, 4, NULL, NULL, '2022-04-03 14:04:19', NULL);


#
# TABLE STRUCTURE FOR: chat_messages
#

DROP TABLE IF EXISTS `chat_messages`;

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text DEFAULT NULL,
  `chat_user_id` int(11) NOT NULL,
  `ip` varchar(30) NOT NULL,
  `time` int(11) NOT NULL,
  `is_first` int(1) DEFAULT 0,
  `is_read` int(1) NOT NULL DEFAULT 0,
  `chat_connection_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_user_id` (`chat_user_id`),
  KEY `chat_connection_id` (`chat_connection_id`),
  CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`chat_user_id`) REFERENCES `chat_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_messages_ibfk_2` FOREIGN KEY (`chat_connection_id`) REFERENCES `chat_connections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (1, 'you are now connected on chat', 2, '', 0, 1, 1, 1, NULL);
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (2, 'HI', 2, '', 0, 0, 1, 1, '2021-12-20 11:32:56');
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (3, 'How are you &#63;', 2, '', 0, 0, 1, 1, '2021-12-24 10:03:41');
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (4, 'you are now connected on chat', 3, '', 0, 1, 1, 2, NULL);
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (5, 'Hi Nati', 3, '', 0, 0, 0, 2, '2022-01-17 11:09:33');
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (6, 'I am doing good', 1, '', 0, 0, 1, 1, '2022-04-02 15:56:54');
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (7, 'Great', 2, '', 0, 0, 1, 1, '2022-04-02 15:57:38');
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (8, 'Thanks', 1, '', 0, 0, 1, 1, '2022-04-02 15:58:13');
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (9, 'you are now connected on chat', 4, '', 0, 1, 1, 3, NULL);
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (10, 'Hi Dr. Hanibal', 4, '', 0, 0, 1, 3, '2022-04-03 17:04:21');
INSERT INTO `chat_messages` (`id`, `message`, `chat_user_id`, `ip`, `time`, `is_first`, `is_read`, `chat_connection_id`, `created_at`) VALUES (11, 'Hello W&#47;o Abebech', 2, '', 0, 0, 1, 3, '2022-04-03 17:04:45');


#
# TABLE STRUCTURE FOR: chat_users
#

DROP TABLE IF EXISTS `chat_users`;

CREATE TABLE `chat_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(20) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `create_staff_id` int(11) DEFAULT NULL,
  `create_patient_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `patient_id` (`patient_id`),
  KEY `create_staff_id` (`create_staff_id`),
  KEY `create_patient_id` (`create_patient_id`),
  CONSTRAINT `chat_users_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_users_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_users_ibfk_3` FOREIGN KEY (`create_staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_users_ibfk_4` FOREIGN KEY (`create_patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `chat_users` (`id`, `user_type`, `staff_id`, `patient_id`, `create_staff_id`, `create_patient_id`, `is_active`, `created_at`, `updated_at`) VALUES (1, 'staff', 1, NULL, NULL, NULL, 0, '2021-12-17 17:57:58', NULL);
INSERT INTO `chat_users` (`id`, `user_type`, `staff_id`, `patient_id`, `create_staff_id`, `create_patient_id`, `is_active`, `created_at`, `updated_at`) VALUES (2, 'patient', NULL, 1, 1, NULL, 0, '2021-12-17 17:57:58', NULL);
INSERT INTO `chat_users` (`id`, `user_type`, `staff_id`, `patient_id`, `create_staff_id`, `create_patient_id`, `is_active`, `created_at`, `updated_at`) VALUES (3, 'patient', NULL, 2, 1, NULL, 0, '2022-01-17 08:09:28', NULL);
INSERT INTO `chat_users` (`id`, `user_type`, `staff_id`, `patient_id`, `create_staff_id`, `create_patient_id`, `is_active`, `created_at`, `updated_at`) VALUES (4, 'staff', 5, NULL, NULL, 1, 0, '2022-04-03 14:04:19', NULL);


#
# TABLE STRUCTURE FOR: complaint
#

DROP TABLE IF EXISTS `complaint`;

CREATE TABLE `complaint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_type_id` int(11) DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `email` varchar(200) NOT NULL,
  `date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `action_taken` varchar(200) NOT NULL,
  `assigned` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `complaint_type_id` (`complaint_type_id`),
  CONSTRAINT `complaint_ibfk_1` FOREIGN KEY (`complaint_type_id`) REFERENCES `complaint_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: complaint_type
#

DROP TABLE IF EXISTS `complaint_type`;

CREATE TABLE `complaint_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_type` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: conference_staff
#

DROP TABLE IF EXISTS `conference_staff`;

CREATE TABLE `conference_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `conference_staff_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conference_staff_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `conference_staff` (`id`, `conference_id`, `staff_id`, `created_at`) VALUES (1, 1, 1, '2022-04-03 13:48:13');


#
# TABLE STRUCTURE FOR: conferences
#

DROP TABLE IF EXISTS `conferences`;

CREATE TABLE `conferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purpose` varchar(200) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `created_id` int(11) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `date` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `password` varchar(100) NOT NULL,
  `host_video` int(11) NOT NULL,
  `client_video` int(11) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `timezone` text DEFAULT NULL,
  `return_response` text DEFAULT NULL,
  `api_type` varchar(50) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_details_id` (`visit_details_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `created_id` (`created_id`),
  CONSTRAINT `conferences_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_3` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_4` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_ibfk_5` FOREIGN KEY (`created_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (1, 'meeting', NULL, NULL, NULL, NULL, 5, 'Test Meeting with Admin', '2022-04-03 16:47:00', 10, 'zzyLv', 0, 0, 'test Meeting 001', 'Africa/Addis_Ababa', '{\"uuid\":\"LtHksQcnSKa96HLx+fDziw==\",\"id\":84112911795,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Test Meeting with Admin\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-04-03T17:47:00Z\",\"duration\":10,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-04-03T13:48:13Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/84112911795?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6Ijg0MTEyOTExNzk1IiwiZXhwIjoxNjQ5MDAwODkzLCJpYXQiOjE2NDg5OTM2OTMsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.Sq9CIICRa4e0eGSWU0W8ZnGgvYQK8Q7YEd62augnXw8\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/84112911795?pwd=N0laR3I0eTdkeHgyeGNDTDhudVJtUT09\",\"password\":\"zzyLv\",\"h323_password\":\"778083\",\"pstn_password\":\"778083\",\"encrypted_password\":\"N0laR3I0eTdkeHgyeGNDTDhudVJtUT09\",\"settings\":{\"host_video\":false,\"participant_video\":false,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true},\"pre_schedule\":false}', 'global', 0, '2022-04-03 13:48:13');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (2, 'consult', 5, 1, NULL, NULL, 5, 'Test Live Consultation with Abebech', '2022-04-03 16:52:00', 10, '6GsG7', 0, 0, 'Test with Abebech Meeting', 'Africa/Addis_Ababa', '{\"uuid\":\"WVcTa63CTSqA1kVJ8Jifjw==\",\"id\":84112605231,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Test Live Consultation with Abebech\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-04-03T17:52:00Z\",\"duration\":10,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-04-03T13:53:55Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/84112605231?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6Ijg0MTEyNjA1MjMxIiwiZXhwIjoxNjQ5MDAxMjM2LCJpYXQiOjE2NDg5OTQwMzYsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.gxBfpt6dQUDyCIJUcoNTEkdWhvFcnF1AyifhNV0cH-s\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/84112605231?pwd=cE5wZzVROUlXa0RIaVJuSWIzcWtKQT09\",\"password\":\"6GsG7\",\"h323_password\":\"045264\",\"pstn_password\":\"045264\",\"encrypted_password\":\"cE5wZzVROUlXa0RIaVJuSWIzcWtKQT09\",\"settings\":{\"host_video\":false,\"participant_video\":false,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true},\"pre_schedule\":false}', 'global', 2, '2022-04-03 14:02:53');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (3, 'consult', 5, NULL, 3, NULL, 1, 'Online consult for OPDN3 Checkup ID 3', '2022-05-04 19:54:00', 60, 'o17ha', 1, 1, NULL, 'Africa/Addis_Ababa', '{\"uuid\":\"mx66C7bJSfO0\\/ANYx\\/u8IQ==\",\"id\":88349020266,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Online consult for OPDN3 Checkup ID 3\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-05-04T20:54:00Z\",\"duration\":60,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-05-02T16:55:09Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/88349020266?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6Ijg4MzQ5MDIwMjY2IiwiZXhwIjoxNjUxNTE3NzA5LCJpYXQiOjE2NTE1MTA1MDksImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.jMKAKU9VqWY9NvQenss3gMrm4gbF8OBbKySFT2wlECU\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/88349020266?pwd=dVdXekpVZ1lRZmRKMGdSd21Hc1c4UT09\",\"password\":\"o17ha\",\"h323_password\":\"576551\",\"pstn_password\":\"576551\",\"encrypted_password\":\"dVdXekpVZ1lRZmRKMGdSd21Hc1c4UT09\",\"settings\":{\"host_video\":true,\"participant_video\":true,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true},\"pre_schedule\":false}', 'global', 0, '2022-05-02 16:55:09');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (4, 'consult', 5, NULL, 4, NULL, 1, 'Online consult for Revisit OPDN4', '2022-05-02 07:55:00', 15, 'mFtRw', 1, 1, NULL, 'Africa/Addis_Ababa', '{\"uuid\":\"qYiMYk4zTKyOUwEvl\\/sM+A==\",\"id\":83555060111,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Online consult for Revisit OPDN4\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-05-06T15:57:04Z\",\"duration\":15,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-05-06T15:57:04Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/83555060111?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6IjgzNTU1MDYwMTExIiwiZXhwIjoxNjUxODU5ODI0LCJpYXQiOjE2NTE4NTI2MjQsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.SlYIheUYviVD74chFZf3ahRx3hEcfcRb4QUFB_IdB-w\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/83555060111?pwd=akdFZ1NQNG5hYkJxMjdIZVIrVXNhQT09\",\"password\":\"mFtRw\",\"h323_password\":\"826161\",\"pstn_password\":\"826161\",\"encrypted_password\":\"akdFZ1NQNG5hYkJxMjdIZVIrVXNhQT09\",\"settings\":{\"host_video\":true,\"participant_video\":true,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true},\"pre_schedule\":false}', 'global', 0, '2022-05-06 15:57:04');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (5, 'consult', 5, NULL, 5, NULL, 5, 'Online consult for Revisit OPDN5', '2022-05-13 08:15:00', 15, 'UA1ES', 1, 1, NULL, 'Africa/Addis_Ababa', '{\"uuid\":\"2cecjJWxTbadFzVtsCONgA==\",\"id\":89414160161,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Online consult for Revisit OPDN5\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-05-13T09:15:00Z\",\"duration\":15,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-05-06T16:25:45Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/89414160161?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6Ijg5NDE0MTYwMTYxIiwiZXhwIjoxNjUxODYxNTQ1LCJpYXQiOjE2NTE4NTQzNDUsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.v039MyWByhYsLKbYTZ8Y12XfdtPOGzXKpSIQGSZwzQA\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/89414160161?pwd=WjBWRU5pcGs3enVRZnZIbFJYSy96QT09\",\"password\":\"UA1ES\",\"h323_password\":\"430481\",\"pstn_password\":\"430481\",\"encrypted_password\":\"WjBWRU5pcGs3enVRZnZIbFJYSy96QT09\",\"settings\":{\"host_video\":true,\"participant_video\":true,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true},\"pre_schedule\":false}', 'global', 0, '2022-05-06 16:25:45');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (6, 'consult', 5, NULL, 6, NULL, 3, 'Online consult for Revisit OPDN6', '2022-05-13 08:15:00', 15, 'jNF8P', 1, 1, NULL, 'Africa/Addis_Ababa', '{\"uuid\":\"juGGWsgkRFyIhQcXXB679A==\",\"id\":85127026238,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Online consult for Revisit OPDN6\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-05-13T09:15:00Z\",\"duration\":15,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-05-07T11:37:25Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/85127026238?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6Ijg1MTI3MDI2MjM4IiwiZXhwIjoxNjUxOTMwNjQ1LCJpYXQiOjE2NTE5MjM0NDUsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.5b9x8g5FrvmY2jAey0F96Gcj0RhoMq0-JMnxmsnToHY\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/85127026238?pwd=Tmo5RmszQ1gxL0hqWFk1SzVSMGw4Zz09\",\"password\":\"jNF8P\",\"h323_password\":\"301483\",\"pstn_password\":\"301483\",\"encrypted_password\":\"Tmo5RmszQ1gxL0hqWFk1SzVSMGw4Zz09\",\"settings\":{\"host_video\":true,\"participant_video\":true,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true},\"pre_schedule\":false}', 'global', 0, '2022-05-07 11:37:26');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (7, 'consult', 5, NULL, 7, NULL, 1, 'Online consult for Revisit OPDN7', '2022-01-19 11:00:00', 15, 'ICFKK', 1, 1, NULL, 'Africa/Addis_Ababa', '{\"uuid\":\"g76v0lT9TuiZPpJlzQ914Q==\",\"id\":89676489548,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Online consult for Revisit OPDN7\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-06-13T07:43:30Z\",\"duration\":15,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-06-13T07:43:30Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/89676489548?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6Ijg5Njc2NDg5NTQ4IiwiZXhwIjoxNjU1MTEzNDEwLCJpYXQiOjE2NTUxMDYyMTAsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.lb6fLRVFrLV0oI8s8KSdvkhUBIahb3Weg__XF_tcf0M\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/89676489548?pwd=aHluSnJKaE85MSs4ZVM5eUVUTUs3dz09\",\"password\":\"ICFKK\",\"h323_password\":\"878094\",\"pstn_password\":\"878094\",\"encrypted_password\":\"aHluSnJKaE85MSs4ZVM5eUVUTUs3dz09\",\"settings\":{\"host_video\":true,\"participant_video\":true,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true,\"host_save_video_order\":false},\"pre_schedule\":false}', 'global', 0, '2022-06-13 07:43:30');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (8, 'consult', 5, NULL, 8, NULL, 1, 'Online consult for Revisit OPDN8', '2022-05-13 08:15:00', 15, 'QGk8R', 1, 1, NULL, 'Africa/Addis_Ababa', '{\"uuid\":\"JVy8uxMFR7WJS2sg1lYalQ==\",\"id\":83996259674,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Online consult for Revisit OPDN8\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-06-23T08:43:46Z\",\"duration\":15,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-06-23T08:43:46Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/83996259674?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6IjgzOTk2MjU5Njc0IiwiZXhwIjoxNjU1OTgxMDI2LCJpYXQiOjE2NTU5NzM4MjYsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.uPnJONO7ecFTD1xZFd6PpGB7vRNCLQg6R7focHpPY-4\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/83996259674?pwd=61QG9wFOiKH8t2cWUHPcTbUGGyJEM-.1\",\"password\":\"QGk8R\",\"h323_password\":\"366774\",\"pstn_password\":\"366774\",\"encrypted_password\":\"61QG9wFOiKH8t2cWUHPcTbUGGyJEM-.1\",\"settings\":{\"host_video\":true,\"participant_video\":true,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true,\"host_save_video_order\":false},\"pre_schedule\":false}', 'global', 0, '2022-06-23 08:43:46');
INSERT INTO `conferences` (`id`, `purpose`, `staff_id`, `patient_id`, `visit_details_id`, `ipd_id`, `created_id`, `title`, `date`, `duration`, `password`, `host_video`, `client_video`, `description`, `timezone`, `return_response`, `api_type`, `status`, `created_at`) VALUES (9, 'consult', 5, NULL, 9, NULL, 1, 'Online consult for Revisit OPDN9', '2022-05-17 08:35:00', 15, 't35zB', 1, 1, NULL, 'Africa/Addis_Ababa', '{\"uuid\":\"rCpujlQnQbangzk6D03HkQ==\",\"id\":83477140859,\"host_id\":\"32W8UXX_R8yyFsQTtxXH-g\",\"host_email\":\"merqconsultancy@gmail.com\",\"topic\":\"Online consult for Revisit OPDN9\",\"type\":2,\"status\":\"waiting\",\"start_time\":\"2022-07-09T13:40:07Z\",\"duration\":15,\"timezone\":\"America\\/New_York\",\"created_at\":\"2022-07-09T13:40:07Z\",\"start_url\":\"https:\\/\\/us02web.zoom.us\\/s\\/83477140859?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IjMyVzhVWFhfUjh5eUZzUVR0eFhILWciLCJpc3MiOiJ3ZWIiLCJzayI6IjU5NzI1MTA2MzMzOTcxMjQwNTciLCJzdHkiOjEwMCwid2NkIjoidXMwMiIsImNsdCI6MCwibW51bSI6IjgzNDc3MTQwODU5IiwiZXhwIjoxNjU3MzgxMjA3LCJpYXQiOjE2NTczNzQwMDcsImFpZCI6Ill2MGxYYkdzVHl5ZXA0aW5tVFZ0NVEiLCJjaWQiOiIifQ.Gi9zOnLvTGKD2nAI4Es1bIr6FYjdTOeYgzRtMF_hw30\",\"join_url\":\"https:\\/\\/us02web.zoom.us\\/j\\/83477140859?pwd=SHdMTSt6R3gySFowT3N5bjRHdk90UT09\",\"password\":\"t35zB\",\"h323_password\":\"876609\",\"pstn_password\":\"876609\",\"encrypted_password\":\"SHdMTSt6R3gySFowT3N5bjRHdk90UT09\",\"settings\":{\"host_video\":true,\"participant_video\":true,\"cn_meeting\":false,\"in_meeting\":false,\"join_before_host\":false,\"jbh_time\":0,\"mute_upon_entry\":false,\"watermark\":false,\"use_pmi\":false,\"approval_type\":2,\"audio\":\"both\",\"auto_recording\":\"none\",\"enforce_login\":false,\"enforce_login_domains\":\"\",\"alternative_hosts\":\"\",\"alternative_host_update_polls\":false,\"close_registration\":false,\"show_share_button\":false,\"allow_multiple_devices\":false,\"registrants_confirmation_email\":true,\"waiting_room\":false,\"request_permission_to_unmute_participants\":false,\"global_dial_in_countries\":[\"US\"],\"global_dial_in_numbers\":[{\"country_name\":\"US\",\"number\":\"+1 6694449171\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"San Jose\",\"number\":\"+1 6699006833\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"New York\",\"number\":\"+1 9292056099\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Tacoma\",\"number\":\"+1 2532158782\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Washington DC\",\"number\":\"+1 3017158592\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Chicago\",\"number\":\"+1 3126266799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"city\":\"Houston\",\"number\":\"+1 3462487799\",\"type\":\"toll\",\"country\":\"US\"},{\"country_name\":\"US\",\"number\":\"+1 6469313860\",\"type\":\"toll\",\"country\":\"US\"}],\"registrants_email_notification\":true,\"meeting_authentication\":false,\"encryption_type\":\"enhanced_encryption\",\"approved_or_denied_countries_or_regions\":{\"enable\":false},\"breakout_room\":{\"enable\":false},\"alternative_hosts_email_notification\":true,\"device_testing\":false,\"focus_mode\":false,\"private_meeting\":false,\"email_notification\":true,\"host_save_video_order\":false},\"pre_schedule\":false}', 'global', 0, '2022-07-09 13:40:07');


#
# TABLE STRUCTURE FOR: conferences_history
#

DROP TABLE IF EXISTS `conferences_history`;

CREATE TABLE `conferences_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `total_hit` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  KEY `staff_id` (`staff_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `conferences_history_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conferences` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_history_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conferences_history_ibfk_3` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `conferences_history` (`id`, `conference_id`, `staff_id`, `patient_id`, `total_hit`, `created_at`) VALUES (1, 1, 1, NULL, 0, '2022-04-03 13:50:12');


#
# TABLE STRUCTURE FOR: consult_charges
#

DROP TABLE IF EXISTS `consult_charges`;

CREATE TABLE `consult_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `doctor` (`doctor`),
  CONSTRAINT `consult_charges_ibfk_1` FOREIGN KEY (`doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: consultant_register
#

DROP TABLE IF EXISTS `consultant_register`;

CREATE TABLE `consultant_register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `ins_date` date DEFAULT NULL,
  `instruction` text DEFAULT NULL,
  `cons_doctor` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `cons_doctor` (`cons_doctor`),
  CONSTRAINT `consultant_register_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `consultant_register_ibfk_2` FOREIGN KEY (`cons_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: content_for
#

DROP TABLE IF EXISTS `content_for`;

CREATE TABLE `content_for` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(50) DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `content_id` (`content_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `content_for_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_for_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: contents
#

DROP TABLE IF EXISTS `contents`;

CREATE TABLE `contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `is_public` varchar(10) DEFAULT 'No',
  `file` varchar(250) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `contents` (`id`, `title`, `type`, `is_public`, `file`, `note`, `date`, `is_active`, `created_by`, `created_at`) VALUES (1, 'MERQ-EMR', 'MERQ_EMR System Structure', 'No', 'uploads/hospital_content/material/1.pdf', 'Detailed MERQ_EMR System Structure Intro.', NULL, 'no', NULL, '2022-05-06 16:06:24');


#
# TABLE STRUCTURE FOR: custom_field_values
#

DROP TABLE IF EXISTS `custom_field_values`;

CREATE TABLE `custom_field_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `belong_table_id` int(11) DEFAULT NULL,
  `custom_field_id` int(11) DEFAULT NULL,
  `field_value` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `custom_field_id` (`custom_field_id`),
  CONSTRAINT `custom_field_values_ibfk_1` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (1, NULL, 1, 'ChestPain', '2022-04-18 15:57:30');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (2, NULL, 2, 'Pin on Chest ', '2022-05-06 14:56:09');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (3, NULL, 5, ' Cough', '2022-05-06 14:55:18');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (4, NULL, 7, 'Dry Cough', '2022-05-06 14:56:09');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (5, 4, 1, 'ChestPain', '2022-05-06 15:57:05');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (6, 4, 2, '', '2022-05-06 15:57:05');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (7, 4, 5, 'Crackles, Cough', '2022-05-06 15:57:05');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (8, 4, 7, 'Dry Cough', '2022-05-06 15:57:05');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (9, 5, 1, 'ChestPain', '2022-05-06 16:25:46');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (10, 5, 2, '', '2022-05-06 16:25:46');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (11, 5, 5, 'Crackles, Cough', '2022-05-06 16:25:46');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (12, 5, 7, 'Continuous Dry Coughs ', '2022-05-06 16:25:46');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (13, 6, 2, '', '2022-05-07 11:37:27');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (14, 6, 5, ' Cough', '2022-05-07 11:37:27');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (15, 6, 7, 'High Cough', '2022-05-07 11:37:27');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (16, 7, 1, 'ChestPain, Murmur, Dizziness, Edema, Neck Vein Distention, Pacemaker, No Deficit, Other', '2022-06-13 07:43:31');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (17, 7, 2, 'anal bleeding', '2022-06-13 07:43:31');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (18, 7, 5, 'Crackles, Wheezes, Orthopnea, Lungs Clear Bilaterally, Cough, Dyspnea', '2022-06-13 07:43:31');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (19, 7, 7, '', '2022-06-13 07:43:31');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (20, 7, 9, ' Male ', '2022-06-13 07:43:31');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (21, 8, 1, 'ChestPain, Murmur, Dizziness', '2022-06-23 08:43:47');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (22, 8, 2, '', '2022-06-23 08:43:47');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (23, 8, 5, ' Wheezes', '2022-06-23 08:43:47');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (24, 8, 7, '', '2022-06-23 08:43:47');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (25, 8, 9, 'Female', '2022-06-23 08:43:47');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (26, 9, 1, 'ChestPain, Murmur', '2022-07-09 13:40:08');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (27, 9, 2, '', '2022-07-09 13:40:08');
INSERT INTO `custom_field_values` (`id`, `belong_table_id`, `custom_field_id`, `field_value`, `created_at`) VALUES (28, 9, 7, '', '2022-07-09 13:40:08');


#
# TABLE STRUCTURE FOR: custom_fields
#

DROP TABLE IF EXISTS `custom_fields`;

CREATE TABLE `custom_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `belong_to` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `bs_column` int(10) DEFAULT NULL,
  `validation` int(11) DEFAULT 0,
  `field_values` mediumtext DEFAULT NULL,
  `visible_on_print` int(11) DEFAULT NULL,
  `visible_on_report` int(11) DEFAULT NULL,
  `visible_on_table` int(11) DEFAULT NULL,
  `visible_on_patient_panel` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (1, 'CARDIOVASCULAR', 'opd', 'checkbox', 12, 0, 'ChestPain, Murmur, Dizziness, Edema, Neck Vein Distention, Pacemaker, No Deficit, Other', 1, 1, 1, 1, NULL, 0, '2022-04-18 15:43:07');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (2, 'CARDIOVASCULAR Notes', 'opd', 'input', 12, 0, 'If Other,', 1, 1, 1, 1, NULL, 0, '2022-04-18 15:51:03');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (3, 'CARDIOVASCULAR', 'opdrecheckup', 'checkbox', 12, 0, 'ChestPain, Murmur, Dizziness, Edema, Neck Vein Distention, Pacemaker, No Deficit, Other', 1, 1, 1, 1, NULL, 0, '2022-05-06 14:45:46');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (4, 'CARDIOVASCULAR Notes', 'opdrecheckup', 'textarea', 12, 0, '', 1, 1, 1, 1, NULL, 0, '2022-05-06 14:47:19');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (5, 'RESPIRATORY', 'opd', 'checkbox', 12, 0, 'Crackles, Wheezes, Orthopnea, Lungs Clear Bilaterally, Cough, Dyspnea, Other', 1, 1, 1, 1, NULL, 0, '2022-05-06 14:50:51');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (6, 'RESPIRATORY', 'opdrecheckup', 'checkbox', 12, 0, 'Crackles, Wheezes, Orthopnea, Lungs Clear Bilaterally, Cough, Dyspnea, Other', 1, 1, 1, 1, NULL, 0, '2022-05-06 14:51:56');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (7, 'RESPIRATORY Notes', 'opd', 'textarea', 12, 0, '', 1, 1, 1, 1, NULL, 0, '2022-05-06 14:52:30');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (8, 'RESPIRATORY Notes', 'opdrecheckup', 'textarea', 12, 0, '', 1, 1, 1, 1, NULL, 0, '2022-05-06 14:52:56');
INSERT INTO `custom_fields` (`id`, `name`, `belong_to`, `type`, `bs_column`, `validation`, `field_values`, `visible_on_print`, `visible_on_report`, `visible_on_table`, `visible_on_patient_panel`, `weight`, `is_active`, `created_at`) VALUES (9, 'Genders', 'opd', 'checkbox', 12, 0, 'Female, Male ', 1, 1, 1, 1, NULL, 0, '2022-05-10 08:51:14');


#
# TABLE STRUCTURE FOR: death_report
#

DROP TABLE IF EXISTS `death_report`;

CREATE TABLE `death_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `attachment` varchar(200) NOT NULL,
  `attachment_name` text DEFAULT NULL,
  `death_date` datetime NOT NULL,
  `guardian_name` varchar(200) NOT NULL,
  `death_report` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `death_report_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `death_report_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: department
#

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(200) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `department` (`id`, `department_name`, `is_active`, `created_at`) VALUES (1, 'HEW', 'yes', '2021-12-12 17:32:54');
INSERT INTO `department` (`id`, `department_name`, `is_active`, `created_at`) VALUES (2, 'Pediatrics', 'yes', '2022-04-03 11:56:52');
INSERT INTO `department` (`id`, `department_name`, `is_active`, `created_at`) VALUES (3, 'Maternal Health', 'yes', '2022-04-03 11:59:37');


#
# TABLE STRUCTURE FOR: discharge_card
#

DROP TABLE IF EXISTS `discharge_card`;

CREATE TABLE `discharge_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `opd_details_id` int(11) DEFAULT NULL,
  `ipd_details_id` int(11) DEFAULT NULL,
  `discharge_by` int(11) DEFAULT NULL,
  `discharge_date` datetime DEFAULT NULL,
  `discharge_status` int(10) NOT NULL,
  `death_date` datetime DEFAULT NULL,
  `refer_date` datetime DEFAULT NULL,
  `refer_to_hospital` varchar(255) DEFAULT NULL,
  `reason_for_referral` varchar(255) DEFAULT NULL,
  `operation` varchar(225) NOT NULL,
  `diagnosis` varchar(255) NOT NULL,
  `investigations` text DEFAULT NULL,
  `treatment_home` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `opd_details_id` (`opd_details_id`),
  KEY `ipd_details_id` (`ipd_details_id`),
  KEY `discharge_by` (`discharge_by`),
  CONSTRAINT `discharge_card_ibfk_1` FOREIGN KEY (`ipd_details_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_2` FOREIGN KEY (`discharge_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_4` FOREIGN KEY (`opd_details_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_5` FOREIGN KEY (`ipd_details_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discharge_card_ibfk_6` FOREIGN KEY (`discharge_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: dispatch_receive
#

DROP TABLE IF EXISTS `dispatch_receive`;

CREATE TABLE `dispatch_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL,
  `to_title` varchar(100) NOT NULL,
  `address` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `from_title` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `image` varchar(100) NOT NULL,
  `type` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: doctor_absent
#

DROP TABLE IF EXISTS `doctor_absent`;

CREATE TABLE `doctor_absent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `doctor_absent_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: doctor_global_shift
#

DROP TABLE IF EXISTS `doctor_global_shift`;

CREATE TABLE `doctor_global_shift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `global_shift_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `global_shift_id` (`global_shift_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `doctor_global_shift_ibfk_1` FOREIGN KEY (`global_shift_id`) REFERENCES `global_shift` (`id`) ON DELETE CASCADE,
  CONSTRAINT `doctor_global_shift_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (2, 4, 1, '2022-04-03 12:29:34');
INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (3, 5, 3, '2022-05-06 15:12:19');
INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (4, 5, 2, '2022-05-06 15:12:24');
INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (5, 4, 4, '2022-05-06 15:12:30');
INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (6, 5, 1, '2022-05-06 15:15:09');
INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (7, 4, 2, '2022-05-06 15:15:11');
INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (8, 4, 3, '2022-05-06 15:15:12');
INSERT INTO `doctor_global_shift` (`id`, `staff_id`, `global_shift_id`, `created_at`) VALUES (9, 5, 4, '2022-05-06 15:15:13');


#
# TABLE STRUCTURE FOR: doctor_shift
#

DROP TABLE IF EXISTS `doctor_shift`;

CREATE TABLE `doctor_shift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` varchar(20) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `global_shift_id` int(11) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `global_shift_id` (`global_shift_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `doctor_shift_ibfk_1` FOREIGN KEY (`global_shift_id`) REFERENCES `global_shift` (`id`) ON DELETE CASCADE,
  CONSTRAINT `doctor_shift_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (1, 'Monday', 5, 1, '08:30:00', '12:30:00', '2022-05-06 15:17:24');
INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (3, 'Wednesday', 5, 1, '08:30:00', '12:30:00', '2022-05-06 15:25:43');
INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (4, 'Friday', 5, 1, '15:00:00', '17:30:00', '2022-04-03 12:42:36');
INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (5, 'Tuesday', 5, 2, '13:30:00', '17:30:00', '2022-05-06 15:20:08');
INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (6, 'Thursday', 5, 2, '13:30:00', '17:30:00', '2022-05-06 15:20:59');
INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (7, 'Friday', 5, 3, '19:00:00', '23:00:00', '2022-05-06 15:22:40');
INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (8, 'Sunday', 5, 2, '13:30:00', '17:30:00', '2022-05-06 15:25:05');
INSERT INTO `doctor_shift` (`id`, `day`, `staff_id`, `global_shift_id`, `start_time`, `end_time`, `created_at`) VALUES (9, 'Thursday', 5, 1, '08:30:00', '12:30:00', '2022-05-06 15:32:32');


#
# TABLE STRUCTURE FOR: dose_duration
#

DROP TABLE IF EXISTS `dose_duration`;

CREATE TABLE `dose_duration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (1, '1 Month', '2022-05-06 17:10:45');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (2, '2 Weeks', '2022-05-06 17:10:55');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (3, '1 Week', '2022-05-06 17:11:05');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (4, '3 Days', '2022-05-06 17:11:37');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (5, '2 Months', '2022-05-06 17:11:47');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (6, '3 Months', '2022-05-06 17:12:00');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (7, '6 Months', '2022-05-06 17:12:07');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (8, 'QD', '2022-05-06 17:12:44');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (9, 'TID', '2022-05-06 17:12:53');
INSERT INTO `dose_duration` (`id`, `name`, `created_at`) VALUES (10, 'QID', '2022-05-06 17:13:40');


#
# TABLE STRUCTURE FOR: dose_interval
#

DROP TABLE IF EXISTS `dose_interval`;

CREATE TABLE `dose_interval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (1, 'Month', '2022-05-06 17:05:34');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (2, 'Week', '2022-05-06 17:06:56');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (3, '2 Week', '2022-05-06 17:07:13');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (4, 'Day', '2022-05-06 17:07:21');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (5, 'Morning', '2022-05-06 17:07:40');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (6, 'Afternoon', '2022-05-06 17:08:13');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (7, 'Evening', '2022-05-06 17:08:25');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (8, 'Night', '2022-05-06 17:08:33');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (9, '2 Daily', '2022-05-06 17:08:51');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (10, '1 Daily', '2022-05-06 17:09:35');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (11, '3 Times Daily', '2022-05-06 17:09:57');
INSERT INTO `dose_interval` (`id`, `name`, `created_at`) VALUES (12, 'Every 8 Hours', '2022-05-06 17:10:13');


#
# TABLE STRUCTURE FOR: email_config
#

DROP TABLE IF EXISTS `email_config`;

CREATE TABLE `email_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email_type` varchar(100) DEFAULT NULL,
  `smtp_server` varchar(100) DEFAULT NULL,
  `smtp_port` varchar(100) DEFAULT NULL,
  `smtp_username` varchar(100) DEFAULT NULL,
  `smtp_password` varchar(100) DEFAULT NULL,
  `ssl_tls` varchar(100) DEFAULT NULL,
  `smtp_auth` varchar(10) NOT NULL,
  `is_active` varchar(10) NOT NULL DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `email_config` (`id`, `email_type`, `smtp_server`, `smtp_port`, `smtp_username`, `smtp_password`, `ssl_tls`, `smtp_auth`, `is_active`, `created_at`) VALUES (1, 'smtp', 'mail.merqconsultancy.org', '465', 'emr@merqconsultancy.org', 'mktd19735', 'ssl', 'true', 'yes', '2021-12-12 13:16:38');


#
# TABLE STRUCTURE FOR: events
#

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_title` varchar(200) NOT NULL,
  `event_description` text DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `event_type` varchar(100) NOT NULL,
  `event_color` varchar(200) NOT NULL,
  `event_for` varchar(100) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `events` (`id`, `event_title`, `event_description`, `start_date`, `end_date`, `event_type`, `event_color`, `event_for`, `role_id`, `is_active`, `created_at`) VALUES (1, 'ቀጠሮ ከዶክተር ጋር', '', '2022-04-29 00:00:00', '2022-04-29 00:00:00', 'task', '#000', '1', NULL, 'no', '2022-04-19 18:47:25');


#
# TABLE STRUCTURE FOR: expense_head
#

DROP TABLE IF EXISTS `expense_head`;

CREATE TABLE `expense_head` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exp_category` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `is_deleted` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: expenses
#

DROP TABLE IF EXISTS `expenses`;

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exp_head_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `invoice_no` varchar(200) NOT NULL,
  `date` date DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `documents` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `is_deleted` varchar(10) DEFAULT 'no',
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `exp_head_id` (`exp_head_id`),
  KEY `generated_by` (`generated_by`),
  CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`exp_head_id`) REFERENCES `expense_head` (`id`) ON DELETE CASCADE,
  CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: finding
#

DROP TABLE IF EXISTS `finding`;

CREATE TABLE `finding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `finding_category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `finding_category_id` (`finding_category_id`),
  CONSTRAINT `finding_ibfk_1` FOREIGN KEY (`finding_category_id`) REFERENCES `finding_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

INSERT INTO `finding` (`id`, `name`, `description`, `finding_category_id`, `created_at`) VALUES (1, 'Temperature High', 'Patient has a high Temperature and is having a fever', 1, '2022-05-06 15:36:37');
INSERT INTO `finding` (`id`, `name`, `description`, `finding_category_id`, `created_at`) VALUES (2, 'Diarrhea or constipation', 'Some people with typhoid fever or paratyphoid fever develop a rash of flat, rose-colored spots.', 4, '2022-05-06 15:49:50');
INSERT INTO `finding` (`id`, `name`, `description`, `finding_category_id`, `created_at`) VALUES (3, 'Headache', 'Typhoid fever and paratyphoid fever are treated with antibiotics.', 4, '2022-05-06 15:50:15');
INSERT INTO `finding` (`id`, `name`, `description`, `finding_category_id`, `created_at`) VALUES (4, 'Elevated temperature (above 37 °C)', 'The medical community generally defines a fever as a body temperature above 37 °C is usually considered a low-grade fever. ', 1, '2022-05-06 15:51:24');
INSERT INTO `finding` (`id`, `name`, `description`, `finding_category_id`, `created_at`) VALUES (5, 'Stomach pain', 'Typhoid fever and paratyphoid fever have similar symptoms̵. People usually have a sustained fever (one that doesn’t come and go) that can be as high as 103–104°F (39–40°C).', 4, '2022-05-06 15:52:07');
INSERT INTO `finding` (`id`, `name`, `description`, `finding_category_id`, `created_at`) VALUES (6, 'Dry Cough', 'Continuous Dry Coughs check with antibiotics  ', 2, '2022-05-06 16:28:40');


#
# TABLE STRUCTURE FOR: finding_category
#

DROP TABLE IF EXISTS `finding_category`;

CREATE TABLE `finding_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (1, 'Fever', '2022-05-06 15:34:46');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (2, 'Cough', '2022-05-06 15:35:02');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (3, 'Lungs', '2022-05-06 15:35:28');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (4, 'Typhidot (or Widal Test)', '2022-05-06 15:48:35');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (5, 'Skin Problem', '2022-05-06 15:48:43');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (6, 'Bone Density Problems', '2022-05-06 15:48:52');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (7, 'Hair Problems', '2022-05-06 15:49:00');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (8, 'Eye Diseases', '2022-05-06 15:49:07');
INSERT INTO `finding_category` (`id`, `category`, `created_at`) VALUES (9, 'Nose Diseases', '2022-05-06 15:49:21');


#
# TABLE STRUCTURE FOR: floor
#

DROP TABLE IF EXISTS `floor`;

CREATE TABLE `floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: front_cms_media_gallery
#

DROP TABLE IF EXISTS `front_cms_media_gallery`;

CREATE TABLE `front_cms_media_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(300) DEFAULT NULL,
  `thumb_path` varchar(300) DEFAULT NULL,
  `dir_path` varchar(300) DEFAULT NULL,
  `img_name` varchar(300) DEFAULT NULL,
  `thumb_name` varchar(300) DEFAULT NULL,
  `file_type` varchar(100) NOT NULL,
  `file_size` varchar(100) NOT NULL,
  `vid_url` mediumtext DEFAULT NULL,
  `vid_title` varchar(250) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: front_cms_menu_items
#

DROP TABLE IF EXISTS `front_cms_menu_items`;

CREATE TABLE `front_cms_menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `menu` varchar(100) DEFAULT NULL,
  `page_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `ext_url` mediumtext DEFAULT NULL,
  `open_new_tab` int(11) DEFAULT 0,
  `ext_url_link` mediumtext DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `publish` int(11) NOT NULL DEFAULT 0,
  `description` mediumtext DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

INSERT INTO `front_cms_menu_items` (`id`, `menu_id`, `menu`, `page_id`, `parent_id`, `ext_url`, `open_new_tab`, `ext_url_link`, `slug`, `weight`, `publish`, `description`, `is_active`, `created_at`) VALUES (1, 2, 'Home', 1, 0, NULL, NULL, NULL, 'home-1', NULL, 0, NULL, 'no', '2018-07-14 03:14:12');
INSERT INTO `front_cms_menu_items` (`id`, `menu_id`, `menu`, `page_id`, `parent_id`, `ext_url`, `open_new_tab`, `ext_url_link`, `slug`, `weight`, `publish`, `description`, `is_active`, `created_at`) VALUES (2, 1, 'Appointment', 0, 0, '1', NULL, 'https://momonahealthcare.merqconsultancy.org/form/appointment', 'appointment', 2, 0, NULL, 'no', '2022-07-23 11:22:09');
INSERT INTO `front_cms_menu_items` (`id`, `menu_id`, `menu`, `page_id`, `parent_id`, `ext_url`, `open_new_tab`, `ext_url_link`, `slug`, `weight`, `publish`, `description`, `is_active`, `created_at`) VALUES (3, 1, 'Home', 1, 0, NULL, NULL, NULL, 'home', 1, 0, NULL, 'no', '2022-04-03 14:40:31');
INSERT INTO `front_cms_menu_items` (`id`, `menu_id`, `menu`, `page_id`, `parent_id`, `ext_url`, `open_new_tab`, `ext_url_link`, `slug`, `weight`, `publish`, `description`, `is_active`, `created_at`) VALUES (4, 2, 'Appointment', 0, 0, '1', NULL, 'https://momonahealthcare.merqconsultancy.org/form/appointment', 'appointment-1', NULL, 0, NULL, 'no', '2022-07-23 11:22:23');
INSERT INTO `front_cms_menu_items` (`id`, `menu_id`, `menu`, `page_id`, `parent_id`, `ext_url`, `open_new_tab`, `ext_url_link`, `slug`, `weight`, `publish`, `description`, `is_active`, `created_at`) VALUES (5, 1, 'Contact Us', 4, 0, NULL, NULL, NULL, 'contact-us', 4, 0, NULL, 'no', '2022-04-03 14:41:55');
INSERT INTO `front_cms_menu_items` (`id`, `menu_id`, `menu`, `page_id`, `parent_id`, `ext_url`, `open_new_tab`, `ext_url_link`, `slug`, `weight`, `publish`, `description`, `is_active`, `created_at`) VALUES (6, 1, 'Search Appointments', 5, 0, NULL, NULL, NULL, 'search-appointments', 3, 0, NULL, 'no', '2022-04-03 14:44:22');
INSERT INTO `front_cms_menu_items` (`id`, `menu_id`, `menu`, `page_id`, `parent_id`, `ext_url`, `open_new_tab`, `ext_url_link`, `slug`, `weight`, `publish`, `description`, `is_active`, `created_at`) VALUES (8, 2, 'Staff Login', 0, 0, '1', 1, 'https://momonahealthcare.merqconsultancy.org/site/login', 'staff-login-1', NULL, 0, NULL, 'no', '2022-07-23 11:22:56');


#
# TABLE STRUCTURE FOR: front_cms_menus
#

DROP TABLE IF EXISTS `front_cms_menus`;

CREATE TABLE `front_cms_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu` varchar(100) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `open_new_tab` int(10) NOT NULL DEFAULT 0,
  `ext_url` mediumtext DEFAULT NULL,
  `ext_url_link` mediumtext DEFAULT NULL,
  `publish` int(11) NOT NULL DEFAULT 0,
  `content_type` varchar(10) NOT NULL DEFAULT 'manual',
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `front_cms_menus` (`id`, `menu`, `slug`, `description`, `open_new_tab`, `ext_url`, `ext_url_link`, `publish`, `content_type`, `is_active`, `created_at`) VALUES (1, 'Main Menu', 'main-menu', 'Main menu', 0, '', '', 0, 'default', 'no', '2018-04-20 03:54:49');
INSERT INTO `front_cms_menus` (`id`, `menu`, `slug`, `description`, `open_new_tab`, `ext_url`, `ext_url_link`, `publish`, `content_type`, `is_active`, `created_at`) VALUES (2, 'Bottom Menu', 'bottom-menu', 'Bottom Menu', 0, '', '', 0, 'default', 'no', '2018-04-20 03:54:55');


#
# TABLE STRUCTURE FOR: front_cms_page_contents
#

DROP TABLE IF EXISTS `front_cms_page_contents`;

CREATE TABLE `front_cms_page_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) DEFAULT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  CONSTRAINT `front_cms_page_contents_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `front_cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: front_cms_pages
#

DROP TABLE IF EXISTS `front_cms_pages`;

CREATE TABLE `front_cms_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_type` varchar(10) NOT NULL DEFAULT 'manual',
  `is_homepage` int(1) DEFAULT 0,
  `title` varchar(250) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `meta_title` mediumtext DEFAULT NULL,
  `meta_description` mediumtext DEFAULT NULL,
  `meta_keyword` mediumtext DEFAULT NULL,
  `feature_image` varchar(200) NOT NULL,
  `description` longtext DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `publish` int(10) DEFAULT 0,
  `sidebar` int(10) DEFAULT 0,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO `front_cms_pages` (`id`, `page_type`, `is_homepage`, `title`, `url`, `type`, `slug`, `meta_title`, `meta_description`, `meta_keyword`, `feature_image`, `description`, `publish_date`, `publish`, `sidebar`, `is_active`, `created_at`) VALUES (1, 'default', 1, 'Home MERQ-EMR', 'page/home-merq-emr', 'page', 'home-merq-emr', '', '', '', '', '<p style=\"text-align: center;\"><br />\r\n<span style=\"font-size:18px;\">እንኳን ወደ <span style=\"color:#008080;\"><u><b>MERQ EMR</b></u></span> በደህና መጡ! <u>ለጤና አገልግሎት ስርዓት 1ኛ ምርጫዎ!</u></span></p>\r\n\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n\r\n<p style=\"text-align: center;\">Welcome to <span style=\"color:#008080;\"><u><b>MERQ EMR</b></u></span> the all in one and <i><u>Your #1 Health Companion System!</u></i></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p style=\"text-align: center;\"><span style=\"font-size:20px;\"><span style=\"font-size:16px;\"><strong>ሲስተማችንን መጠቀም ለመጀመር እባክዎን የአንድሮይድ መተግበሪያችንን ከዚህ ያውርዱ ወይም <a href=\"https://emr.merqconsultancy.org/#\">እዚህ ይጫኑ</a> ወደ <a href=\"https://emr.merqconsultancy.org/form/appointment\">ቀጠሮ ፖርታል</a> በመሄድ ለመመዝገብ አሁንኑ የጤና ስርዓት ይጀምሩ።</strong></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n\r\n<p style=\"text-align: center;\">To start using our system please download our android application from <a href=\"https://emr.merqconsultancy.org/#\">here</a> or <a href=\"https://emr.merqconsultancy.org/form/appointment\">click here </a>to go to the <u><strong>appointment portal</strong></u> to register and</p>\r\n\r\n<p style=\"text-align: center;\">get started with the best health system today.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"col-md-12 hometop\">\r\n<div class=\"row\">\r\n<div class=\"col-md-3 col-sm-6 p-0\">\r\n<div class=\"featurebox1\">\r\n<h3 class=\"he-title\">Clinic News</h3>\r\n\r\n<p>MERQ EMR clinic news</p>\r\n\r\n<p><a class=\"morebtn\" href=\"#\" title=\"Read More\">Read More</a></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6 p-0\">\r\n<div class=\"featurebox2\">\r\n<h3 class=\"he-title\">Top Doctors</h3>\r\n\r\n<p>MERQ EMR Top Doctors</p>\r\n\r\n<p><a class=\"morebtn\" href=\"#\" title=\"Read More\">Read More</a></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6 p-0\">\r\n<div class=\"featurebox3\">\r\n<h3 class=\"he-title\">24 Hours Service</h3>\r\n\r\n<p>MERQ EMR 24 Hour service contents</p>\r\n\r\n<p><a class=\"morebtn\" href=\"#\" title=\"Read More\">Read More</a></p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6 p-0\">\r\n<div class=\"featurebox4\">\r\n<h3 class=\"he-title\">Opening Hours</h3>\r\n\r\n<ul style=\"padding: 0;list-style: none;clear: both; width:100%\">\r\n	<li style=\"width:100%; clear:both\"><span class=\"pull-left\">Monday - Friday</span><span class=\"pull-right\">8.00 - 17.00</span></li>\r\n	<li style=\"width:100%; clear:both\"><span class=\"pull-left\">Saturday</span><span class=\"pull-right\">9.30 - 17.30</span></li>\r\n	<li style=\"width:100%; clear:both\"><span class=\"pull-left\">Sunday</span><span class=\"pull-right\">9.30 - 15.00</span></li>\r\n</ul>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<div style=\"height:50px; clear: both\">&nbsp;</div>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-8\">\r\n<h3>About Us</h3>\r\n\r\n<h5>What we are and our history</h5>\r\n\r\n<p>About MERQ EMR contents</p>\r\n\r\n<hr />\r\n<h3>Vision & Mission</h3>\r\n\r\n<h5>Our goal and thoughts</h5>\r\n\r\n<p>MERQ EMR Vision and Mission contents</p>\r\n</div>\r\n\r\n<div class=\"col-md-4\"><img class=\"img-responsive\" src=\"https://emr.merqconsultancy.org/uploads/gallery/media/about.jpg\" /></div>\r\n</div>\r\n\r\n<h2 style=\"text-align: center;\">Featured Services</h2>\r\n\r\n<p style=\"text-align: center;\">We cover a big variety of medical services</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"row text-center\">\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"chooseus\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/medicine-icons.jpg\" />\r\n<h4>Medical Treatment</h4>\r\n\r\n<p>MERQ EMR Medical Treatment contents</p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"chooseus\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/emergency-1547424000.jpg\" />\r\n<h4>Emergency Help</h4>\r\n\r\n<p>MERQ EMR Emergency Help contents</p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"chooseus\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/doctor-icon.jpg\" />\r\n<h4>Qualified Doctors</h4>\r\n\r\n<p>MERQ EMR Qualified Doctors</p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"chooseus\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/profession-icon-1547424000.jpg\" />\r\n<h4>Medical professionals</h4>\r\n\r\n<p>MERQ EMR professionals</p>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<hr />\r\n<h2 style=\"text-align: center;\">Our Doctors</h2>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<div class=\"row text-center\">\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"team-member\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/docter1.jpg\" />\r\n<h4>Dr. Hannibal Kassahun</h4>\r\n\r\n<p>Medical Doctor (Internist)</p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"team-member\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/docter2.jpg\" />\r\n<h4>Dr. Haile Abebe</h4>\r\n\r\n<p>General Physician</p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"team-member\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/docter3.jpg\" />\r\n<h4>Dr. Ruth Kebede</h4>\r\n\r\n<p>Pediatrician</p>\r\n</div>\r\n</div>\r\n\r\n<div class=\"col-md-3 col-sm-6\">\r\n<div class=\"team-member\"><img src=\"https://emr.merqconsultancy.org/uploads/gallery/media/docter4.jpg\" />\r\n<h4>Dr. Samuel Z</h4>\r\n\r\n<p>Maternal Health Specialist</p>\r\n</div>\r\n</div>\r\n</div>', '0000-00-00', 1, 1, 'no', '2022-05-17 15:14:54');
INSERT INTO `front_cms_pages` (`id`, `page_type`, `is_homepage`, `title`, `url`, `type`, `slug`, `meta_title`, `meta_description`, `meta_keyword`, `feature_image`, `description`, `publish_date`, `publish`, `sidebar`, `is_active`, `created_at`) VALUES (2, 'default', 0, 'Complain', 'page/complain', 'page', 'complain', 'Complain form', '                                                                                                                                                                                    complain form                                                                                                                                                                                                                                ', 'complain form', '', '<div class=\"col-md-12 col-sm-12\">\r\n<h2 class=\"text-center\">&nbsp;</h2>\r\n\r\n<p class=\"text-center\">[form-builder:complain]</p>\r\n</div>', '0000-00-00', 1, 1, 'no', '2019-01-24 03:00:12');
INSERT INTO `front_cms_pages` (`id`, `page_type`, `is_homepage`, `title`, `url`, `type`, `slug`, `meta_title`, `meta_description`, `meta_keyword`, `feature_image`, `description`, `publish_date`, `publish`, `sidebar`, `is_active`, `created_at`) VALUES (3, 'default', 0, '404 page', 'page/404-page', 'page', '404-page', '', '                                ', '', '', '<title></title>\r\n<p>404 page found</p>', '0000-00-00', 0, NULL, 'no', '2021-09-24 11:35:15');
INSERT INTO `front_cms_pages` (`id`, `page_type`, `is_homepage`, `title`, `url`, `type`, `slug`, `meta_title`, `meta_description`, `meta_keyword`, `feature_image`, `description`, `publish_date`, `publish`, `sidebar`, `is_active`, `created_at`) VALUES (4, 'default', 0, 'Contact us', 'page/contact-us', 'page', 'contact-us', '', '', '', '', '<p>[form-builder:contact_us]</p>', '0000-00-00', 0, NULL, 'no', '2021-09-24 06:27:54');
INSERT INTO `front_cms_pages` (`id`, `page_type`, `is_homepage`, `title`, `url`, `type`, `slug`, `meta_title`, `meta_description`, `meta_keyword`, `feature_image`, `description`, `publish_date`, `publish`, `sidebar`, `is_active`, `created_at`) VALUES (5, 'manual', 0, 'our-appointment', 'page/our-appointment', 'page', 'our-appointment', '', '', '', '', '<form action=\"welcome/appointment\" method=\"get\">First name: <input name=\"fname\" type=\"text\" /><br />\r\nLast name: <input name=\"lname\" type=\"text\" /><br />\r\n<input type=\"submit\" value=\"Submit\" />&nbsp;</form>', '0000-00-00', 0, 1, 'no', '2021-09-24 11:35:25');


#
# TABLE STRUCTURE FOR: front_cms_program_photos
#

DROP TABLE IF EXISTS `front_cms_program_photos`;

CREATE TABLE `front_cms_program_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) DEFAULT NULL,
  `media_gallery_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `front_cms_program_photos_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `front_cms_programs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: front_cms_programs
#

DROP TABLE IF EXISTS `front_cms_programs`;

CREATE TABLE `front_cms_programs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `url` mediumtext DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `event_start` date DEFAULT NULL,
  `event_end` date DEFAULT NULL,
  `event_venue` mediumtext DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `meta_title` mediumtext DEFAULT NULL,
  `meta_description` mediumtext DEFAULT NULL,
  `meta_keyword` mediumtext DEFAULT NULL,
  `feature_image` mediumtext DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `publish` varchar(10) NOT NULL DEFAULT '0',
  `sidebar` int(10) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `front_cms_programs` (`id`, `type`, `slug`, `url`, `title`, `date`, `event_start`, `event_end`, `event_venue`, `description`, `is_active`, `meta_title`, `meta_description`, `meta_keyword`, `feature_image`, `publish_date`, `publish`, `sidebar`, `created_at`) VALUES (1, 'notice', 'welcome-to-merq-emr', 'read/welcome-to-merq-emr', 'Welcome to MERQ EMR', '2022-04-03', NULL, NULL, NULL, '<p>Welcome to <u><b>MERQ EMR</b></u> the all in one and <i><u>Your #1 Health Companion System!</u></i></p>\r\n\r\n<p><br>\r\n<br>\r\n<br>\r\n </p>', 'no', 'merq emr ', 'Welcome to MERQ EMR the all in one and Your #1 Health Companion System!', 'merq emr', '', NULL, '0', 1, '2022-04-03 14:58:27');


#
# TABLE STRUCTURE FOR: front_cms_settings
#

DROP TABLE IF EXISTS `front_cms_settings`;

CREATE TABLE `front_cms_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(50) DEFAULT NULL,
  `is_active_rtl` int(10) DEFAULT 0,
  `is_active_front_cms` int(11) DEFAULT 0,
  `is_active_online_appointment` int(11) DEFAULT NULL,
  `is_active_sidebar` int(1) DEFAULT 0,
  `logo` varchar(200) DEFAULT NULL,
  `contact_us_email` varchar(100) DEFAULT NULL,
  `complain_form_email` varchar(100) DEFAULT NULL,
  `sidebar_options` mediumtext DEFAULT NULL,
  `fb_url` varchar(200) NOT NULL,
  `twitter_url` varchar(200) NOT NULL,
  `youtube_url` varchar(200) NOT NULL,
  `google_plus` varchar(200) NOT NULL,
  `instagram_url` varchar(200) NOT NULL,
  `pinterest_url` varchar(200) NOT NULL,
  `linkedin_url` varchar(200) NOT NULL,
  `google_analytics` mediumtext DEFAULT NULL,
  `footer_text` varchar(500) DEFAULT NULL,
  `fav_icon` varchar(250) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `front_cms_settings` (`id`, `theme`, `is_active_rtl`, `is_active_front_cms`, `is_active_online_appointment`, `is_active_sidebar`, `logo`, `contact_us_email`, `complain_form_email`, `sidebar_options`, `fb_url`, `twitter_url`, `youtube_url`, `google_plus`, `instagram_url`, `pinterest_url`, `linkedin_url`, `google_analytics`, `footer_text`, `fav_icon`, `created_at`) VALUES (1, 'default', NULL, 1, 1, 1, './uploads/hospital_content/logo/front_logo-61b5f6883e29b6.60961018.png', '', '', '[\"news\",\"complain\"]', '', '', '', '', '', '', '', '', 'All Rights Reserved MERQ-EMR System', './uploads/hospital_content/logo/front_fav_icon-61b5f6883f31c4.33298647.png', '2022-04-03 14:45:06');


#
# TABLE STRUCTURE FOR: general_calls
#

DROP TABLE IF EXISTS `general_calls`;

CREATE TABLE `general_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `contact` varchar(12) NOT NULL,
  `date` date NOT NULL,
  `description` text DEFAULT NULL,
  `follow_up_date` date DEFAULT NULL,
  `call_duration` varchar(50) NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `call_type` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: global_shift
#

DROP TABLE IF EXISTS `global_shift`;

CREATE TABLE `global_shift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `global_shift` (`id`, `name`, `start_time`, `end_time`, `date_created`) VALUES (1, 'Morning Shift', '08:30:00', '12:30:00', '2022-05-06 15:06:01');
INSERT INTO `global_shift` (`id`, `name`, `start_time`, `end_time`, `date_created`) VALUES (2, 'Afternoon Shift', '13:30:00', '17:30:00', '2022-05-06 15:07:00');
INSERT INTO `global_shift` (`id`, `name`, `start_time`, `end_time`, `date_created`) VALUES (3, 'Night Shift', '19:00:00', '23:00:00', '2022-05-06 15:08:20');
INSERT INTO `global_shift` (`id`, `name`, `start_time`, `end_time`, `date_created`) VALUES (4, 'Late (Mid Night) Shift', '00:00:00', '07:00:00', '2022-05-06 15:11:06');


#
# TABLE STRUCTURE FOR: income
#

DROP TABLE IF EXISTS `income`;

CREATE TABLE `income` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inc_head_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `invoice_no` varchar(200) NOT NULL,
  `date` date DEFAULT NULL,
  `amount` float(10,2) DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `is_deleted` varchar(10) DEFAULT 'no',
  `documents` varchar(255) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `inc_head_id` (`inc_head_id`),
  KEY `generated_by` (`generated_by`),
  CONSTRAINT `income_ibfk_1` FOREIGN KEY (`inc_head_id`) REFERENCES `income_head` (`id`) ON DELETE CASCADE,
  CONSTRAINT `income_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: income_head
#

DROP TABLE IF EXISTS `income_head`;

CREATE TABLE `income_head` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `income_category` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL DEFAULT 'yes',
  `is_deleted` varchar(10) NOT NULL DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: ipd_details
#

DROP TABLE IF EXISTS `ipd_details`;

CREATE TABLE `ipd_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `height` varchar(5) DEFAULT NULL,
  `weight` varchar(5) DEFAULT NULL,
  `pulse` varchar(200) NOT NULL,
  `temperature` varchar(200) NOT NULL,
  `respiration` varchar(200) NOT NULL,
  `bp` varchar(20) DEFAULT NULL,
  `bed` varchar(100) NOT NULL,
  `bed_group_id` int(10) DEFAULT NULL,
  `case_type` varchar(100) NOT NULL,
  `casualty` varchar(100) NOT NULL,
  `symptoms` varchar(200) NOT NULL,
  `known_allergies` varchar(200) DEFAULT NULL,
  `patient_old` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `refference` varchar(200) NOT NULL,
  `cons_doctor` int(11) DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `credit_limit` varchar(100) NOT NULL,
  `payment_mode` varchar(100) NOT NULL,
  `date` datetime DEFAULT NULL,
  `discharged` varchar(200) NOT NULL,
  `live_consult` varchar(50) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `cons_doctor` (`cons_doctor`),
  KEY `bed_group_id` (`bed_group_id`),
  CONSTRAINT `ipd_details_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_4` FOREIGN KEY (`cons_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_details_ibfk_5` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: ipd_doctors
#

DROP TABLE IF EXISTS `ipd_doctors`;

CREATE TABLE `ipd_doctors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_id` int(11) NOT NULL,
  `consult_doctor` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `consult_doctor` (`consult_doctor`),
  CONSTRAINT `ipd_doctors_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_doctors_ibfk_2` FOREIGN KEY (`consult_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: ipd_prescription_basic
#

DROP TABLE IF EXISTS `ipd_prescription_basic`;

CREATE TABLE `ipd_prescription_basic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_id` int(11) DEFAULT NULL,
  `visit_details_id` int(11) DEFAULT NULL,
  `header_note` text DEFAULT NULL,
  `footer_note` text DEFAULT NULL,
  `finding_description` text DEFAULT NULL,
  `is_finding_print` varchar(100) DEFAULT NULL,
  `date` date NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `prescribe_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `visit_details_id` (`visit_details_id`),
  CONSTRAINT `ipd_prescription_basic_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_basic_ibfk_2` FOREIGN KEY (`visit_details_id`) REFERENCES `visit_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `ipd_prescription_basic` (`id`, `ipd_id`, `visit_details_id`, `header_note`, `footer_note`, `finding_description`, `is_finding_print`, `date`, `generated_by`, `prescribe_by`, `created_at`) VALUES (1, NULL, 5, '<p>Prescription for Mrs Abebech<br></p>', '<p>Follow the Doctors Note <br></p>', 'Dry Cough\r\nContinuous Dry Coughs check with antibiotics  ', 'yes', '2022-05-06', 5, 5, '2022-05-06 17:51:24');
INSERT INTO `ipd_prescription_basic` (`id`, `ipd_id`, `visit_details_id`, `header_note`, `footer_note`, `finding_description`, `is_finding_print`, `date`, `generated_by`, `prescribe_by`, `created_at`) VALUES (2, NULL, 6, '<p>Mo<br></p>', '<p>pres<br></p>', 'Temperature High\r\nPatient has a high Temperature and is having a fever', 'yes', '2022-05-07', 1, 5, '2022-05-07 11:48:03');


#
# TABLE STRUCTURE FOR: ipd_prescription_details
#

DROP TABLE IF EXISTS `ipd_prescription_details`;

CREATE TABLE `ipd_prescription_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basic_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(10) DEFAULT NULL,
  `dosage` int(11) DEFAULT NULL,
  `dose_interval_id` int(11) DEFAULT NULL,
  `dose_duration_id` int(11) DEFAULT NULL,
  `instruction` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `basic_id` (`basic_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  CONSTRAINT `ipd_prescription_details_ibfk_1` FOREIGN KEY (`basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_details_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `ipd_prescription_details` (`id`, `basic_id`, `pharmacy_id`, `dosage`, `dose_interval_id`, `dose_duration_id`, `instruction`, `created_at`) VALUES (1, 1, 2, 13, 11, 3, 'Please use as directed 3 times per day for a week', '2022-05-06 17:51:24');
INSERT INTO `ipd_prescription_details` (`id`, `basic_id`, `pharmacy_id`, `dosage`, `dose_interval_id`, `dose_duration_id`, `instruction`, `created_at`) VALUES (2, 2, 2, 13, 9, 3, 'Instruction ', '2022-05-07 11:48:03');


#
# TABLE STRUCTURE FOR: ipd_prescription_test
#

DROP TABLE IF EXISTS `ipd_prescription_test`;

CREATE TABLE `ipd_prescription_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipd_prescription_basic_id` int(100) DEFAULT NULL,
  `pathology_id` int(11) DEFAULT NULL,
  `radiology_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  KEY `pathology_id` (`pathology_id`),
  KEY `radiology_id` (`radiology_id`),
  CONSTRAINT `ipd_prescription_test_ibfk_1` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_test_ibfk_2` FOREIGN KEY (`pathology_id`) REFERENCES `pathology` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipd_prescription_test_ibfk_3` FOREIGN KEY (`radiology_id`) REFERENCES `radio` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: item
#

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_category_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(200) NOT NULL,
  `item_photo` varchar(225) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(100) NOT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `item_category_id` (`item_category_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `item` (`id`, `item_category_id`, `name`, `unit`, `item_photo`, `description`, `quantity`, `date`, `created_at`) VALUES (1, 1, 'Syringe', '600', NULL, 'Syringe Items for MERQ EMR', 0, NULL, '2022-05-06 17:28:50');


#
# TABLE STRUCTURE FOR: item_category
#

DROP TABLE IF EXISTS `item_category`;

CREATE TABLE `item_category` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `item_category` varchar(255) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL DEFAULT 'yes',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `item_category` (`id`, `item_category`, `is_active`, `description`, `created_at`) VALUES (1, 'Syringe Packs', 'yes', ' is a contract manufacturer of human and veterinary drug, medical device, and cosmetic products specializing in multiple non-sterile syringe packaging solutions. .Syringes can be filled with powder, semi-solids and liquid dosage forms at volumes from 1 mL to 10 mLs and larger.', '2022-05-06 17:24:10');
INSERT INTO `item_category` (`id`, `item_category`, `is_active`, `description`, `created_at`) VALUES (2, 'Cotton Packs', 'yes', 'Cotton Packs ', '2022-05-06 17:24:25');
INSERT INTO `item_category` (`id`, `item_category`, `is_active`, `description`, `created_at`) VALUES (3, 'Equipments', 'yes', 'Med Equipment ', '2022-05-06 17:25:03');
INSERT INTO `item_category` (`id`, `item_category`, `is_active`, `description`, `created_at`) VALUES (4, 'Bed Sheets', 'yes', 'Bed Sheets List', '2022-05-06 17:25:26');


#
# TABLE STRUCTURE FOR: item_issue
#

DROP TABLE IF EXISTS `item_issue`;

CREATE TABLE `item_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_type` int(11) DEFAULT NULL,
  `issue_to` int(11) DEFAULT NULL,
  `issue_by` varchar(100) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `item_category_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(10) NOT NULL,
  `note` text DEFAULT NULL,
  `is_returned` int(2) NOT NULL DEFAULT 1,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `item_category_id` (`item_category_id`),
  KEY `issue_to` (`issue_to`),
  CONSTRAINT `item_issue_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_issue_ibfk_2` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_issue_ibfk_3` FOREIGN KEY (`issue_to`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: item_stock
#

DROP TABLE IF EXISTS `item_stock`;

CREATE TABLE `item_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `symbol` varchar(10) NOT NULL DEFAULT '+',
  `store_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `purchase_price` float(10,2) DEFAULT 0.00,
  `date` date DEFAULT NULL,
  `attachment` varchar(250) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `item_stock_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_stock_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `item_supplier` (`id`) ON DELETE CASCADE,
  CONSTRAINT `item_stock_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `item_store` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `item_stock` (`id`, `item_id`, `supplier_id`, `symbol`, `store_id`, `quantity`, `purchase_price`, `date`, `attachment`, `description`, `is_active`, `created_at`) VALUES (1, 1, 1, '+', 1, 100, '1000.00', '2022-05-06', NULL, 'MERQ Syringes', 'yes', '2022-05-06 17:30:13');


#
# TABLE STRUCTURE FOR: item_store
#

DROP TABLE IF EXISTS `item_store`;

CREATE TABLE `item_store` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `item_store` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `item_store` (`id`, `item_store`, `code`, `description`, `created_at`) VALUES (1, 'MERQ EMR Store', '0001', 'MERQ EMR Store 0001', '2022-05-06 17:27:19');


#
# TABLE STRUCTURE FOR: item_supplier
#

DROP TABLE IF EXISTS `item_supplier`;

CREATE TABLE `item_supplier` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `item_supplier` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `contact_person_name` varchar(255) NOT NULL,
  `contact_person_phone` varchar(255) NOT NULL,
  `contact_person_email` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `item_supplier` (`id`, `item_supplier`, `phone`, `email`, `address`, `contact_person_name`, `contact_person_phone`, `contact_person_email`, `description`, `created_at`) VALUES (1, 'MERQ Item Supplier Name', '', '', '', '', '', '', '', '2022-05-06 17:22:57');


#
# TABLE STRUCTURE FOR: lab
#

DROP TABLE IF EXISTS `lab`;

CREATE TABLE `lab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (1, 'X-RAY CHEST PA VIEW', '2022-05-06 16:42:02');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (2, 'X-RAY PNS (WATER\'S VIEW)', '2022-05-06 16:42:11');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (3, 'X-RAY LUMBOSACRAL SPINE AP AND LAT VIEWS', '2022-05-06 16:42:22');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (4, 'ULTRASOUND WHOLE ABDOMEN', '2022-05-06 16:42:54');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (5, 'DOPPLER PERIPHERAL BILATERAL (VENOUS)', '2022-05-06 16:43:02');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (6, 'CT ORBITS', '2022-05-06 16:43:27');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (7, 'CT CHEST PLAIN', '2022-05-06 16:43:41');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (8, 'CT 3D STUDY', '2022-05-06 16:44:03');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (9, 'M. R. C. P.', '2022-05-06 16:44:21');
INSERT INTO `lab` (`id`, `lab_name`, `created_at`) VALUES (10, 'MRI CARDIAC WITH CONTRAST', '2022-05-06 16:44:30');


#
# TABLE STRUCTURE FOR: languages
#

DROP TABLE IF EXISTS `languages`;

CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(50) DEFAULT NULL,
  `short_code` varchar(255) NOT NULL,
  `country_code` varchar(255) NOT NULL,
  `is_deleted` varchar(10) NOT NULL DEFAULT 'yes',
  `is_rtl` varchar(10) NOT NULL DEFAULT 'no',
  `is_active` varchar(255) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (1, 'Azerbaijan', 'az', 'az', 'no', 'no', 'no', '2021-09-28 09:51:22', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (2, 'Albanian', 'sq', 'al', 'no', 'no', 'no', '2021-09-28 10:08:10', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (3, 'Amharic', 'am', 'et', 'no', 'no', 'no', '2022-04-03 15:10:56', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (4, 'English', 'en', 'us', 'no', 'no', 'no', '2021-09-16 05:20:47', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (5, 'Arabic', 'ar', 'sa', 'no', 'no', 'no', '2021-09-28 09:50:48', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (6, 'Afrikaans', 'af', 'af', 'no', 'no', 'no', '2021-09-28 10:51:19', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (7, 'Basque', 'eu', 'es', 'no', 'no', 'no', '2021-09-24 06:58:21', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (8, 'Bengali', 'bn', 'in', 'no', 'no', 'no', '2021-09-24 06:58:25', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (9, 'Bosnian', 'bs', 'bs', 'no', 'no', 'no', '2021-09-24 06:58:28', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (10, 'Welsh', 'cy', 'cy', 'no', 'no', 'no', '2021-09-24 06:58:31', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (11, 'Hungarian', 'hu', 'hu', 'no', 'no', 'no', '2021-09-24 06:58:35', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (12, 'Vietnamese', 'vi', 'vi', 'no', 'no', 'no', '2021-09-24 06:58:39', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (13, 'Haitian', 'ht', 'ht', 'no', 'no', 'no', '2021-09-24 06:58:43', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (14, 'Galician', 'gl', 'gl', 'no', 'no', 'no', '2021-09-24 06:58:47', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (15, 'Dutch', 'nl', 'nl', 'no', 'no', 'no', '2021-09-24 06:58:51', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (16, 'Greek', 'el', 'gr', 'no', 'no', 'no', '2021-09-24 06:58:53', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (17, 'Georgian', 'ka', 'ge', 'no', 'no', 'no', '2021-09-24 06:58:56', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (18, 'Gujarati', 'gu', 'in', 'no', 'no', 'no', '2021-09-24 06:58:59', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (19, 'Danish', 'da', 'dk', 'no', 'no', 'no', '2021-09-24 06:59:01', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (20, 'Hebrew', 'he', 'il', 'no', 'no', 'no', '2021-09-24 06:59:04', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (21, 'Yiddish', 'yi', 'il', 'no', 'no', 'no', '2021-09-24 06:59:07', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (22, 'Indonesian', 'id', 'id', 'no', 'no', 'no', '2021-09-24 06:59:10', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (23, 'Irish', 'ga', 'ga', 'no', 'no', 'no', '2021-09-24 06:59:14', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (24, 'Italian', 'it', 'it', 'no', 'no', 'no', '2021-09-24 06:59:17', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (25, 'Icelandic', 'is', 'is', 'no', 'no', 'no', '2021-09-24 06:59:20', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (26, 'Spanish', 'es', 'es', 'no', 'no', 'no', '2021-09-24 06:59:29', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (27, 'Kannada', 'kn', 'kn', 'no', 'no', 'no', '2021-09-24 06:59:32', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (28, 'Catalan', 'ca', 'ca', 'no', 'no', 'no', '2021-09-24 06:59:34', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (29, 'Chinese', 'zh', 'cn', 'no', 'no', 'no', '2021-09-24 06:59:36', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (30, 'Korean', 'ko', 'kr', 'no', 'no', 'no', '2021-09-24 06:59:39', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (31, 'Xhosa', 'xh', 'ls', 'no', 'no', 'no', '2021-09-24 06:59:42', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (32, 'Latin', 'la', 'la', 'no', 'no', 'no', '2021-09-24 06:59:45', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (33, 'Latvian', 'lv', 'lv', 'no', 'no', 'no', '2021-09-24 06:59:47', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (34, 'Lithuanian', 'lt', 'lt', 'no', 'no', 'no', '2021-09-24 06:59:50', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (35, 'Malagasy', 'mg', 'mg', 'no', 'no', 'no', '2021-09-24 06:59:52', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (36, 'Malay', 'ms', 'ms', 'no', 'no', 'no', '2021-09-24 07:00:01', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (37, 'Malayalam', 'ml', 'ml', 'no', 'no', 'no', '2021-09-24 07:00:05', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (38, 'Maltese', 'mt', 'mt', 'no', 'no', 'no', '2021-09-24 07:00:26', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (39, 'Macedonian', 'mk', 'mk', 'no', 'no', 'no', '2021-09-24 07:00:41', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (40, 'Maori', 'mi', 'nz', 'no', 'no', 'no', '2021-09-24 07:00:44', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (41, 'Marathi', 'mr', 'in', 'no', 'no', 'no', '2021-09-24 07:00:51', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (42, 'Mongolian', 'mn', 'mn', 'no', 'no', 'no', '2021-09-24 07:01:15', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (43, 'German', 'de', 'de', 'no', 'no', 'no', '2021-09-24 07:01:18', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (44, 'Nepali', 'ne', 'ne', 'no', 'no', 'no', '2021-09-24 07:01:21', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (45, 'Norwegian', 'no', 'no', 'no', 'no', 'no', '2021-09-24 07:01:41', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (46, 'Punjabi', 'pa', 'in', 'no', 'no', 'no', '2021-09-24 07:01:43', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (47, 'Persian', 'fa', 'ir', 'no', 'no', 'no', '2021-09-24 07:01:49', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (48, 'Portuguese', 'pt', 'pt', 'no', 'no', 'no', '2021-09-24 07:01:52', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (49, 'Romanian', 'ro', 'ro', 'no', 'no', 'no', '2021-09-24 07:01:56', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (50, 'Russian', 'ru', 'ru', 'no', 'no', 'no', '2021-09-24 07:01:59', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (51, 'Cebuano', 'ceb', 'ph', 'no', 'no', 'no', '2021-09-24 07:02:02', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (52, 'Sinhala', 'si', 'si', 'no', 'no', 'no', '2021-09-24 07:02:04', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (53, 'Slovakian', 'sk', 'sk', 'no', 'no', 'no', '2021-09-24 07:02:07', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (54, 'Slovenian', 'sl', 'sl', 'no', 'no', 'no', '2021-09-24 07:02:10', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (55, 'Swahili', 'sw', 'ke', 'no', 'no', 'no', '2021-09-24 07:02:12', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (56, 'Sundanese', 'su', 'sd', 'no', 'no', 'no', '2021-09-24 07:02:15', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (57, 'Thai', 'th', 'th', 'no', 'no', 'no', '2021-09-24 07:02:18', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (58, 'Tagalog', 'tl', 'tl', 'no', 'no', 'no', '2021-09-24 07:02:21', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (59, 'Tamil', 'ta', 'in', 'no', 'no', 'no', '2021-09-24 07:02:23', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (60, 'Telugu', 'te', 'in', 'no', 'no', 'no', '2021-09-24 07:02:26', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (61, 'Turkish', 'tr', 'tr', 'no', 'no', 'no', '2021-09-24 07:02:29', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (62, 'Uzbek', 'uz', 'uz', 'no', 'no', 'no', '2021-09-24 07:02:31', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (63, 'Urdu', 'ur', 'pk', 'no', 'no', 'no', '2021-09-24 07:02:34', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (64, 'Finnish', 'fi', 'fi', 'no', 'no', 'no', '2021-09-24 07:02:37', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (65, 'French', 'fr', 'fr', 'no', 'no', 'no', '2021-09-24 07:02:39', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (66, 'Hindi', 'hi', 'in', 'no', 'no', 'no', '2021-09-24 07:02:41', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (67, 'Czech', 'cs', 'cz', 'no', 'no', 'no', '2021-09-24 07:02:44', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (68, 'Swedish', 'sv', 'sv', 'no', 'no', 'no', '2021-09-24 07:02:46', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (69, 'Scottish', 'gd', 'gd', 'no', 'no', 'no', '2021-09-24 07:02:49', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (70, 'Estonian', 'et', 'et', 'no', 'no', 'no', '2021-09-24 07:02:52', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (71, 'Esperanto', 'eo', 'br', 'no', 'no', 'no', '2021-09-24 07:02:55', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (72, 'Javanese', 'jv', 'id', 'no', 'no', 'no', '2021-09-24 07:02:58', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (73, 'Japanese', 'ja', 'jp', 'no', 'no', 'no', '2021-09-24 07:03:01', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (74, 'Polish', 'pl', 'pl', 'no', 'no', 'no', '2021-09-28 06:39:06', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (75, 'Croatia ', 'hr', 'hr', 'no', 'no', 'no', '2021-10-25 07:56:41', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (76, 'Kurdish', 'ku', 'iq', 'no', 'no', 'no', '2021-10-25 07:56:44', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (77, 'Lao', 'lo', 'la', 'no', 'no', 'no', '2021-10-25 07:56:47', NULL);
INSERT INTO `languages` (`id`, `language`, `short_code`, `country_code`, `is_deleted`, `is_rtl`, `is_active`, `created_at`, `updated_at`) VALUES (78, 'Amharic/አማርኛ', 'et', 'am', 'yes', 'no', 'no', '2021-12-17 17:33:58', NULL);


#
# TABLE STRUCTURE FOR: leave_types
#

DROP TABLE IF EXISTS `leave_types`;

CREATE TABLE `leave_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: logs
#

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text DEFAULT NULL,
  `record_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `platform` varchar(50) NOT NULL,
  `agent` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8;

INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (1, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 12:56:30', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (2, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 15:57:16', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (3, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 15:57:24', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (4, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 16:07:37', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (5, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 16:07:58', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (6, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 16:08:05', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (7, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 16:08:43', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (8, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 16:08:50', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (9, 'Record updated On Email Config id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 16:16:38', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (10, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 16:18:00', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (11, 'Record updated For Staff id 2', 2, 1, 'Update', '197.156.95.187', 'Linux', 'Chrome 97.0.4692.36', '2021-12-12 18:12:48', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (12, 'New Record inserted On Department id 1', 1, 1, 'Insert', '197.156.95.187', 'Android', 'Opera 65.2.3381.61420', '2021-12-12 20:32:54', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (13, 'Record updated On Notification Setting id 1', 1, 1, 'Update', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:38:10', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (14, 'Record updated On Notification Setting id 2', 2, 1, 'Update', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:38:41', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (15, 'Record updated On Notification Setting id 3', 3, 1, 'Update', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:39:02', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (16, 'Record updated On Notification Setting id 5', 5, 1, 'Update', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:39:31', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (17, 'Record updated On Notification Setting id 9', 9, 1, 'Update', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:40:39', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (18, 'Record updated On Notification Setting id 10', 10, 1, 'Update', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:41:18', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (19, 'Record updated For Staff id 3', 3, 1, 'Update', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:41:41', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (20, 'New Record inserted On Patient id 1', 1, 3, 'Insert', '197.156.95.187', 'Android', 'Firefox 93.0', '2021-12-12 20:49:56', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (21, 'Record updated On Patient id 1', 1, 3, 'Update', '197.156.95.187', 'Android', 'Firefox 93.0', '2021-12-12 20:49:56', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (22, 'New Record inserted On Charge Type Master id 13', 13, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (23, 'New Record inserted On Charge Type Module id 28', 28, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (24, 'New Record inserted On Charge Type Module id 29', 29, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (25, 'New Record inserted On Charge Type Module id 30', 30, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (26, 'New Record inserted On Charge Type Module id 31', 31, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (27, 'New Record inserted On Charge Type Module id 32', 32, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (28, 'New Record inserted On Charge Type Module id 33', 33, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (29, 'New Record inserted On Charge Type Module id 34', 34, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:58:42', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (30, 'New Record inserted On Charge Categories id 1', 1, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 20:59:39', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (31, 'New Record inserted On Tax Category id 1', 1, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 21:00:05', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (32, 'New Record inserted On Charge Units id 1', 1, 1, 'Insert', '197.156.95.187', 'Linux', 'Opera 79.0.4143.66', '2021-12-12 21:00:18', '2021-12-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (33, 'Record updated On Certificates id 12', 12, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:09:39', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (34, 'Record updated On Certificates id 12', 12, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:13:09', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (37, 'Record deleted On Patient id card id 1', 1, 1, 'Delete', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:22:57', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (38, 'New Record inserted On Patient id card id 2', 2, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:24:56', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (39, 'Record updated On Patient id card id 2', 2, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:24:56', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (40, 'Record deleted On staff id card id 1', 1, 1, 'Delete', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:26:07', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (41, 'New Record inserted On Staff id card id 2', 2, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:27:46', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (42, 'Record updated On Staff id card id 2', 2, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:27:46', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (43, 'New Record inserted On Read System Notification id 1', 1, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:34:46', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (44, 'New Record inserted On Symptoms Classification id 1', 1, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:35:46', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (45, 'New Record inserted On Symptoms Classification id 2', 2, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:35:58', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (46, 'New Record inserted On Symptoms id 1', 1, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:36:34', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (47, 'Record updated On Print Setting id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:47:58', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (48, 'Record updated On Print Setting id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:47:58', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (49, 'Record updated On Print Setting id 2', 2, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:16', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (50, 'Record updated On Print Setting id 2', 2, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:16', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (51, 'Record updated On Print Setting id 3', 3, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:30', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (52, 'Record updated On Print Setting id 3', 3, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:30', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (53, 'Record updated On Print Setting id 4', 4, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:43', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (54, 'Record updated On Print Setting id 4', 4, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:43', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (55, 'Record updated On Print Setting id 5', 5, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:55', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (56, 'Record updated On Print Setting id 5', 5, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:48:55', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (57, 'Record updated On Print Setting id 6', 6, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:09', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (58, 'Record updated On Print Setting id 6', 6, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:09', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (59, 'Record updated On Print Setting id 7', 7, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:23', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (60, 'Record updated On Print Setting id 7', 7, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:23', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (61, 'Record updated On Print Setting id 8', 8, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:35', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (62, 'Record updated On Print Setting id 8', 8, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:35', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (63, 'Record updated On Print Setting id 9', 9, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:49', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (64, 'Record updated On Print Setting id 9', 9, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:49:49', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (65, 'Record updated On Print Setting id 10', 10, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:01', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (66, 'Record updated On Print Setting id 10', 10, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:01', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (67, 'Record updated On Print Setting id 11', 11, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:13', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (68, 'Record updated On Print Setting id 11', 11, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:13', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (69, 'Record updated On Print Setting id 12', 12, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:27', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (70, 'Record updated On Print Setting id 12', 12, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:27', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (71, 'Record updated On Print Setting id 13', 13, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:40', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (72, 'Record updated On Print Setting id 13', 13, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:40', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (73, 'Record updated On Print Setting id 14', 14, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:53', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (74, 'Record updated On Print Setting id 14', 14, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:50:53', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (75, 'Record updated On Print Setting id 15', 15, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:51:04', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (76, 'Record updated On Print Setting id 15', 15, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:51:04', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (77, 'Record updated On Print Setting id 16', 16, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:51:14', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (78, 'Record updated On Print Setting id 16', 16, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:51:14', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (79, 'Record updated For Staff id 4', 4, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 19:58:22', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (80, 'Record updated On Charge Categories id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:01:28', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (81, 'Record updated On Charge Units id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:03:05', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (82, 'New Record inserted On Transactions id 1', 1, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:06:33', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (83, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:11:22', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (84, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:12:39', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (85, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:13:33', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (86, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:15:40', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (87, 'New Record inserted On Languages id 78', 78, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:33:58', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (88, 'New Record inserted On Languages id 79', 79, 1, 'Insert', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:34:57', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (89, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:35:34', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (90, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:35:48', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (91, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:36:23', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (92, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:36:34', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (93, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:42:45', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (94, 'Record deleted On Languages id 79', 79, 1, 'Delete', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:45:13', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (95, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.107.92', 'Linux', 'Chrome 97.0.4692.56', '2021-12-17 20:45:13', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (96, 'New Record inserted On Read System Notification id 2', 2, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:24', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (97, 'New Record inserted On Read System Notification id 3', 3, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:29', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (98, 'New Record inserted On Read System Notification id 4', 4, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:30', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (99, 'New Record inserted On Read System Notification id 5', 5, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:32', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (100, 'New Record inserted On Read System Notification id 6', 6, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:32', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (101, 'New Record inserted On Read System Notification id 7', 7, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:34', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (102, 'New Record inserted On Read System Notification id 8', 8, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:34', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (103, 'New Record inserted On Read System Notification id 9', 9, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:35', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (104, 'New Record inserted On Read System Notification id 10', 10, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:49:35', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (105, 'New Record inserted On Read System Notification id 11', 11, 1, 'Insert', '197.156.107.92', 'Android', 'Opera 65.2.3381.61420', '2021-12-17 20:53:24', '2021-12-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (106, 'New Record inserted On Chat Messages id 2', 2, 1, 'Insert', '197.156.107.60', 'Linux', 'Chrome 97.0.4692.56', '2021-12-20 11:33:02', '2021-12-20');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (107, 'New Record inserted On Chat Messages id 3', 3, 1, 'Insert', '197.156.107.60', 'Linux', 'Chrome 97.0.4692.56', '2021-12-24 10:03:49', '2021-12-24');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (108, 'Record updated On Patient id 1', 1, 1, 'Update', '197.156.107.60', 'Linux', 'Chrome 96.0.4664.113', '2021-12-29 16:26:38', '2021-12-29');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (109, 'Record updated On Patient id 1', 1, 1, 'Update', '197.156.107.60', 'Linux', 'Chrome 96.0.4664.113', '2021-12-29 16:27:41', '2021-12-29');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (110, 'Record updated On Patient id 1', 1, 1, 'Update', '197.156.107.60', 'Linux', 'Chrome 96.0.4664.113', '2021-12-29 16:28:08', '2021-12-29');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (111, 'New Record inserted On Read System Notification id 12', 12, 1, 'Insert', '197.156.107.60', 'Windows 10', 'Firefox 96.0', '2021-12-30 15:23:59', '2021-12-30');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (112, 'New Record inserted On Patient id 2', 2, 1, 'Insert', '196.189.57.154', 'Windows 10', 'Firefox 97.0', '2022-01-17 10:57:52', '2022-01-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (113, 'Record updated On Patient id 2', 2, 1, 'Update', '196.189.57.154', 'Windows 10', 'Firefox 97.0', '2022-01-17 10:57:52', '2022-01-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (114, 'Record updated On Patient id 2', 2, 1, 'Update', '196.189.57.154', 'Windows 10', 'Firefox 97.0', '2022-01-17 10:58:45', '2022-01-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (115, 'New Record inserted On Transactions id 2', 2, 1, 'Insert', '196.189.57.154', 'Windows 10', 'Firefox 97.0', '2022-01-17 11:01:38', '2022-01-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (116, 'New Record inserted On Chat Messages id 5', 5, 1, 'Insert', '196.189.57.154', 'Windows 10', 'Firefox 97.0', '2022-01-17 11:09:38', '2022-01-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (117, 'New Record inserted On Read System Notification id 13', 13, 1, 'Insert', '197.156.111.234', 'Linux', 'Firefox 91.0', '2022-04-02 15:50:24', '2022-04-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (118, 'New Record inserted On Read System Notification id 14', 14, 1, 'Insert', '197.156.111.234', 'Linux', 'Firefox 91.0', '2022-04-02 15:50:30', '2022-04-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (119, 'New Record inserted On Chat Messages id 6', 6, 0, 'Insert', '197.156.111.234', 'Linux', 'Firefox 91.0', '2022-04-02 15:57:02', '2022-04-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (120, 'New Record inserted On Chat Messages id 7', 7, 1, 'Insert', '197.156.111.234', 'Linux', 'Firefox 91.0', '2022-04-02 15:57:46', '2022-04-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (121, 'New Record inserted On Chat Messages id 8', 8, 0, 'Insert', '197.156.111.234', 'Linux', 'Firefox 91.0', '2022-04-02 15:58:21', '2022-04-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (122, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.111.234', 'Linux', 'Firefox 91.0', '2022-04-02 16:12:36', '2022-04-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (123, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:31:27', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (124, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:53:28', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (125, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:53:28', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (126, 'New Record inserted On Specialist id 1', 1, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:55:50', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (127, 'New Record inserted On Specialist id 2', 2, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:56:18', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (128, 'New Record inserted On Staff Designation id 1', 1, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:56:36', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (129, 'New Record inserted On Department id 2', 2, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:56:52', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (130, 'New Record inserted On Department id 3', 3, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 14:59:37', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (131, 'Record updated On Specialist id 2', 2, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:00:01', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (132, 'New Record inserted On Staff Designation id 2', 2, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:00:16', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (133, 'Record updated For Staff id 5', 5, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:02:54', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (134, 'Record updated For Staff id 5', 5, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:03:15', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (135, 'Record updated For Staff id 5', 5, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:03:16', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (136, 'Record updated On Notification Setting id 5', 5, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:06:44', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (137, 'Record updated On Zoom Settings id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:25:10', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (138, 'New Record inserted On Global Shift id 1', 1, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:29:14', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (139, 'New Record inserted On Charge Categories id 2', 2, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:31:40', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (140, 'New Record inserted On Charge Units id 2', 2, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:36:21', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (141, 'New Record inserted On Tax Category id 2', 2, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:36:38', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (142, 'New Record inserted On Shift Details id 1', 1, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:40:44', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (143, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:41:36', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (144, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 15:42:36', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (145, 'New Record inserted On Patients id 3', 3, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:01:55', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (146, 'New Record inserted On Read System Notification id 15', 15, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:03:17', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (147, 'New Record inserted On Read System Notification id 16', 16, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:03:25', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (148, 'New Record inserted On Charge Categories id 3', 3, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:15:20', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (149, 'New Record inserted On Read System Notification id 17', 17, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:17:18', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (150, 'New Record inserted On Read System Notification id 18', 18, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:17:32', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (151, 'Record updated On Staff id 5', 5, 5, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:18:19', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (152, 'New Record inserted On Read System Notification id 19', 19, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:29:36', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (153, 'Record updated For Staff id 5', 5, 0, 'Update', '197.156.103.126', 'Linux', 'Chrome 100.0.4896.60', '2022-04-03 13:32:41', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (154, 'Record updated On Staff id 5', 5, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:42:06', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (155, 'New Record inserted On Read System Notification id 20', 20, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:46:56', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (156, 'New Record inserted On Live Meeting id 1', 1, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:48:13', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (157, 'New Record inserted On Read System Notification id 21', 21, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:48:53', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (158, 'New Record inserted On Conferences History id 1', 1, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:50:12', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (159, 'New Record inserted On Live Consultation id 2', 2, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:53:56', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (160, 'Record updated On Staff id 5', 5, 5, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 16:54:54', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (161, 'Record updated On Roles id 3', 3, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:01:29', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (162, 'New Record inserted On Read System Notification id 22', 22, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:02:18', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (163, 'New Record inserted On Read System Notification id 23', 23, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:02:33', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (164, 'Record updated On Conferences id 2', 2, 5, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:02:40', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (165, 'Record updated On Conferences id 2', 2, 5, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:02:53', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (166, 'New Record inserted On Read System Notification id 24', 24, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:24', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (167, 'New Record inserted On Read System Notification id 25', 25, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:26', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (168, 'New Record inserted On Read System Notification id 26', 26, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:39', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (169, 'New Record inserted On Read System Notification id 27', 27, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:40', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (170, 'New Record inserted On Read System Notification id 28', 28, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:41', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (171, 'New Record inserted On Read System Notification id 29', 29, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:42', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (172, 'New Record inserted On Read System Notification id 30', 30, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:43', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (173, 'New Record inserted On Read System Notification id 31', 31, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:44', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (174, 'New Record inserted On Read System Notification id 32', 32, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:45', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (175, 'New Record inserted On Read System Notification id 33', 33, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:46', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (176, 'New Record inserted On Read System Notification id 34', 34, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:51', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (177, 'New Record inserted On Read System Notification id 35', 35, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:52', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (178, 'New Record inserted On Read System Notification id 36', 36, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:54', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (179, 'New Record inserted On Read System Notification id 37', 37, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:56', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (180, 'New Record inserted On Read System Notification id 38', 38, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:57', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (181, 'New Record inserted On Read System Notification id 39', 39, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:03:59', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (182, 'New Record inserted On Chat Messages id 10', 10, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:04:29', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (183, 'New Record inserted On Chat Messages id 11', 11, 5, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:04:53', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (184, 'Record deleted On roles Permissions where Role id  3', 3, 1, 'Delete', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:06:54', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (185, 'New Record inserted On Ambulance id 1', 1, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:24:17', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (186, 'New Record inserted On Transactions id 3', 3, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:26:24', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (187, 'Record updated For Staff id 6', 6, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:29:48', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (188, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:35:53', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (189, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:36:41', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (190, 'New Record inserted On Menu Item id 5', 5, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:40:26', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (191, 'New Record inserted On Menu Item id 6', 6, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:41:47', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (192, 'Record updated For Menu Item id 6', 6, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:42:50', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (193, 'Record updated For Menu Item id 6', 6, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:44:22', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (194, 'Record updated On Front Cms Settings id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:45:06', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (195, 'New Record inserted On Page notice id 1', 1, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 17:58:27', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (196, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:00:19', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (197, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:00:19', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (198, 'New Record inserted On Read System Notification id 40', 40, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:06:27', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (199, 'New Record inserted On Read System Notification id 41', 41, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:06:28', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (200, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:42:09', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (201, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:42:09', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (202, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:54:24', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (203, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 18:54:24', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (204, 'New Record inserted On Read System Notification id 42', 42, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 19:12:16', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (205, 'New Record inserted On Read System Notification id 43', 43, 1, 'Insert', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 19:13:07', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (206, 'Record updated On Patients id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 19:13:23', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (207, 'Record updated On Patients id 1', 1, 1, 'Update', '197.156.103.126', 'Linux', 'Firefox 91.0', '2022-04-03 19:13:44', '2022-04-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (208, 'Record updated On Patients id 1', 1, 0, 'Update', '197.156.103.177', 'Linux', 'Firefox 91.0', '2022-04-05 09:53:41', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (209, 'New Record inserted On Patient Timeline id 1', 1, 1, 'Insert', '197.156.103.177', 'Linux', 'Firefox 91.0', '2022-04-05 10:04:36', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (210, 'Record updated On Patient Timeline id 1', 1, 1, 'Update', '197.156.103.177', 'Linux', 'Firefox 91.0', '2022-04-05 10:04:36', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (211, 'New Record inserted On Birth Report id 1', 1, 1, 'Insert', '197.156.103.177', 'Linux', 'Firefox 91.0', '2022-04-05 10:08:05', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (212, 'Record updated For Birth Report id 1', 1, 1, 'Update', '197.156.103.177', 'Linux', 'Firefox 91.0', '2022-04-05 10:08:05', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (213, 'New Record inserted On Read System Notification id 44', 44, 1, 'Insert', '197.156.103.177', 'Linux', 'Firefox 91.0', '2022-04-05 10:08:35', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (214, 'Record updated On Patients id 1', 1, 0, 'Update', '196.189.38.70', 'Windows 10', 'Chrome 50.0.2661.102', '2022-04-05 10:33:26', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (215, 'Record updated On Patients id 1', 1, 0, 'Update', '196.189.38.70', 'Windows 10', 'Chrome 50.0.2661.102', '2022-04-05 10:33:33', '2022-04-05');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (216, 'New Record inserted On Patients id 4', 4, 0, 'Insert', '196.189.38.70', 'Linux', 'Chrome 99.0.4844.51', '2022-04-06 11:14:49', '2022-04-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (217, 'New Record inserted On Custom Fields id 1', 1, 1, 'Insert', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:37:48', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (218, 'Record updated On Custom Fields id 1', 1, 1, 'Update', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:38:55', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (219, 'Record updated On Custom Fields id 1', 1, 1, 'Update', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:40:42', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (220, 'Record updated On Custom Fields id 1', 1, 1, 'Update', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:43:07', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (221, 'New Record inserted On Custom Fields id 2', 2, 1, 'Insert', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:44:57', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (222, 'Record updated On Custom Fields id 2', 2, 1, 'Update', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:51:03', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (223, 'Record updated On Visit Details id 1', 1, 1, 'Update', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:57:30', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (224, 'New Record inserted On Custom Field Values id 1', 1, 1, 'Insert', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:57:30', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (225, 'New Record inserted On Custom Field Values id 2', 2, 1, 'Insert', '197.156.103.39', 'Windows 10', 'Firefox 100.0', '2022-04-18 18:57:30', '2022-04-18');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (226, 'Record updated On Patients id 1', 1, 0, 'Update', '197.156.103.13', 'Linux', 'Firefox 91.0', '2022-04-19 17:49:19', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (227, 'Record updated On Patients id 1', 1, 0, 'Update', '197.156.103.13', 'Linux', 'Firefox 91.0', '2022-04-19 17:49:25', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (228, 'Record updated On Patients id 1', 1, 0, 'Update', '197.156.103.13', 'Linux', 'Firefox 91.0', '2022-04-19 18:25:17', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (229, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.103.13', 'Linux', 'Firefox 91.0', '2022-04-19 18:32:15', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (230, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.103.13', 'Linux', 'Firefox 91.0', '2022-04-19 18:32:15', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (231, 'Record updated On Patients id 1', 1, 0, 'Update', '197.156.103.13', 'Android', 'Opera 67.1.3508.63168', '2022-04-19 21:43:30', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (232, 'New Record inserted On Referral Category id 1', 1, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:52:19', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (233, 'New Record inserted On Referral Commission id 1', 1, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:53:00', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (234, 'New Record inserted On Referral Commission id 2', 2, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:53:00', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (235, 'New Record inserted On Referral Commission id 3', 3, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:53:00', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (236, 'New Record inserted On Referral Commission id 4', 4, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:53:00', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (237, 'New Record inserted On Referral Commission id 5', 5, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:53:00', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (238, 'New Record inserted On Referral Commission id 6', 6, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:53:00', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (239, 'New Record inserted On Referral Commission id 7', 7, 1, 'Insert', '197.156.103.13', 'Linux', 'Opera 82.0.4227.58', '2022-04-19 21:53:00', '2022-04-19');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (240, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-04-27 16:02:57', '2022-04-27');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (241, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-04-27 16:02:57', '2022-04-27');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (242, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-04-27 16:04:31', '2022-04-27');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (243, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-04-27 16:04:31', '2022-04-27');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (244, 'Record updated On Settings id 1', 1, 1, 'Update', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-04-27 16:12:46', '2022-04-27');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (245, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-04-27 16:16:17', '2022-04-27');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (246, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-04-27 16:16:17', '2022-04-27');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (247, 'New Record inserted On Sms Config id 1', 1, 1, 'Insert', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-05-02 19:02:31', '2022-05-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (248, 'Record updated On Sms Config type custom', 0, 1, 'Update', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-05-02 19:02:40', '2022-05-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (249, 'Record updated On Sms Config type custom', 0, 1, 'Update', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-05-02 19:03:08', '2022-05-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (250, 'New Record inserted On Sms Config id 2', 2, 1, 'Insert', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-05-02 19:48:04', '2022-05-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (251, 'Record updated On Patient id 1', 1, 1, 'Update', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-05-02 19:53:49', '2022-05-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (252, 'New Record inserted On Appointment Created 7', 7, 1, 'Insert', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-05-02 19:55:08', '2022-05-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (253, 'New Record inserted On Live Consultation id 3', 3, 1, 'Insert', '197.156.86.197', 'Linux', 'Firefox 91.0', '2022-05-02 19:55:09', '2022-05-02');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (254, 'Record updated On Sms Config type custom', 0, 1, 'Update', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:30:40', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (255, 'Record updated On Sms Config type twilio', 0, 1, 'Update', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:45:10', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (256, 'Record updated On Sms Config type custom', 0, 1, 'Update', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:45:19', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (257, 'New Record inserted On Messages Send SMS id 1', 1, 1, 'Insert', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:47:18', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (258, 'Record updated On Sms Config type custom', 0, 1, 'Update', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:49:57', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (259, 'Record updated On Sms Config type twilio', 0, 1, 'Update', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:50:04', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (260, 'Record updated On Sms Config type twilio', 0, 1, 'Update', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:50:29', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (261, 'New Record inserted On Messages Send SMS id 2', 2, 1, 'Insert', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 19:51:10', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (262, 'Record updated On Sms Config type twilio', 0, 1, 'Update', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 20:02:19', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (263, 'New Record inserted On Messages Send SMS id 3', 3, 1, 'Insert', '197.156.86.228', 'Linux', 'Firefox 91.0', '2022-05-03 20:03:14', '2022-05-03');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (264, 'New Record inserted On Custom Fields id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:45:46', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (265, 'New Record inserted On Custom Fields id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:47:19', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (266, 'New Record inserted On Custom Fields id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:50:51', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (267, 'New Record inserted On Custom Fields id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:51:56', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (268, 'New Record inserted On Custom Fields id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:52:30', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (269, 'New Record inserted On Custom Fields id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:52:56', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (270, 'Record updated On Visit Details id 3', 3, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:55:18', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (271, 'Record updated On Custom Field Values id 1', 1, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:55:18', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (272, 'Record updated On Custom Field Values id 2', 2, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:55:18', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (273, 'New Record inserted On Custom Field Values id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:55:18', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (274, 'New Record inserted On Custom Field Values id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:55:18', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (275, 'Record updated On Visit Details id 3', 3, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:56:09', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (276, 'Record updated On Custom Field Values id 1', 1, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:56:09', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (277, 'Record updated On Custom Field Values id 2', 2, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:56:09', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (278, 'Record updated On Custom Field Values id 3', 3, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:56:09', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (279, 'Record updated On Custom Field Values id 4', 4, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:56:09', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (280, 'New Record inserted On Charge Units id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 17:59:55', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (281, 'New Record inserted On Tax Category id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:00:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (282, 'Record updated On Global Shift id 1', 1, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:06:01', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (283, 'New Record inserted On Global Shift id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:07:00', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (284, 'New Record inserted On Global Shift id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:08:20', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (285, 'New Record inserted On Global Shift id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:11:06', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (286, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:17:24', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (287, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:20:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (288, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:20:59', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (289, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:22:40', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (290, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:25:05', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (291, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:25:43', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (292, 'Record updated On Shift Details id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:32:32', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (293, 'New Record inserted On Finding Category id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:34:46', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (294, 'New Record inserted On Finding Category id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:35:02', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (295, 'New Record inserted On Finding Category id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:35:28', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (296, 'New Record inserted On Finding id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:36:37', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (297, 'New Record inserted On Symptoms Classification id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:37:29', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (298, 'New Record inserted On Symptoms id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:38:40', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (299, 'New Record inserted On Symptoms Classification id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:42:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (300, 'New Record inserted On Symptoms Classification id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:43:05', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (301, 'New Record inserted On Symptoms Classification id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:43:18', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (302, 'New Record inserted On Symptoms Classification id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:43:30', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (303, 'New Record inserted On Symptoms Classification id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:44:01', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (304, 'New Record inserted On Symptoms Classification id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:44:17', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (305, 'New Record inserted On Symptoms Classification id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:44:37', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (306, 'New Record inserted On Symptoms id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:45:20', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (307, 'New Record inserted On Symptoms id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:45:46', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (308, 'New Record inserted On Symptoms id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:46:17', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (309, 'New Record inserted On Symptoms id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:46:37', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (310, 'New Record inserted On Symptoms id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:46:57', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (311, 'New Record inserted On Symptoms id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:47:19', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (312, 'New Record inserted On Finding Category id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:48:35', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (313, 'New Record inserted On Finding Category id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:48:43', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (314, 'New Record inserted On Finding Category id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:48:52', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (315, 'New Record inserted On Finding Category id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:49:00', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (316, 'New Record inserted On Finding Category id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:49:07', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (317, 'New Record inserted On Finding Category id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:49:21', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (318, 'New Record inserted On Finding id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:49:50', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (319, 'New Record inserted On Finding id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:50:15', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (320, 'New Record inserted On Finding id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:51:24', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (321, 'New Record inserted On Finding id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:52:07', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (322, 'New Record inserted On Transactions id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:57:03', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (323, 'New Record inserted On Live Consultation id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 18:57:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (324, 'New Record inserted On Contents id 1', 1, 5, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:06:23', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (325, 'Record updated On Contents id 1', 1, 5, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:06:24', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (326, 'Record updated On Patient id 1', 1, 5, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:18:29', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (327, 'New Record inserted For Organisation id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:20:23', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (328, 'New Record inserted For Organisation id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:21:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (329, 'Record updated On Patient id 1', 1, 5, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:22:22', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (330, 'New Record inserted On Transactions id 6', 6, 5, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:25:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (331, 'New Record inserted On Live Consultation id 5', 5, 5, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:25:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (332, 'New Record inserted On Finding id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:28:40', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (333, 'New Record inserted On Unit id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:32:32', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (334, 'New Record inserted On Unit id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:32:51', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (335, 'New Record inserted On Unit id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:33:00', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (336, 'New Record inserted On Unit id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:33:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (337, 'New Record inserted On Unit id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:33:19', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (338, 'New Record inserted On Unit id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:33:28', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (339, 'New Record inserted On Unit id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:33:38', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (340, 'New Record inserted On Pathology Category id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:34:19', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (341, 'New Record inserted On Pathology Category id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:34:28', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (342, 'New Record inserted On Pathology Category id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:34:37', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (343, 'New Record inserted On Pathology Category id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:34:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (344, 'New Record inserted On Pathology Category id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:34:53', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (345, 'New Record inserted On Pathology Category id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:35:02', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (346, 'New Record inserted On Pathology Parameter id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:35:52', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (347, 'New Record inserted On Pathology Parameter id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:36:51', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (348, 'New Record inserted On Pathology Parameter id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:37:31', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (349, 'New Record inserted On Pathology Parameter id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:38:00', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (350, 'New Record inserted On Unit id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:40:12', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (351, 'New Record inserted On Unit id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:40:21', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (352, 'New Record inserted On Unit id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:40:33', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (353, 'New Record inserted On Unit id 11', 11, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:40:43', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (354, 'New Record inserted On Unit id 12', 12, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:40:50', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (355, 'New Record inserted On Unit id 13', 13, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:41:19', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (356, 'New Record inserted On Unit id 14', 14, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:41:33', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (357, 'New Record inserted On Lab id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:42:02', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (358, 'New Record inserted On Lab id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:42:11', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (359, 'New Record inserted On Lab id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:42:22', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (360, 'New Record inserted On Lab id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:42:54', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (361, 'New Record inserted On Lab id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:43:02', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (362, 'New Record inserted On Lab id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:43:27', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (363, 'New Record inserted On Lab id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:43:41', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (364, 'New Record inserted On Lab id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:44:03', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (365, 'New Record inserted On Lab id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:44:21', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (366, 'New Record inserted On Lab id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:44:30', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (367, 'New Record inserted On Radiology Parameter id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:45:09', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (368, 'New Record inserted On Radiology Parameter id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:45:39', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (369, 'New Record inserted On Radiology Parameter id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:46:43', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (370, 'New Record inserted On Medicine Category id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:50:05', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (371, 'New Record inserted On Medicine Category id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:50:27', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (372, 'New Record inserted On Medicine Category id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:50:37', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (373, 'New Record inserted On Medicine Category id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:50:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (374, 'New Record inserted On Medicine Category id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:50:53', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (375, 'New Record inserted On Medicine Category id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:51:01', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (376, 'New Record inserted On Medicine Category id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:51:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (377, 'New Record inserted On Medicine Category id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:51:41', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (378, 'New Record inserted On Medicine Category id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:51:51', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (379, 'New Record inserted On Medicine Category id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:52:00', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (380, 'New Record inserted On Medicine Category id 11', 11, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:52:09', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (381, 'New Record inserted On Medicine Category id 12', 12, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:52:20', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (382, 'New Record inserted On Medicine Category id 13', 13, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:52:28', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (383, 'New Record inserted On Charge Units id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:54:44', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (384, 'New Record inserted On Charge Units id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:54:59', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (385, 'Record updated On Charge Units id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:55:24', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (386, 'Record updated On Charge Units id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:55:30', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (387, 'Record updated On Charge Units id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:55:36', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (388, 'Record updated On Charge Units id 5', 5, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:56:05', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (389, 'New Record inserted On Charge Units id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:56:39', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (390, 'New Record inserted On Charge Units id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:56:52', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (391, 'New Record inserted On Charge Units id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:57:07', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (392, 'New Record inserted On Charge Units id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:57:14', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (393, 'New Record inserted On Charge Units id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:57:33', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (394, 'New Record inserted On Medicine Dosage id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:59:06', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (395, 'New Record inserted On Medicine Dosage id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:59:06', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (396, 'New Record inserted On Medicine Dosage id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:59:06', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (397, 'New Record inserted On Medicine Dosage id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:59:06', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (398, 'New Record inserted On Medicine Dosage id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 19:59:06', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (399, 'New Record inserted On Medicine Dosage id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (400, 'New Record inserted On Medicine Dosage id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (401, 'New Record inserted On Medicine Dosage id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (402, 'New Record inserted On Medicine Dosage id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (403, 'New Record inserted On Medicine Dosage id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (404, 'New Record inserted On Medicine Dosage id 11', 11, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (405, 'New Record inserted On Medicine Dosage id 12', 12, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (406, 'New Record inserted On Medicine Dosage id 13', 13, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (407, 'New Record inserted On Medicine Dosage id 14', 14, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (408, 'New Record inserted On Medicine Dosage id 15', 15, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (409, 'New Record inserted On Medicine Dosage id 16', 16, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (410, 'New Record inserted On Medicine Dosage id 17', 17, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (411, 'New Record inserted On Medicine Dosage id 18', 18, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:08', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (412, 'New Record inserted On Medicine Dosage id 19', 19, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:50', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (413, 'New Record inserted On Medicine Dosage id 20', 20, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:01:50', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (414, 'New Record inserted On Medicine Dosage id 21', 21, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:02:42', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (415, 'New Record inserted On Medicine Dosage id 22', 22, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:02:42', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (416, 'New Record inserted On Medicine Dosage id 23', 23, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:02:42', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (417, 'New Record inserted On Medicine Dosage id 24', 24, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:03:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (418, 'New Record inserted On Medicine Dosage id 25', 25, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:03:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (419, 'New Record inserted On Medicine Dosage id 26', 26, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:03:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (420, 'New Record inserted On Medicine Dosage id 27', 27, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:03:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (421, 'New Record inserted On Medicine Dosage id 28', 28, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:03:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (422, 'New Record inserted On Medicine Dosage id 29', 29, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (423, 'New Record inserted On Medicine Dosage id 30', 30, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (424, 'New Record inserted On Medicine Dosage id 31', 31, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (425, 'New Record inserted On Medicine Dosage id 32', 32, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (426, 'New Record inserted On Medicine Dosage id 33', 33, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (427, 'New Record inserted On Medicine Dosage id 34', 34, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (428, 'New Record inserted On Medicine Dosage id 35', 35, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:04', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (429, 'New Record inserted On Dose Interval id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:05:34', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (430, 'New Record inserted On Dose Interval id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:06:56', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (431, 'New Record inserted On Dose Interval id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:07:13', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (432, 'New Record inserted On Dose Interval id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:07:21', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (433, 'New Record inserted On Dose Interval id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:07:40', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (434, 'New Record inserted On Dose Interval id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:08:13', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (435, 'New Record inserted On Dose Interval id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:08:25', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (436, 'New Record inserted On Dose Interval id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:08:33', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (437, 'New Record inserted On Dose Interval id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:08:51', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (438, 'New Record inserted On Dose Interval id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:09:35', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (439, 'New Record inserted On Dose Interval id 11', 11, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:09:57', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (440, 'New Record inserted On Dose Interval id 12', 12, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:10:13', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (441, 'New Record inserted On Dose Duration id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:10:45', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (442, 'New Record inserted On Dose Duration id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:10:55', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (443, 'New Record inserted On Dose Duration id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:11:05', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (444, 'New Record inserted On Dose Duration id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:11:37', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (445, 'New Record inserted On Dose Duration id 5', 5, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:11:47', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (446, 'New Record inserted On Dose Duration id 6', 6, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:12:00', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (447, 'New Record inserted On Dose Duration id 7', 7, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:12:07', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (448, 'New Record inserted On Dose Duration id 8', 8, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:12:44', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (449, 'New Record inserted On Dose Duration id 9', 9, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:12:53', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (450, 'New Record inserted On Dose Duration id 10', 10, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:13:40', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (451, 'New Record inserted On Medicine Supplier id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:21:39', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (452, 'New Record inserted On Item supplier id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:22:57', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (453, 'New Record inserted On Item Category id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:24:10', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (454, 'New Record inserted On Item Category id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:24:25', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (455, 'New Record inserted On Item Category id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:25:03', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (456, 'New Record inserted On Item Category id 4', 4, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:25:26', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (457, 'New Record inserted On Item Store id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:27:19', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (458, 'New Record inserted On Item id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:28:50', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (459, 'New Record inserted On Item Stock id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:30:01', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (460, 'Record updated For Item Stock id 1', 1, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:30:13', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (461, 'New Record inserted On Pharmacy id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:32:28', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (462, 'New Record inserted On Supplier Bill Basic id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:34:27', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (463, 'New Record inserted On Pharmacy id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:39:26', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (464, 'New Record inserted On Supplier Bill Basic id 2', 2, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:41:15', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (465, 'New Record inserted On Medicine Bad Stock id 1', 1, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:42:03', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (466, 'Record updated On Medicine Batch Details id 1', 1, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:42:03', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (467, 'New Record inserted On Supplier Bill Basic id 3', 3, 1, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:43:27', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (468, 'Record updated For Staff id 7', 7, 1, 'Update', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:48:50', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (469, 'New Record inserted On Ipd Prescription Basic id 1', 1, 5, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:51:24', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (470, 'New Record inserted On Read System Notification id 45', 45, 5, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:51:49', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (471, 'New Record inserted On Read System Notification id 46', 46, 5, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:51:52', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (472, 'New Record inserted On Read System Notification id 47', 47, 7, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:54:00', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (473, 'New Record inserted On Pharmacy Bill Basic id 1', 1, 7, 'Insert', '197.156.86.37', 'Linux', 'Firefox 91.0', '2022-05-06 20:54:52', '2022-05-06');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (474, 'New Record inserted On Transactions id 8', 8, 3, 'Insert', '197.156.86.37', 'Windows 10', 'Firefox 101.0', '2022-05-07 14:37:25', '2022-05-07');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (475, 'New Record inserted On Live Consultation id 6', 6, 3, 'Insert', '197.156.86.37', 'Windows 10', 'Firefox 101.0', '2022-05-07 14:37:26', '2022-05-07');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (476, 'New Record inserted On Ipd Prescription Basic id 2', 2, 1, 'Insert', '197.156.86.37', 'Windows 10', 'Firefox 101.0', '2022-05-07 14:48:03', '2022-05-07');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (477, 'New Record inserted On Custom Fields id 9', 9, 1, 'Insert', '196.189.38.70', 'Linux', 'Firefox 91.0', '2022-05-10 11:51:14', '2022-05-10');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (478, 'Record updated On Patients id 1', 1, 1, 'Update', '197.156.77.141', 'Windows 10', 'Firefox 101.0', '2022-05-12 17:02:52', '2022-05-12');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (479, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '196.191.61.239', 'Windows 10', 'Firefox 101.0', '2022-05-17 18:09:16', '2022-05-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (480, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '196.191.61.239', 'Windows 10', 'Firefox 101.0', '2022-05-17 18:09:16', '2022-05-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (481, 'Record deleted On Front Cms Page Contents id 1', 1, 1, 'Delete', '196.191.61.239', 'Windows 10', 'Firefox 101.0', '2022-05-17 18:14:54', '2022-05-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (482, 'Record updated On Front Cms Pages id 1', 1, 1, 'Update', '196.191.61.239', 'Windows 10', 'Firefox 101.0', '2022-05-17 18:14:54', '2022-05-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (483, 'New Record inserted On Menu Item id 7', 7, 1, 'Insert', '196.191.61.239', 'Linux', 'Opera 86.0.4363.50', '2022-05-17 20:07:33', '2022-05-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (484, 'New Record inserted On Menu Item id 8', 8, 1, 'Insert', '196.191.61.239', 'Linux', 'Opera 86.0.4363.50', '2022-05-17 20:10:44', '2022-05-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (485, 'Record deleted On Front Cms Menu Items id 7', 7, 1, 'Delete', '196.191.61.239', 'Linux', 'Opera 86.0.4363.50', '2022-05-17 20:11:20', '2022-05-17');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (486, 'New Record inserted On Symptoms id 9', 9, 1, 'Insert', '196.189.38.70', 'Linux', 'Firefox 91.0', '2022-06-13 10:39:39', '2022-06-13');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (487, 'New Record inserted On Transactions id 9', 9, 1, 'Insert', '196.189.38.70', 'Linux', 'Firefox 91.0', '2022-06-13 10:43:29', '2022-06-13');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (488, 'New Record inserted On Live Consultation id 7', 7, 1, 'Insert', '196.189.38.70', 'Linux', 'Firefox 91.0', '2022-06-13 10:43:30', '2022-06-13');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (489, 'New Record inserted On Transactions id 10', 10, 1, 'Insert', '197.156.103.212', 'Linux', 'Firefox 91.0', '2022-06-23 11:43:46', '2022-06-23');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (490, 'New Record inserted On Live Consultation id 8', 8, 1, 'Insert', '197.156.103.212', 'Linux', 'Firefox 91.0', '2022-06-23 11:43:46', '2022-06-23');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (491, 'New Record inserted On Pharmacy Bill Basic id 2', 2, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-08 12:46:17', '2022-07-08');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (492, 'Record updated On Sms Config type custom', 0, 1, 'Update', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 16:16:33', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (493, 'Record updated On Patients id 1', 1, 1, 'Update', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 16:25:18', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (494, 'New Record inserted On Transactions id 12', 12, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 16:40:06', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (495, 'New Record inserted On Live Consultation id 9', 9, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 16:40:07', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (496, 'New Record inserted On Read System Notification id 48', 48, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 16:44:06', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (497, 'New Record inserted On Read System Notification id 49', 49, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 16:44:28', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (498, 'New Record inserted On Radio id 1', 1, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 17:17:40', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (499, 'New Record inserted On Radiology Billing id 1', 1, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 17:18:53', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (500, 'New Record inserted On Transactions id 13', 13, 1, 'Insert', '197.156.86.219', 'Windows 10', 'Firefox 103.0', '2022-07-09 17:18:53', '2022-07-09');
INSERT INTO `logs` (`id`, `message`, `record_id`, `user_id`, `action`, `ip_address`, `platform`, `agent`, `time`, `created_at`) VALUES (501, 'Record updated On Settings id 1', 1, 1, 'Update', '196.191.52.222', 'Windows 10', 'Firefox 103.0', '2022-07-23 14:18:51', '2022-07-23');


#
# TABLE STRUCTURE FOR: medication_report
#

DROP TABLE IF EXISTS `medication_report`;

CREATE TABLE `medication_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_dosage_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `opd_details_id` int(11) DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `remark` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `generated_by` (`generated_by`),
  KEY `pharmacy_id` (`pharmacy_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `medicine_dosage_id` (`medicine_dosage_id`),
  CONSTRAINT `medication_report_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_report_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_report_ibfk_3` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_report_ibfk_4` FOREIGN KEY (`medicine_dosage_id`) REFERENCES `medicine_dosage` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: medicine_bad_stock
#

DROP TABLE IF EXISTS `medicine_bad_stock`;

CREATE TABLE `medicine_bad_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_batch_details_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(11) DEFAULT NULL,
  `outward_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `batch_no` varchar(100) NOT NULL,
  `quantity` varchar(20) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  CONSTRAINT `medicine_bad_stock_ibfk_1` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `medicine_bad_stock` (`id`, `medicine_batch_details_id`, `pharmacy_id`, `outward_date`, `expiry_date`, `batch_no`, `quantity`, `note`, `created_at`) VALUES (1, 1, 1, '2022-05-06', '2024-02-29', '001', '143', '', '2022-05-06 17:42:03');


#
# TABLE STRUCTURE FOR: medicine_batch_details
#

DROP TABLE IF EXISTS `medicine_batch_details`;

CREATE TABLE `medicine_batch_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_bill_basic_id` int(11) DEFAULT NULL,
  `pharmacy_id` int(100) DEFAULT NULL,
  `inward_date` datetime NOT NULL,
  `expiry` date NOT NULL,
  `batch_no` varchar(100) NOT NULL,
  `packing_qty` varchar(100) NOT NULL,
  `purchase_rate_packing` varchar(100) NOT NULL,
  `quantity` varchar(200) NOT NULL,
  `mrp` float(10,2) DEFAULT 0.00,
  `purchase_price` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `sale_rate` float(10,2) DEFAULT 0.00,
  `batch_amount` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT 0.00,
  `available_quantity` int(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `supplier_bill_basic_id` (`supplier_bill_basic_id`),
  KEY `pharmacy_id` (`pharmacy_id`),
  CONSTRAINT `medicine_batch_details_ibfk_1` FOREIGN KEY (`supplier_bill_basic_id`) REFERENCES `supplier_bill_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medicine_batch_details_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `medicine_batch_details` (`id`, `supplier_bill_basic_id`, `pharmacy_id`, `inward_date`, `expiry`, `batch_no`, `packing_qty`, `purchase_rate_packing`, `quantity`, `mrp`, `purchase_price`, `tax`, `sale_rate`, `batch_amount`, `amount`, `available_quantity`, `created_at`) VALUES (1, 1, 1, '2022-05-06 20:33:00', '2024-02-29', '001', '10', '', '3', '300.00', '25000.00', '15.00', '2500.00', '1500.00', '75000.00', -140, '2022-05-06 17:34:27');
INSERT INTO `medicine_batch_details` (`id`, `supplier_bill_basic_id`, `pharmacy_id`, `inward_date`, `expiry`, `batch_no`, `packing_qty`, `purchase_rate_packing`, `quantity`, `mrp`, `purchase_price`, `tax`, `sale_rate`, `batch_amount`, `amount`, `available_quantity`, `created_at`) VALUES (2, 2, 2, '2022-05-06 20:39:00', '2024-07-31', '0002', '60', '', '200', '15.00', '1500.00', '15.00', '75.00', '60.00', '300000.00', 200, '2022-05-06 17:41:15');
INSERT INTO `medicine_batch_details` (`id`, `supplier_bill_basic_id`, `pharmacy_id`, `inward_date`, `expiry`, `batch_no`, `packing_qty`, `purchase_rate_packing`, `quantity`, `mrp`, `purchase_price`, `tax`, `sale_rate`, `batch_amount`, `amount`, `available_quantity`, `created_at`) VALUES (3, 3, 1, '2022-05-06 20:42:00', '2024-08-31', '0001', '30', '', '60', '25.00', '200.00', '15.00', '300.00', '250.00', '12000.00', 60, '2022-05-06 17:43:27');


#
# TABLE STRUCTURE FOR: medicine_category
#

DROP TABLE IF EXISTS `medicine_category`;

CREATE TABLE `medicine_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_category` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (1, 'Syrup', '2022-05-06 16:50:05');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (2, 'Capsule', '2022-05-06 16:50:27');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (3, 'Injection', '2022-05-06 16:50:37');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (4, 'Ointment', '2022-05-06 16:50:45');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (5, 'Cream', '2022-05-06 16:50:53');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (6, 'Surgical', '2022-05-06 16:51:01');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (7, 'Drops', '2022-05-06 16:51:08');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (8, 'Inhalers', '2022-05-06 16:51:41');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (9, 'Implants / Patches', '2022-05-06 16:51:51');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (10, 'Liquid', '2022-05-06 16:52:00');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (11, 'Preparations', '2022-05-06 16:52:09');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (12, 'Diaper', '2022-05-06 16:52:20');
INSERT INTO `medicine_category` (`id`, `medicine_category`, `created_at`) VALUES (13, 'Tablet', '2022-05-06 16:52:28');


#
# TABLE STRUCTURE FOR: medicine_dosage
#

DROP TABLE IF EXISTS `medicine_dosage`;

CREATE TABLE `medicine_dosage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_category_id` int(11) DEFAULT NULL,
  `dosage` varchar(100) NOT NULL,
  `charge_units_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `medicine_category_id` (`medicine_category_id`),
  KEY `charge_units_id` (`charge_units_id`),
  CONSTRAINT `medicine_dosage_ibfk_1` FOREIGN KEY (`medicine_category_id`) REFERENCES `medicine_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medicine_dosage_ibfk_2` FOREIGN KEY (`charge_units_id`) REFERENCES `charge_units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (1, 1, '1', 9, '2022-05-06 16:59:06');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (2, 1, '2', 9, '2022-05-06 16:59:06');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (3, 1, '3', 9, '2022-05-06 16:59:06');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (4, 1, '4', 9, '2022-05-06 16:59:06');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (5, 1, '5', 9, '2022-05-06 16:59:06');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (6, 2, '2', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (7, 2, '3', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (8, 2, '4', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (9, 2, '5', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (10, 2, '10', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (11, 2, '25', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (12, 2, '40', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (13, 2, '100', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (14, 2, '200', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (15, 2, '300', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (16, 2, '400', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (17, 2, '500', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (18, 2, '1000', 4, '2022-05-06 17:01:08');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (19, 1, '10', 9, '2022-05-06 17:01:50');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (20, 1, '20', 9, '2022-05-06 17:01:50');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (21, 7, '1', 6, '2022-05-06 17:02:42');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (22, 7, '2', 6, '2022-05-06 17:02:42');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (23, 7, '3', 6, '2022-05-06 17:02:42');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (24, 13, '1', 6, '2022-05-06 17:03:45');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (25, 13, '2', 6, '2022-05-06 17:03:45');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (26, 13, '3', 6, '2022-05-06 17:03:45');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (27, 13, '1/2', 6, '2022-05-06 17:03:45');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (28, 13, '1', 5, '2022-05-06 17:03:45');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (29, 3, '0.5', 9, '2022-05-06 17:05:04');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (30, 3, '1', 9, '2022-05-06 17:05:04');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (31, 3, '2', 9, '2022-05-06 17:05:04');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (32, 3, '5', 9, '2022-05-06 17:05:04');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (33, 3, '10', 9, '2022-05-06 17:05:04');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (34, 3, '1', 6, '2022-05-06 17:05:04');
INSERT INTO `medicine_dosage` (`id`, `medicine_category_id`, `dosage`, `charge_units_id`, `created_at`) VALUES (35, 3, '2', 6, '2022-05-06 17:05:04');


#
# TABLE STRUCTURE FOR: medicine_supplier
#

DROP TABLE IF EXISTS `medicine_supplier`;

CREATE TABLE `medicine_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier` varchar(200) NOT NULL,
  `contact` varchar(200) NOT NULL,
  `supplier_person` varchar(200) NOT NULL,
  `supplier_person_contact` varchar(200) NOT NULL,
  `supplier_drug_licence` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `medicine_supplier` (`id`, `supplier`, `contact`, `supplier_person`, `supplier_person_contact`, `supplier_drug_licence`, `address`, `created_at`) VALUES (1, 'MERQ Supplier Name', '+25123456789', 'MERQ Supplier Contact Name', '+251321654987', '012303210', 'AA, Ethiopia', '2022-05-06 17:21:39');


#
# TABLE STRUCTURE FOR: messages
#

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `template_id` varchar(100) NOT NULL,
  `message` text DEFAULT NULL,
  `send_mail` varchar(10) DEFAULT '0',
  `send_sms` varchar(10) DEFAULT '0',
  `is_group` varchar(10) DEFAULT '0',
  `is_individual` varchar(10) DEFAULT '0',
  `file` varchar(200) NOT NULL,
  `group_list` text DEFAULT NULL,
  `user_list` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `messages` (`id`, `title`, `template_id`, `message`, `send_mail`, `send_sms`, `is_group`, `is_individual`, `file`, `group_list`, `user_list`, `created_at`) VALUES (1, 'Greetings', '', 'Hi Abebech', '0', '1', '0', '1', '', NULL, '[{\"category\":\"patient\",\"user_id\":\"1\",\"email\":\"michaelktd7@gmail.com\",\"mobileno\":\"+251913391985\",\"app_key\":\"\"}]', '2022-05-03 16:47:18');
INSERT INTO `messages` (`id`, `title`, `template_id`, `message`, `send_mail`, `send_sms`, `is_group`, `is_individual`, `file`, `group_list`, `user_list`, `created_at`) VALUES (2, 'Greetings', '', 'Hi Abebech,\r\n\r\nDid you get the sms?', '0', '1', '0', '1', '', NULL, '[{\"category\":\"patient\",\"user_id\":\"1\",\"email\":\"michaelktd7@gmail.com\",\"mobileno\":\"+251913391985\",\"app_key\":\"\"}]', '2022-05-03 16:51:10');
INSERT INTO `messages` (`id`, `title`, `template_id`, `message`, `send_mail`, `send_sms`, `is_group`, `is_individual`, `file`, `group_list`, `user_list`, `created_at`) VALUES (3, 'Test SMS', '', 'Dear User\r\n\r\nThis is a test sms\r\n', '0', '1', '1', '0', '', '[]', NULL, '2022-05-03 17:03:14');


#
# TABLE STRUCTURE FOR: migrations
#

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: notification_roles
#

DROP TABLE IF EXISTS `notification_roles`;

CREATE TABLE `notification_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_notification_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `send_notification_id` (`send_notification_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `notification_roles_ibfk_1` FOREIGN KEY (`send_notification_id`) REFERENCES `send_notification` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notification_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (1, 1, 1, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (2, 1, 2, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (3, 1, 3, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (4, 1, 4, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (5, 1, 5, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (6, 1, 6, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (7, 1, 7, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (8, 1, 8, 0, '2022-04-03 15:02:24');
INSERT INTO `notification_roles` (`id`, `send_notification_id`, `role_id`, `is_active`, `created_at`) VALUES (9, 1, 9, 0, '2022-04-03 15:02:24');


#
# TABLE STRUCTURE FOR: notification_setting
#

DROP TABLE IF EXISTS `notification_setting`;

CREATE TABLE `notification_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `is_mail` int(11) DEFAULT 0,
  `is_sms` int(11) DEFAULT 0,
  `is_mobileapp` int(11) NOT NULL,
  `is_notification` int(11) NOT NULL,
  `display_notification` int(11) NOT NULL,
  `display_sms` int(11) NOT NULL,
  `template` longtext DEFAULT NULL,
  `template_id` varchar(100) NOT NULL,
  `subject` text DEFAULT NULL,
  `variables` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (1, 'opd_patient_registration', 1, 1, 1, 1, 1, 1, 'Dear {{patient_name}} your OPD Registration at MERQ-EMR System is successful on date {{appointment_date}} with Patient Id {{patient_id}} and OPD No {{opdno}}', '', 'OPD Patient', '{{patient_name}} {{appointment_date}} {{patient_id}} {{opdno}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (2, 'ipd_patient_registration', 1, 1, 0, 0, 1, 1, 'Dear {{patient_name}} your IPD Registration at MERQ-EMR System is successful  with Patient Id {{patient_id}} and IPD No {{ipd_no}}', '', 'IPD Patient Registration', '{{patient_name}} {{patient_id}} {{ipd_no}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (3, 'ipd_patient_discharged', 1, 1, 0, 0, 1, 1, 'IPD Patient {{patient_name}} is now discharged from MERQ-EMR System\r\nTotal bill amount is {{currency_symbol}}{{total_amount}}\r\nTotal paid amount is {{currency_symbol}}{{paid_amount}}\r\nTotal balance bill amount is {{currency_symbol}}{{balance_amount}}', '', 'IPD Patient Discharge', '{{patient_name}} {{currency_symbol}} {{total_amount}} {{paid_amount}} {balance_amount}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (5, 'login_credential', 1, 1, 0, 0, 0, 1, 'Hello {{display_name}} your MERQ-EMR System login details are Url: {{url}} Username: {{username}} Password: {{password}}', '', 'MERQ EMR Login Credential', '{{display_name}} {{url}} {{username}} {{password}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (6, 'appointment_approved', 1, 1, 0, 0, 1, 1, 'Dear {{patient_name}} your appointment with {{staff_name}} {{staff_surname}} is confirmed on {{date}} with appointment no: {{appointment_no}}', '', 'Appointment Approved', '{{patient_name}} {{staff_name}}\n{{staff_surname}}  {{date}} {{appointment_no}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (7, 'live_meeting', 1, 1, 0, 0, 0, 1, 'Dear staff, your live meeting {{title}} has been scheduled on {{date}} for the duration of {{duration}} minute.', '', 'Live Meeting', '{{title}} {{date}} {{duration}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (8, 'live_consult', 1, 1, 0, 0, 1, 1, 'Dear patient, your live consultation {{title}} has been scheduled on {{date}} for the duration of {{duration}} minute.', '', 'Live Consultation', '{{title}} {{date}} {{duration}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (9, 'opd_patient_discharged', 1, 1, 0, 0, 1, 1, 'OPD No {{opd_no}}  {{patient_name}} is now discharged from MERQ-EMR System.\r\n\r\nTotal bill amount was {{currency_symbol}}  {{total_amount}} \r\nTotal paid amount was {{currency_symbol}}{{paid_amount}}  \r\nTotal balance amount is {{currency_symbol}}{{balance_amount}}', '', 'OPD Patient Discharged', '{{patient_name}} {{mobileno}} {{email}} {{dob}} {{gender}} {{patient_unique_id}} {{opd_no}}{{currency_symbol}} {{billing_amount}}', '2022-05-02 16:52:05');
INSERT INTO `notification_setting` (`id`, `type`, `is_mail`, `is_sms`, `is_mobileapp`, `is_notification`, `display_notification`, `display_sms`, `template`, `template_id`, `subject`, `variables`, `created_at`) VALUES (10, 'forgot_password', 1, 0, 0, 0, 0, 0, 'Dear  {{display_name}}, recently a request was submitted to reset password for your account with email: {{email}}. If you didn\'t make the request, just ignore this email, otherwise you can reset your password using this link <a href=\'{{resetpasslink}}\'>click here to reset your password</a>, if you\'re having trouble clicking the password reset link, copy and paste below URL  into your web browser. {{resetpasslink}} <br> Regards,  <br>\r\nMERQ-EMR System', '', 'Reset Password Request', '{{display_name}}  {{email}}  {{resetpasslink}', '2021-12-12 17:41:18');


#
# TABLE STRUCTURE FOR: nurse_note
#

DROP TABLE IF EXISTS `nurse_note`;

CREATE TABLE `nurse_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `nurse_note_ibfk_1` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nurse_note_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: nurse_notes_comment
#

DROP TABLE IF EXISTS `nurse_notes_comment`;

CREATE TABLE `nurse_notes_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nurse_note_id` int(11) DEFAULT NULL,
  `comment_staffid` int(11) DEFAULT NULL,
  `comment_staff` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nurse_note_id` (`nurse_note_id`),
  KEY `comment_staffid` (`comment_staffid`),
  CONSTRAINT `nurse_notes_comment_ibfk_1` FOREIGN KEY (`nurse_note_id`) REFERENCES `nurse_note` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nurse_notes_comment_ibfk_2` FOREIGN KEY (`comment_staffid`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: opd_details
#

DROP TABLE IF EXISTS `opd_details`;

CREATE TABLE `opd_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `is_ipd_moved` int(11) NOT NULL DEFAULT 0,
  `discharged` varchar(10) NOT NULL DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `generated_by` (`generated_by`),
  CONSTRAINT `opd_details_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `opd_details_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `opd_details_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (1, 1, 1, 1, 0, 'no', '2021-12-17 17:06:33');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (2, 2, 2, 1, 0, 'no', '2022-01-17 08:01:38');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (3, 3, 1, 1, 0, 'no', '2022-05-02 16:55:08');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (4, 4, 1, 1, 0, 'no', '2022-05-06 15:57:03');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (5, 5, 1, 5, 0, 'no', '2022-05-06 16:25:45');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (6, 6, 1, 3, 0, 'no', '2022-05-07 11:37:25');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (7, 7, 2, 1, 0, 'no', '2022-06-13 07:43:29');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (8, 8, 1, 1, 0, 'no', '2022-06-23 08:43:46');
INSERT INTO `opd_details` (`id`, `case_reference_id`, `patient_id`, `generated_by`, `is_ipd_moved`, `discharged`, `created_at`) VALUES (9, 9, 1, 1, 0, 'no', '2022-07-09 13:40:06');


#
# TABLE STRUCTURE FOR: operation
#

DROP TABLE IF EXISTS `operation`;

CREATE TABLE `operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation` varchar(250) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `operation_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `operation_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: operation_category
#

DROP TABLE IF EXISTS `operation_category`;

CREATE TABLE `operation_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(250) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: operation_theatre
#

DROP TABLE IF EXISTS `operation_theatre`;

CREATE TABLE `operation_theatre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `opd_details_id` int(11) DEFAULT NULL,
  `ipd_details_id` int(11) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `operation_id` int(100) NOT NULL,
  `date` datetime DEFAULT NULL,
  `operation_type` varchar(100) DEFAULT NULL,
  `consultant_doctor` int(11) DEFAULT NULL,
  `ass_consultant_1` varchar(50) DEFAULT NULL,
  `ass_consultant_2` varchar(50) DEFAULT NULL,
  `anesthetist` varchar(50) DEFAULT NULL,
  `anaethesia_type` varchar(50) DEFAULT NULL,
  `ot_technician` varchar(100) DEFAULT NULL,
  `ot_assistant` varchar(100) DEFAULT NULL,
  `result` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `opd_details_id` (`opd_details_id`),
  KEY `ipd_details_id` (`ipd_details_id`),
  KEY `consultant_doctor` (`consultant_doctor`),
  KEY `generated_by` (`generated_by`),
  KEY `operation_id` (`operation_id`),
  CONSTRAINT `operation_theatre_ibfk_1` FOREIGN KEY (`opd_details_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_2` FOREIGN KEY (`ipd_details_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_3` FOREIGN KEY (`consultant_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `operation_theatre_ibfk_5` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: organisation
#

DROP TABLE IF EXISTS `organisation`;

CREATE TABLE `organisation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organisation_name` varchar(200) NOT NULL,
  `code` varchar(50) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `address` varchar(300) NOT NULL,
  `contact_person_name` varchar(200) NOT NULL,
  `contact_person_phone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `organisation` (`id`, `organisation_name`, `code`, `contact_no`, `address`, `contact_person_name`, `contact_person_phone`, `created_at`) VALUES (1, 'AWASH Insurance', 'AWAINC', '+123456789', 'AA, ET', 'AWASH Person', '1234567890', '2022-05-06 16:20:23');
INSERT INTO `organisation` (`id`, `organisation_name`, `code`, `contact_no`, `address`, `contact_person_name`, `contact_person_phone`, `created_at`) VALUES (2, 'Birhan Insurance', 'BRHINS', '369874561', 'AA, ET', 'Bierhan Person', '368894616', '2022-05-06 16:21:08');


#
# TABLE STRUCTURE FOR: organisations_charges
#

DROP TABLE IF EXISTS `organisations_charges`;

CREATE TABLE `organisations_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `org_charge` float(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `organisations_charges_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE,
  CONSTRAINT `organisations_charges_ibfk_2` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: pathology
#

DROP TABLE IF EXISTS `pathology`;

CREATE TABLE `pathology` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(100) DEFAULT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  `test_type` varchar(100) DEFAULT NULL,
  `pathology_category_id` int(11) DEFAULT NULL,
  `unit` varchar(50) NOT NULL,
  `sub_category` varchar(50) NOT NULL,
  `report_days` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pathology_category_id` (`pathology_category_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `pathology_ibfk_1` FOREIGN KEY (`pathology_category_id`) REFERENCES `pathology_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_ibfk_2` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: pathology_billing
#

DROP TABLE IF EXISTS `pathology_billing`;

CREATE TABLE `pathology_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `ipd_prescription_basic_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `total` float(10,2) DEFAULT 0.00,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `discount` float(10,2) DEFAULT 0.00,
  `tax_percentage` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `net_amount` float(10,2) DEFAULT 0.00,
  `transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `generated_by` (`generated_by`),
  CONSTRAINT `pathology_billing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_3` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_billing_ibfk_5` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: pathology_category
#

DROP TABLE IF EXISTS `pathology_category`;

CREATE TABLE `pathology_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

INSERT INTO `pathology_category` (`id`, `category_name`, `created_at`) VALUES (1, 'Clinical Microbiology', '2022-05-06 16:34:19');
INSERT INTO `pathology_category` (`id`, `category_name`, `created_at`) VALUES (2, 'Clinical Chemistry', '2022-05-06 16:34:28');
INSERT INTO `pathology_category` (`id`, `category_name`, `created_at`) VALUES (3, 'Hematology', '2022-05-06 16:34:37');
INSERT INTO `pathology_category` (`id`, `category_name`, `created_at`) VALUES (4, 'Molecular Diagnostics', '2022-05-06 16:34:45');
INSERT INTO `pathology_category` (`id`, `category_name`, `created_at`) VALUES (5, 'Reproductive Biology', '2022-05-06 16:34:53');
INSERT INTO `pathology_category` (`id`, `category_name`, `created_at`) VALUES (6, 'Electromagnetic Waves', '2022-05-06 16:35:02');


#
# TABLE STRUCTURE FOR: pathology_parameter
#

DROP TABLE IF EXISTS `pathology_parameter`;

CREATE TABLE `pathology_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(100) NOT NULL,
  `test_value` varchar(100) NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `unit` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `unit` (`unit`),
  CONSTRAINT `pathology_parameter_ibfk_1` FOREIGN KEY (`unit`) REFERENCES `unit` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `pathology_parameter` (`id`, `parameter_name`, `test_value`, `reference_range`, `gender`, `unit`, `description`, `created_at`) VALUES (1, 'RBC', '', '4.1 to 5.1 million/mm3', '', 3, 'RBC Blood Test', '2022-05-06 16:35:52');
INSERT INTO `pathology_parameter` (`id`, `parameter_name`, `test_value`, `reference_range`, `gender`, `unit`, `description`, `created_at`) VALUES (2, 'WBC ', '', '4.1 to 5.1 million/mm3', '', 3, 'WBC Blood Test ', '2022-05-06 16:36:51');
INSERT INTO `pathology_parameter` (`id`, `parameter_name`, `test_value`, `reference_range`, `gender`, `unit`, `description`, `created_at`) VALUES (3, 'Liver Function Test', '', '7 to 55 units per liter ', '', 1, 'Liver function tests (LFTs or LFs), also referred to as a hepatic panel, are groups of blood tests ... ranges are given, these will vary depending on age, gender and his/her health, ethnicity, method of analysis, and units of measurement.', '2022-05-06 16:37:31');
INSERT INTO `pathology_parameter` (`id`, `parameter_name`, `test_value`, `reference_range`, `gender`, `unit`, `description`, `created_at`) VALUES (4, 'TSH (Thyroid Stimulating Hormone)', '', ' 0.5 to 3.0', '', 1, 'A TSH level > 20 milli-International Units/L in association with a low free thyroxine (T4) confirms the diagnosis of hypothyroidism.', '2022-05-06 16:38:00');


#
# TABLE STRUCTURE FOR: pathology_parameterdetails
#

DROP TABLE IF EXISTS `pathology_parameterdetails`;

CREATE TABLE `pathology_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pathology_id` int(11) DEFAULT NULL,
  `pathology_parameter_id` int(11) DEFAULT NULL,
  `created_id` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pathology_id` (`pathology_id`),
  KEY `pathology_parameter_id` (`pathology_parameter_id`),
  CONSTRAINT `pathology_parameterdetails_ibfk_1` FOREIGN KEY (`pathology_id`) REFERENCES `pathology` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_parameterdetails_ibfk_2` FOREIGN KEY (`pathology_parameter_id`) REFERENCES `pathology_parameter` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: pathology_report
#

DROP TABLE IF EXISTS `pathology_report`;

CREATE TABLE `pathology_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pathology_bill_id` int(11) DEFAULT NULL,
  `pathology_id` int(11) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `reporting_date` date DEFAULT NULL,
  `parameter_update` date DEFAULT NULL,
  `tax_percentage` float(10,2) NOT NULL DEFAULT 0.00,
  `apply_charge` float(10,2) NOT NULL,
  `collection_date` date DEFAULT NULL,
  `collection_specialist` int(100) DEFAULT NULL,
  `pathology_center` varchar(250) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `patient_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `pathology_report` varchar(255) DEFAULT NULL,
  `report_name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `pathology_bill_id` (`pathology_bill_id`),
  KEY `pathology_id` (`pathology_id`),
  KEY `collection_specialist` (`collection_specialist`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `pathology_report_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_2` FOREIGN KEY (`pathology_bill_id`) REFERENCES `pathology_billing` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_3` FOREIGN KEY (`pathology_id`) REFERENCES `pathology` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_4` FOREIGN KEY (`collection_specialist`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_ibfk_5` FOREIGN KEY (`approved_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: pathology_report_parameterdetails
#

DROP TABLE IF EXISTS `pathology_report_parameterdetails`;

CREATE TABLE `pathology_report_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pathology_report_id` int(11) DEFAULT NULL,
  `pathology_parameterdetail_id` int(11) DEFAULT NULL,
  `pathology_report_value` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pathology_report_id` (`pathology_report_id`),
  KEY `pathology_parameterdetail_id` (`pathology_parameterdetail_id`),
  CONSTRAINT `pathology_report_parameterdetails_ibfk_1` FOREIGN KEY (`pathology_report_id`) REFERENCES `pathology_report` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pathology_report_parameterdetails_ibfk_2` FOREIGN KEY (`pathology_parameterdetail_id`) REFERENCES `pathology_parameterdetails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: patient_bed_history
#

DROP TABLE IF EXISTS `patient_bed_history`;

CREATE TABLE `patient_bed_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_reference_id` int(11) DEFAULT NULL,
  `bed_group_id` int(11) DEFAULT NULL,
  `bed_id` int(11) DEFAULT NULL,
  `revert_reason` text DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `is_active` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `bed_group_id` (`bed_group_id`),
  KEY `bed_id` (`bed_id`),
  CONSTRAINT `patient_bed_history_ibfk_1` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_bed_history_ibfk_2` FOREIGN KEY (`bed_group_id`) REFERENCES `bed_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_bed_history_ibfk_3` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: patient_charges
#

DROP TABLE IF EXISTS `patient_charges`;

CREATE TABLE `patient_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `opd_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `standard_charge` float(10,2) DEFAULT 0.00,
  `tpa_charge` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `apply_charge` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `opd_id` (`opd_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `patient_charges_ibfk_1` FOREIGN KEY (`opd_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_charges_ibfk_2` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `patient_charges_ibfk_3` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (1, '2021-12-20 09:00:00', NULL, 1, 1, 1, '0.00', '0.00', '0.00', '0.00', '0.00', '', '2021-12-17 00:00:00');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (2, '2022-01-19 11:00:00', NULL, 2, 1, 1, '0.00', '0.00', '0.00', '0.01', '0.01', '', '2022-01-17 00:00:00');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (3, '2022-05-02 19:55:08', NULL, 3, 1, 2, '50.00', '0.00', '15.00', '57.50', '57.50', 'Hanibal Kassahun', '2022-05-02 19:55:08');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (4, '2022-05-02 07:55:00', NULL, 4, 1, 3, '99.99', NULL, '0.00', '99.99', '114.99', '', '2022-05-06 00:00:00');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (5, '2022-05-13 08:15:00', NULL, 5, 1, 3, '99.99', NULL, '0.00', '99.99', '114.99', '', '2022-05-06 00:00:00');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (6, '2022-05-13 08:15:00', NULL, 6, 1, 3, '99.99', NULL, '0.00', '99.99', '114.99', '', '2022-05-07 00:00:00');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (7, '2022-01-19 11:00:00', NULL, 7, 1, 3, '99.99', NULL, '0.00', '10.00', '11.50', '', '2022-06-13 00:00:00');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (8, '2022-05-13 08:15:00', NULL, 8, 1, 3, '99.99', NULL, '0.00', '99.99', '114.99', '', '2022-06-23 00:00:00');
INSERT INTO `patient_charges` (`id`, `date`, `ipd_id`, `opd_id`, `qty`, `charge_id`, `standard_charge`, `tpa_charge`, `tax`, `apply_charge`, `amount`, `note`, `created_at`) VALUES (9, '2022-05-17 08:35:00', NULL, 9, 1, 3, '99.99', NULL, '0.00', '99.99', '114.99', '', '2022-07-09 00:00:00');


#
# TABLE STRUCTURE FOR: patient_id_card
#

DROP TABLE IF EXISTS `patient_id_card`;

CREATE TABLE `patient_id_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `hospital_name` varchar(100) NOT NULL,
  `hospital_address` varchar(500) NOT NULL,
  `background` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `sign_image` varchar(100) NOT NULL,
  `header_color` varchar(100) NOT NULL,
  `enable_patient_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_guardian_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_patient_unique_id` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_address` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_phone` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_dob` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_blood_group` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `status` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `patient_id_card` (`id`, `title`, `hospital_name`, `hospital_address`, `background`, `logo`, `sign_image`, `header_color`, `enable_patient_name`, `enable_guardian_name`, `enable_patient_unique_id`, `enable_address`, `enable_phone`, `enable_dob`, `enable_blood_group`, `status`, `created_at`) VALUES (2, 'Patient ID Card', 'MERQ-EMR', 'Addis Ababa', 'background2.png', 'logo2.png', 'signature2.png', '#071a49', 1, 1, 1, 1, 1, 1, 1, 1, '2021-12-17 16:24:56');


#
# TABLE STRUCTURE FOR: patient_timeline
#

DROP TABLE IF EXISTS `patient_timeline`;

CREATE TABLE `patient_timeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `timeline_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `document` varchar(200) NOT NULL,
  `status` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `generated_users_type` varchar(100) NOT NULL,
  `generated_users_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `generated_users_id` (`generated_users_id`),
  CONSTRAINT `patient_timeline_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `patient_timeline` (`id`, `patient_id`, `title`, `timeline_date`, `description`, `document`, `status`, `date`, `generated_users_type`, `generated_users_id`, `created_at`) VALUES (1, 1, 'covid', '2022-04-05', 'She got covid', '', 'yes', '2022-04-05', 'staff', 1, '2022-04-05 07:04:36');


#
# TABLE STRUCTURE FOR: patients
#

DROP TABLE IF EXISTS `patients`;

CREATE TABLE `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang_id` int(11) DEFAULT NULL,
  `patient_name` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `age` int(10) NOT NULL,
  `month` int(10) NOT NULL,
  `day` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `mobileno` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `marital_status` varchar(100) NOT NULL,
  `blood_group` varchar(200) NOT NULL,
  `blood_bank_product_id` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `guardian_name` varchar(100) DEFAULT NULL,
  `patient_type` varchar(200) NOT NULL,
  `identification_number` varchar(60) NOT NULL,
  `known_allergies` varchar(200) NOT NULL,
  `note` varchar(200) NOT NULL,
  `is_ipd` varchar(200) NOT NULL,
  `app_key` varchar(200) NOT NULL,
  `insurance_id` varchar(250) DEFAULT NULL,
  `insurance_validity` date DEFAULT NULL,
  `is_dead` varchar(255) NOT NULL DEFAULT 'no',
  `is_active` varchar(255) DEFAULT 'no',
  `disable_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `blood_bank_product_id` (`blood_bank_product_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`blood_bank_product_id`) REFERENCES `blood_bank_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `patients` (`id`, `lang_id`, `patient_name`, `dob`, `age`, `month`, `day`, `image`, `mobileno`, `email`, `gender`, `marital_status`, `blood_group`, `blood_bank_product_id`, `address`, `guardian_name`, `patient_type`, `identification_number`, `known_allergies`, `note`, `is_ipd`, `app_key`, `insurance_id`, `insurance_validity`, `is_dead`, `is_active`, `disable_at`, `created_at`) VALUES (1, 3, 'Abebech Haile', '1989-07-09', 32, 9, 27, 'uploads/patient_images/no_image.png', '+251913391985', 'michaelktd7@gmail.com', 'Female', 'Married', '', 6, '', 'Abebe Kebede', '', '01234567890', 'Penicillin', '', '', '', 'AWAINC-0012', '2023-04-07', 'no', 'yes', NULL, '2022-07-09 13:25:18');
INSERT INTO `patients` (`id`, `lang_id`, `patient_name`, `dob`, `age`, `month`, `day`, `image`, `mobileno`, `email`, `gender`, `marital_status`, `blood_group`, `blood_bank_product_id`, `address`, `guardian_name`, `patient_type`, `identification_number`, `known_allergies`, `note`, `is_ipd`, `app_key`, `insurance_id`, `insurance_validity`, `is_dead`, `is_active`, `disable_at`, `created_at`) VALUES (2, NULL, 'Nati Kassa', '1997-07-26', 24, 5, 22, 'uploads/patient_images/no_image.png', '+251912345678', '', 'Male', 'Married', '', NULL, '', 'Gash Kassa', '', '', 'Flu', '', '', '', '', NULL, 'no', 'yes', NULL, '2022-01-17 07:58:45');
INSERT INTO `patients` (`id`, `lang_id`, `patient_name`, `dob`, `age`, `month`, `day`, `image`, `mobileno`, `email`, `gender`, `marital_status`, `blood_group`, `blood_bank_product_id`, `address`, `guardian_name`, `patient_type`, `identification_number`, `known_allergies`, `note`, `is_ipd`, `app_key`, `insurance_id`, `insurance_validity`, `is_dead`, `is_active`, `disable_at`, `created_at`) VALUES (3, NULL, 'Menbere', NULL, 0, 0, 0, NULL, '+251938048182', 'merqerp@gmail.com', 'Female', '', '', NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, 'no', 'yes', NULL, '2022-04-03 13:01:55');
INSERT INTO `patients` (`id`, `lang_id`, `patient_name`, `dob`, `age`, `month`, `day`, `image`, `mobileno`, `email`, `gender`, `marital_status`, `blood_group`, `blood_bank_product_id`, `address`, `guardian_name`, `patient_type`, `identification_number`, `known_allergies`, `note`, `is_ipd`, `app_key`, `insurance_id`, `insurance_validity`, `is_dead`, `is_active`, `disable_at`, `created_at`) VALUES (4, NULL, 'abebe', NULL, 0, 0, 0, NULL, '0911584769', 'abebe@gmail.com', 'Male', '', '', NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, 'no', 'yes', NULL, '2022-04-06 08:14:49');


#
# TABLE STRUCTURE FOR: payment_settings
#

DROP TABLE IF EXISTS `payment_settings`;

CREATE TABLE `payment_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(200) NOT NULL,
  `api_username` varchar(200) DEFAULT NULL,
  `api_secret_key` varchar(200) NOT NULL,
  `salt` varchar(200) NOT NULL,
  `api_publishable_key` varchar(200) NOT NULL,
  `paytm_website` varchar(255) NOT NULL,
  `paytm_industrytype` varchar(255) NOT NULL,
  `api_password` varchar(200) DEFAULT NULL,
  `api_signature` varchar(200) DEFAULT NULL,
  `api_email` varchar(200) DEFAULT NULL,
  `paypal_demo` varchar(100) NOT NULL,
  `account_no` varchar(200) NOT NULL,
  `is_active` varchar(255) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: payslip_allowance
#

DROP TABLE IF EXISTS `payslip_allowance`;

CREATE TABLE `payslip_allowance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_payslip_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `allowance_type` varchar(200) NOT NULL,
  `amount` float NOT NULL,
  `cal_type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `staff_payslip_id` (`staff_payslip_id`),
  CONSTRAINT `payslip_allowance_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payslip_allowance_ibfk_2` FOREIGN KEY (`staff_payslip_id`) REFERENCES `staff_payslip` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: permission_category
#

DROP TABLE IF EXISTS `permission_category`;

CREATE TABLE `permission_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `perm_group_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `short_code` varchar(100) DEFAULT NULL,
  `enable_view` int(11) DEFAULT 0,
  `enable_add` int(11) DEFAULT 0,
  `enable_edit` int(11) DEFAULT 0,
  `enable_delete` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=376 DEFAULT CHARSET=utf8;

INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (9, 3, 'Income', 'income', 1, 1, 1, 1, '2018-06-21 23:23:21');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (10, 3, 'Income Head', 'income_head', 1, 1, 1, 1, '2018-06-21 23:22:44');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (12, 4, 'Expense', 'expense', 1, 1, 1, 1, '2018-06-21 23:24:06');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (13, 4, 'Expense Head', 'expense_head', 1, 1, 1, 1, '2018-06-21 23:23:47');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (27, 8, 'Upload Content', 'upload_content', 1, 1, 0, 1, '2018-06-21 23:33:19');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (31, 10, 'Issue Item', 'issue_item', 1, 1, 0, 1, '2018-12-16 22:55:14');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (32, 10, 'Item Stock', 'item_stock', 1, 1, 1, 1, '2018-06-21 23:35:17');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (33, 10, 'Item', 'item', 1, 1, 1, 1, '2018-06-21 23:35:40');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (34, 10, 'Store', 'store', 1, 1, 1, 1, '2018-06-21 23:36:02');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (35, 10, 'Supplier', 'supplier', 1, 1, 1, 1, '2018-06-21 23:36:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (43, 13, 'Notice Board', 'notice_board', 1, 1, 1, 1, '2018-06-21 23:41:17');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (44, 13, 'Email / SMS', 'email_sms', 1, 0, 0, 0, '2018-06-21 23:40:54');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (48, 14, 'OPD Report', 'opd_report', 1, 0, 0, 0, '2018-12-17 21:59:18');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (53, 15, 'Languages', 'languages', 1, 1, 0, 0, '2021-09-12 22:56:36');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (54, 15, 'General Setting', 'general_setting', 1, 0, 1, 0, '2018-07-04 22:08:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (56, 15, 'Notification Setting', 'notification_setting', 1, 0, 1, 0, '2018-07-04 22:08:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (57, 15, 'SMS Setting', 'sms_setting', 1, 0, 1, 0, '2018-07-04 22:08:47');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (58, 15, 'Email Setting', 'email_setting', 1, 0, 1, 0, '2018-07-04 22:08:51');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (59, 15, 'Front CMS Setting', 'front_cms_setting', 1, 0, 1, 0, '2018-07-04 22:08:55');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (60, 15, 'Payment Methods', 'payment_methods', 1, 0, 1, 0, '2018-07-04 22:08:59');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (61, 16, 'Menus', 'menus', 1, 1, 0, 1, '2018-07-08 16:50:06');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (62, 16, 'Media Manager', 'media_manager', 1, 1, 0, 1, '2018-07-08 16:50:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (63, 16, 'Banner Images', 'banner_images', 1, 1, 0, 1, '2018-06-21 23:46:02');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (64, 16, 'Pages', 'pages', 1, 1, 1, 1, '2018-06-21 23:46:21');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (65, 16, 'Gallery', 'gallery', 1, 1, 1, 1, '2018-06-21 23:47:02');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (66, 16, 'Event', 'event', 1, 1, 1, 1, '2018-06-21 23:47:20');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (67, 16, 'News', 'notice', 1, 1, 1, 1, '2018-07-02 21:39:34');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (80, 17, 'Visitor Book', 'visitor_book', 1, 1, 1, 1, '2018-06-21 23:48:58');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (81, 17, 'Phone Call Log', 'phone_call_log', 1, 1, 1, 1, '2018-06-21 23:50:57');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (82, 17, 'Postal Dispatch', 'postal_dispatch', 1, 1, 1, 1, '2018-06-21 23:50:21');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (83, 17, 'Postal Receive', 'postal_receive', 1, 1, 1, 1, '2018-06-21 23:50:04');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (84, 17, 'Complain', 'complain', 1, 1, 1, 1, '2018-12-18 22:11:37');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (85, 17, 'Setup Front Office', 'setup_front_office', 1, 1, 1, 1, '2018-11-14 13:49:58');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (86, 18, 'Staff', 'staff', 1, 1, 1, 1, '2018-06-21 23:53:31');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (87, 18, 'Disable Staff', 'disable_staff', 1, 0, 0, 0, '2018-06-21 23:53:12');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (88, 18, 'Staff Attendance', 'staff_attendance', 1, 1, 1, 0, '2018-06-21 23:53:10');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (89, 14, 'Staff Attendance Report', 'staff_attendance_report', 1, 0, 0, 0, '2021-09-13 02:12:50');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (90, 18, 'Staff Payroll', 'staff_payroll', 1, 1, 0, 1, '2018-06-21 23:52:51');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (91, 14, 'Payroll Report', 'payroll_report', 1, 0, 0, 0, '2021-09-13 02:13:00');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (102, 21, 'Calendar To Do List', 'calendar_to_do_list', 1, 1, 1, 1, '2018-06-21 23:54:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (104, 10, 'Item Category', 'item_category', 1, 1, 1, 1, '2018-06-21 23:34:33');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (108, 18, ' Approve Leave Request', 'approve_leave_request', 1, 1, 1, 1, '2018-07-01 23:17:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (109, 18, 'Apply Leave', 'apply_leave', 1, 1, 0, 1, '2020-08-24 14:48:58');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (110, 18, 'LeaveTypes', 'leave_types', 1, 1, 1, 1, '2021-10-26 11:54:30');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (111, 18, 'Department', 'department', 1, 1, 1, 1, '2018-06-25 16:57:07');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (112, 18, 'Designation', 'designation', 1, 1, 1, 1, '2018-06-25 16:57:07');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (118, 22, 'Staff Role Count Widget', 'staff_role_count_widget', 1, 0, 0, 0, '2018-07-02 20:13:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (126, 15, 'Users', 'users', 1, 0, 0, 0, '2021-09-21 19:43:59');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (127, 18, 'Can See Other Users Profile', 'can_see_other_users_profile', 1, 0, 0, 0, '2018-07-02 21:42:29');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (129, 18, 'Staff Timeline', 'staff_timeline', 0, 1, 0, 1, '2018-07-04 21:08:52');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (130, 15, 'Backup', 'backup', 1, 1, 0, 1, '2018-07-08 17:17:17');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (131, 15, 'Restore', 'restore', 1, 0, 0, 0, '2018-07-08 17:17:17');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (132, 23, 'OPD Patient', 'opd_patient', 1, 1, 1, 1, '2018-12-19 22:37:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (134, 23, 'Prescription', 'prescription', 1, 1, 1, 1, '2018-10-10 14:28:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (135, 23, 'Visit', 'visit', 1, 1, 1, 1, '2021-09-16 20:39:58');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (137, 23, 'OPD Timeline', 'opd_timeline', 1, 1, 1, 1, '2021-02-24 01:02:04');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (138, 24, 'IPD Patients', 'ipd_patient', 1, 1, 1, 1, '2018-10-10 20:14:55');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (139, 24, 'Discharged Patients', 'discharged_patients', 1, 1, 1, 1, '2021-02-24 01:27:17');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (140, 24, 'Consultant Register', 'consultant_register', 1, 1, 1, 1, '2021-02-24 01:37:07');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (142, 24, 'IPD Timeline', 'ipd_timeline', 1, 1, 1, 1, '2021-02-25 01:30:00');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (143, 24, 'Charges', 'charges', 1, 1, 1, 1, '2018-10-10 14:28:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (144, 24, 'Payment', 'payment', 1, 1, 0, 1, '2021-09-08 01:41:13');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (146, 25, 'Medicine', 'medicine', 1, 1, 1, 1, '2018-10-10 14:28:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (148, 25, 'Pharmacy Bill', 'pharmacy_bill', 1, 1, 1, 1, '2021-02-25 01:33:40');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (149, 26, 'Pathology Test', 'pathology_test', 1, 1, 1, 1, '2021-02-25 01:36:32');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (152, 27, 'Radiology Test', 'radiology_test', 1, 1, 1, 1, '2021-02-25 01:45:31');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (153, 27, 'Radiology  Bill', 'radiology_bill', 1, 1, 1, 1, '2021-09-16 18:16:48');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (155, 22, 'IPD Income Widget', 'ipd_income_widget', 1, 0, 0, 0, '2018-12-19 22:08:05');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (156, 22, 'OPD Income Widget', 'opd_income_widget', 1, 0, 0, 0, '2018-12-19 22:08:15');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (157, 22, 'Pharmacy Income Widget', 'pharmacy_income_widget', 1, 0, 0, 0, '2018-12-19 22:08:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (158, 22, 'Pathology Income Widget', 'pathology_income_widget', 1, 0, 0, 0, '2018-12-19 22:08:37');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (159, 22, 'Radiology Income Widget', 'radiology_income_widget', 1, 0, 0, 0, '2018-12-19 22:08:49');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (161, 22, 'Blood Bank Income Widget', 'blood_bank_income_widget', 1, 0, 0, 0, '2018-12-19 22:09:13');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (162, 22, 'Ambulance Income Widget', 'ambulance_income_widget', 1, 0, 0, 0, '2018-12-19 22:09:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (165, 29, 'Ambulance Call', 'ambulance_call', 1, 1, 1, 1, '2018-10-26 16:37:51');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (166, 29, 'Ambulance', 'ambulance', 1, 1, 1, 1, '2018-10-26 16:37:59');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (168, 30, 'Blood Issue', 'blood_issue', 1, 1, 1, 1, '2018-10-26 17:20:15');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (169, 30, 'Blood Donor', 'blood_donor', 1, 1, 1, 1, '2018-10-26 17:20:19');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (170, 25, 'Medicine Category', 'medicine_category', 1, 1, 1, 1, '2018-10-24 19:10:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (171, 27, 'Radiology Category', 'radiology_category', 1, 1, 1, 1, '2021-02-25 01:52:34');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (173, 31, 'Organisation', 'organisation', 1, 1, 1, 1, '2018-10-24 19:10:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (175, 26, 'Pathology Category', 'pathology_category', 1, 1, 1, 1, '2018-10-24 19:10:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (176, 32, 'Hospital Charges', 'hospital_charges', 1, 1, 1, 1, '2021-09-12 20:29:30');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (178, 14, 'IPD Report', 'ipd_report', 1, 0, 0, 0, '2018-12-11 23:09:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (179, 14, 'Pharmacy Bill Report', 'pharmacy_bill_report', 1, 0, 0, 0, '2018-12-11 23:09:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (180, 14, 'Pathology Patient Report', 'pathology_patient_report', 1, 0, 0, 0, '2018-12-11 23:09:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (181, 14, 'Radiology Patient Report', 'radiology_patient_report', 1, 0, 0, 0, '2018-12-11 23:09:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (182, 14, 'OT Report', 'ot_report', 1, 0, 0, 0, '2019-03-07 19:56:54');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (183, 14, 'Blood Donor Report', 'blood_donor_report', 1, 0, 0, 0, '2019-03-07 19:56:54');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (184, 14, 'Payroll Month Report', 'payroll_month_report', 1, 0, 0, 0, '2019-03-07 19:57:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (185, 14, 'Payroll Report', 'payroll_report', 1, 0, 0, 0, '2019-03-07 19:57:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (187, 14, 'User Log', 'user_log', 1, 0, 0, 0, '2018-12-11 23:09:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (188, 14, 'Patient Login Credential', 'patient_login_credential', 1, 0, 0, 0, '2018-12-11 23:09:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (189, 14, 'Email / SMS Log', 'email_sms_log', 1, 0, 0, 0, '2018-12-11 23:09:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (190, 22, 'Yearly Income & Expense Chart', 'yearly_income_expense_chart', 1, 0, 0, 0, '2018-12-11 23:22:05');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (191, 22, 'Monthly Income & Expense Chart', 'monthly_income_expense_chart', 1, 0, 0, 0, '2018-12-11 23:25:14');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (192, 23, 'OPD Prescription Print Header Footer ', 'opd_prescription_print_header_footer', 1, 0, 1, 0, '2021-09-06 19:22:20');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (196, 24, 'Bed', 'bed', 1, 1, 1, 1, '2018-12-11 23:46:01');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (197, 24, 'IPD Prescription Print Header Footer', 'ipd_prescription_print_header_footer', 1, 0, 1, 0, '2021-09-06 20:26:49');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (198, 24, 'Bed Status', 'bed_status', 1, 0, 0, 0, '2018-12-11 23:39:42');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (200, 25, 'Medicine Bad Stock', 'medicine_bad_stock', 1, 1, 0, 1, '2018-12-17 14:12:46');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (201, 25, 'Pharmacy Bill print Header Footer', 'pharmacy_bill_print_header_footer', 1, 0, 1, 0, '2021-09-10 01:41:18');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (202, 30, 'Blood Stock', 'blood_stock', 1, 1, 0, 1, '2021-09-10 22:49:52');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (203, 32, 'Charge Category', 'charge_category', 1, 1, 1, 1, '2018-12-12 00:19:38');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (206, 14, 'TPA Report', 'tpa_report', 1, 0, 0, 0, '2019-03-07 19:49:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (207, 14, 'Ambulance Report', 'ambulance_report', 1, 0, 0, 0, '2019-03-07 19:49:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (208, 14, 'Discharge Patient Report', 'discharge_patient_report', 1, 0, 0, 0, '2019-03-07 19:49:55');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (209, 14, 'Appointment Report', 'appointment_report', 1, 0, 0, 0, '2019-03-07 19:50:10');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (210, 14, 'Transaction Report', 'transaction_report', 1, 0, 0, 0, '2019-03-07 19:57:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (211, 14, 'Blood Issue Report', 'blood_issue_report', 1, 0, 0, 0, '2019-03-07 19:57:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (212, 14, 'Income Report', 'income_report', 1, 0, 0, 0, '2019-03-07 19:57:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (213, 14, 'Expense Report', 'expense_report', 1, 0, 0, 0, '2019-03-07 19:57:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (214, 34, 'Birth Record', 'birth_record', 1, 1, 1, 1, '2018-06-21 23:36:02');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (215, 34, 'Death Record', 'death_record', 1, 1, 1, 1, '2018-06-21 23:36:02');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (218, 23, 'Move Patient in IPD', 'opd_move_patient_in_ipd', 1, 0, 0, 0, '2021-09-16 21:00:06');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (219, 23, 'Manual Prescription', 'manual_prescription', 1, 0, 0, 0, '2019-09-22 17:52:06');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (220, 24, 'Prescription ', 'ipd_prescription', 1, 1, 1, 1, '2019-09-23 13:59:27');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (221, 23, 'Charges', 'opd_charges', 1, 1, 1, 1, '2019-09-22 17:58:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (222, 23, 'Payment', 'opd_payment', 1, 1, 0, 1, '2021-09-08 00:44:17');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (224, 25, 'Import Medicine', 'import_medicine', 1, 0, 0, 0, '2019-09-22 18:03:31');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (225, 25, 'Medicine Purchase', 'medicine_purchase', 1, 1, 0, 1, '2021-10-02 04:59:02');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (226, 25, 'Medicine Supplier', 'medicine_supplier', 1, 1, 1, 1, '2019-09-22 18:09:36');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (227, 25, 'Medicine Dosage', 'medicine_dosage', 1, 1, 1, 1, '2019-09-22 18:17:16');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (236, 36, 'Patient', 'patient', 1, 1, 1, 1, '2021-09-21 21:29:37');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (237, 36, 'Enabled/Disabled', 'enabled_disabled', 1, 0, 0, 0, '2019-09-22 19:25:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (238, 22, 'Notification Center', 'notification_center', 1, 0, 0, 0, '2019-09-23 16:48:33');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (239, 36, 'Import', 'patient_import', 1, 0, 0, 0, '2019-10-03 14:20:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (240, 34, 'Birth Print Header Footer', 'birth_print_header_footer', 1, 0, 1, 0, '2021-09-12 22:51:32');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (242, 34, 'Death Print Header Footer', 'death_print_header_footer', 1, 0, 1, 0, '2021-09-12 22:51:38');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (243, 26, 'Print Header Footer', 'pathology_print_header_footer', 1, 0, 1, 0, '2021-09-16 19:37:21');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (244, 27, 'Print Header Footer', 'radiology_print_header_footer', 1, 0, 1, 0, '2021-09-16 19:24:43');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (246, 30, 'Print Header Footer', 'bloodbank_print_header_footer', 1, 0, 0, 0, '2021-10-07 04:06:58');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (247, 29, 'Print Header Footer', 'ambulance_print_header_footer', 1, 1, 1, 1, '2019-10-03 14:45:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (248, 24, 'IPD Bill Print Header Footer', 'ipd_bill_print_header_footer', 1, 0, 1, 0, '2021-09-06 20:27:00');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (249, 18, 'Print Payslip Header Footer', 'print_payslip_header_footer', 1, 1, 1, 1, '2019-10-03 15:31:33');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (250, 14, 'Income Group Report', 'income_group_report', 1, 0, 0, 0, '2020-08-11 18:52:52');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (251, 14, 'Expense Group Report', 'expense_group_report', 1, 0, 0, 0, '2019-10-03 17:15:56');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (253, 14, 'Inventory Stock Report', 'inventory_stock_report', 1, 0, 0, 0, '2019-10-03 18:20:31');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (254, 14, 'Inventory Item Report', 'add_item_report', 1, 0, 0, 0, '2019-10-03 18:23:22');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (255, 14, 'Inventory Issue Report', 'issue_inventory_report', 1, 0, 0, 0, '2019-10-03 18:24:40');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (256, 14, 'Expiry Medicine Report', 'expiry_medicine_report', 1, 0, 0, 0, '2019-10-03 19:00:11');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (257, 26, 'Pathology Bill', 'pathology_bill', 1, 1, 1, 1, '2021-02-25 01:58:10');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (258, 14, 'Birth Report', 'birth_report', 1, 0, 0, 0, '2019-10-13 16:12:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (259, 14, 'Death Report', 'death_report', 1, 0, 0, 0, '2019-10-13 16:13:56');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (260, 26, 'Pathology Unit', 'pathology_unit', 1, 1, 1, 1, '2020-07-21 14:13:49');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (261, 27, 'Radiology Unit', 'radiology_unit', 1, 1, 1, 1, '2020-07-21 14:14:47');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (262, 27, 'Radiology Parameter', 'radiology_parameter', 1, 1, 1, 1, '2020-07-21 14:20:28');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (263, 26, 'Pathology Parameter', 'pathology_parameter', 1, 1, 1, 1, '2020-07-21 14:20:28');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (264, 32, 'Charge Type', 'charge_type', 1, 1, 0, 1, '2020-07-21 17:09:44');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (265, 14, 'OPD Balance Report', 'opd_balance_report', 1, 0, 0, 0, '2020-07-27 15:03:34');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (266, 14, 'IPD Balance Report', 'ipd_balance_report', 1, 0, 0, 0, '2020-07-27 15:03:34');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (267, 15, 'Symptoms Type', 'symptoms_type', 1, 1, 1, 1, '2021-09-13 21:36:22');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (269, 37, 'Live Consultation', 'live_consultation', 1, 1, 0, 1, '2020-08-12 19:19:27');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (270, 37, 'Live Meeting', 'live_meeting', 1, 1, 0, 1, '2020-08-12 19:19:27');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (271, 14, 'Live Consultation Report', 'live_consultation_report', 1, 0, 0, 0, '2021-09-13 02:11:19');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (272, 14, 'Live Meeting Report', 'live_meeting_report', 1, 0, 0, 0, '2021-09-13 02:11:14');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (273, 37, 'Setting', 'setting', 1, 0, 1, 0, '2020-08-12 20:03:28');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (274, 15, 'Language Switcher', 'language_switcher', 1, 0, 0, 0, '2020-08-20 17:48:53');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (279, 15, 'Symptoms Head', 'symptoms_head', 1, 1, 1, 1, '2021-09-13 21:36:27');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (280, 18, 'Specialist', 'specialist', 1, 1, 1, 1, '2019-10-03 10:01:33');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (281, 22, 'General Income Widget', 'general_income_widget', 1, 0, 0, 0, '2018-12-19 16:38:05');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (282, 22, 'Expenses Widget', 'expenses_widget', 1, 0, 0, 0, '2018-12-19 16:38:05');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (283, 38, 'Referral Category', 'referral_category', 1, 1, 1, 1, '2021-06-11 02:54:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (284, 38, 'Referral Commission', 'referral_commission', 1, 1, 1, 1, '2021-06-11 02:54:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (285, 38, 'Referral Person', 'referral_person', 1, 1, 1, 1, '2021-06-11 02:55:21');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (286, 38, 'Referral Payment', 'referral_payment', 1, 1, 1, 1, '2021-06-11 02:55:21');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (287, 15, 'Prefix Setting', 'prefix_setting', 1, 0, 1, 0, '2021-06-11 20:46:10');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (288, 15, 'Captcha Setting', 'captcha_setting', 1, 0, 1, 0, '2021-06-11 21:43:53');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (289, 32, 'Tax Category', 'tax_category', 1, 1, 1, 1, '2021-06-11 22:16:39');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (290, 32, 'Unit Type', 'unit_type', 1, 1, 1, 1, '2021-06-11 22:16:39');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (291, 25, 'Dosage Interval', 'dosage_interval', 1, 1, 1, 1, '2021-06-12 00:15:37');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (292, 25, 'Dosage Duration', 'dosage_duration', 1, 1, 1, 1, '2021-06-12 00:15:37');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (293, 30, 'Blood Bank Product', 'blood_bank_product', 1, 1, 1, 1, '2021-06-12 00:51:23');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (294, 39, 'Slot', 'online_appointment_slot', 1, 1, 1, 1, '2021-09-14 01:04:31');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (295, 39, 'Doctor Shift', 'online_appointment_doctor_shift', 1, 0, 1, 0, '2021-06-12 01:43:48');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (296, 39, 'Shift', 'online_appointment_shift', 1, 1, 1, 1, '2021-06-12 01:24:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (297, 39, 'Doctor Wise Appointment', 'doctor_wise_appointment', 1, 0, 0, 0, '2021-10-07 01:45:39');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (298, 39, 'Patient Queue', 'patient_queue', 1, 0, 0, 0, '2021-10-07 01:45:42');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (299, 23, 'OPD Medication', 'opd_medication', 1, 1, 1, 1, '2021-06-14 20:00:12');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (300, 24, 'IPD Medication', 'ipd_medication', 1, 1, 1, 1, '2021-06-14 20:00:12');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (301, 24, 'Bed History', 'bed_history', 1, 0, 0, 0, '2021-06-14 20:00:12');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (302, 30, 'Blood Bank Components', 'blood_bank_components', 1, 1, 0, 1, '2021-06-15 00:46:48');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (303, 23, 'Operation Theatre', 'opd_operation_theatre', 1, 1, 1, 1, '2021-09-07 22:49:13');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (304, 23, 'Lab Investigation', 'opd_lab_investigation', 1, 0, 0, 0, '2021-09-06 19:36:10');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (305, 23, 'Patient Discharge', 'opd_patient_discharge', 1, 0, 1, 0, '2021-09-06 19:39:16');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (306, 23, 'Patient Discharge Revert', 'opd_patient_discharge_revert', 1, 0, 0, 0, '2021-09-06 19:39:38');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (307, 23, 'Treatment History', 'opd_treatment_history', 1, 0, 0, 0, '2021-09-06 19:49:05');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (308, 24, 'Lab Investigation', 'ipd_lab_investigation', 1, 0, 0, 0, '2021-09-06 20:45:59');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (309, 24, 'Patient Discharge', 'ipd_patient_discharge', 1, 0, 1, 0, '2021-09-06 22:08:20');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (310, 24, 'Patient Discharge Revert', 'ipd_patient_discharge_revert', 1, 0, 0, 0, '2021-09-06 22:14:54');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (311, 30, 'Issue Component', 'issue_component', 1, 1, 1, 1, '2021-09-06 22:21:53');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (312, 26, '	Add/Edit Collection Person', 'pathology_add_edit_collection_person', 1, 0, 1, 0, '2021-09-16 20:06:13');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (313, 25, 'Partial Payment', 'pharmacy_partial_payment', 1, 1, 0, 1, '2021-09-07 01:10:15');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (314, 26, 'Partial Payment', 'pathology_partial_payment', 1, 1, 0, 1, '2021-09-07 02:34:33');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (315, 27, 'Partial Payment', 'radiology_partial_payment', 1, 1, 0, 1, '2021-09-07 02:38:15');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (316, 28, 'Partial Payment', 'radiology_partial_payment', 1, 1, 0, 1, '2021-09-07 02:39:02');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (317, 30, 'Partial Payment', 'blood_bank_partial_payment', 1, 1, 0, 1, '2021-09-07 02:47:22');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (318, 29, 'Partial Payment', 'ambulance_partial_payment', 1, 1, 0, 1, '2021-09-07 02:48:10');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (319, 23, 'Checkup', 'checkup', 1, 1, 1, 1, '2021-09-16 20:40:33');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (320, 23, 'Print Bill', 'opd_print_bill', 1, 0, 0, 0, '2021-09-07 23:09:27');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (321, 23, 'Live Consult', 'opd_live_consult', 1, 0, 0, 0, '2021-09-08 00:53:31');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (322, 24, 'Nurse Note', 'nurse_note', 1, 1, 1, 1, '2021-09-08 01:20:07');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (323, 24, 'Bed Type', 'bed_type', 1, 1, 1, 1, '2021-09-08 20:06:39');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (324, 24, 'Bed Group', 'bed_group', 1, 1, 1, 1, '2021-09-08 20:07:08');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (325, 24, 'Floor', 'floor', 1, 1, 1, 1, '2021-09-08 20:08:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (326, 24, 'Operation Theatre', 'ipd_operation_theatre', 1, 1, 1, 1, '2021-09-08 22:38:14');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (327, 24, 'Live Consult', 'ipd_live_consultation', 1, 0, 0, 0, '2021-09-08 23:05:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (329, 24, 'Treatment History', 'ipd_treatment_history', 1, 0, 0, 0, '2021-09-06 20:45:59');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (330, 41, 'OPD Billing', 'opd_billing', 1, 0, 0, 0, '2021-09-09 00:33:14');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (331, 41, 'OPD Billing Payment', 'opd_billing_payment', 1, 1, 0, 0, '2021-09-09 01:10:36');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (332, 41, 'IPD Billing', 'ipd_billing', 1, 0, 0, 0, '2021-09-09 00:52:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (333, 41, 'IPD Billing Payment', 'ipd_billing_payment', 1, 1, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (334, 41, 'Pharmacy Billing', 'pharmacy_billing', 1, 0, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (335, 41, 'Pharmacy Billing Payment', 'pharmacy_billing_payment', 1, 1, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (336, 41, 'Pathology Billing', 'pathology_billing', 1, 0, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (337, 41, 'Pathology Billing Payment', 'pathology_billing_payment', 1, 1, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (338, 41, 'Radiology Billing', 'radiology_billing', 1, 0, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (339, 41, 'Radiology Billing Payment', 'radiology_billing_payment', 1, 1, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (340, 41, 'Blood Bank Billing', 'blood_bank_billing', 1, 0, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (341, 41, 'Blood Bank Billing Payment', 'blood_bank_billing_payment', 1, 1, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (342, 41, 'Ambulance Billing', 'ambulance_billing', 1, 0, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (343, 41, 'Ambulance Billing Payment', 'ambulance_billing_payment', 1, 1, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (344, 41, 'Generate Bill', 'generate_bill', 1, 0, 0, 0, '2021-09-09 20:36:09');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (345, 41, 'Generate Discharge Card', 'generate_discharge_card', 1, 0, 0, 0, '2021-09-09 00:53:03');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (346, 40, 'Online Appointment', 'online_appointment', 1, 0, 0, 0, '2021-09-09 02:15:17');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (347, 31, 'TPA Charges ', 'tpa_charges', 1, 0, 1, 1, '2018-10-24 19:10:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (348, 15, 'System Notification Setting', 'system_notification_setting', 1, 0, 1, 0, '2018-07-04 22:08:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (349, 14, 'All Transaction Report', 'all_transaction_report', 1, 0, 0, 0, '2021-09-13 02:29:20');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (350, 14, 'Patient Visit Report', 'patient_visit_report', 1, 0, 0, 0, '2019-10-03 18:23:22');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (351, 14, 'Patient Bill Report', 'patient_bill_report', 1, 0, 0, 0, '2019-10-03 17:15:56');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (352, 14, 'Referral Report', 'referral_report', 1, 0, 0, 0, '2019-10-03 17:15:56');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (353, 27, 'Add/Edit Collection Person', 'radiology_add_edit_collection_person', 1, 0, 1, 0, '2021-09-16 20:06:41');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (354, 27, 'Add/Edit  Report', 'radiology_add_edit_report', 1, 0, 1, 0, '2021-09-16 20:06:50');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (355, 26, 'Add/Edit Report', 'pathology_add_edit_report', 1, 0, 1, 0, '2021-09-16 20:06:24');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (362, 42, 'Generate Certificate', 'generate_certificate', 1, 0, 0, 0, '2021-09-20 16:48:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (363, 42, 'Certificate', 'certificate', 1, 1, 1, 1, '2021-09-20 16:48:25');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (364, 42, 'Generate Staff ID Card', 'generate_staff_id_card', 1, 0, 0, 0, '2021-09-20 16:56:38');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (365, 42, 'Staff ID Card', 'staff_id_card', 1, 1, 1, 1, '2021-09-20 16:56:09');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (366, 42, 'Generate Patient ID Card', 'generate_patient_id_card', 1, 0, 0, 0, '2021-09-20 23:13:54');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (367, 42, 'Patient ID Card', 'patient_id_card', 1, 1, 1, 1, '2021-09-20 16:54:38');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (369, 14, 'Component Issue Report', 'component_issue_report', 1, 0, 0, 0, '2019-03-07 19:57:35');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (370, 14, 'Audit Trail Report', 'audit_trail_report', 1, 0, 0, 0, '2021-09-28 01:08:22');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (371, 43, 'Chat', 'chat', 1, 0, 0, 0, '2021-10-07 05:05:15');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (372, 15, 'Custom Fields', 'custom_fields', 1, 0, 0, 0, '2021-10-29 07:41:26');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (373, 14, 'Daily Transaction Report', 'daily_transaction_report', 1, 0, 0, 0, '2021-10-29 07:42:08');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (374, 15, 'Operation', 'operation', 1, 1, 1, 1, '2021-10-29 07:45:14');
INSERT INTO `permission_category` (`id`, `perm_group_id`, `name`, `short_code`, `enable_view`, `enable_add`, `enable_edit`, `enable_delete`, `created_at`) VALUES (375, 15, 'Operation Category', 'operation_category', 1, 1, 1, 1, '2021-10-29 07:45:14');


#
# TABLE STRUCTURE FOR: permission_group
#

DROP TABLE IF EXISTS `permission_group`;

CREATE TABLE `permission_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `short_code` varchar(100) NOT NULL,
  `is_active` int(11) DEFAULT 0,
  `system` int(11) NOT NULL,
  `sort_order` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (3, 'Income', 'income', 1, 0, '15.00', '2021-10-22 00:07:50');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (4, 'Expense', 'expense', 1, 0, '16.00', '2021-10-22 00:07:55');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (8, 'Download Center', 'download_center', 1, 0, '19.00', '2021-10-22 00:13:38');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (10, 'Inventory', 'inventory', 1, 0, '18.00', '2021-10-22 00:13:22');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (13, 'Messaging', 'communicate', 1, 0, '17.00', '2021-10-22 00:13:08');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (14, 'Reports', 'reports', 1, 1, '23.00', '2021-10-22 00:14:35');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (15, 'System Settings', 'system_settings', 1, 1, '24.00', '2021-10-22 00:16:02');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (16, 'Front CMS', 'front_cms', 1, 0, '21.00', '2021-10-22 00:14:07');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (17, 'Front Office', 'front_office', 1, 0, '10.00', '2021-10-22 00:05:56');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (18, 'Human Resource', 'human_resource', 1, 1, '12.00', '2021-10-22 00:06:27');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (21, 'Calendar To Do List', 'calendar_to_do_list', 1, 0, '28.00', '2021-10-22 00:22:27');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (22, 'Dashboard and Widgets', 'dashboard_and_widgets', 1, 1, '0.01', '2021-10-22 00:18:00');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (23, 'OPD', 'opd', 1, 0, '3.00', '2021-10-22 00:04:29');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (24, 'IPD', 'ipd', 1, 0, '4.00', '2021-10-22 00:04:38');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (25, 'Pharmacy', 'pharmacy', 1, 0, '5.00', '2021-10-22 00:04:47');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (26, 'Pathology', 'pathology', 1, 0, '6.00', '2021-10-22 00:04:59');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (27, 'Radiology', 'radiology', 1, 0, '7.00', '2021-10-22 00:05:09');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (29, 'Ambulance', 'ambulance', 1, 0, '9.00', '2021-10-22 00:05:31');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (30, 'Blood Bank', 'blood_bank', 1, 0, '8.00', '2021-10-22 00:05:21');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (31, 'TPA Management', 'tpa_management', 1, 0, '14.00', '2021-10-22 00:06:58');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (32, 'Hospital Charges', 'hospital_charges', 1, 1, '26.00', '2021-10-22 00:19:04');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (34, 'Birth Death Record', 'birth_death_report', 1, 0, '11.00', '2021-10-22 00:06:10');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (36, 'Patient', 'patient', 1, 0, '25.00', '2021-10-22 00:18:46');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (37, 'Live Consultation', 'live_consultation', 1, 0, '22.00', '2021-10-22 00:14:21');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (38, 'Referral', 'referral', 1, 0, '13.00', '2021-10-22 00:06:48');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (39, 'Appointment', 'appointment', 1, 0, '2.00', '2021-10-22 00:04:15');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (41, 'Bill', 'bill', 1, 0, '1.00', '2021-10-22 00:03:47');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (42, 'Certificate', 'certificate', 1, 0, '20.00', '2021-10-04 03:36:58');
INSERT INTO `permission_group` (`id`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (43, 'Chat', 'chat', 1, 0, '27.00', '2021-10-22 00:22:19');


#
# TABLE STRUCTURE FOR: permission_patient
#

DROP TABLE IF EXISTS `permission_patient`;

CREATE TABLE `permission_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_group_short_code` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `short_code` varchar(100) NOT NULL,
  `is_active` int(11) DEFAULT NULL,
  `system` int(11) NOT NULL,
  `sort_order` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (1, 'appointment', 'My Appointments', 'my_appointments', 1, 0, '1.00', '2021-09-27 13:17:05');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (2, 'opd', 'OPD', 'opd', 1, 0, '2.00', '2021-09-27 13:17:21');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (3, 'ipd', 'IPD', 'ipd', 1, 0, '3.00', '2021-09-25 09:33:07');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (4, 'pharmacy', 'Pharmacy', 'pharmacy', 1, 0, '4.00', '2021-09-25 06:03:29');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (5, 'pathology', 'Pathology', 'pathology', 1, 0, '5.00', '2021-09-27 13:15:45');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (6, 'radiology', 'Radiology', 'radiology', 1, 0, '6.00', '2021-09-27 13:15:47');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (7, 'ambulance', 'Ambulance', 'ambulance', 1, 0, '7.00', '2021-09-27 13:15:50');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (8, 'blood_bank', 'Blood Bank', 'blood_bank', 1, 0, '8.00', '2021-09-24 07:40:59');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (9, 'live_consultation', 'Live Consultation', 'live_consultation', 1, 0, '9.00', '2021-09-27 13:16:49');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (10, 'calendar_to_do_list', 'Calendar To Do List', 'calendar_to_do_list', 1, 0, '11.00', '2021-10-04 09:07:25');
INSERT INTO `permission_patient` (`id`, `permission_group_short_code`, `name`, `short_code`, `is_active`, `system`, `sort_order`, `created_at`) VALUES (11, 'chat', 'Chat', 'chat', 1, 0, '11.00', '2021-10-04 07:34:59');


#
# TABLE STRUCTURE FOR: pharmacy
#

DROP TABLE IF EXISTS `pharmacy`;

CREATE TABLE `pharmacy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(200) DEFAULT NULL,
  `medicine_category_id` int(11) DEFAULT NULL,
  `medicine_image` varchar(200) NOT NULL,
  `medicine_company` varchar(100) DEFAULT NULL,
  `medicine_composition` varchar(100) DEFAULT NULL,
  `medicine_group` varchar(100) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `min_level` varchar(50) DEFAULT NULL,
  `reorder_level` varchar(50) DEFAULT NULL,
  `vat` float DEFAULT NULL,
  `unit_packing` varchar(50) DEFAULT NULL,
  `vat_ac` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `medicine_category_id` (`medicine_category_id`),
  CONSTRAINT `pharmacy_ibfk_1` FOREIGN KEY (`medicine_category_id`) REFERENCES `medicine_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `pharmacy` (`id`, `medicine_name`, `medicine_category_id`, `medicine_image`, `medicine_company`, `medicine_composition`, `medicine_group`, `unit`, `min_level`, `reorder_level`, `vat`, `unit_packing`, `vat_ac`, `note`, `is_active`, `created_at`) VALUES (1, 'Albendazol', 1, '', 'Albendazol LLC', 'ALB', 'Anti Germ', '200', '20', '10', '15', '1000', '', '', '', '2022-05-06 17:32:28');
INSERT INTO `pharmacy` (`id`, `medicine_name`, `medicine_category_id`, `medicine_image`, `medicine_company`, `medicine_composition`, `medicine_group`, `unit`, `min_level`, `reorder_level`, `vat`, `unit_packing`, `vat_ac`, `note`, `is_active`, `created_at`) VALUES (2, 'Amoxicillin', 2, '', 'Ethiopian Pharmacitcals ', 'Amoxicillin Compositions', 'Antibiotics', '500', '20', '10', '15', '50', '', '', '', '2022-05-06 17:39:26');


#
# TABLE STRUCTURE FOR: pharmacy_bill_basic
#

DROP TABLE IF EXISTS `pharmacy_bill_basic`;

CREATE TABLE `pharmacy_bill_basic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `ipd_prescription_basic_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `customer_name` varchar(50) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `doctor_name` varchar(50) DEFAULT NULL,
  `file` varchar(200) NOT NULL,
  `total` float(10,2) DEFAULT 0.00,
  `discount_percentage` float(10,2) DEFAULT 0.00,
  `discount` float(10,2) DEFAULT 0.00,
  `tax_percentage` float(10,2) DEFAULT 0.00,
  `tax` float(10,2) DEFAULT 0.00,
  `net_amount` float(10,2) DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `generated_by` (`generated_by`),
  KEY `ipd_prescription_basic_id` (`ipd_prescription_basic_id`),
  CONSTRAINT `pharmacy_bill_basic_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_basic_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_basic_ibfk_3` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_basic_ibfk_4` FOREIGN KEY (`ipd_prescription_basic_id`) REFERENCES `ipd_prescription_basic` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `pharmacy_bill_basic` (`id`, `date`, `patient_id`, `ipd_prescription_basic_id`, `case_reference_id`, `customer_name`, `customer_type`, `doctor_name`, `file`, `total`, `discount_percentage`, `discount`, `tax_percentage`, `tax`, `net_amount`, `note`, `generated_by`, `created_at`) VALUES (1, '2022-05-06 08:54:00', 1, NULL, NULL, '', NULL, 'Hanibal Kassahun (MERQ EMR 01)', '', '75.00', '0.00', '0.00', NULL, '11.25', '86.25', '', 7, '2022-05-06 17:54:52');
INSERT INTO `pharmacy_bill_basic` (`id`, `date`, `patient_id`, `ipd_prescription_basic_id`, `case_reference_id`, `customer_name`, `customer_type`, `doctor_name`, `file`, `total`, `discount_percentage`, `discount`, `tax_percentage`, `tax`, `net_amount`, `note`, `generated_by`, `created_at`) VALUES (2, '2022-07-08 12:44:00', 1, NULL, NULL, '', NULL, 'Hanibal Kassahun (MERQ EMR 01)', '', '825.00', '0.00', '0.00', NULL, '123.75', '948.75', '', 1, '2022-07-08 09:46:17');


#
# TABLE STRUCTURE FOR: pharmacy_bill_detail
#

DROP TABLE IF EXISTS `pharmacy_bill_detail`;

CREATE TABLE `pharmacy_bill_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pharmacy_bill_basic_id` int(11) DEFAULT NULL,
  `medicine_batch_detail_id` int(11) DEFAULT NULL,
  `quantity` varchar(100) NOT NULL,
  `sale_price` float(10,2) NOT NULL,
  `amount` float(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `pharmacy_bill_basic_id` (`pharmacy_bill_basic_id`),
  KEY `medicine_batch_detail_id` (`medicine_batch_detail_id`),
  CONSTRAINT `pharmacy_bill_detail_ibfk_1` FOREIGN KEY (`pharmacy_bill_basic_id`) REFERENCES `pharmacy_bill_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pharmacy_bill_detail_ibfk_2` FOREIGN KEY (`medicine_batch_detail_id`) REFERENCES `medicine_batch_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `pharmacy_bill_detail` (`id`, `pharmacy_bill_basic_id`, `medicine_batch_detail_id`, `quantity`, `sale_price`, `amount`, `created_at`) VALUES (1, 1, 2, '1', '75.00', '0.00', '2022-05-06 17:54:52');
INSERT INTO `pharmacy_bill_detail` (`id`, `pharmacy_bill_basic_id`, `medicine_batch_detail_id`, `quantity`, `sale_price`, `amount`, `created_at`) VALUES (2, 2, 2, '3', '75.00', '0.00', '2022-07-08 09:46:17');
INSERT INTO `pharmacy_bill_detail` (`id`, `pharmacy_bill_basic_id`, `medicine_batch_detail_id`, `quantity`, `sale_price`, `amount`, `created_at`) VALUES (3, 2, 3, '2', '300.00', '0.00', '2022-07-08 09:46:17');


#
# TABLE STRUCTURE FOR: prefixes
#

DROP TABLE IF EXISTS `prefixes`;

CREATE TABLE `prefixes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `prefix` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (1, 'ipd_no', 'IPDN', '2021-06-30 17:40:23');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (2, 'opd_no', 'OPDN', '2021-02-22 13:38:01');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (3, 'ipd_prescription', 'IPDP', '2021-02-12 18:42:07');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (4, 'opd_prescription', 'OPDP', '2021-02-12 18:42:17');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (5, 'appointment', 'APPN', '2021-10-22 05:37:43');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (6, 'pharmacy_billing', 'PHAB', '2021-10-22 05:37:43');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (7, 'operation_theater_reference_no', 'OTRN', '2021-10-22 05:37:43');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (8, 'blood_bank_billing', 'BLBB', '2021-10-22 05:40:38');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (9, 'ambulance_call_billing', 'AMCB', '2021-10-22 05:40:38');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (10, 'radiology_billing', 'RADB', '2021-10-22 05:40:38');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (11, 'pathology_billing', 'PATB', '2021-10-22 05:40:38');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (12, 'checkup_id', 'OCID', '2021-10-22 05:44:25');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (13, 'purchase_no', 'PHPN', '2021-10-22 05:44:25');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (14, 'transaction_id', 'TRID', '2021-10-22 05:44:25');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (15, 'birth_record_reference_no', 'BRRN', '2021-10-22 05:44:25');
INSERT INTO `prefixes` (`id`, `type`, `prefix`, `created_at`) VALUES (16, 'death_record_reference_no', 'DRRN', '2021-10-22 05:44:25');


#
# TABLE STRUCTURE FOR: print_setting
#

DROP TABLE IF EXISTS `print_setting`;

CREATE TABLE `print_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `print_header` varchar(300) NOT NULL,
  `print_footer` varchar(200) NOT NULL,
  `setting_for` varchar(200) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (1, 'uploads/printing/1.png', '', 'opdpre', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (2, 'uploads/printing/2.png', '', 'opd', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (3, 'uploads/printing/3.png', '', 'ipdpres', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (4, 'uploads/printing/4.png', '', 'ipd', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (5, 'uploads/printing/5.png', '', 'bill', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (6, 'uploads/printing/6.png', '', 'pharmacy', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (7, 'uploads/printing/7.png', '', 'payslip', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (8, 'uploads/printing/8.png', '', 'paymentreceipt', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (9, 'uploads/printing/9.png', '', 'birth', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (10, 'uploads/printing/10.png', '', 'death', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (11, 'uploads/printing/11.png', '', 'pathology', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (12, 'uploads/printing/12.png', '', 'radiology', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (13, 'uploads/printing/13.png', '', 'ot', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (14, 'uploads/printing/14.png', '', 'bloodbank', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (15, 'uploads/printing/15.png', '', 'ambulance', 'yes', '2021-09-25 06:44:20');
INSERT INTO `print_setting` (`id`, `print_header`, `print_footer`, `setting_for`, `is_active`, `created_at`) VALUES (16, 'uploads/printing/16.png', '', 'discharge_card', 'yes', '2021-09-25 06:44:20');


#
# TABLE STRUCTURE FOR: radio
#

DROP TABLE IF EXISTS `radio`;

CREATE TABLE `radio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(100) DEFAULT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  `test_type` varchar(100) DEFAULT NULL,
  `radiology_category_id` int(11) DEFAULT NULL,
  `sub_category` varchar(50) NOT NULL,
  `report_days` varchar(50) NOT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `radio_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `radio` (`id`, `test_name`, `short_name`, `test_type`, `radiology_category_id`, `sub_category`, `report_days`, `charge_id`, `created_at`) VALUES (1, 'Lung Radiology', 'lun', 'Lung Test', 1, 'LungTest', '0', 3, '2022-07-09 14:17:40');


#
# TABLE STRUCTURE FOR: radiology_billing
#

DROP TABLE IF EXISTS `radiology_billing`;

CREATE TABLE `radiology_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `ipd_prescription_basic_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `total` float(10,2) NOT NULL,
  `discount_percentage` float(10,2) NOT NULL,
  `discount` float(10,2) NOT NULL,
  `tax_percentage` float(10,2) NOT NULL,
  `tax` float(10,2) NOT NULL,
  `net_amount` float(10,2) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `generated_by` (`generated_by`),
  CONSTRAINT `radiology_billing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_billing_ibfk_5` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `radiology_billing` (`id`, `patient_id`, `case_reference_id`, `ipd_prescription_basic_id`, `doctor_id`, `date`, `doctor_name`, `total`, `discount_percentage`, `discount`, `tax_percentage`, `tax`, `net_amount`, `transaction_id`, `note`, `generated_by`, `created_at`, `updated_at`) VALUES (1, 1, NULL, NULL, NULL, '2022-07-09 05:17:00', '', '99.99', '0.00', '0.00', '0.00', '15.00', '114.99', NULL, '', 1, '2022-07-09 14:18:53', NULL);


#
# TABLE STRUCTURE FOR: radiology_parameter
#

DROP TABLE IF EXISTS `radiology_parameter`;

CREATE TABLE `radiology_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(100) NOT NULL,
  `test_value` varchar(100) NOT NULL,
  `reference_range` varchar(100) NOT NULL,
  `gender` varchar(100) NOT NULL,
  `unit` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `radiology_parameter` (`id`, `parameter_name`, `test_value`, `reference_range`, `gender`, `unit`, `description`, `created_at`) VALUES (1, 'MRI Cardiac with Contrast', '', '1.5', '', '8', 'MRI Cardiac with Contrast', '2022-05-06 16:45:09');
INSERT INTO `radiology_parameter` (`id`, `parameter_name`, `test_value`, `reference_range`, `gender`, `unit`, `description`, `created_at`) VALUES (2, 'Ultrasound', '', '<7 mm', '', '12', 'Ultrasound is sound waves with frequencies higher than the upper audible limit of human hearing. Ultrasound is not different from \"normal\" (audible) sound in its physical properties, except that humans cannot hear it.', '2022-05-06 16:45:39');
INSERT INTO `radiology_parameter` (`id`, `parameter_name`, `test_value`, `reference_range`, `gender`, `unit`, `description`, `created_at`) VALUES (3, 'XRay ', '', '< 9 mm', '', '13', 'Body Back Xray Scan', '2022-05-06 16:46:43');


#
# TABLE STRUCTURE FOR: radiology_parameterdetails
#

DROP TABLE IF EXISTS `radiology_parameterdetails`;

CREATE TABLE `radiology_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `radiology_id` int(11) DEFAULT NULL,
  `radiology_parameter_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `radiology_id` (`radiology_id`),
  KEY `radiology_parameter_id` (`radiology_parameter_id`),
  CONSTRAINT `radiology_parameterdetails_ibfk_1` FOREIGN KEY (`radiology_id`) REFERENCES `radio` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_parameterdetails_ibfk_2` FOREIGN KEY (`radiology_parameter_id`) REFERENCES `radiology_parameter` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `radiology_parameterdetails` (`id`, `radiology_id`, `radiology_parameter_id`, `created_at`) VALUES (1, 1, 3, '2022-07-09 14:17:40');


#
# TABLE STRUCTURE FOR: radiology_report
#

DROP TABLE IF EXISTS `radiology_report`;

CREATE TABLE `radiology_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `radiology_bill_id` int(11) DEFAULT NULL,
  `radiology_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `patient_name` varchar(100) DEFAULT NULL,
  `consultant_doctor` varchar(10) NOT NULL,
  `reporting_date` date DEFAULT NULL,
  `parameter_update` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `radiology_report` text DEFAULT NULL,
  `report_name` text DEFAULT NULL,
  `tax_percentage` float(10,2) NOT NULL DEFAULT 0.00,
  `apply_charge` float(10,2) NOT NULL DEFAULT 0.00,
  `radiology_center` varchar(250) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `collection_specialist` int(11) DEFAULT NULL,
  `collection_date` date DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `radiology_id` (`radiology_id`),
  KEY `radiology_bill_id` (`radiology_bill_id`),
  KEY `patient_id` (`patient_id`),
  KEY `generated_by` (`generated_by`),
  KEY `collection_specialist` (`collection_specialist`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `radiology_report_ibfk_1` FOREIGN KEY (`radiology_id`) REFERENCES `radio` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_2` FOREIGN KEY (`radiology_bill_id`) REFERENCES `radiology_billing` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_3` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_4` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_5` FOREIGN KEY (`collection_specialist`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_ibfk_6` FOREIGN KEY (`approved_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `radiology_report` (`id`, `radiology_bill_id`, `radiology_id`, `patient_id`, `customer_type`, `patient_name`, `consultant_doctor`, `reporting_date`, `parameter_update`, `description`, `radiology_report`, `report_name`, `tax_percentage`, `apply_charge`, `radiology_center`, `generated_by`, `collection_specialist`, `collection_date`, `approved_by`, `created_at`) VALUES (1, 1, 1, 1, NULL, NULL, '', '2022-07-09', NULL, NULL, NULL, NULL, '15.00', '99.99', '', NULL, NULL, NULL, NULL, '2022-07-09 14:18:53');


#
# TABLE STRUCTURE FOR: radiology_report_parameterdetails
#

DROP TABLE IF EXISTS `radiology_report_parameterdetails`;

CREATE TABLE `radiology_report_parameterdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `radiology_report_id` int(11) DEFAULT NULL,
  `radiology_parameterdetail_id` int(11) DEFAULT NULL,
  `radiology_report_value` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `radiology_report_id` (`radiology_report_id`),
  KEY `radiology_parameterdetail_id` (`radiology_parameterdetail_id`),
  CONSTRAINT `radiology_report_parameterdetails_ibfk_1` FOREIGN KEY (`radiology_report_id`) REFERENCES `radiology_report` (`id`) ON DELETE CASCADE,
  CONSTRAINT `radiology_report_parameterdetails_ibfk_2` FOREIGN KEY (`radiology_parameterdetail_id`) REFERENCES `radiology_parameterdetails` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: read_notification
#

DROP TABLE IF EXISTS `read_notification`;

CREATE TABLE `read_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `notification_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `read_notification_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `read_notification` (`id`, `staff_id`, `notification_id`, `is_active`, `created_at`) VALUES (1, 1, 1, 'no', '2022-04-03 15:06:20');


#
# TABLE STRUCTURE FOR: read_systemnotification
#

DROP TABLE IF EXISTS `read_systemnotification`;

CREATE TABLE `read_systemnotification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`),
  CONSTRAINT `read_systemnotification_ibfk_1` FOREIGN KEY (`notification_id`) REFERENCES `system_notification` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (1, 2, 1, 'no', '2021-12-17 19:34:46');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (2, 4, 1, 'no', '2021-12-17 20:49:24');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (3, 4, 1, 'no', '2021-12-17 20:49:29');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (4, 4, 1, 'no', '2021-12-17 20:49:30');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (5, 4, 1, 'no', '2021-12-17 20:49:32');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (6, 2, 1, 'no', '2021-12-17 20:49:32');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (7, 2, 1, 'no', '2021-12-17 20:49:34');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (8, 2, 1, 'no', '2021-12-17 20:49:34');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (9, 2, 1, 'no', '2021-12-17 20:49:35');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (10, 4, 1, 'no', '2021-12-17 20:49:35');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (11, 4, 1, 'no', '2021-12-17 20:53:24');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (12, 8, 1, 'no', '2021-12-30 15:23:59');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (13, 10, 1, 'no', '2022-04-02 15:50:24');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (14, 8, 1, 'no', '2022-04-02 15:50:30');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (15, 14, 1, 'no', '2022-04-03 16:03:17');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (16, 10, 1, 'no', '2022-04-03 16:03:25');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (17, 19, 5, 'no', '2022-04-03 16:17:18');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (18, 18, 1, 'no', '2022-04-03 16:17:32');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (19, 23, 5, 'no', '2022-04-03 16:29:36');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (20, 24, 1, 'no', '2022-04-03 16:46:56');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (21, 30, 1, 'no', '2022-04-03 16:48:53');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (22, 43, 5, 'no', '2022-04-03 17:02:18');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (23, 43, 5, 'no', '2022-04-03 17:02:33');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (24, 39, 5, 'no', '2022-04-03 17:03:24');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (25, 43, 5, 'no', '2022-04-03 17:03:26');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (26, 44, 1, 'no', '2022-04-03 17:03:39');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (27, 42, 1, 'no', '2022-04-03 17:03:40');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (28, 40, 1, 'no', '2022-04-03 17:03:41');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (29, 38, 1, 'no', '2022-04-03 17:03:42');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (30, 36, 1, 'no', '2022-04-03 17:03:43');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (31, 35, 1, 'no', '2022-04-03 17:03:44');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (32, 33, 1, 'no', '2022-04-03 17:03:45');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (33, 32, 1, 'no', '2022-04-03 17:03:46');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (34, 29, 1, 'no', '2022-04-03 17:03:51');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (35, 27, 1, 'no', '2022-04-03 17:03:52');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (36, 26, 1, 'no', '2022-04-03 17:03:54');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (37, 22, 1, 'no', '2022-04-03 17:03:56');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (38, 12, 1, 'no', '2022-04-03 17:03:57');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (39, 10, 1, 'no', '2022-04-03 17:03:59');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (40, 46, 1, 'no', '2022-04-03 18:06:27');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (41, 48, 1, 'no', '2022-04-03 18:06:28');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (42, 49, 1, 'no', '2022-04-03 19:12:16');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (43, 6, 1, 'no', '2022-04-03 19:13:07');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (44, 51, 1, 'no', '2022-04-05 10:08:35');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (45, 90, 5, 'no', '2022-05-06 20:51:49');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (46, 90, 5, 'no', '2022-05-06 20:51:52');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (47, 91, 7, 'no', '2022-05-06 20:54:00');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (48, 119, 1, 'no', '2022-07-09 16:44:06');
INSERT INTO `read_systemnotification` (`id`, `notification_id`, `receiver_id`, `is_active`, `date`) VALUES (49, 117, 1, 'no', '2022-07-09 16:44:28');


#
# TABLE STRUCTURE FOR: referral_category
#

DROP TABLE IF EXISTS `referral_category`;

CREATE TABLE `referral_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `referral_category` (`id`, `name`, `is_active`, `created_at`) VALUES (1, 'Referral To 01', 1, '2022-04-19 18:52:19');


#
# TABLE STRUCTURE FOR: referral_commission
#

DROP TABLE IF EXISTS `referral_commission`;

CREATE TABLE `referral_commission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_category_id` int(11) DEFAULT NULL,
  `referral_type_id` int(11) DEFAULT NULL,
  `commission` float DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `referral_category_id` (`referral_category_id`),
  KEY `referral_type_id` (`referral_type_id`),
  CONSTRAINT `referral_commission_ibfk_1` FOREIGN KEY (`referral_category_id`) REFERENCES `referral_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_commission_ibfk_2` FOREIGN KEY (`referral_type_id`) REFERENCES `referral_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

INSERT INTO `referral_commission` (`id`, `referral_category_id`, `referral_type_id`, `commission`, `is_active`, `created_at`) VALUES (1, 1, 1, '2', 1, '2022-04-19 18:53:00');
INSERT INTO `referral_commission` (`id`, `referral_category_id`, `referral_type_id`, `commission`, `is_active`, `created_at`) VALUES (2, 1, 2, '2', 1, '2022-04-19 18:53:00');
INSERT INTO `referral_commission` (`id`, `referral_category_id`, `referral_type_id`, `commission`, `is_active`, `created_at`) VALUES (3, 1, 3, '2', 1, '2022-04-19 18:53:00');
INSERT INTO `referral_commission` (`id`, `referral_category_id`, `referral_type_id`, `commission`, `is_active`, `created_at`) VALUES (4, 1, 4, '2', 1, '2022-04-19 18:53:00');
INSERT INTO `referral_commission` (`id`, `referral_category_id`, `referral_type_id`, `commission`, `is_active`, `created_at`) VALUES (5, 1, 5, '2', 1, '2022-04-19 18:53:00');
INSERT INTO `referral_commission` (`id`, `referral_category_id`, `referral_type_id`, `commission`, `is_active`, `created_at`) VALUES (6, 1, 6, '2', 1, '2022-04-19 18:53:00');
INSERT INTO `referral_commission` (`id`, `referral_category_id`, `referral_type_id`, `commission`, `is_active`, `created_at`) VALUES (7, 1, 7, '2', 1, '2022-04-19 18:53:00');


#
# TABLE STRUCTURE FOR: referral_payment
#

DROP TABLE IF EXISTS `referral_payment`;

CREATE TABLE `referral_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_person_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `referral_type` int(11) DEFAULT NULL,
  `billing_id` int(11) NOT NULL,
  `bill_amount` float(10,2) DEFAULT 0.00,
  `percentage` float(10,2) DEFAULT 0.00,
  `amount` float(10,2) DEFAULT 0.00,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `referral_person_id` (`referral_person_id`),
  KEY `referral_type` (`referral_type`),
  CONSTRAINT `referral_payment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_payment_ibfk_2` FOREIGN KEY (`referral_person_id`) REFERENCES `referral_person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_payment_ibfk_3` FOREIGN KEY (`referral_type`) REFERENCES `referral_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: referral_person
#

DROP TABLE IF EXISTS `referral_person`;

CREATE TABLE `referral_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `person_name` varchar(100) DEFAULT NULL,
  `person_phone` varchar(50) DEFAULT NULL,
  `standard_commission` float(10,2) NOT NULL DEFAULT 0.00,
  `address` varchar(100) DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `referral_category` (`category_id`),
  CONSTRAINT `referral_person_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `referral_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: referral_person_commission
#

DROP TABLE IF EXISTS `referral_person_commission`;

CREATE TABLE `referral_person_commission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_person_id` int(11) DEFAULT NULL,
  `referral_type_id` int(11) DEFAULT NULL,
  `commission` float(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `referral_person_id` (`referral_person_id`),
  KEY `referral_type_id` (`referral_type_id`),
  CONSTRAINT `referral_person_commission_ibfk_1` FOREIGN KEY (`referral_person_id`) REFERENCES `referral_person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referral_person_commission_ibfk_2` FOREIGN KEY (`referral_type_id`) REFERENCES `referral_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: referral_type
#

DROP TABLE IF EXISTS `referral_type`;

CREATE TABLE `referral_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `prefixes_type` varchar(100) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

INSERT INTO `referral_type` (`id`, `name`, `prefixes_type`, `is_active`, `created_at`) VALUES (1, 'opd', 'opd_no', 1, '2021-09-17 02:07:51');
INSERT INTO `referral_type` (`id`, `name`, `prefixes_type`, `is_active`, `created_at`) VALUES (2, 'ipd', 'ipd_no', 1, '2021-09-17 02:07:51');
INSERT INTO `referral_type` (`id`, `name`, `prefixes_type`, `is_active`, `created_at`) VALUES (3, 'pharmacy', 'pharmacy_billing', 1, '2021-09-17 02:07:51');
INSERT INTO `referral_type` (`id`, `name`, `prefixes_type`, `is_active`, `created_at`) VALUES (4, 'pathology', 'pathology_billing', 1, '2021-09-17 02:07:51');
INSERT INTO `referral_type` (`id`, `name`, `prefixes_type`, `is_active`, `created_at`) VALUES (5, 'radiology', 'radiology_billing', 1, '2021-09-17 02:07:51');
INSERT INTO `referral_type` (`id`, `name`, `prefixes_type`, `is_active`, `created_at`) VALUES (6, 'blood_bank', 'blood_bank_billing', 1, '2021-09-17 02:07:51');
INSERT INTO `referral_type` (`id`, `name`, `prefixes_type`, `is_active`, `created_at`) VALUES (7, 'ambulance', 'ambulance_call_billing', 1, '2021-09-17 02:07:51');


#
# TABLE STRUCTURE FOR: roles
#

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `slug` varchar(150) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `is_system` int(1) NOT NULL DEFAULT 0,
  `is_superadmin` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (1, 'Admin', NULL, 0, 1, 0, '2018-12-25 06:19:43');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (2, 'Accountant', NULL, 0, 1, 0, '2018-12-25 06:19:38');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (3, 'Doctor', NULL, 0, 1, 0, '2018-07-21 05:07:36');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (4, 'Pharmacist', NULL, 0, 1, 0, '2018-07-21 05:08:26');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (5, 'Pathologist', NULL, 0, 1, 0, '2018-12-25 06:19:59');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (6, 'Radiologist', NULL, 0, 1, 0, '2018-12-25 06:20:27');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (7, 'Super Admin', NULL, 0, 1, 1, '2018-12-25 06:22:24');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (8, 'Receptionist', NULL, 0, 1, 0, '2018-12-25 06:20:22');
INSERT INTO `roles` (`id`, `name`, `slug`, `is_active`, `is_system`, `is_superadmin`, `created_at`) VALUES (9, 'Nurse', NULL, 0, 1, 0, '2020-12-23 01:58:58');


#
# TABLE STRUCTURE FOR: roles_permissions
#

DROP TABLE IF EXISTS `roles_permissions`;

CREATE TABLE `roles_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `perm_cat_id` int(11) DEFAULT NULL,
  `can_view` int(11) DEFAULT NULL,
  `can_add` int(11) DEFAULT NULL,
  `can_edit` int(11) DEFAULT NULL,
  `can_delete` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2299 DEFAULT CHARSET=utf8;

INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1, 1, 346, 1, 0, 0, 0, '2021-09-15 02:19:21');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2, 1, 80, 1, 1, 1, 1, '2021-09-15 02:31:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (3, 1, 81, 1, 1, 1, 1, '2021-09-15 02:31:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (4, 1, 82, 1, 1, 1, 1, '2021-09-15 02:31:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (5, 1, 83, 1, 1, 1, 1, '2021-09-15 02:31:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (6, 1, 84, 1, 1, 1, 1, '2021-09-15 02:31:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (7, 1, 85, 1, 1, 1, 1, '2021-09-15 02:31:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (8, 1, 204, 1, 1, 1, 1, '2021-09-15 02:22:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (9, 1, 205, 1, 0, 0, 0, '2021-09-15 02:20:15');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (10, 1, 216, 1, 0, 0, 0, '2021-09-15 02:20:15');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (11, 1, 217, 1, 0, 0, 0, '2021-09-15 02:20:15');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (14, 1, 237, 1, 0, 0, 0, '2021-09-15 02:25:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (15, 1, 239, 1, 0, 0, 0, '2021-09-15 02:25:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (16, 1, 214, 1, 1, 1, 1, '2021-09-15 02:35:14');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (17, 1, 215, 1, 1, 1, 1, '2021-09-15 02:35:14');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (18, 1, 240, 1, 0, 1, 0, '2021-09-15 02:35:14');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (19, 1, 242, 1, 0, 1, 0, '2021-09-15 02:35:14');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (36, 1, 48, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (37, 1, 89, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (38, 1, 91, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (39, 1, 178, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (40, 1, 179, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (41, 1, 180, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (42, 1, 181, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (43, 1, 182, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (44, 1, 183, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (45, 1, 184, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (46, 1, 185, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (47, 1, 187, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (48, 1, 188, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (49, 1, 189, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (50, 1, 206, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (51, 1, 207, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (52, 1, 208, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (53, 1, 209, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (54, 1, 210, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (55, 1, 211, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (56, 1, 212, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (57, 1, 213, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (58, 1, 250, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (59, 1, 251, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (60, 1, 253, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (61, 1, 254, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (62, 1, 255, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (63, 1, 256, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (64, 1, 258, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (65, 1, 259, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (66, 1, 265, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (67, 1, 266, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (68, 1, 271, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (69, 1, 272, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (70, 1, 349, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (71, 1, 350, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (72, 1, 351, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (73, 1, 352, 1, 0, 0, 0, '2021-09-15 18:37:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (78, 1, 12, 1, 1, 1, 1, '2021-09-17 21:55:07');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (79, 1, 13, 1, 1, 1, 1, '2021-09-17 21:55:07');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (81, 1, 134, 1, 1, 1, 1, '2021-10-07 04:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (84, 1, 192, 1, 0, 1, 0, '2021-10-07 04:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (105, 1, 140, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (106, 1, 142, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (114, 1, 300, 1, 1, 1, 1, '2021-09-16 22:16:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (117, 1, 309, 1, 0, 1, 0, '2021-09-16 22:16:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (119, 1, 322, 1, 1, 1, 1, '2021-09-16 22:16:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (125, 1, 170, 1, 1, 1, 1, '2021-09-17 19:38:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (127, 1, 201, 1, 0, 1, 0, '2021-09-15 23:45:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (131, 1, 227, 1, 1, 1, 1, '2021-09-17 19:10:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (132, 1, 291, 1, 1, 1, 1, '2021-09-17 19:10:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (133, 1, 292, 1, 1, 1, 1, '2021-09-17 19:10:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (142, 1, 317, 1, 1, 0, 1, '2021-09-15 20:15:33');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (143, 1, 269, 1, 1, 0, 1, '2021-09-15 20:16:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (144, 1, 270, 1, 1, 0, 1, '2021-09-15 20:16:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (149, 1, 54, 1, 0, 1, 0, '2021-10-07 00:37:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (150, 1, 56, 1, 0, 1, 0, '2021-10-07 00:37:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (151, 1, 57, 1, 0, 1, 0, '2021-09-15 20:53:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (152, 1, 58, 1, 0, 1, 0, '2021-09-15 20:53:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (153, 1, 59, 1, 0, 1, 0, '2021-09-15 20:53:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (154, 1, 60, 1, 0, 1, 0, '2021-09-15 20:53:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (155, 1, 126, 1, 0, 0, 0, '2021-09-15 20:53:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (156, 1, 130, 1, 1, 0, 1, '2021-09-15 20:53:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (157, 1, 131, 1, 0, 0, 0, '2021-09-15 20:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (158, 1, 267, 1, 1, 1, 1, '2021-09-15 20:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (159, 1, 274, 1, 0, 0, 0, '2021-09-15 20:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (160, 1, 279, 1, 1, 1, 1, '2021-09-15 20:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (161, 1, 287, 1, 0, 1, 0, '2021-09-15 20:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (162, 1, 288, 1, 0, 1, 0, '2021-09-15 20:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (163, 1, 348, 1, 0, 1, 0, '2021-09-15 20:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (164, 1, 61, 1, 1, 0, 1, '2021-10-07 04:57:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (165, 1, 62, 1, 1, 0, 1, '2021-10-07 04:57:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (166, 1, 63, 1, 1, 0, 1, '2021-10-07 04:57:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (167, 1, 64, 1, 1, 1, 1, '2021-10-07 04:57:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (168, 1, 65, 1, 1, 1, 1, '2021-10-07 04:57:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (169, 1, 66, 1, 1, 1, 1, '2021-10-07 04:57:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (170, 1, 67, 1, 1, 1, 1, '2021-10-07 04:57:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (171, 1, 43, 1, 1, 1, 1, '2021-09-15 21:54:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (172, 1, 44, 1, 0, 0, 0, '2021-09-15 21:53:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (175, 1, 283, 1, 1, 1, 1, '2021-09-17 22:22:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (176, 1, 284, 1, 1, 1, 1, '2021-09-17 22:22:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (177, 1, 285, 1, 1, 1, 1, '2021-09-17 22:22:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (178, 1, 286, 1, 1, 1, 1, '2021-09-17 22:22:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (181, 1, 146, 1, 1, 1, 1, '2021-09-17 02:03:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (182, 1, 148, 1, 1, 1, 1, '2021-09-17 02:03:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (184, 1, 86, 1, 1, 1, 1, '2021-09-17 23:02:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (192, 1, 127, 1, 0, 0, 0, '2021-09-16 00:46:49');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (193, 1, 118, 1, 0, 0, 0, '2021-09-16 00:59:08');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (194, 1, 152, 1, 1, 1, 1, '2021-09-16 23:30:15');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (195, 1, 153, 1, 1, 1, 1, '2021-09-16 19:14:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (197, 1, 354, 1, 0, 1, 0, '2021-09-17 19:42:16');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (199, 1, 261, 1, 1, 1, 1, '2021-09-17 19:42:16');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (200, 1, 262, 1, 1, 1, 1, '2021-09-17 19:42:16');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (201, 1, 315, 1, 1, 0, 1, '2021-09-17 19:42:16');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (202, 1, 244, 1, 0, 1, 0, '2021-09-16 20:29:17');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (221, 1, 138, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (222, 1, 139, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (223, 1, 143, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (224, 1, 144, 1, 1, 0, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (226, 1, 197, 1, 0, 1, 0, '2021-09-17 02:01:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (228, 1, 248, 1, 0, 1, 0, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (229, 1, 301, 1, 0, 0, 0, '2021-09-16 22:16:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (230, 1, 308, 1, 0, 0, 0, '2021-09-16 22:16:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (236, 1, 149, 1, 1, 1, 1, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (237, 1, 175, 1, 1, 1, 1, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (238, 1, 243, 1, 0, 1, 0, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (239, 1, 257, 1, 1, 1, 1, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (243, 1, 314, 1, 1, 0, 1, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (245, 1, 310, 1, 0, 0, 0, '2021-09-16 22:29:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (247, 1, 355, 1, 0, 1, 0, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (248, 1, 260, 1, 1, 1, 1, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (249, 1, 263, 1, 1, 1, 1, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (250, 1, 312, 1, 0, 1, 0, '2021-10-22 00:28:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (254, 1, 135, 1, 1, 1, 1, '2021-10-07 04:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (255, 1, 137, 1, 1, 1, 1, '2021-10-07 04:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (257, 1, 219, 1, 0, 0, 0, '2021-09-17 01:09:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (258, 1, 221, 1, 1, 1, 1, '2021-09-18 00:55:57');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (259, 1, 222, 1, 1, 0, 1, '2021-09-17 01:13:33');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (260, 1, 299, 1, 1, 1, 1, '2021-09-17 01:14:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (261, 1, 303, 1, 1, 1, 1, '2021-09-17 01:17:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (262, 1, 304, 1, 0, 0, 0, '2021-09-17 01:21:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (263, 1, 305, 1, 0, 1, 0, '2021-09-17 01:22:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (264, 1, 306, 1, 0, 0, 0, '2021-09-17 01:22:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (265, 1, 307, 1, 0, 0, 0, '2021-09-17 01:23:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (266, 1, 319, 1, 1, 1, 1, '2021-10-07 05:01:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (274, 1, 220, 1, 1, 1, 1, '2021-09-17 02:02:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (275, 1, 326, 1, 1, 1, 1, '2021-09-17 18:09:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (276, 1, 200, 1, 1, 0, 1, '2021-09-17 18:59:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (277, 1, 225, 1, 1, 1, 1, '2021-09-17 19:10:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (278, 1, 226, 1, 1, 1, 1, '2021-09-17 19:10:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (279, 1, 224, 1, 0, 0, 0, '2021-09-17 19:38:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (280, 1, 313, 1, 1, 0, 1, '2021-09-17 19:39:06');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (281, 1, 171, 1, 1, 1, 1, '2021-09-17 19:46:07');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (282, 1, 353, 1, 0, 1, 0, '2021-09-17 19:46:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (283, 1, 168, 1, 1, 1, 1, '2021-09-17 20:14:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (284, 1, 169, 1, 1, 1, 1, '2021-09-17 20:16:16');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (285, 1, 311, 1, 1, 1, 1, '2021-09-17 20:24:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (286, 1, 246, 1, 1, 1, 1, '2021-09-17 20:26:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (287, 1, 202, 1, 1, 0, 1, '2021-09-17 20:30:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (288, 1, 293, 1, 1, 1, 1, '2021-09-17 20:30:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (289, 1, 302, 1, 1, 0, 1, '2021-09-17 20:30:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (290, 1, 173, 1, 1, 1, 1, '2021-09-17 20:36:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (291, 1, 347, 1, 0, 1, 1, '2021-09-17 20:36:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (292, 1, 273, 1, 0, 1, 0, '2021-09-17 21:43:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (293, 1, 9, 1, 1, 1, 1, '2021-09-17 21:47:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (294, 1, 10, 1, 1, 1, 1, '2021-09-17 21:47:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (295, 1, 176, 1, 1, 1, 1, '2021-09-20 23:45:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (296, 1, 102, 1, 1, 1, 1, '2021-10-07 05:04:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (297, 1, 31, 1, 1, 0, 1, '2021-10-07 00:40:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (298, 1, 32, 1, 1, 1, 1, '2021-09-17 22:47:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (299, 1, 33, 1, 1, 1, 1, '2021-09-17 22:47:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (300, 1, 34, 1, 1, 1, 1, '2021-09-17 22:47:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (301, 1, 35, 1, 1, 1, 1, '2021-09-17 22:47:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (302, 1, 104, 1, 1, 1, 1, '2021-09-17 22:47:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (303, 1, 87, 1, 0, 0, 0, '2021-09-17 23:01:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (304, 1, 88, 1, 1, 1, 0, '2021-09-17 23:33:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (305, 1, 90, 1, 1, 0, 1, '2021-09-17 23:34:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (306, 1, 108, 1, 1, 1, 1, '2021-09-17 23:37:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (307, 1, 109, 1, 1, 0, 1, '2021-09-17 23:39:39');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (308, 1, 110, 1, 1, 1, 1, '2021-10-07 04:56:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (309, 1, 111, 1, 1, 1, 1, '2021-10-07 04:56:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (310, 1, 112, 1, 1, 1, 1, '2021-10-07 04:56:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (311, 1, 249, 1, 1, 1, 1, '2021-10-07 04:56:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (313, 1, 203, 1, 1, 1, 1, '2021-09-17 23:08:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (314, 1, 264, 1, 1, 0, 1, '2021-09-17 23:08:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (315, 1, 289, 1, 1, 1, 1, '2021-09-17 23:08:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (316, 1, 290, 1, 1, 1, 1, '2021-09-17 23:08:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (317, 1, 165, 1, 1, 1, 1, '2021-09-17 23:23:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (318, 1, 166, 1, 1, 1, 1, '2021-09-17 23:23:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (319, 1, 247, 1, 1, 1, 1, '2021-09-17 23:23:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (320, 1, 318, 1, 1, 0, 1, '2021-09-17 23:23:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (324, 2, 237, 1, 0, 0, 0, '2021-09-18 01:01:56');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (327, 2, 135, 1, 1, 1, 0, '2021-10-07 01:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (334, 2, 221, 1, 1, 1, 1, '2021-09-18 01:25:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (335, 2, 222, 1, 1, 0, 1, '2021-09-18 01:26:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (336, 2, 299, 1, 0, 0, 0, '2021-10-07 01:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (337, 2, 303, 1, 0, 0, 0, '2021-10-07 01:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (339, 2, 305, 1, 0, 1, 0, '2021-09-18 01:38:56');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (341, 2, 307, 1, 0, 0, 0, '2021-09-18 01:43:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (343, 2, 320, 1, 0, 0, 0, '2021-09-18 01:44:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (346, 2, 138, 1, 1, 1, 0, '2021-10-07 01:02:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (350, 2, 143, 1, 1, 1, 1, '2021-09-19 23:54:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (351, 2, 144, 1, 1, 0, 1, '2021-09-19 23:54:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (354, 2, 329, 1, 0, 0, 0, '2021-09-18 02:23:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (356, 2, 326, 1, 0, 0, 0, '2021-10-07 05:33:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (357, 3, 132, 1, 1, 1, 1, '2021-09-21 20:39:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (358, 3, 134, 1, 1, 1, 1, '2021-09-19 19:30:16');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (362, 3, 135, 1, 1, 1, 1, '2021-09-19 19:45:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (363, 3, 137, 1, 1, 1, 1, '2021-09-19 19:45:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (364, 3, 192, 1, 0, 1, 0, '2021-09-19 19:46:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (372, 1, 295, 1, 0, 1, 0, '2021-10-07 04:56:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (373, 3, 218, 1, 0, 0, 0, '2021-09-19 21:47:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (374, 3, 219, 1, 0, 0, 0, '2021-09-19 21:48:21');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (375, 3, 221, 1, 1, 1, 1, '2021-09-19 21:48:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (376, 3, 222, 1, 1, 0, 1, '2021-09-19 21:51:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (377, 3, 299, 1, 1, 1, 1, '2021-09-19 21:53:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (378, 3, 303, 1, 1, 1, 1, '2021-09-19 22:05:35');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (379, 2, 139, 1, 1, 1, 0, '2021-10-07 01:02:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (380, 3, 304, 1, 0, 0, 0, '2021-09-19 22:21:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (382, 3, 305, 1, 0, 1, 0, '2021-09-19 22:23:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (384, 2, 198, 1, 0, 0, 0, '2021-09-19 22:24:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (386, 2, 300, 1, 1, 1, 1, '2021-09-19 23:54:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (387, 2, 301, 1, 0, 0, 0, '2021-09-19 22:24:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (388, 2, 308, 1, 0, 0, 0, '2021-09-19 22:24:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (389, 2, 309, 1, 0, 0, 0, '2021-09-19 22:24:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (391, 2, 323, 1, 1, 1, 1, '2021-09-19 23:54:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (392, 2, 324, 1, 1, 1, 1, '2021-09-19 23:54:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (393, 2, 325, 1, 1, 1, 1, '2021-09-19 23:54:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (394, 3, 306, 1, 0, 0, 0, '2021-09-19 22:24:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (395, 3, 307, 1, 0, 0, 0, '2021-09-19 22:26:27');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (396, 3, 319, 1, 1, 1, 1, '2021-09-19 22:27:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (397, 3, 320, 1, 0, 0, 0, '2021-09-19 22:38:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (398, 3, 321, 1, 0, 0, 0, '2021-09-19 22:46:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (399, 3, 138, 1, 1, 1, 1, '2021-09-19 22:47:05');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (400, 3, 139, 1, 1, 1, 1, '2021-09-19 22:50:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (401, 3, 140, 1, 1, 1, 1, '2021-09-19 22:51:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (402, 3, 142, 1, 1, 1, 1, '2021-09-19 22:51:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (403, 3, 143, 1, 1, 1, 1, '2021-09-19 22:51:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (404, 3, 144, 1, 1, 0, 1, '2021-09-19 22:52:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (405, 3, 196, 1, 1, 1, 1, '2021-09-19 22:56:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (406, 3, 197, 1, 0, 1, 0, '2021-09-19 22:57:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (407, 3, 198, 1, 0, 0, 0, '2021-09-19 22:57:21');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (408, 3, 220, 1, 1, 1, 1, '2021-09-19 22:57:21');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (409, 3, 248, 1, 0, 1, 0, '2021-09-19 22:58:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (410, 3, 300, 1, 1, 1, 1, '2021-09-19 22:58:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (411, 3, 301, 1, 0, 0, 0, '2021-09-19 22:59:15');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (412, 3, 308, 1, 0, 0, 0, '2021-09-19 22:59:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (413, 3, 309, 1, 0, 1, 0, '2021-09-19 23:00:17');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (414, 3, 310, 1, 0, 0, 0, '2021-09-19 23:00:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (415, 3, 322, 1, 1, 1, 1, '2021-09-19 23:01:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (416, 3, 323, 1, 1, 1, 1, '2021-09-19 23:02:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (417, 3, 324, 1, 1, 1, 1, '2021-09-19 23:02:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (418, 3, 325, 1, 1, 1, 1, '2021-09-19 23:02:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (419, 3, 326, 1, 1, 1, 1, '2021-09-19 23:03:57');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (420, 3, 327, 1, 0, 0, 0, '2021-09-19 23:10:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (421, 3, 329, 1, 0, 0, 0, '2021-09-19 23:10:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (422, 3, 146, 1, 0, 0, 0, '2021-09-21 21:58:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (424, 2, 327, 1, 0, 0, 0, '2021-09-19 23:14:27');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (425, 3, 236, 1, 1, 1, 0, '2022-04-03 14:13:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (433, 3, 226, 1, 0, 0, 0, '2021-09-20 19:02:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (435, 3, 291, 1, 0, 0, 0, '2021-09-20 19:02:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (436, 3, 292, 1, 0, 0, 0, '2021-09-20 19:02:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (438, 3, 149, 1, 0, 0, 0, '2021-10-07 01:50:27');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (444, 3, 312, 1, 0, 0, 0, '2021-10-07 01:50:27');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (447, 2, 149, 1, 0, 0, 0, '2021-10-07 01:17:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (453, 2, 312, 1, 0, 1, 0, '2021-09-20 00:04:18');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (454, 2, 314, 1, 1, 0, 1, '2021-09-22 19:32:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (455, 2, 355, 1, 0, 1, 0, '2021-09-20 00:04:18');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (456, 3, 152, 1, 0, 0, 0, '2021-10-07 01:50:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (463, 3, 353, 1, 0, 0, 0, '2021-10-07 01:50:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (465, 2, 152, 1, 0, 0, 0, '2021-10-07 01:21:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (466, 2, 153, 1, 0, 0, 0, '2021-10-07 01:22:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (472, 2, 353, 1, 0, 1, 0, '2021-09-20 00:34:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (474, 3, 168, 1, 0, 0, 0, '2021-10-07 01:56:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (475, 2, 146, 1, 0, 0, 0, '2021-10-07 01:12:21');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (476, 2, 148, 1, 0, 0, 0, '2021-10-07 01:12:21');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (478, 2, 200, 1, 0, 0, 0, '2021-10-07 01:14:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (481, 2, 225, 1, 0, 0, 0, '2021-10-07 01:14:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (484, 2, 291, 1, 1, 0, 0, '2021-10-07 05:33:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (485, 2, 292, 1, 1, 0, 0, '2021-10-07 05:33:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (486, 2, 313, 1, 1, 0, 0, '2021-10-07 05:33:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (495, 3, 270, 1, 1, 0, 0, '2022-04-03 14:06:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (496, 2, 168, 1, 0, 0, 0, '2021-10-07 01:24:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (498, 2, 202, 1, 0, 0, 0, '2021-10-07 01:24:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (500, 2, 293, 1, 0, 0, 0, '2021-10-07 01:25:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (501, 2, 302, 1, 0, 0, 0, '2021-10-07 01:25:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (502, 2, 311, 1, 0, 0, 0, '2021-10-07 01:25:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (503, 2, 317, 1, 1, 0, 1, '2021-09-21 02:02:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (504, 3, 102, 1, 1, 1, 1, '2021-09-20 01:26:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (506, 3, 118, 1, 0, 0, 0, '2021-09-20 01:29:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (519, 3, 173, 1, 0, 0, 0, '2021-10-07 01:56:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (520, 3, 347, 1, 0, 0, 0, '2021-10-07 01:56:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (527, 3, 176, 1, 0, 0, 0, '2021-10-07 02:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (530, 3, 289, 1, 0, 0, 0, '2021-10-07 02:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (531, 3, 290, 1, 0, 0, 0, '2021-10-07 02:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (533, 3, 330, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (534, 3, 331, 1, 0, 0, 0, '2021-10-07 05:42:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (535, 3, 332, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (536, 3, 333, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (537, 3, 334, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (538, 3, 335, 1, 0, 0, 0, '2021-10-07 02:00:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (539, 3, 336, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (540, 3, 337, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (541, 3, 338, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (542, 3, 339, 1, 0, 0, 0, '2021-10-07 02:00:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (543, 3, 340, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (544, 3, 341, 1, 0, 0, 0, '2021-09-21 02:32:35');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (545, 3, 342, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (546, 3, 343, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (547, 3, 344, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (548, 3, 345, 1, 0, 0, 0, '2021-09-20 01:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (550, 3, 166, 1, 0, 0, 0, '2021-09-21 01:50:56');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (565, 3, 204, 1, 1, 1, 1, '2021-09-20 18:43:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (566, 3, 205, 1, 0, 0, 0, '2021-09-20 02:08:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (567, 3, 216, 1, 0, 0, 0, '2021-09-20 02:08:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (568, 3, 217, 1, 0, 0, 0, '2021-09-20 02:08:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (573, 3, 214, 1, 1, 1, 1, '2021-09-20 02:18:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (574, 3, 215, 1, 1, 1, 1, '2021-09-20 02:18:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (577, 3, 294, 1, 1, 1, 1, '2021-10-07 05:43:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (578, 3, 295, 1, 0, 1, 0, '2021-09-20 23:39:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (579, 3, 296, 1, 1, 1, 1, '2021-09-20 23:39:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (580, 3, 297, 1, 0, 0, 0, '2021-10-07 05:43:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (581, 3, 298, 1, 0, 0, 0, '2021-10-07 05:43:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (584, 2, 165, 1, 0, 0, 0, '2021-10-07 05:35:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (585, 2, 166, 1, 0, 0, 0, '2021-10-07 01:35:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (594, 2, 204, 1, 1, 1, 1, '2021-09-20 18:35:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (596, 2, 216, 1, 0, 0, 0, '2021-09-20 18:14:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (597, 2, 217, 1, 0, 0, 0, '2021-09-20 18:14:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (607, 2, 294, 1, 1, 1, 1, '2021-09-20 20:46:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (608, 2, 295, 1, 0, 1, 0, '2021-09-20 19:50:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (609, 2, 296, 1, 1, 1, 1, '2021-09-20 20:46:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (610, 2, 297, 1, 0, 1, 0, '2021-09-20 19:50:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (611, 2, 298, 1, 0, 1, 0, '2021-09-20 19:50:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (612, 2, 102, 1, 1, 1, 1, '2021-10-07 01:46:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (614, 2, 304, 1, 0, 0, 0, '2021-09-20 20:11:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (619, 3, 302, 1, 0, 0, 0, '2021-10-07 01:56:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (620, 3, 311, 1, 0, 0, 0, '2021-10-07 01:56:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (624, 3, 269, 1, 1, 0, 0, '2022-04-03 14:06:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (626, 2, 176, 1, 1, 1, 1, '2021-09-20 20:55:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (627, 2, 203, 1, 1, 1, 1, '2021-09-20 20:55:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (629, 2, 289, 1, 1, 1, 1, '2021-09-20 20:55:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (630, 2, 290, 1, 1, 1, 1, '2021-09-20 20:55:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (631, 2, 9, 1, 1, 1, 1, '2021-10-07 01:27:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (632, 2, 10, 1, 1, 1, 1, '2021-10-07 01:27:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (633, 2, 12, 1, 1, 1, 1, '2021-09-20 21:09:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (634, 2, 13, 1, 1, 1, 1, '2021-09-22 19:19:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (639, 2, 330, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (640, 2, 331, 1, 1, 0, 0, '2021-09-20 22:53:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (641, 2, 332, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (642, 2, 333, 1, 1, 0, 0, '2021-09-20 22:53:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (643, 2, 334, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (644, 2, 335, 1, 1, 0, 0, '2021-09-21 01:52:27');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (646, 2, 337, 1, 1, 0, 0, '2021-09-21 19:15:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (647, 2, 338, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (648, 2, 339, 1, 1, 0, 0, '2021-09-21 00:38:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (649, 2, 340, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (650, 2, 341, 1, 1, 0, 0, '2021-09-22 19:19:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (651, 2, 342, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (652, 2, 343, 1, 1, 0, 0, '2021-09-22 19:19:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (653, 2, 344, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (654, 2, 345, 1, 0, 0, 0, '2021-09-20 22:27:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (655, 2, 48, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (658, 2, 178, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (659, 2, 179, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (660, 2, 180, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (661, 2, 181, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (662, 2, 182, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (667, 2, 188, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (668, 2, 189, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (669, 2, 206, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (670, 2, 207, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (671, 2, 208, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (672, 2, 209, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (673, 2, 210, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (675, 2, 212, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (676, 2, 213, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (677, 2, 250, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (678, 2, 251, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (679, 2, 253, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (680, 2, 254, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (681, 2, 255, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (687, 2, 271, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (688, 2, 272, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (689, 2, 349, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (690, 2, 350, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (691, 2, 351, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (692, 2, 352, 1, 0, 0, 0, '2021-09-20 23:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (693, 3, 86, 1, 0, 0, 0, '2021-10-07 02:07:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (695, 2, 43, 1, 1, 1, 1, '2021-09-21 00:07:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (696, 2, 44, 1, 0, 0, 0, '2021-09-20 23:59:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (700, 3, 109, 1, 1, 0, 1, '2021-10-07 02:07:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (703, 2, 27, 1, 1, 0, 1, '2021-09-21 00:22:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (706, 2, 31, 1, 1, 0, 1, '2021-09-21 00:38:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (707, 2, 32, 1, 1, 1, 1, '2021-09-21 00:38:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (708, 2, 33, 1, 1, 1, 1, '2021-09-21 00:38:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (709, 2, 34, 1, 1, 1, 1, '2021-09-21 00:38:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (710, 2, 35, 1, 1, 1, 1, '2021-09-21 00:38:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (711, 2, 104, 1, 1, 1, 1, '2021-09-21 00:38:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (712, 2, 315, 1, 1, 0, 1, '2021-09-22 19:34:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (726, 3, 43, 1, 1, 1, 1, '2021-09-21 01:03:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (727, 3, 44, 1, 0, 0, 0, '2021-09-21 01:03:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (728, 3, 27, 1, 1, 0, 0, '2022-04-03 12:15:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (735, 3, 165, 1, 0, 0, 0, '2021-10-07 02:02:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (750, 3, 267, 1, 1, 1, 1, '2021-09-21 01:47:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (751, 3, 274, 1, 0, 0, 0, '2021-09-21 01:45:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (752, 3, 279, 1, 1, 1, 1, '2021-09-21 01:47:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (757, 2, 86, 1, 1, 1, 1, '2021-09-21 20:06:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (764, 2, 283, 1, 1, 1, 1, '2021-09-22 01:07:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (765, 2, 284, 1, 1, 1, 1, '2021-09-22 01:07:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (766, 2, 285, 1, 1, 1, 1, '2021-09-22 01:07:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (767, 2, 286, 1, 1, 1, 1, '2021-09-22 01:07:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (768, 3, 48, 1, 0, 0, 0, '2021-09-21 02:12:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (771, 3, 178, 1, 0, 0, 0, '2021-09-21 02:12:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (775, 3, 182, 1, 0, 0, 0, '2021-09-21 02:12:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (801, 3, 272, 1, 0, 0, 0, '2021-09-21 02:12:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (806, 2, 88, 1, 0, 0, 0, '2021-10-07 05:36:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (807, 2, 90, 1, 0, 0, 0, '2021-10-07 05:36:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (809, 2, 109, 1, 1, 0, 1, '2021-09-27 06:57:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (814, 2, 249, 1, 1, 1, 1, '2021-09-22 01:43:04');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (816, 2, 310, 1, 0, 0, 0, '2021-09-21 18:00:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (817, 2, 129, 0, 1, 0, 1, '2021-09-22 01:43:04');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (819, 1, 362, 1, 0, 0, 0, '2021-09-21 18:50:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (820, 1, 363, 1, 1, 1, 1, '2021-09-21 19:07:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (821, 1, 364, 1, 0, 0, 0, '2021-09-21 18:59:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (822, 1, 365, 1, 1, 1, 1, '2021-09-21 19:03:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (823, 1, 366, 1, 0, 0, 0, '2021-09-21 18:59:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (826, 2, 132, 1, 1, 1, 0, '2021-10-07 01:01:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (849, 2, 319, 1, 0, 0, 0, '2021-10-07 05:31:49');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (870, 3, 368, 1, 0, 0, 0, '2021-09-21 20:33:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (924, 8, 152, 1, 0, 0, 0, '2021-10-07 04:04:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (927, 4, 270, 1, 0, 0, 0, '2021-10-07 02:27:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (948, 4, 334, 1, 0, 0, 0, '2021-09-21 23:56:07');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (949, 4, 335, 1, 1, 0, 0, '2021-09-30 06:47:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (962, 4, 176, 1, 1, 1, 1, '2021-10-07 05:52:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (963, 4, 203, 1, 1, 1, 1, '2021-10-07 05:52:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (965, 4, 289, 1, 1, 1, 1, '2021-09-30 07:32:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (966, 4, 290, 1, 1, 1, 1, '2021-09-30 07:32:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (983, 4, 216, 1, 0, 0, 0, '2021-09-22 00:25:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (984, 4, 217, 1, 0, 0, 0, '2021-09-22 00:34:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (990, 4, 86, 1, 0, 0, 0, '2021-10-07 02:37:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (995, 4, 109, 1, 1, 0, 1, '2021-10-01 00:27:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1001, 2, 118, 1, 0, 0, 0, '2021-09-22 00:55:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1016, 4, 43, 1, 1, 1, 1, '2021-09-22 01:04:08');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1017, 4, 44, 1, 0, 0, 0, '2021-09-22 01:04:08');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1018, 4, 27, 1, 1, 0, 1, '2021-09-22 01:12:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1060, 4, 179, 1, 0, 0, 0, '2021-09-22 01:51:01');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1099, 2, 336, 1, 0, 0, 0, '2021-09-22 19:19:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1119, 1, 367, 1, 1, 1, 1, '2021-10-07 05:04:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1134, 9, 102, 1, 1, 1, 1, '2021-09-22 20:44:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1136, 9, 132, 1, 1, 1, 0, '2021-12-12 17:52:06');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1137, 9, 134, 1, 0, 0, 0, '2021-10-07 04:18:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1138, 9, 135, 1, 1, 1, 0, '2021-12-12 17:52:06');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1141, 9, 218, 1, 0, 0, 0, '2021-09-22 20:46:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1142, 9, 219, 1, 0, 0, 0, '2021-09-22 20:46:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1145, 9, 299, 1, 1, 1, 1, '2021-09-22 22:31:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1146, 9, 303, 1, 0, 0, 0, '2021-10-07 04:24:16');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1147, 9, 304, 1, 0, 0, 0, '2021-09-22 20:46:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1148, 9, 305, 1, 0, 0, 0, '2021-10-07 04:25:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1150, 9, 307, 1, 0, 0, 0, '2021-09-22 20:46:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1151, 9, 319, 1, 0, 0, 0, '2021-10-07 04:25:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1165, 5, 308, 1, 0, 0, 0, '2021-09-22 20:57:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1175, 5, 329, 1, 0, 0, 0, '2021-09-22 22:14:39');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1188, 1, 53, 1, 1, 0, 0, '2021-09-22 23:24:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1189, 5, 149, 1, 1, 1, 1, '2021-09-22 22:40:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1190, 5, 175, 1, 1, 1, 1, '2021-09-22 22:59:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1191, 5, 243, 1, 0, 1, 0, '2021-09-22 22:59:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1193, 5, 260, 1, 1, 1, 1, '2021-09-22 22:59:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1194, 5, 263, 1, 1, 1, 1, '2021-09-22 22:59:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1195, 5, 312, 1, 0, 1, 0, '2021-09-22 22:59:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1196, 5, 314, 1, 1, 0, 1, '2021-09-22 22:59:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1197, 5, 355, 1, 0, 1, 0, '2021-09-22 22:59:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1204, 9, 138, 1, 0, 0, 0, '2021-10-07 04:51:18');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1205, 9, 139, 1, 0, 0, 0, '2021-10-07 04:51:18');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1206, 9, 140, 1, 1, 1, 1, '2021-10-23 04:56:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1207, 9, 142, 1, 1, 1, 1, '2021-10-23 04:56:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1210, 9, 196, 1, 0, 0, 0, '2021-10-07 04:27:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1212, 9, 198, 1, 0, 0, 0, '2021-09-22 23:19:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1213, 9, 220, 1, 0, 0, 0, '2021-10-07 04:27:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1215, 9, 300, 1, 1, 1, 1, '2021-09-23 01:24:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1216, 9, 301, 1, 0, 0, 0, '2021-09-22 23:19:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1217, 9, 308, 1, 0, 0, 0, '2021-09-22 23:19:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1218, 9, 309, 1, 0, 0, 0, '2021-10-07 04:27:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1220, 9, 322, 1, 1, 1, 1, '2021-09-23 01:24:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1224, 9, 326, 1, 0, 0, 0, '2021-10-07 04:27:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1225, 9, 327, 1, 0, 0, 0, '2021-09-22 23:19:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1226, 9, 329, 1, 0, 0, 0, '2021-09-22 23:19:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1235, 1, 191, 1, 0, 0, 0, '2021-09-22 23:49:17');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1246, 5, 317, 1, 1, 0, 1, '2021-09-23 00:16:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1248, 5, 270, 1, 0, 0, 0, '2021-10-07 03:23:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1250, 5, 102, 1, 1, 1, 1, '2021-09-23 00:32:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1251, 5, 346, 1, 0, 0, 0, '2021-09-23 00:32:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1269, 5, 337, 1, 1, 0, 0, '2021-09-23 01:31:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1278, 5, 236, 1, 0, 0, 0, '2021-10-07 03:26:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1306, 5, 216, 1, 0, 0, 0, '2021-09-23 01:40:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1307, 5, 217, 1, 0, 0, 0, '2021-09-23 01:40:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1317, 5, 86, 1, 0, 0, 0, '2021-10-07 03:29:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1322, 5, 109, 1, 1, 0, 1, '2021-09-23 19:36:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1329, 5, 43, 1, 1, 1, 1, '2021-09-30 00:45:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1330, 5, 44, 1, 0, 0, 0, '2021-09-23 02:12:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1331, 5, 27, 1, 1, 0, 1, '2021-09-23 02:15:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1355, 9, 270, 1, 1, 0, 0, '2021-12-12 17:52:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1358, 9, 236, 1, 1, 1, 0, '2021-12-12 17:48:07');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1370, 5, 158, 1, 0, 0, 0, '2021-09-23 19:44:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1416, 5, 369, 1, 0, 0, 0, '2021-09-23 20:16:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1426, 5, 180, 1, 0, 0, 0, '2021-09-23 20:23:15');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1460, 6, 270, 1, 0, 0, 0, '2021-10-07 03:38:49');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1503, 6, 304, 1, 0, 0, 0, '2021-09-27 00:19:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1509, 6, 319, 1, 0, 0, 0, '2021-10-07 06:03:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1518, 9, 216, 1, 0, 0, 0, '2021-09-27 00:45:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1519, 9, 217, 1, 0, 0, 0, '2021-09-27 00:45:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1579, 2, 155, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1580, 2, 156, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1581, 2, 157, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1582, 2, 158, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1583, 2, 159, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1584, 2, 161, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1585, 2, 162, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1586, 2, 190, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1587, 2, 191, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1588, 2, 238, 1, 0, 0, 0, '2021-09-27 05:41:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1596, 9, 48, 1, 0, 0, 0, '2021-09-27 06:56:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1599, 9, 178, 1, 0, 0, 0, '2021-09-27 06:56:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1603, 9, 182, 1, 0, 0, 0, '2021-09-27 06:56:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1631, 9, 350, 1, 0, 0, 0, '2021-09-27 06:56:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1663, 9, 27, 1, 0, 0, 0, '2021-10-23 04:59:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1664, 9, 43, 1, 1, 1, 1, '2021-09-28 01:25:13');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1665, 9, 44, 1, 0, 0, 0, '2021-09-28 01:20:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1666, 9, 86, 1, 0, 0, 0, '2021-10-07 04:46:07');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1671, 9, 109, 1, 1, 0, 1, '2021-09-28 01:58:50');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1679, 9, 204, 1, 1, 1, 1, '2021-09-28 03:31:04');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1680, 9, 205, 1, 0, 0, 0, '2021-09-28 03:31:04');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1697, 6, 152, 1, 1, 1, 1, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1698, 6, 153, 1, 1, 1, 1, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1699, 6, 171, 1, 1, 1, 1, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1700, 6, 244, 1, 0, 1, 0, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1701, 6, 261, 1, 1, 1, 1, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1702, 6, 262, 1, 1, 1, 1, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1703, 6, 315, 1, 1, 0, 1, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1704, 6, 353, 1, 0, 1, 0, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1705, 6, 354, 1, 0, 1, 0, '2021-09-28 05:21:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1713, 6, 236, 1, 0, 0, 0, '2021-10-07 03:46:01');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1716, 6, 176, 1, 1, 1, 1, '2021-10-07 06:04:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1719, 6, 289, 1, 1, 1, 1, '2021-09-28 06:47:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1720, 6, 290, 1, 1, 1, 1, '2021-09-28 06:47:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1739, 6, 43, 1, 1, 1, 1, '2021-09-28 07:53:01');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1740, 6, 44, 1, 0, 0, 0, '2021-09-28 07:51:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1741, 6, 27, 1, 1, 0, 1, '2021-09-28 07:57:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1742, 6, 118, 1, 0, 0, 0, '2021-09-28 07:59:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1747, 6, 159, 1, 0, 0, 0, '2021-09-28 07:59:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1782, 2, 205, 1, 0, 0, 0, '2021-09-29 03:01:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1823, 6, 338, 1, 0, 0, 0, '2021-09-29 05:47:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1824, 6, 339, 1, 1, 0, 0, '2021-09-29 06:07:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1831, 2, 318, 1, 1, 0, 1, '2021-09-29 06:26:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1838, 6, 181, 1, 0, 0, 0, '2021-09-29 06:27:14');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1872, 6, 102, 1, 1, 1, 1, '2021-09-29 06:31:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1873, 6, 86, 1, 0, 0, 0, '2021-10-07 03:48:51');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1878, 6, 109, 1, 1, 0, 1, '2021-09-29 07:05:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1900, 6, 329, 1, 0, 0, 0, '2021-09-29 07:59:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1906, 5, 370, 1, 0, 0, 0, '2021-09-30 02:11:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1908, 4, 146, 1, 1, 1, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1909, 4, 148, 1, 1, 1, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1910, 4, 170, 1, 1, 1, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1911, 4, 200, 1, 1, 0, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1912, 4, 201, 1, 0, 1, 0, '2021-09-30 05:42:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1913, 4, 224, 1, 0, 0, 0, '2021-09-30 05:36:57');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1914, 4, 225, 1, 1, 0, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1915, 4, 226, 1, 1, 1, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1916, 4, 227, 1, 1, 1, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1917, 4, 291, 1, 1, 1, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1918, 4, 292, 1, 1, 1, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1919, 4, 313, 1, 1, 0, 1, '2021-10-07 02:24:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1931, 4, 236, 1, 0, 0, 0, '2021-10-07 02:30:35');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1934, 4, 118, 1, 0, 0, 0, '2021-10-01 00:51:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1937, 4, 157, 1, 0, 0, 0, '2021-10-01 00:51:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1944, 4, 238, 1, 0, 0, 0, '2021-10-01 00:51:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1957, 4, 256, 1, 0, 0, 0, '2021-10-01 00:54:01');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1976, 4, 102, 1, 1, 1, 1, '2021-10-01 01:33:49');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1977, 4, 274, 1, 0, 0, 0, '2021-10-01 01:36:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1980, 9, 137, 1, 1, 1, 1, '2021-10-23 04:54:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1981, 2, 173, 1, 1, 1, 1, '2021-10-07 05:34:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1982, 2, 347, 1, 0, 1, 1, '2021-10-07 05:34:24');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1995, 1, 196, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1996, 1, 323, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1997, 1, 324, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1998, 1, 325, 1, 1, 1, 1, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (1999, 1, 236, 1, 1, 1, 1, '2021-10-07 00:36:12');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2001, 2, 270, 1, 0, 0, 0, '2021-10-07 01:25:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2002, 2, 236, 1, 1, 1, 0, '2021-10-07 01:28:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2003, 2, 266, 1, 0, 0, 0, '2021-10-07 01:43:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2019, 8, 132, 1, 1, 1, 1, '2021-10-07 04:00:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2020, 8, 135, 1, 1, 1, 1, '2021-10-07 04:00:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2021, 8, 218, 1, 0, 0, 0, '2021-10-07 04:00:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2022, 8, 219, 1, 0, 0, 0, '2021-10-07 04:00:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2023, 8, 221, 1, 1, 1, 1, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2024, 8, 222, 1, 1, 0, 1, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2025, 8, 138, 1, 1, 1, 1, '2021-10-07 04:00:35');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2026, 8, 139, 1, 1, 1, 1, '2021-10-07 04:00:35');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2027, 8, 143, 1, 1, 1, 1, '2021-10-07 06:10:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2028, 8, 144, 1, 1, 0, 1, '2021-10-07 06:10:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2029, 8, 326, 1, 0, 0, 0, '2021-10-07 04:01:17');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2031, 8, 196, 1, 1, 1, 1, '2021-10-07 06:10:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2032, 8, 198, 1, 0, 0, 0, '2021-10-07 04:03:01');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2034, 4, 202, 1, 0, 0, 0, '2021-10-07 04:03:15');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2035, 8, 146, 1, 0, 0, 0, '2021-10-07 04:03:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2036, 8, 148, 1, 0, 0, 0, '2021-10-07 04:03:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2037, 8, 200, 1, 0, 0, 0, '2021-10-07 04:03:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2038, 8, 225, 1, 0, 0, 0, '2021-10-07 04:03:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2039, 8, 149, 1, 0, 0, 0, '2021-10-07 04:04:27');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2042, 8, 168, 1, 0, 0, 0, '2021-10-07 04:04:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2043, 8, 270, 1, 0, 0, 0, '2021-10-07 04:05:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2044, 8, 173, 1, 0, 0, 0, '2021-10-07 04:06:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2045, 8, 347, 1, 0, 0, 0, '2021-10-07 04:06:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2046, 8, 330, 1, 0, 0, 0, '2021-10-07 04:08:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2047, 8, 332, 1, 0, 0, 0, '2021-10-07 04:08:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2048, 8, 334, 1, 0, 0, 0, '2021-10-07 04:08:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2049, 8, 336, 1, 0, 0, 0, '2021-10-07 04:08:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2050, 8, 338, 1, 0, 0, 0, '2021-10-07 04:08:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2051, 8, 340, 1, 0, 0, 0, '2021-10-07 04:08:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2052, 8, 342, 1, 0, 0, 0, '2021-10-07 04:08:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2053, 8, 236, 1, 1, 1, 0, '2021-10-07 04:08:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2055, 8, 165, 1, 1, 1, 1, '2021-10-07 06:12:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2056, 8, 166, 1, 1, 1, 1, '2021-10-07 06:12:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2057, 8, 80, 1, 1, 1, 1, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2058, 8, 81, 1, 1, 1, 1, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2059, 8, 82, 1, 1, 1, 1, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2060, 8, 83, 1, 1, 1, 1, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2061, 8, 84, 1, 1, 1, 1, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2062, 8, 85, 1, 1, 1, 1, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2063, 8, 204, 1, 1, 1, 1, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2064, 8, 205, 1, 0, 0, 0, '2021-10-07 04:11:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2065, 8, 214, 1, 0, 0, 0, '2021-10-07 04:11:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2066, 8, 215, 1, 0, 0, 0, '2021-10-07 04:11:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2067, 8, 86, 1, 0, 0, 0, '2021-10-07 04:11:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2068, 8, 109, 1, 1, 0, 1, '2021-10-07 04:11:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2069, 8, 31, 1, 0, 0, 0, '2021-10-07 04:12:14');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2070, 8, 32, 1, 0, 0, 0, '2021-10-07 04:12:14');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2071, 8, 48, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2072, 8, 89, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2073, 8, 178, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2074, 8, 180, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2075, 8, 181, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2076, 8, 182, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2077, 8, 207, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2078, 8, 208, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2079, 8, 209, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2080, 8, 253, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2081, 8, 254, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2082, 8, 255, 1, 0, 0, 0, '2021-10-07 04:13:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2083, 8, 118, 1, 0, 0, 0, '2021-10-07 04:14:18');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2084, 8, 238, 1, 0, 0, 0, '2021-10-07 04:14:18');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2085, 8, 102, 1, 1, 1, 1, '2021-10-07 04:14:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2086, 9, 321, 1, 0, 0, 0, '2021-10-07 04:25:46');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2093, 1, 132, 1, 1, 1, 1, '2021-10-07 04:54:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2094, 1, 198, 1, 0, 0, 0, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2095, 1, 327, 1, 0, 0, 0, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2096, 1, 329, 1, 0, 0, 0, '2021-10-07 04:55:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2108, 1, 294, 1, 1, 1, 1, '2021-10-07 04:56:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2109, 1, 296, 1, 1, 1, 1, '2021-10-07 04:56:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2110, 1, 297, 1, 0, 0, 0, '2021-10-07 04:56:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2111, 1, 298, 1, 0, 0, 0, '2021-10-07 04:56:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2112, 1, 129, 0, 1, 0, 1, '2021-10-07 04:56:43');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2113, 1, 27, 1, 1, 0, 1, '2021-10-07 04:56:54');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2114, 1, 155, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2115, 1, 156, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2116, 1, 157, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2117, 1, 158, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2118, 1, 159, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2119, 1, 161, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2120, 1, 162, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2121, 1, 190, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2122, 1, 238, 1, 0, 0, 0, '2021-10-07 04:57:41');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2127, 1, 320, 1, 0, 0, 0, '2021-10-07 05:01:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2128, 1, 321, 1, 0, 0, 0, '2021-10-07 05:01:34');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2135, 1, 371, 1, 0, 0, 0, '2021-10-07 05:05:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2150, 1, 280, 1, 1, 1, 1, '2021-10-07 05:29:08');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2151, 1, 369, 1, 0, 0, 0, '2021-10-07 05:30:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2152, 1, 370, 1, 0, 0, 0, '2021-10-07 05:30:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2153, 1, 281, 1, 0, 0, 0, '2021-10-07 05:30:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2154, 1, 282, 1, 0, 0, 0, '2021-10-07 05:30:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2155, 2, 321, 1, 0, 0, 0, '2021-10-07 05:31:49');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2156, 2, 197, 1, 0, 0, 0, '2021-10-07 05:33:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2157, 2, 248, 1, 0, 0, 0, '2021-10-07 05:33:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2158, 2, 264, 1, 1, 0, 1, '2021-10-07 05:34:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2159, 2, 247, 1, 0, 0, 0, '2021-10-07 05:35:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2160, 2, 281, 1, 0, 0, 0, '2021-10-07 05:40:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2161, 2, 282, 1, 0, 0, 0, '2021-10-07 05:40:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2162, 2, 371, 1, 0, 0, 0, '2021-10-07 05:40:26');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2163, 3, 257, 1, 0, 0, 0, '2021-10-07 05:41:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2164, 3, 355, 1, 0, 0, 0, '2021-10-07 05:41:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2165, 3, 153, 1, 0, 0, 0, '2021-10-07 05:41:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2166, 3, 244, 1, 0, 0, 0, '2021-10-07 05:41:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2167, 3, 354, 1, 0, 0, 0, '2021-10-07 05:41:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2168, 3, 202, 1, 0, 0, 0, '2021-10-07 05:42:06');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2169, 3, 246, 1, 0, 0, 0, '2021-10-07 05:42:06');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2170, 3, 237, 1, 0, 0, 0, '2021-10-07 05:43:04');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2171, 3, 240, 1, 0, 1, 0, '2021-10-07 05:43:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2172, 3, 242, 1, 0, 1, 0, '2021-10-07 05:43:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2173, 3, 129, 0, 1, 0, 1, '2021-10-07 05:43:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2174, 3, 183, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2175, 3, 188, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2176, 3, 206, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2177, 3, 207, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2178, 3, 208, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2179, 3, 209, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2180, 3, 211, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2181, 3, 258, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2182, 3, 271, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2183, 3, 350, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2184, 3, 369, 1, 0, 0, 0, '2021-10-07 05:46:03');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2185, 3, 238, 1, 0, 0, 0, '2021-10-07 05:46:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2186, 3, 362, 1, 0, 0, 0, '2021-10-07 05:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2187, 3, 363, 1, 0, 0, 0, '2022-04-03 14:10:11');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2188, 3, 366, 1, 0, 0, 0, '2021-10-07 05:46:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2189, 3, 367, 1, 0, 0, 0, '2022-04-03 14:14:30');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2190, 3, 371, 1, 0, 0, 0, '2021-10-07 05:47:23');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2194, 4, 132, 1, 0, 0, 0, '2021-10-07 05:50:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2195, 4, 138, 1, 0, 0, 0, '2021-10-07 05:51:05');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2196, 4, 264, 1, 1, 0, 1, '2021-10-07 05:52:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2198, 4, 371, 1, 0, 0, 0, '2021-10-07 05:56:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2201, 5, 132, 1, 0, 0, 0, '2021-10-07 05:56:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2202, 5, 304, 1, 0, 0, 0, '2021-10-07 05:56:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2204, 5, 138, 1, 0, 0, 0, '2021-10-07 05:57:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2205, 5, 139, 1, 0, 0, 0, '2021-10-07 05:57:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2206, 5, 307, 1, 0, 0, 0, '2021-10-07 05:57:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2207, 5, 257, 1, 1, 1, 1, '2021-10-07 05:58:05');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2209, 5, 168, 1, 1, 1, 1, '2021-10-07 05:58:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2210, 5, 169, 1, 1, 1, 1, '2021-10-07 05:58:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2211, 5, 202, 1, 1, 0, 1, '2021-10-07 05:58:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2212, 5, 246, 1, 0, 0, 0, '2021-10-07 05:58:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2213, 5, 293, 1, 1, 1, 1, '2021-10-07 05:58:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2214, 5, 302, 1, 1, 0, 1, '2021-10-07 05:58:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2215, 5, 311, 1, 1, 1, 1, '2021-10-07 05:58:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2216, 5, 336, 1, 0, 0, 0, '2021-10-07 05:59:04');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2217, 5, 274, 1, 0, 0, 0, '2021-10-07 06:00:38');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2219, 5, 183, 1, 0, 0, 0, '2021-10-07 06:01:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2220, 5, 211, 1, 0, 0, 0, '2021-10-07 06:01:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2221, 5, 371, 1, 0, 0, 0, '2021-10-07 06:02:10');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2222, 6, 132, 1, 0, 0, 0, '2021-10-07 06:03:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2223, 6, 135, 1, 0, 0, 0, '2021-10-07 06:03:09');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2224, 6, 138, 1, 0, 0, 0, '2021-10-07 06:03:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2225, 6, 139, 1, 0, 0, 0, '2021-10-07 06:03:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2226, 6, 308, 1, 0, 0, 0, '2021-10-07 06:03:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2227, 6, 309, 1, 0, 0, 0, '2021-10-07 06:03:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2228, 6, 203, 1, 1, 1, 1, '2021-10-07 06:04:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2229, 6, 264, 1, 1, 0, 1, '2021-10-07 06:04:58');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2231, 6, 274, 1, 0, 0, 0, '2021-10-07 06:06:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2232, 6, 371, 1, 0, 0, 0, '2021-10-07 06:07:27');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2233, 8, 304, 1, 0, 0, 0, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2234, 8, 305, 1, 0, 1, 0, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2235, 8, 306, 1, 0, 0, 0, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2236, 8, 307, 1, 0, 0, 0, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2237, 8, 319, 1, 1, 1, 1, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2238, 8, 320, 1, 0, 0, 0, '2021-10-07 06:09:52');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2239, 8, 301, 1, 0, 0, 0, '2021-10-07 06:10:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2240, 8, 309, 1, 0, 1, 0, '2021-10-07 06:10:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2241, 8, 310, 1, 0, 0, 0, '2021-10-07 06:10:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2242, 8, 329, 1, 0, 0, 0, '2021-10-07 06:10:36');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2243, 8, 257, 1, 0, 0, 0, '2021-10-07 06:10:57');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2244, 8, 153, 1, 0, 0, 0, '2021-10-07 06:11:07');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2245, 8, 169, 1, 0, 0, 0, '2021-10-07 06:11:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2246, 8, 202, 1, 0, 0, 0, '2021-10-07 06:11:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2247, 8, 302, 1, 0, 0, 0, '2021-10-07 06:11:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2248, 8, 311, 1, 0, 0, 0, '2021-10-07 06:11:37');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2249, 2, 348, 1, 0, 1, 0, '2021-10-07 06:17:44');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2250, 8, 247, 1, 1, 1, 1, '2021-10-07 06:12:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2251, 8, 318, 1, 1, 0, 1, '2021-10-07 06:12:31');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2252, 8, 294, 1, 1, 1, 1, '2021-10-07 06:13:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2253, 8, 295, 1, 0, 1, 0, '2021-10-07 06:13:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2254, 8, 296, 1, 1, 1, 1, '2021-10-07 06:13:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2255, 8, 297, 1, 0, 0, 0, '2021-10-07 06:13:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2256, 8, 298, 1, 0, 0, 0, '2021-10-07 06:13:02');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2257, 2, 56, 1, 0, 0, 0, '2021-10-07 06:13:19');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2258, 8, 43, 1, 1, 1, 1, '2021-10-07 06:13:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2259, 8, 44, 1, 0, 0, 0, '2021-10-07 06:13:22');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2260, 8, 27, 1, 1, 0, 1, '2021-10-07 06:13:28');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2261, 8, 274, 1, 0, 0, 0, '2021-10-07 06:13:45');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2262, 2, 54, 1, 0, 0, 0, '2021-10-07 06:13:47');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2263, 8, 183, 1, 0, 0, 0, '2021-10-07 06:15:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2264, 8, 256, 1, 0, 0, 0, '2021-10-07 06:15:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2265, 8, 258, 1, 0, 0, 0, '2021-10-07 06:15:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2266, 8, 259, 1, 0, 0, 0, '2021-10-07 06:15:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2267, 8, 350, 1, 0, 0, 0, '2021-10-07 06:15:00');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2268, 8, 162, 1, 0, 0, 0, '2021-10-07 06:15:18');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2269, 8, 371, 1, 0, 0, 0, '2021-10-07 06:15:32');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2271, 9, 274, 1, 0, 0, 0, '2021-10-07 06:19:59');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2272, 9, 118, 1, 0, 0, 0, '2021-10-07 06:20:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2273, 9, 238, 1, 0, 0, 0, '2021-10-07 06:20:29');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2274, 9, 371, 1, 0, 0, 0, '2021-10-07 06:20:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2275, 1, 218, 1, 0, 0, 0, '2021-10-07 06:20:53');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2276, 1, 330, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2277, 1, 331, 1, 1, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2278, 1, 332, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2279, 1, 333, 1, 1, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2280, 1, 334, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2281, 1, 335, 1, 1, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2282, 1, 336, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2283, 1, 337, 1, 1, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2284, 1, 338, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2285, 1, 339, 1, 1, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2286, 1, 340, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2287, 1, 341, 1, 1, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2288, 1, 342, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2289, 1, 343, 1, 1, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2290, 1, 344, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2291, 1, 345, 1, 0, 0, 0, '2021-10-22 00:27:48');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2292, 1, 372, 1, NULL, NULL, NULL, '2021-10-29 07:41:42');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2293, 1, 373, 1, NULL, NULL, NULL, '2021-10-29 07:42:20');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2294, 1, 374, 1, 1, 1, 1, '2021-10-29 07:45:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2295, 1, 375, 1, 1, 1, 1, '2021-10-29 07:45:25');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2296, 9, 269, 1, 1, 0, 0, '2021-12-12 17:52:40');
INSERT INTO `roles_permissions` (`id`, `role_id`, `perm_cat_id`, `can_view`, `can_add`, `can_edit`, `can_delete`, `created_at`) VALUES (2298, 3, 239, 1, 0, 0, 0, '2022-04-03 13:58:34');


#
# TABLE STRUCTURE FOR: sch_settings
#

DROP TABLE IF EXISTS `sch_settings`;

CREATE TABLE `sch_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `start_month` varchar(100) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `languages` varchar(255) NOT NULL DEFAULT '["4"]',
  `dise_code` varchar(50) DEFAULT NULL,
  `date_format` varchar(50) NOT NULL,
  `time_format` varchar(20) DEFAULT '24-hour',
  `currency` varchar(50) NOT NULL,
  `currency_symbol` varchar(50) NOT NULL,
  `is_rtl` varchar(10) DEFAULT 'disabled',
  `timezone` varchar(30) DEFAULT 'UTC',
  `image` varchar(100) DEFAULT NULL,
  `mini_logo` varchar(200) NOT NULL,
  `theme` varchar(200) NOT NULL DEFAULT 'default.jpg',
  `credit_limit` varchar(255) DEFAULT NULL,
  `opd_record_month` varchar(50) DEFAULT NULL,
  `is_active` varchar(255) DEFAULT 'no',
  `cron_secret_key` varchar(100) NOT NULL,
  `doctor_restriction` varchar(100) NOT NULL,
  `superadmin_restriction` varchar(200) NOT NULL,
  `patient_panel` varchar(50) NOT NULL,
  `mobile_api_url` varchar(200) NOT NULL,
  `app_primary_color_code` varchar(50) NOT NULL,
  `app_secondary_color_code` varchar(50) NOT NULL,
  `app_logo` varchar(200) NOT NULL,
  `zoom_api_key` varchar(200) NOT NULL,
  `zoom_api_secret` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `lang_id` (`lang_id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `sch_settings` (`id`, `name`, `email`, `phone`, `address`, `start_month`, `session_id`, `lang_id`, `languages`, `dise_code`, `date_format`, `time_format`, `currency`, `currency_symbol`, `is_rtl`, `timezone`, `image`, `mini_logo`, `theme`, `credit_limit`, `opd_record_month`, `is_active`, `cron_secret_key`, `doctor_restriction`, `superadmin_restriction`, `patient_panel`, `mobile_api_url`, `app_primary_color_code`, `app_secondary_color_code`, `app_logo`, `zoom_api_key`, `zoom_api_secret`, `created_at`) VALUES (1, 'MERQ-EMR', 'emr@merqconsultancy.org', '+251912345678', 'Addis Ababa', '', NULL, 4, '[\"4\",\"3\"]', 'MERQ-EMR-0001', 'm/d/Y', '24-hour', 'ETB', 'Birr', 'disabled', 'Africa/Addis_Ababa', '1.png', '1mini_logo.png', 'blue.jpg', '20000', '1', 'no', '', 'disabled', 'enabled', 'enabled', 'https://momonahealthcare.merqconsultancy.org/api/', '#424242', '#eeeeee', '1app_logo.png', '', '', '2022-07-23 11:18:51');


#
# TABLE STRUCTURE FOR: send_notification
#

DROP TABLE IF EXISTS `send_notification`;

CREATE TABLE `send_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `message` text DEFAULT NULL,
  `visible_staff` varchar(10) NOT NULL DEFAULT 'no',
  `visible_patient` varchar(10) NOT NULL DEFAULT 'no',
  `created_by` varchar(60) DEFAULT NULL,
  `created_id` int(11) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `created_id` (`created_id`),
  CONSTRAINT `send_notification_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `send_notification` (`id`, `title`, `publish_date`, `date`, `message`, `visible_staff`, `visible_patient`, `created_by`, `created_id`, `is_active`, `created_at`) VALUES (1, 'Welcome to MERQ EMR', '2022-04-03', '2022-04-03', '<p>Welcome to <u><b>MERQ EMR</b></u> the all in one and <i><u>Your #1 Health Companion System!</u></i><br></p><br><br><br><br>', 'Yes', 'No', 'admin', 1, 'no', '2022-04-03 15:02:24');


#
# TABLE STRUCTURE FOR: shift_details
#

DROP TABLE IF EXISTS `shift_details`;

CREATE TABLE `shift_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `consult_duration` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `shift_details_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shift_details_ibfk_2` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `shift_details` (`id`, `staff_id`, `consult_duration`, `charge_id`, `created_at`) VALUES (1, 5, 15, 3, '2022-05-06 15:17:24');


#
# TABLE STRUCTURE FOR: sms_config
#

DROP TABLE IF EXISTS `sms_config`;

CREATE TABLE `sms_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `api_id` varchar(100) NOT NULL,
  `authkey` varchar(100) NOT NULL,
  `senderid` varchar(100) NOT NULL,
  `contact` text DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `url` varchar(150) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  `is_active` varchar(10) DEFAULT 'disabled',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `sms_config` (`id`, `type`, `name`, `api_id`, `authkey`, `senderid`, `contact`, `username`, `url`, `password`, `is_active`, `created_at`) VALUES (1, 'custom', 'MERQSMS[EthioTelecom]', 'ZXVtcDI1MTY6WlNlTmNXa0c=', '843cd4a7d2mshb5bea2e451fdaeep124e6bjsn7d469f95374d', '', '+420778467091', 'eump2516', 'https://rest-api.d7networks.com/secure/send', 'ZSeNcWkG', 'disabled', '2022-07-09 13:16:33');
INSERT INTO `sms_config` (`id`, `type`, `name`, `api_id`, `authkey`, `senderid`, `contact`, `username`, `url`, `password`, `is_active`, `created_at`) VALUES (2, 'twilio', '', 'AC2c8f353fc0a8e4961d54b9ef04cf35f1', '', '', '+17438004497', NULL, NULL, '276c4cdb2d82a7dacbbe0680afa5c036', 'enabled', '2022-05-03 16:50:04');


#
# TABLE STRUCTURE FOR: source
#

DROP TABLE IF EXISTS `source`;

CREATE TABLE `source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: specialist
#

DROP TABLE IF EXISTS `specialist`;

CREATE TABLE `specialist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `specialist_name` varchar(200) NOT NULL,
  `is_active` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `specialist` (`id`, `specialist_name`, `is_active`, `created_at`) VALUES (1, 'Pediatrics', 'yes', '2022-04-03 11:55:50');
INSERT INTO `specialist` (`id`, `specialist_name`, `is_active`, `created_at`) VALUES (2, 'Maternal Health Specialization', 'yes', '2022-04-03 12:00:01');


#
# TABLE STRUCTURE FOR: staff
#

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(200) DEFAULT NULL,
  `lang_id` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `staff_designation_id` int(11) DEFAULT NULL,
  `specialist` varchar(200) NOT NULL,
  `qualification` varchar(200) NOT NULL,
  `work_exp` varchar(200) NOT NULL,
  `specialization` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `surname` varchar(200) NOT NULL,
  `father_name` varchar(200) NOT NULL,
  `mother_name` varchar(200) NOT NULL,
  `contact_no` varchar(200) NOT NULL,
  `emergency_contact_no` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `dob` date DEFAULT NULL,
  `marital_status` varchar(100) NOT NULL,
  `date_of_joining` date DEFAULT NULL,
  `date_of_leaving` date DEFAULT NULL,
  `local_address` varchar(300) NOT NULL,
  `permanent_address` varchar(200) NOT NULL,
  `note` varchar(200) NOT NULL,
  `image` varchar(200) NOT NULL,
  `password` varchar(250) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `blood_group` varchar(100) NOT NULL,
  `account_title` varchar(200) NOT NULL,
  `bank_account_no` varchar(200) NOT NULL,
  `bank_name` varchar(200) NOT NULL,
  `ifsc_code` varchar(200) NOT NULL,
  `bank_branch` varchar(100) NOT NULL,
  `payscale` varchar(200) NOT NULL,
  `basic_salary` varchar(200) NOT NULL,
  `epf_no` varchar(200) NOT NULL,
  `contract_type` varchar(100) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `facebook` varchar(200) NOT NULL,
  `twitter` varchar(200) NOT NULL,
  `linkedin` varchar(200) NOT NULL,
  `instagram` varchar(200) NOT NULL,
  `resume` varchar(200) NOT NULL,
  `joining_letter` varchar(200) NOT NULL,
  `resignation_letter` varchar(200) NOT NULL,
  `other_document_name` varchar(200) NOT NULL,
  `other_document_file` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `verification_code` varchar(100) NOT NULL,
  `zoom_api_key` varchar(100) NOT NULL,
  `zoom_api_secret` varchar(100) NOT NULL,
  `pan_number` varchar(30) NOT NULL,
  `identification_number` varchar(30) NOT NULL,
  `local_identification_number` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

INSERT INTO `staff` (`id`, `employee_id`, `lang_id`, `department_id`, `staff_designation_id`, `specialist`, `qualification`, `work_exp`, `specialization`, `name`, `surname`, `father_name`, `mother_name`, `contact_no`, `emergency_contact_no`, `email`, `dob`, `marital_status`, `date_of_joining`, `date_of_leaving`, `local_address`, `permanent_address`, `note`, `image`, `password`, `gender`, `blood_group`, `account_title`, `bank_account_no`, `bank_name`, `ifsc_code`, `bank_branch`, `payscale`, `basic_salary`, `epf_no`, `contract_type`, `shift`, `location`, `facebook`, `twitter`, `linkedin`, `instagram`, `resume`, `joining_letter`, `resignation_letter`, `other_document_name`, `other_document_file`, `user_id`, `is_active`, `verification_code`, `zoom_api_key`, `zoom_api_secret`, `pan_number`, `identification_number`, `local_identification_number`, `created_at`) VALUES (1, '9001', 4, NULL, NULL, '', '', '', '', 'Super Admin', '', '', '', '', '', 'administrator@merqconsultancy.org', NULL, '', NULL, NULL, '', '', '', '', '$2y$10$a9yDeGTqL9ASGzr4XWUQB.vx5qU4tc14ulS8OGUL0OIOf6/.g.Do.', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 1, '', '', '', '', '', '', '2021-12-12 12:51:55');
INSERT INTO `staff` (`id`, `employee_id`, `lang_id`, `department_id`, `staff_designation_id`, `specialist`, `qualification`, `work_exp`, `specialization`, `name`, `surname`, `father_name`, `mother_name`, `contact_no`, `emergency_contact_no`, `email`, `dob`, `marital_status`, `date_of_joining`, `date_of_leaving`, `local_address`, `permanent_address`, `note`, `image`, `password`, `gender`, `blood_group`, `account_title`, `bank_account_no`, `bank_name`, `ifsc_code`, `bank_branch`, `payscale`, `basic_salary`, `epf_no`, `contract_type`, `shift`, `location`, `facebook`, `twitter`, `linkedin`, `instagram`, `resume`, `joining_letter`, `resignation_letter`, `other_document_name`, `other_document_file`, `user_id`, `is_active`, `verification_code`, `zoom_api_key`, `zoom_api_secret`, `pan_number`, `identification_number`, `local_identification_number`, `created_at`) VALUES (2, 'MERQ-EMR-ID001', 0, 0, 0, '', '', '', '', 'Michael', 'Teferra', 'Kifle', 'A', '', '', 'michaelktd@merqconsultancy.org', '1990-07-09', 'Single', NULL, NULL, '', '', '', '', '$2y$10$ozJgIgv4.tyPIA1roW13m.URA72dVmoo6dmi38j.zSFGkJd4ExDYG', 'Male', 'AB-', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 1, '', '', '', '', '', '', '2021-12-12 15:12:48');
INSERT INTO `staff` (`id`, `employee_id`, `lang_id`, `department_id`, `staff_designation_id`, `specialist`, `qualification`, `work_exp`, `specialization`, `name`, `surname`, `father_name`, `mother_name`, `contact_no`, `emergency_contact_no`, `email`, `dob`, `marital_status`, `date_of_joining`, `date_of_leaving`, `local_address`, `permanent_address`, `note`, `image`, `password`, `gender`, `blood_group`, `account_title`, `bank_account_no`, `bank_name`, `ifsc_code`, `bank_branch`, `payscale`, `basic_salary`, `epf_no`, `contract_type`, `shift`, `location`, `facebook`, `twitter`, `linkedin`, `instagram`, `resume`, `joining_letter`, `resignation_letter`, `other_document_name`, `other_document_file`, `user_id`, `is_active`, `verification_code`, `zoom_api_key`, `zoom_api_secret`, `pan_number`, `identification_number`, `local_identification_number`, `created_at`) VALUES (3, 'MERQ-EMR-HEW001', 0, 1, 0, '', '', '', '', 'MERQ', 'HEW', '', '', '', '', 'michaelktd7@gmail.com', '1992-07-09', 'Single', NULL, NULL, '', '', '', '', '$2y$10$RkAXYOYovaDJPWYULVLuE./buUsopdpKaB.Jjl.aU/ohJs63wx9o.', 'Female', 'O-', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 1, '', '', '', '', '', '', '2021-12-12 17:41:41');
INSERT INTO `staff` (`id`, `employee_id`, `lang_id`, `department_id`, `staff_designation_id`, `specialist`, `qualification`, `work_exp`, `specialization`, `name`, `surname`, `father_name`, `mother_name`, `contact_no`, `emergency_contact_no`, `email`, `dob`, `marital_status`, `date_of_joining`, `date_of_leaving`, `local_address`, `permanent_address`, `note`, `image`, `password`, `gender`, `blood_group`, `account_title`, `bank_account_no`, `bank_name`, `ifsc_code`, `bank_branch`, `payscale`, `basic_salary`, `epf_no`, `contract_type`, `shift`, `location`, `facebook`, `twitter`, `linkedin`, `instagram`, `resume`, `joining_letter`, `resignation_letter`, `other_document_name`, `other_document_file`, `user_id`, `is_active`, `verification_code`, `zoom_api_key`, `zoom_api_secret`, `pan_number`, `identification_number`, `local_identification_number`, `created_at`) VALUES (4, 'MERQ-HEW-DOC0001', 0, 0, 0, '', '', '', '', 'Mike', '', '', '', '', '', 'mikeintoshsys@gmail.com', '1990-07-09', '', NULL, NULL, '', '', '', '', '$2y$10$kl5q0CVUmEP5FYjggdAQZ.xeRDMLGNoaY1swiQdfKGYCKIpNoJrL2', 'Male', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 1, '', '', '', '', '', '', '2021-12-17 16:58:22');
INSERT INTO `staff` (`id`, `employee_id`, `lang_id`, `department_id`, `staff_designation_id`, `specialist`, `qualification`, `work_exp`, `specialization`, `name`, `surname`, `father_name`, `mother_name`, `contact_no`, `emergency_contact_no`, `email`, `dob`, `marital_status`, `date_of_joining`, `date_of_leaving`, `local_address`, `permanent_address`, `note`, `image`, `password`, `gender`, `blood_group`, `account_title`, `bank_account_no`, `bank_name`, `ifsc_code`, `bank_branch`, `payscale`, `basic_salary`, `epf_no`, `contract_type`, `shift`, `location`, `facebook`, `twitter`, `linkedin`, `instagram`, `resume`, `joining_letter`, `resignation_letter`, `other_document_name`, `other_document_file`, `user_id`, `is_active`, `verification_code`, `zoom_api_key`, `zoom_api_secret`, `pan_number`, `identification_number`, `local_identification_number`, `created_at`) VALUES (5, 'MERQ EMR 01', 4, 3, 2, '1,2', '', '', '', 'Hanibal', 'Kassahun', '', 'A', '', '', 'michaelktd@gmail.com', '1990-01-30', 'Married', NULL, NULL, '', '', '', '', '$2y$10$q3Vd58zELXKP.mzk3Toi8OZTpF3yk8fZwebDm1VrAoRSJBdfUBhu.', 'Male', 'O+', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Other Document', '', 0, 1, '', 'BGE4yvYSQEC5MyxaptgQJQ', 'eJDdilXOy5qotAAoEORASssonfreMZejqj1l', '', '', '', '2022-04-03 12:02:53');
INSERT INTO `staff` (`id`, `employee_id`, `lang_id`, `department_id`, `staff_designation_id`, `specialist`, `qualification`, `work_exp`, `specialization`, `name`, `surname`, `father_name`, `mother_name`, `contact_no`, `emergency_contact_no`, `email`, `dob`, `marital_status`, `date_of_joining`, `date_of_leaving`, `local_address`, `permanent_address`, `note`, `image`, `password`, `gender`, `blood_group`, `account_title`, `bank_account_no`, `bank_name`, `ifsc_code`, `bank_branch`, `payscale`, `basic_salary`, `epf_no`, `contract_type`, `shift`, `location`, `facebook`, `twitter`, `linkedin`, `instagram`, `resume`, `joining_letter`, `resignation_letter`, `other_document_name`, `other_document_file`, `user_id`, `is_active`, `verification_code`, `zoom_api_key`, `zoom_api_secret`, `pan_number`, `identification_number`, `local_identification_number`, `created_at`) VALUES (6, 'MERQ Staff -001', 0, 0, 2, '', '', '', '', 'Helen', 'Ketema', '', '', '', '', 'merqsys@gmail.com', '2000-04-04', 'Single', NULL, NULL, '', '', '', '', '$2y$10$HK5l39zUY9tSnUpiYtOvD.OMtW2iatYD190PmoFvuMB7jWVrOH2Ru', 'Female', 'O-', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 1, '', '', '', '', '', '', '2022-04-03 14:29:48');
INSERT INTO `staff` (`id`, `employee_id`, `lang_id`, `department_id`, `staff_designation_id`, `specialist`, `qualification`, `work_exp`, `specialization`, `name`, `surname`, `father_name`, `mother_name`, `contact_no`, `emergency_contact_no`, `email`, `dob`, `marital_status`, `date_of_joining`, `date_of_leaving`, `local_address`, `permanent_address`, `note`, `image`, `password`, `gender`, `blood_group`, `account_title`, `bank_account_no`, `bank_name`, `ifsc_code`, `bank_branch`, `payscale`, `basic_salary`, `epf_no`, `contract_type`, `shift`, `location`, `facebook`, `twitter`, `linkedin`, `instagram`, `resume`, `joining_letter`, `resignation_letter`, `other_document_name`, `other_document_file`, `user_id`, `is_active`, `verification_code`, `zoom_api_key`, `zoom_api_secret`, `pan_number`, `identification_number`, `local_identification_number`, `created_at`) VALUES (7, 'MERQ-EMR 0012', 0, 0, 1, '', '', '', '', 'Hewan', 'Ayalew', 'Belete', '', '', '', 'merqerp@gmail.com', '1994-06-21', 'Single', NULL, NULL, '', '', '', '', '$2y$10$aeepyYKSDj2UTcPU0cK1XeEuYuI1lRTfC7J8uC6Fx7THwYXQ2ckjm', 'Female', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 1, '', '', '', '', '', '', '2022-05-06 17:48:50');


#
# TABLE STRUCTURE FOR: staff_attendance
#

DROP TABLE IF EXISTS `staff_attendance`;

CREATE TABLE `staff_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `staff_attendance_type_id` int(11) DEFAULT NULL,
  `remark` varchar(200) NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `staff_attendance_type_id` (`staff_attendance_type_id`),
  CONSTRAINT `staff_attendance_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_attendance_ibfk_2` FOREIGN KEY (`staff_attendance_type_id`) REFERENCES `staff_attendance_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: staff_attendance_type
#

DROP TABLE IF EXISTS `staff_attendance_type`;

CREATE TABLE `staff_attendance_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `key_value` varchar(200) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO `staff_attendance_type` (`id`, `type`, `key_value`, `is_active`, `created_at`) VALUES (1, 'Present', '<b class=\"text text-success\">P</b>', 'yes', '0000-00-00 00:00:00');
INSERT INTO `staff_attendance_type` (`id`, `type`, `key_value`, `is_active`, `created_at`) VALUES (2, 'Late', '<b class=\"text text-warning\">L</b>', 'yes', '0000-00-00 00:00:00');
INSERT INTO `staff_attendance_type` (`id`, `type`, `key_value`, `is_active`, `created_at`) VALUES (3, 'Absent', '<b class=\"text text-danger\">A</b>', 'yes', '0000-00-00 00:00:00');
INSERT INTO `staff_attendance_type` (`id`, `type`, `key_value`, `is_active`, `created_at`) VALUES (4, 'Half Day', '<b class=\"text text-warning\">F</b>', 'yes', '2018-05-06 20:26:16');
INSERT INTO `staff_attendance_type` (`id`, `type`, `key_value`, `is_active`, `created_at`) VALUES (5, 'Holiday', 'H', 'yes', '0000-00-00 00:00:00');


#
# TABLE STRUCTURE FOR: staff_designation
#

DROP TABLE IF EXISTS `staff_designation`;

CREATE TABLE `staff_designation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `designation` varchar(200) NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `staff_designation` (`id`, `designation`, `is_active`, `created_at`) VALUES (1, 'Internal', 'yes', '2022-04-03 11:56:36');
INSERT INTO `staff_designation` (`id`, `designation`, `is_active`, `created_at`) VALUES (2, 'Main Ward', 'yes', '2022-04-03 12:00:16');


#
# TABLE STRUCTURE FOR: staff_id_card
#

DROP TABLE IF EXISTS `staff_id_card`;

CREATE TABLE `staff_id_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `hospital_name` varchar(255) NOT NULL,
  `hospital_address` varchar(255) NOT NULL,
  `background` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `sign_image` varchar(100) NOT NULL,
  `header_color` varchar(100) NOT NULL,
  `enable_staff_role` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_id` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_department` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_designation` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_fathers_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_mothers_name` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_date_of_joining` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_permanent_address` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_dob` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `enable_staff_phone` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `status` tinyint(1) NOT NULL COMMENT '0=disable,1=enable',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `staff_id_card` (`id`, `title`, `hospital_name`, `hospital_address`, `background`, `logo`, `sign_image`, `header_color`, `enable_staff_role`, `enable_staff_id`, `enable_staff_department`, `enable_designation`, `enable_name`, `enable_fathers_name`, `enable_mothers_name`, `enable_date_of_joining`, `enable_permanent_address`, `enable_staff_dob`, `enable_staff_phone`, `status`, `created_at`) VALUES (2, 'Staff ID Card', 'MERQ-EMR Hospital Name', 'Addis Ababa', 'background2.png', 'logo2.png', 'signature2.png', '#071d53', 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2021-12-17 16:27:46');


#
# TABLE STRUCTURE FOR: staff_leave_details
#

DROP TABLE IF EXISTS `staff_leave_details`;

CREATE TABLE `staff_leave_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `leave_type_id` int(11) DEFAULT NULL,
  `alloted_leave` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `leave_type_id` (`leave_type_id`),
  CONSTRAINT `staff_leave_details_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_leave_details_ibfk_2` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: staff_leave_request
#

DROP TABLE IF EXISTS `staff_leave_request`;

CREATE TABLE `staff_leave_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `leave_type_id` int(11) DEFAULT NULL,
  `leave_from` date NOT NULL,
  `leave_to` date NOT NULL,
  `leave_days` int(11) NOT NULL,
  `employee_remark` varchar(200) NOT NULL,
  `admin_remark` varchar(200) NOT NULL,
  `status` varchar(100) NOT NULL,
  `applied_by` int(11) DEFAULT NULL,
  `status_updated_by` int(11) DEFAULT NULL,
  `document_file` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `leave_type_id` (`leave_type_id`),
  KEY `applied_by` (`applied_by`),
  CONSTRAINT `staff_leave_request_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_leave_request_ibfk_2` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_leave_request_ibfk_3` FOREIGN KEY (`applied_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: staff_payroll
#

DROP TABLE IF EXISTS `staff_payroll`;

CREATE TABLE `staff_payroll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basic_salary` float(10,2) NOT NULL,
  `pay_scale` int(200) NOT NULL,
  `grade` varchar(50) NOT NULL,
  `is_active` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: staff_payslip
#

DROP TABLE IF EXISTS `staff_payslip`;

CREATE TABLE `staff_payslip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `basic` float(10,2) NOT NULL,
  `total_allowance` float(10,2) NOT NULL,
  `total_deduction` float(10,2) NOT NULL,
  `leave_deduction` int(11) NOT NULL,
  `tax` float(10,2) NOT NULL DEFAULT 0.00,
  `net_salary` float(10,2) NOT NULL,
  `status` varchar(100) NOT NULL,
  `month` varchar(200) NOT NULL,
  `year` varchar(200) NOT NULL,
  `cheque_no` varchar(250) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `attachment` varchar(250) DEFAULT NULL,
  `attachment_name` text DEFAULT NULL,
  `payment_mode` varchar(200) NOT NULL,
  `payment_date` date NOT NULL,
  `remark` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `generated_by` (`generated_by`),
  CONSTRAINT `staff_payslip_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_payslip_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: staff_roles
#

DROP TABLE IF EXISTS `staff_roles`;

CREATE TABLE `staff_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `staff_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_roles_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

INSERT INTO `staff_roles` (`id`, `role_id`, `staff_id`, `is_active`, `created_at`) VALUES (1, 7, 1, 0, '2021-12-12 12:51:55');
INSERT INTO `staff_roles` (`id`, `role_id`, `staff_id`, `is_active`, `created_at`) VALUES (2, 1, 2, 0, '2021-12-12 15:12:48');
INSERT INTO `staff_roles` (`id`, `role_id`, `staff_id`, `is_active`, `created_at`) VALUES (3, 9, 3, 0, '2021-12-12 17:41:41');
INSERT INTO `staff_roles` (`id`, `role_id`, `staff_id`, `is_active`, `created_at`) VALUES (4, 3, 4, 0, '2021-12-17 16:58:22');
INSERT INTO `staff_roles` (`id`, `role_id`, `staff_id`, `is_active`, `created_at`) VALUES (5, 3, 5, 0, '2022-04-03 12:02:54');
INSERT INTO `staff_roles` (`id`, `role_id`, `staff_id`, `is_active`, `created_at`) VALUES (6, 8, 6, 0, '2022-04-03 14:29:48');
INSERT INTO `staff_roles` (`id`, `role_id`, `staff_id`, `is_active`, `created_at`) VALUES (7, 4, 7, 0, '2022-05-06 17:48:50');


#
# TABLE STRUCTURE FOR: staff_timeline
#

DROP TABLE IF EXISTS `staff_timeline`;

CREATE TABLE `staff_timeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `timeline_date` date NOT NULL,
  `description` text DEFAULT NULL,
  `document` varchar(200) NOT NULL,
  `status` varchar(10) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `staff_timeline_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: supplier_bill_basic
#

DROP TABLE IF EXISTS `supplier_bill_basic`;

CREATE TABLE `supplier_bill_basic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `file` varchar(200) NOT NULL,
  `total` float(10,2) NOT NULL,
  `tax` float(10,2) NOT NULL,
  `discount` float(10,2) NOT NULL,
  `net_amount` float(10,2) NOT NULL,
  `note` text DEFAULT NULL,
  `payment_mode` varchar(30) DEFAULT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `received_by` (`received_by`),
  CONSTRAINT `supplier_bill_basic_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `medicine_supplier` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supplier_bill_basic_ibfk_2` FOREIGN KEY (`received_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `supplier_bill_basic` (`id`, `invoice_no`, `date`, `supplier_id`, `file`, `total`, `tax`, `discount`, `net_amount`, `note`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `received_by`, `attachment`, `attachment_name`, `payment_note`, `created_at`) VALUES (1, '', '2022-05-06 20:33:00', 1, '', '75000.00', '11250.00', '0.00', '86250.00', '', 'Cash', NULL, NULL, '2022-05-06 20:34:27', 1, NULL, NULL, '', '2022-05-06 17:34:27');
INSERT INTO `supplier_bill_basic` (`id`, `invoice_no`, `date`, `supplier_id`, `file`, `total`, `tax`, `discount`, `net_amount`, `note`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `received_by`, `attachment`, `attachment_name`, `payment_note`, `created_at`) VALUES (2, '', '2022-05-06 20:39:00', 1, '', '300000.00', '45000.00', '0.00', '345000.00', '', 'Cash', NULL, NULL, '2022-05-06 20:41:15', 1, NULL, NULL, '', '2022-05-06 17:41:15');
INSERT INTO `supplier_bill_basic` (`id`, `invoice_no`, `date`, `supplier_id`, `file`, `total`, `tax`, `discount`, `net_amount`, `note`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `received_by`, `attachment`, `attachment_name`, `payment_note`, `created_at`) VALUES (3, '', '2022-05-06 20:42:00', 1, '', '12000.00', '1800.00', '0.00', '13800.00', '', 'Cash', NULL, NULL, '2022-05-06 20:43:27', 1, NULL, NULL, '', '2022-05-06 17:43:27');


#
# TABLE STRUCTURE FOR: symptoms
#

DROP TABLE IF EXISTS `symptoms`;

CREATE TABLE `symptoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `symptoms_title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (1, 'Covid-19', 'No Symptoms Identified', '1', '2021-12-17 16:36:34');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (2, 'Fever', 'Patient is having a high temperature Head Ache with Fever further Diagnosis is required!', '3', '2022-05-06 15:38:40');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (3, 'Thirst', 'Thirst is the feeling of needing to drink something. It occurs whenever the body is dehydrated for any reason. Any condition that can result in a loss of body water can lead to thirst or excessive thirst.', '4', '2022-05-06 15:45:20');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (4, 'Cramps and injuries', 'Muscle pain: Muscle spasms, cramps and injuries can all cause muscle pain. Some infections or tumors may also lead to muscle pain. Tendon and ligament pain: Ligaments and tendons are strong bands of tissue that connect your joints and bones. Sprains, strains and overuse injuries can lead to tendon or ligament pain.', '5', '2022-05-06 15:45:46');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (5, 'Atopic dermatitis (Eczema)', 'Atopic dermatitis usually develops in early childhood and is more common in people who have a family history of the condition.', '6', '2022-05-06 15:46:17');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (6, 'Bladder leakage', 'Urinary incontinence — the loss of bladder control — is a common and often embarrassing problem. The severity ranges from occasionally leaking urine when you cough or sneeze to having an urge to urinate that\'s so sudden and strong you don\'t get to a toilet in time.', '7', '2022-05-06 15:46:37');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (7, 'Constant or severe abdominal pain.', 'Diseases that affect the digestive system can also cause chronic abdominal pain. The most common are: gastroesophageal reflux disease (GERD) irritable bowel syndrome or spastic colon (a disorder that causes abdominal pain, cramping, and changes in bowel movements)', '8', '2022-05-06 15:46:57');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (8, 'Asthma', 'Asthma is a condition in which your airways narrow and swell and may produce extra mucus. This can make breathing difficult and trigger coughing, a whistling sound (wheezing) when you breathe out and shortness of breath. For some people, asthma is a minor nuisance.', '9', '2022-05-06 15:47:19');
INSERT INTO `symptoms` (`id`, `symptoms_title`, `description`, `type`, `created_at`) VALUES (9, 'trauma', 'raped', '10', '2022-06-13 07:39:39');


#
# TABLE STRUCTURE FOR: symptoms_classification
#

DROP TABLE IF EXISTS `symptoms_classification`;

CREATE TABLE `symptoms_classification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `symptoms_type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (1, 'Asymptomatic', '2021-12-17 16:35:46');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (2, 'Chronic', '2021-12-17 16:35:58');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (3, 'Head Ache', '2022-05-06 15:37:29');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (4, 'Eating or Weight Problems', '2022-05-06 15:42:45');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (5, 'Muscle or Joint Problems', '2022-05-06 15:43:05');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (6, 'Skin Problem', '2022-05-06 15:43:18');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (7, 'Bladder Problems', '2022-05-06 15:43:30');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (8, 'Stomach Problems', '2022-05-06 15:44:01');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (9, 'Lung Problems', '2022-05-06 15:44:17');
INSERT INTO `symptoms_classification` (`id`, `symptoms_type`, `created_at`) VALUES (10, 'Emotional Problems', '2022-05-06 15:44:37');


#
# TABLE STRUCTURE FOR: system_notification
#

DROP TABLE IF EXISTS `system_notification`;

CREATE TABLE `system_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_title` varchar(200) NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  `notification_desc` text DEFAULT NULL,
  `notification_for` varchar(50) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `is_active` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (1, 'Generate Staff ID Card', 'certificate', 'Staff ID card is generated for Role: Nurse, staff name MERQ suename HEW employee id: MERQ-EMR-HEW001.', '', 1, 2, '2021-12-17 19:33:33', 'yes', '2021-12-17 16:33:33');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (2, 'Generate Staff ID Card', 'certificate', 'Staff ID card is generated for Role: Nurse, staff name MERQ suename HEW employee id: MERQ-EMR-HEW001.', '', 7, 1, '2021-12-17 19:33:33', 'yes', '2021-12-17 16:33:33');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (3, 'New OPD Visit Created', 'opd', 'OPD Visit has been created for patient: Abebech Haile (1) with doctor: Mike (MERQ-HEW-DOC0001). Patient Symptoms Details are  and any known allergies:  .', '', 1, 2, '2021-12-17 20:06:34', 'yes', '2021-12-17 17:06:34');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (4, 'New OPD Visit Created', 'opd', 'OPD Visit has been created for patient: Abebech Haile (1) with doctor: Mike (MERQ-HEW-DOC0001). Patient Symptoms Details are  and any known allergies:  .', '', 7, 1, '2021-12-17 20:06:34', 'yes', '2021-12-17 17:06:34');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (5, 'New OPD Visit Created', 'opd', 'OPD Visit has been created for patient: Abebech Haile (1) with doctor: Mike (MERQ-HEW-DOC0001). Patient Symptoms Details are  and any known allergies:  .', '', 3, 4, '2021-12-17 20:06:34', 'yes', '2021-12-17 17:06:34');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (6, 'New OPD Visit Created', 'opd', 'Dear: Abebech Haile (1) your OPD visit has been created.  Your Symptoms Details are  and any known allergies: . ', '', NULL, 1, '2021-12-17 20:06:34', 'yes', '2021-12-17 17:06:34');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (7, 'Patient Certificate Generate', 'certificate', 'Patient Name Abebech Haile 1 certificate Sample Patient File Cover has been generated. OPD/ IPD number OPD1.', '', 1, 2, '2021-12-30 15:20:29', 'yes', '2021-12-30 12:20:29');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (8, 'Patient Certificate Generate', 'certificate', 'Patient Name Abebech Haile 1 certificate Sample Patient File Cover has been generated. OPD/ IPD number OPD1.', '', 7, 1, '2021-12-30 15:20:29', 'yes', '2021-12-30 12:20:29');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (9, 'Patient Consultation Add', 'live_consultation', 'Live Consultation for Patient  Name Abebech Haile 1  with Consultant Doctor Mike (MERQ-HEW-DOC0001) . Live consulatent Title  fgsfghio Date 15/20/1 22:12  minutes 15/20/1 22:12  10.', '', 1, 2, '2022-01-15 12:07:59', 'yes', '2022-01-15 09:07:59');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (10, 'Patient Consultation Add', 'live_consultation', 'Live Consultation for Patient  Name Abebech Haile 1  with Consultant Doctor Mike (MERQ-HEW-DOC0001) . Live consulatent Title  fgsfghio Date 15/20/1 22:12  minutes 15/20/1 22:12  10.', '', 7, 1, '2022-01-15 12:07:59', 'yes', '2022-01-15 09:07:59');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (11, 'Patient Consultation Add', 'live_consultation', 'Live Consultation for Patient  Name Abebech Haile 1  with Consultant Doctor Mike (MERQ-HEW-DOC0001) . Live consulatent Title  fgsfghio Date 15/20/1 22:12  minutes 15/20/1 22:12  10.', '', 3, 4, '2022-01-15 12:07:59', 'yes', '2022-01-15 09:07:59');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (12, 'Patient Consultation Add', 'live_consultation', 'Dear Abebech Haile 1 your live consultation subject fgsfghio date 15/20/1 22:12  minute 10  with Consultant Doctor Mike (MERQ-HEW-DOC0001).', '', NULL, 1, '2022-01-15 12:07:59', 'yes', '2022-01-15 09:07:59');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (13, 'New OPD Visit Created', 'opd', 'OPD Visit has been created for patient: Nati Kassa (2) with doctor: Mike (MERQ-HEW-DOC0001). Patient Symptoms Details are Dry Caugh and any known allergies:  .', '', 1, 2, '2022-01-17 11:01:38', 'yes', '2022-01-17 08:01:38');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (14, 'New OPD Visit Created', 'opd', 'OPD Visit has been created for patient: Nati Kassa (2) with doctor: Mike (MERQ-HEW-DOC0001). Patient Symptoms Details are Dry Caugh and any known allergies:  .', '', 7, 1, '2022-01-17 11:01:38', 'yes', '2022-01-17 08:01:38');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (15, 'New OPD Visit Created', 'opd', 'OPD Visit has been created for patient: Nati Kassa (2) with doctor: Mike (MERQ-HEW-DOC0001). Patient Symptoms Details are Dry Caugh and any known allergies:  .', '', 3, 4, '2022-01-17 11:01:38', 'yes', '2022-01-17 08:01:38');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (16, 'New OPD Visit Created', 'opd', 'Dear: Nati Kassa (2) your OPD visit has been created.  Your Symptoms Details are Dry Caugh and any known allergies: . ', '', NULL, 2, '2022-01-17 11:01:38', 'yes', '2022-01-17 08:01:38');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (17, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Menbere (3). Appointment Date: 04/08/2022 15:45   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-04-03 16:16:51', 'yes', '2022-04-03 13:16:51');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (18, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Menbere (3). Appointment Date: 04/08/2022 15:45   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-04-03 16:16:51', 'yes', '2022-04-03 13:16:51');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (19, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Menbere (3). Appointment Date: 04/08/2022 15:45   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-04-03 16:16:51', 'yes', '2022-04-03 13:16:51');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (20, 'New Appointment Created', 'appointment', 'Dear Menbere (3) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 3, '2022-04-03 16:16:51', 'yes', '2022-04-03 13:16:51');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (21, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 04/08/2022 16:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-04-03 16:24:22', 'yes', '2022-04-03 13:24:22');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (22, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 04/08/2022 16:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-04-03 16:24:22', 'yes', '2022-04-03 13:24:22');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (23, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 04/08/2022 16:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-04-03 16:24:22', 'yes', '2022-04-03 13:24:22');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (24, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-04-03 16:24:22', 'yes', '2022-04-03 13:24:22');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (25, 'Live Meeting Add', 'live_consultation', 'Live Meeting Created for Staff Super Admin  (Super Admin : 9001) and  Meeting Title is Test Meeting with Admin on Meeting Date 03/20/4 22:16  Meeting Duration Minutes10 .', '', 1, 2, '2022-04-03 16:48:14', 'yes', '2022-04-03 13:48:14');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (26, 'Live Meeting Add', 'live_consultation', 'Live Meeting Created for Staff Super Admin  (Super Admin : 9001) and  Meeting Title is Test Meeting with Admin on Meeting Date 03/20/4 22:16  Meeting Duration Minutes10 .', '', 7, 1, '2022-04-03 16:48:14', 'yes', '2022-04-03 13:48:14');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (27, 'Live Meeting Add', 'live_consultation', 'Live Meeting Created for Staff Super Admin  (Super Admin : 9001) and  Meeting Title is Test Meeting with Admin on Meeting Date 03/20/4 22:16  Meeting Duration Minutes10 .', '', 7, 1, '2022-04-03 16:48:14', 'yes', '2022-04-03 13:48:14');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (28, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 1, 2, '2022-04-03 16:48:23', 'yes', '2022-04-03 13:48:23');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (29, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-04-03 16:48:23', 'yes', '2022-04-03 13:48:23');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (30, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-04-03 16:48:23', 'yes', '2022-04-03 13:48:23');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (31, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 1, 2, '2022-04-03 16:49:25', 'yes', '2022-04-03 13:49:25');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (32, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-04-03 16:49:25', 'yes', '2022-04-03 13:49:25');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (33, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-04-03 16:49:25', 'yes', '2022-04-03 13:49:25');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (34, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 1, 2, '2022-04-03 16:50:10', 'yes', '2022-04-03 13:50:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (35, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-04-03 16:50:10', 'yes', '2022-04-03 13:50:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (36, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-04-03 16:50:10', 'yes', '2022-04-03 13:50:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (37, 'Patient Consultation Add', 'live_consultation', 'Live Consultation for Patient  Name Abebech Haile 1  with Consultant Doctor Hanibal Kassahun (MERQ EMR 01) . Live consulatent Title  Test Live Consultation with Abebech Date 03/20/4 22:16  minutes 03/20/4 22:16  10.', '', 1, 2, '2022-04-03 16:53:56', 'yes', '2022-04-03 13:53:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (38, 'Patient Consultation Add', 'live_consultation', 'Live Consultation for Patient  Name Abebech Haile 1  with Consultant Doctor Hanibal Kassahun (MERQ EMR 01) . Live consulatent Title  Test Live Consultation with Abebech Date 03/20/4 22:16  minutes 03/20/4 22:16  10.', '', 7, 1, '2022-04-03 16:53:56', 'yes', '2022-04-03 13:53:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (39, 'Patient Consultation Add', 'live_consultation', 'Live Consultation for Patient  Name Abebech Haile 1  with Consultant Doctor Hanibal Kassahun (MERQ EMR 01) . Live consulatent Title  Test Live Consultation with Abebech Date 03/20/4 22:16  minutes 03/20/4 22:16  10.', '', 3, 5, '2022-04-03 16:53:56', 'yes', '2022-04-03 13:53:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (40, 'Patient Consultation Add', 'live_consultation', 'Dear Abebech Haile 1 your live consultation subject Test Live Consultation with Abebech date 03/20/4 22:16  minute 10  with Consultant Doctor Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-04-03 16:53:56', 'yes', '2022-04-03 13:53:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (41, 'Live IPD Consultation Start', 'live_consultation', 'IPD No IPDN Patient Name Abebech Haile 1. Live Consultation Doctor Hanibal Kassahun (MERQ EMR 01). \r\n\r\nLive Consultation Details.\r\nConsultation Title Test Live Consultation with Abebech\r\nConsultation Date  04/03/2022 16:52 \r\nConsultation Duration Minutes  10', '', 1, 2, '2022-04-03 16:55:56', 'yes', '2022-04-03 13:55:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (42, 'Live IPD Consultation Start', 'live_consultation', 'IPD No IPDN Patient Name Abebech Haile 1. Live Consultation Doctor Hanibal Kassahun (MERQ EMR 01). \r\n\r\nLive Consultation Details.\r\nConsultation Title Test Live Consultation with Abebech\r\nConsultation Date  04/03/2022 16:52 \r\nConsultation Duration Minutes  10', '', 7, 1, '2022-04-03 16:55:56', 'yes', '2022-04-03 13:55:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (43, 'Live IPD Consultation Start', 'live_consultation', 'IPD No IPDN Patient Name Abebech Haile 1. Live Consultation Doctor Hanibal Kassahun (MERQ EMR 01). \r\n\r\nLive Consultation Details.\r\nConsultation Title Test Live Consultation with Abebech\r\nConsultation Date  04/03/2022 16:52 \r\nConsultation Duration Minutes  10', '', 3, 5, '2022-04-03 16:55:56', 'yes', '2022-04-03 13:55:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (44, 'Live IPD Consultation Start', 'live_consultation', 'Dear patient patient_name: Abebech Haile patient_id: 1 , your live consultation consultation_title: Test Live Consultation with Abebech has been scheduled on Consultation Date: 04/03/2022 16:52  for the duration of consultation_duration_minutes: 10 minute, ipd_no: IPDN and your consultant doctor doctor_name: Hanibal Kassahun (MERQ EMR 01)  please do not share the link to any body.', '', NULL, 1, '2022-04-03 16:55:56', 'yes', '2022-04-03 13:55:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (45, 'Patient Certificate Generate', 'certificate', 'Patient Name Abebech Haile 1 certificate Sample Patient File Cover has been generated. OPD/ IPD number OPD1.', '', 1, 2, '2022-04-03 17:08:38', 'yes', '2022-04-03 14:08:38');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (46, 'Patient Certificate Generate', 'certificate', 'Patient Name Abebech Haile 1 certificate Sample Patient File Cover has been generated. OPD/ IPD number OPD1.', '', 7, 1, '2022-04-03 17:08:38', 'yes', '2022-04-03 14:08:38');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (47, 'Create Ambulance Call', 'ambulance', 'Abebech Haile 1 has booked an ambulance on 08/20/4 22:17  his charge name HEW-Charge tax 0  net amount 2000 and total paid  amount 2000.\r\n\r\nAmbulance Details \r\n\r\nVehicle Model  Toyota Landcruiser Longbase\r\nDriver Name  Bekele Kebede', '', 1, 2, '2022-04-03 17:26:24', 'yes', '2022-04-03 14:26:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (48, 'Create Ambulance Call', 'ambulance', 'Abebech Haile 1 has booked an ambulance on 08/20/4 22:17  his charge name HEW-Charge tax 0  net amount 2000 and total paid  amount 2000.\r\n\r\nAmbulance Details \r\n\r\nVehicle Model  Toyota Landcruiser Longbase\r\nDriver Name  Bekele Kebede', '', 7, 1, '2022-04-03 17:26:24', 'yes', '2022-04-03 14:26:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (49, 'Create Ambulance Call', 'ambulance', 'Dear Abebech Haile 1 your ambulance is booked on 08/20/4 22:17  . Charge applied HEW-Charge, tax 0 net amount is 2000 and your paid amount is 2000 .\r\n\r\nAmbulance Details-\r\nVehicle Model: Toyota Landcruiser Longbase\r\nDriver Name: Bekele Kebede', '', NULL, 1, '2022-04-03 17:26:24', 'yes', '2022-04-03 14:26:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (50, 'Add Birth Record', 'birth_death_record', 'Patient Abebech Haile (1) has given birth to a new baby baby on 1970-01-01 03:00:00.', '', 1, 2, '2022-04-05 10:08:05', 'yes', '2022-04-05 07:08:05');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (51, 'Add Birth Record', 'birth_death_record', 'Patient Abebech Haile (1) has given birth to a new baby baby on 1970-01-01 03:00:00.', '', 7, 1, '2022-04-05 10:08:05', 'yes', '2022-04-05 07:08:05');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (52, 'Add Birth Record', 'birth_death_record', 'Dear Abebech Haile 1 case id : 1 your baby baby is born on 1970-01-01 03:00:00.', '', NULL, 1, '2022-04-05 10:08:05', 'yes', '2022-04-05 07:08:05');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (53, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 04/20/2022 11:00   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-04-19 17:48:56', 'yes', '2022-04-19 14:48:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (54, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 04/20/2022 11:00   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-04-19 17:48:56', 'yes', '2022-04-19 14:48:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (55, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 04/20/2022 11:00   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-04-19 17:48:56', 'yes', '2022-04-19 14:48:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (56, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-04-19 17:48:56', 'yes', '2022-04-19 14:48:56');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (57, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 1, 2, '2022-05-01 18:33:52', 'yes', '2022-05-01 15:33:52');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (58, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-05-01 18:33:52', 'yes', '2022-05-01 15:33:52');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (59, 'Live Meeting Start', 'live_consultation', 'Live Meeting has been created for Staff: Super Admin  (Super Admin : 9001)  Meeting Title is Test Meeting with Admin  and Meeting Date 04/03/2022 16:47  Meeting Duration Minutes: 10.', '', 7, 1, '2022-05-01 18:33:52', 'yes', '2022-05-01 15:33:52');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (60, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/04/2022 11:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-05-02 14:27:12', 'yes', '2022-05-02 11:27:12');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (61, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/04/2022 11:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-05-02 14:27:12', 'yes', '2022-05-02 11:27:12');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (62, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/04/2022 11:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-05-02 14:27:12', 'yes', '2022-05-02 11:27:12');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (63, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-05-02 14:27:12', 'yes', '2022-05-02 11:27:12');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (64, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/04/2022 19:54   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (65, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/04/2022 19:54   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (66, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/04/2022 19:54   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (67, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (68, 'Appointment Status', 'appointment', 'Patient: Abebech Haile (1) appointment status is 1 with Doctor:  Hanibal Kassahun (MERQ EMR 01) Date: 05/04/2022 19:54 .', '', 1, 2, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (69, 'Appointment Status', 'appointment', 'Patient: Abebech Haile (1) appointment status is 1 with Doctor:  Hanibal Kassahun (MERQ EMR 01) Date: 05/04/2022 19:54 .', '', 7, 1, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (70, 'Appointment Status', 'appointment', 'Patient: Abebech Haile (1) appointment status is 1 with Doctor:  Hanibal Kassahun (MERQ EMR 01) Date: 05/04/2022 19:54 .', '', 3, 5, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (71, 'Appointment Status', 'appointment', 'Dear Abebech Haile (1) your appointment status is 1 Date: 05/04/2022 19:54  with Doctor Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-05-02 19:55:10', 'yes', '2022-05-02 16:55:10');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (72, 'Patient Certificate Generate', 'certificate', 'Patient Name Abebech Haile 1 certificate Sample Patient File Cover has been generated. OPD/ IPD number የተመላላሽ ታካሚ4.', '', 1, 2, '2022-05-06 19:08:36', 'yes', '2022-05-06 16:08:36');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (73, 'Patient Certificate Generate', 'certificate', 'Patient Name Abebech Haile 1 certificate Sample Patient File Cover has been generated. OPD/ IPD number የተመላላሽ ታካሚ4.', '', 7, 1, '2022-05-06 19:08:36', 'yes', '2022-05-06 16:08:36');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (74, 'Add Medicine', 'pharmacy', 'New Add Medicine Details: \r\n\r\nMedicine Name  Albendazol , \r\nMedicine Category  Syrup ,\r\nMedicine Company  Albendazol LLC ,\r\nMedicine Composition  ALB ,\r\nMedicine Group Anti Germ , \r\nUnit 200 ,\r\nPacking  1000 ,', '', 1, 2, '2022-05-06 20:32:28', 'yes', '2022-05-06 17:32:28');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (75, 'Add Medicine', 'pharmacy', 'New Add Medicine Details: \r\n\r\nMedicine Name  Albendazol , \r\nMedicine Category  Syrup ,\r\nMedicine Company  Albendazol LLC ,\r\nMedicine Composition  ALB ,\r\nMedicine Group Anti Germ , \r\nUnit 200 ,\r\nPacking  1000 ,', '', 7, 1, '2022-05-06 20:32:28', 'yes', '2022-05-06 17:32:28');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (76, 'Purchase Medicine', 'pharmacy', 'Purchase Medicine Details :\r\nSupplier Name: MERQ Supplier Name \r\nMedicine Details: Albendazol (001)\r\nPurchase Date: 06/20/5 22:20 \r\nInvoice Number:  \r\nTotal: 75000.00\r\nDiscount: 0.00 \r\nTax: 11250.00\r\nNet Amount: 86250.00', '', 1, 2, '2022-05-06 20:34:27', 'yes', '2022-05-06 17:34:27');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (77, 'Purchase Medicine', 'pharmacy', 'Purchase Medicine Details :\r\nSupplier Name: MERQ Supplier Name \r\nMedicine Details: Albendazol (001)\r\nPurchase Date: 06/20/5 22:20 \r\nInvoice Number:  \r\nTotal: 75000.00\r\nDiscount: 0.00 \r\nTax: 11250.00\r\nNet Amount: 86250.00', '', 7, 1, '2022-05-06 20:34:27', 'yes', '2022-05-06 17:34:27');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (78, 'Add Medicine', 'pharmacy', 'New Add Medicine Details: \r\n\r\nMedicine Name  Amoxicillin , \r\nMedicine Category  Capsule ,\r\nMedicine Company  Ethiopian Pharmacitcals  ,\r\nMedicine Composition  Amoxicillin Compositions ,\r\nMedicine Group Antibiotics , \r\nUnit 500 ,\r\nPacking  50 ,', '', 1, 2, '2022-05-06 20:39:26', 'yes', '2022-05-06 17:39:26');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (79, 'Add Medicine', 'pharmacy', 'New Add Medicine Details: \r\n\r\nMedicine Name  Amoxicillin , \r\nMedicine Category  Capsule ,\r\nMedicine Company  Ethiopian Pharmacitcals  ,\r\nMedicine Composition  Amoxicillin Compositions ,\r\nMedicine Group Antibiotics , \r\nUnit 500 ,\r\nPacking  50 ,', '', 7, 1, '2022-05-06 20:39:26', 'yes', '2022-05-06 17:39:26');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (80, 'Purchase Medicine', 'pharmacy', 'Purchase Medicine Details :\r\nSupplier Name: MERQ Supplier Name \r\nMedicine Details: Amoxicillin (0002)\r\nPurchase Date: 06/20/5 22:20 \r\nInvoice Number:  \r\nTotal: 300000.00\r\nDiscount: 0.00 \r\nTax: 45000.00\r\nNet Amount: 345000.00', '', 1, 2, '2022-05-06 20:41:15', 'yes', '2022-05-06 17:41:15');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (81, 'Purchase Medicine', 'pharmacy', 'Purchase Medicine Details :\r\nSupplier Name: MERQ Supplier Name \r\nMedicine Details: Amoxicillin (0002)\r\nPurchase Date: 06/20/5 22:20 \r\nInvoice Number:  \r\nTotal: 300000.00\r\nDiscount: 0.00 \r\nTax: 45000.00\r\nNet Amount: 345000.00', '', 7, 1, '2022-05-06 20:41:15', 'yes', '2022-05-06 17:41:15');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (82, 'Add Bad Stock', 'pharmacy', 'Add Bad Stock Details :\r\n\r\nBatch No 001\r\nExpiry Date  02/29/2024\r\nOutward Date   06/20/5  \r\n Total Qty  143', '', 1, 2, '2022-05-06 20:42:03', 'yes', '2022-05-06 17:42:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (83, 'Add Bad Stock', 'pharmacy', 'Add Bad Stock Details :\r\n\r\nBatch No 001\r\nExpiry Date  02/29/2024\r\nOutward Date   06/20/5  \r\n Total Qty  143', '', 7, 1, '2022-05-06 20:42:03', 'yes', '2022-05-06 17:42:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (84, 'Purchase Medicine', 'pharmacy', 'Purchase Medicine Details :\r\nSupplier Name: MERQ Supplier Name \r\nMedicine Details: Albendazol (0001)\r\nPurchase Date: 06/20/5 22:20 \r\nInvoice Number:  \r\nTotal: 12000.00\r\nDiscount: 0.00 \r\nTax: 1800.00\r\nNet Amount: 13800.00', '', 1, 2, '2022-05-06 20:43:27', 'yes', '2022-05-06 17:43:27');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (85, 'Purchase Medicine', 'pharmacy', 'Purchase Medicine Details :\r\nSupplier Name: MERQ Supplier Name \r\nMedicine Details: Albendazol (0001)\r\nPurchase Date: 06/20/5 22:20 \r\nInvoice Number:  \r\nTotal: 12000.00\r\nDiscount: 0.00 \r\nTax: 1800.00\r\nNet Amount: 13800.00', '', 7, 1, '2022-05-06 20:43:27', 'yes', '2022-05-06 17:43:27');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (86, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID5). Prescription IPDP1 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Dry Cough\r\nContinuous Dry Coughs check with antibiotics  \r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 1, 2, '2022-05-06 20:51:24', 'yes', '2022-05-06 17:51:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (87, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID5). Prescription IPDP1 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Dry Cough\r\nContinuous Dry Coughs check with antibiotics  \r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 7, 1, '2022-05-06 20:51:24', 'yes', '2022-05-06 17:51:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (88, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID5). Prescription IPDP1 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Dry Cough\r\nContinuous Dry Coughs check with antibiotics  \r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 1, 2, '2022-05-06 20:51:24', 'yes', '2022-05-06 17:51:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (89, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID5). Prescription IPDP1 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Dry Cough\r\nContinuous Dry Coughs check with antibiotics  \r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 3, 4, '2022-05-06 20:51:24', 'yes', '2022-05-06 17:51:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (90, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID5). Prescription IPDP1 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Dry Cough\r\nContinuous Dry Coughs check with antibiotics  \r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 3, 5, '2022-05-06 20:51:24', 'yes', '2022-05-06 17:51:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (91, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID5). Prescription IPDP1 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Dry Cough\r\nContinuous Dry Coughs check with antibiotics  \r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 4, 7, '2022-05-06 20:51:24', 'yes', '2022-05-06 17:51:24');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (92, 'Pharmacy Generate Bill', 'pharmacy', 'Pharmacy Bill Generated for Patient: Abebech Haile (1) Case ID: .\r\n\r\nPharmacy Bill Details-\r\nTotal Amount: 75.00\r\nNet Amount: 86.25\r\nDiscount: {discount}} \r\nTax: 11.25\r\nPaid Amount  $ 86.25\r\nDue Amount  $ 0.00', '', 1, 2, '2022-05-06 20:54:52', 'yes', '2022-05-06 17:54:52');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (93, 'Pharmacy Generate Bill', 'pharmacy', 'Pharmacy Bill Generated for Patient: Abebech Haile (1) Case ID: .\r\n\r\nPharmacy Bill Details-\r\nTotal Amount: 75.00\r\nNet Amount: 86.25\r\nDiscount: {discount}} \r\nTax: 11.25\r\nPaid Amount  $ 86.25\r\nDue Amount  $ 0.00', '', 7, 1, '2022-05-06 20:54:52', 'yes', '2022-05-06 17:54:52');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (94, 'Pharmacy Generate Bill', 'pharmacy', 'Dear Abebech Haile 1 your pharmacy bill is generated. \r\n\r\nBill Details-\r\nTotal Amount: 75.00\r\nNet Amount: 86.25\r\nDiscount: 0.00\r\nTax: 11.25\r\nPaid Amount: 86.25\r\nDue Amount: 0.00', '', NULL, 1, '2022-05-06 20:54:52', 'yes', '2022-05-06 17:54:52');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (95, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID6). Prescription IPDP2 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Temperature High\r\nPatient has a high Temperature and is having a fever\r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 1, 2, '2022-05-07 14:48:03', 'yes', '2022-05-07 11:48:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (96, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID6). Prescription IPDP2 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Temperature High\r\nPatient has a high Temperature and is having a fever\r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 7, 1, '2022-05-07 14:48:03', 'yes', '2022-05-07 11:48:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (97, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID6). Prescription IPDP2 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Temperature High\r\nPatient has a high Temperature and is having a fever\r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 3, 4, '2022-05-07 14:48:03', 'yes', '2022-05-07 11:48:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (98, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID6). Prescription IPDP2 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Temperature High\r\nPatient has a high Temperature and is having a fever\r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 3, 5, '2022-05-07 14:48:03', 'yes', '2022-05-07 11:48:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (99, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID6). Prescription IPDP2 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Temperature High\r\nPatient has a high Temperature and is having a fever\r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 4, 7, '2022-05-07 14:48:03', 'yes', '2022-05-07 11:48:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (100, 'New OPD Prescription Created', 'opd', 'New OPD prescription has been created for Patient: Abebech Haile (1) Checkup ID: (OCID6). Prescription IPDP2 prescribe by Hanibal Kassahun (MERQ EMR 01).  \r\n\r\n Prescription Details.\r\n(1) Finding Description: Temperature High\r\nPatient has a high Temperature and is having a fever\r\n(2) Medicine Details: Amoxicillin\r\n(3) Radiology Test: \r\n(4) Pathology Test: ', '', 7, 1, '2022-05-07 14:48:03', 'yes', '2022-05-07 11:48:03');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (101, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/18/2022 09:30   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-05-17 17:55:17', 'yes', '2022-05-17 14:55:17');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (102, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/18/2022 09:30   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-05-17 17:55:17', 'yes', '2022-05-17 14:55:17');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (103, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 05/18/2022 09:30   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-05-17 17:55:17', 'yes', '2022-05-17 14:55:17');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (104, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-05-17 17:55:17', 'yes', '2022-05-17 14:55:17');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (105, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 06/23/2022 15:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-06-23 11:37:43', 'yes', '2022-06-23 08:37:43');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (106, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 06/23/2022 15:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-06-23 11:37:43', 'yes', '2022-06-23 08:37:43');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (107, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 06/23/2022 15:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-06-23 11:37:43', 'yes', '2022-06-23 08:37:43');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (108, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-06-23 11:37:43', 'yes', '2022-06-23 08:37:43');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (109, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 07/13/2022 10:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-07-08 12:36:21', 'yes', '2022-07-08 09:36:21');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (110, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 07/13/2022 10:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-07-08 12:36:21', 'yes', '2022-07-08 09:36:21');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (111, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 07/13/2022 10:15   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-07-08 12:36:21', 'yes', '2022-07-08 09:36:21');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (112, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-07-08 12:36:21', 'yes', '2022-07-08 09:36:21');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (113, 'Pharmacy Generate Bill', 'pharmacy', 'Pharmacy Bill Generated for Patient: Abebech Haile (1) Case ID: .\r\n\r\nPharmacy Bill Details-\r\nTotal Amount: 825.00\r\nNet Amount: 948.75\r\nDiscount: {discount}} \r\nTax: 123.75\r\nPaid Amount  $ 948.75\r\nDue Amount  $ 0.00', '', 1, 2, '2022-07-08 12:46:17', 'yes', '2022-07-08 09:46:17');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (114, 'Pharmacy Generate Bill', 'pharmacy', 'Pharmacy Bill Generated for Patient: Abebech Haile (1) Case ID: .\r\n\r\nPharmacy Bill Details-\r\nTotal Amount: 825.00\r\nNet Amount: 948.75\r\nDiscount: {discount}} \r\nTax: 123.75\r\nPaid Amount  $ 948.75\r\nDue Amount  $ 0.00', '', 7, 1, '2022-07-08 12:46:17', 'yes', '2022-07-08 09:46:17');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (115, 'Pharmacy Generate Bill', 'pharmacy', 'Dear Abebech Haile 1 your pharmacy bill is generated. \r\n\r\nBill Details-\r\nTotal Amount: 825.00\r\nNet Amount: 948.75\r\nDiscount: 0.00\r\nTax: 123.75\r\nPaid Amount: 948.75\r\nDue Amount: 0.00', '', NULL, 1, '2022-07-08 12:46:17', 'yes', '2022-07-08 09:46:17');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (116, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 07/11/2022 10:00   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 1, 2, '2022-07-09 16:24:29', 'yes', '2022-07-09 13:24:29');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (117, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 07/11/2022 10:00   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 7, 1, '2022-07-09 16:24:29', 'yes', '2022-07-09 13:24:29');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (118, 'New Appointment Created', 'appointment', 'Appointment has been created for Patient: Abebech Haile (1). Appointment Date: 07/11/2022 10:00   With Doctor Name: Hanibal Kassahun (MERQ EMR 01).', '', 3, 5, '2022-07-09 16:24:29', 'yes', '2022-07-09 13:24:29');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (119, 'New Appointment Created', 'appointment', 'Dear Abebech Haile (1) your appointment has been created with Doctor: Hanibal Kassahun (MERQ EMR 01).', '', NULL, 1, '2022-07-09 16:24:29', 'yes', '2022-07-09 13:24:29');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (120, 'Radiology Investigation', 'radiology', 'Radiology Test Report for Patient: Abebech Haile (1) case id: . Radiology test assign by . Test Charge total amount 99.99, total discount 0.00, tax 15.00.', '', 1, 2, '2022-07-09 17:18:53', 'yes', '2022-07-09 14:18:53');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (121, 'Radiology Investigation', 'radiology', 'Radiology Test Report for Patient: Abebech Haile (1) case id: . Radiology test assign by . Test Charge total amount 99.99, total discount 0.00, tax 15.00.', '', 7, 1, '2022-07-09 17:18:53', 'yes', '2022-07-09 14:18:53');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (122, 'Radiology Investigation', 'radiology', 'Radiology Test Report for Patient: Abebech Haile (1) case id: . Radiology test assign by . Test Charge total amount 99.99, total discount 0.00, tax 15.00.', '', 3, NULL, '2022-07-09 17:18:53', 'yes', '2022-07-09 14:18:53');
INSERT INTO `system_notification` (`id`, `notification_title`, `notification_type`, `notification_desc`, `notification_for`, `role_id`, `receiver_id`, `date`, `is_active`, `created_at`) VALUES (123, 'Radiology Investigation', 'radiology', 'Dear Abebech Haile (1) case id: . Your Radiology test bill number is ,  total bill amount 99.99 tax 15.00, discount 0.00 so now your net amount 114.99 and total paid amount is 114.99. ', '', NULL, 1, '2022-07-09 17:18:53', 'yes', '2022-07-09 14:18:53');


#
# TABLE STRUCTURE FOR: system_notification_setting
#

DROP TABLE IF EXISTS `system_notification_setting`;

CREATE TABLE `system_notification_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `staff_message` text DEFAULT NULL,
  `is_staff` int(1) NOT NULL DEFAULT 1,
  `patient_message` text DEFAULT NULL,
  `is_patient` int(1) NOT NULL DEFAULT 0,
  `variables` text DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `patient_url` varchar(255) NOT NULL,
  `notification_type` varchar(255) NOT NULL,
  `is_active` int(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (1, 'notification_appointment_created', 'New Appointment Created', 'Appointment has been created for Patient: {{patient_name}} ({{patient_id}}). Appointment Date: {{appointment_date}}  With Doctor Name: {{doctor_name}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) your appointment has been created with Doctor: {{doctor_name}}.', 1, '{{appointment_date}} {{patient_name}} {{patient_id}} {{doctor_name}} {{message}}', '', '', 'appointment', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (2, 'appointment_approved', 'Appointment Status', 'Patient: {{patient_name}} ({{patient_id}}) appointment status is {{appointment_status}} with Doctor:  {{doctor_name}} Date: {{appointment_date}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) your appointment status is {{appointment_status}} Date: {{appointment_date}} with Doctor {{doctor_name}}.', 1, '{{appointment_date}} {{patient_name}} {{patient_id}} {{doctor_name}} {{message}} {{appointment_status}}', '', '', 'appointment', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (3, 'opd_visit_created', 'New OPD Visit Created', 'OPD Visit has been created for patient: {{patient_name}} ({{patient_id}}) with doctor: {{doctor_name}}. Patient Symptoms Details are {{symptoms_description}} and any known allergies: {{any_known_allergies}} .', 1, 'Dear: {{patient_name}} ({{patient_id}}) your OPD visit has been created.  Your Symptoms Details are {{symptoms_description}} and any known allergies: {{any_known_allergies}}. ', 1, '{{patient_name}} {{patient_id}} {{symptoms_description}} {{any_known_allergies}} {{appointment_date}} {{doctor_name}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (4, 'notification_opd_prescription_created', 'New OPD Prescription Created', 'New OPD prescription has been created for Patient: {{patient_name}} ({{patient_id}}) Checkup ID: ({{checkup_id}}). Prescription {{prescription_no}} prescribe by {{prescribe_by}}.  \r\n\r\n Prescription Details.\r\n(1) Finding Description: {{finding_description}}\r\n(2) Medicine Details: {{medicine}}\r\n(3) Radiology Test: {{radilogy_test}}\r\n(4) Pathology Test: {{pathology_test}}', 1, 'Dear {{patient_name}} ({{patient_id}}) Checkup ID: ({{checkup_id}}) your OPD ({{opd_no}}) prescription has been created . Please Check your finding details {{finding_description}} prescribe by {{prescribe_by}}.\r\n\r\nPlease Check prescription details. \r\n(1) Medicines Details: {{medicine}}\r\n(2) Radiology Test: {{radilogy_test}}\r\n(3) Pathology Test: {{pathology_test}}', 1, '{{prescription_no}} {{opd_no}} {{checkup_id}} {{finding_description}} {{medicine}} {{radilogy_test}} {{pathology_test}} {{prescribe_by}} {{generated_by}} {{patient_name}} {{patient_id}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (5, 'add_opd_patient_charge', 'Add OPD Patient Charge', 'New OPD charges added in OPD Number: ({{opd_no}}) For Patient: {{patient_name}} ({{patient_id}}). In OPD applied charges is {{charge_type}}, charge category {{charge_category}} and charge Name {{charge_name}} quantity {{qty}}. Total net payable bill amount is {{net_amount}} date {{date}}', 1, 'Dear {{patient_name}}({{patient_id}}) OPD Number ({{opd_no}}) . In OPD applied charge name {{charge_type}} , category {{charge_category}},  charge name {{charge_name}} quantity {{qty}} and your net payable bill amount is {{net_amount}} Date {{date}}.', 1, '{{patient_name}} {{patient_id}}  {{opd_no}} {{charge_type}} {{charge_category}} {{charge_name}} {{qty}} {{net_amount}} {{date}} {{doctor_name}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (6, 'add_opd_payment', 'Add OPD Payment', 'New OPD payment has been received from Patient: {{patient_name}}({{patient_id}}) OPD Number: ({{opd_no}}) transaction id: {{transaction_id}} payment date: {{date}} payment amount: {{amount}} payment mode: {{payment_mode}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) your payment successfully received. OPD Number: {{opd_no}} transaction id: {{transaction_id}} payment date: {{date}} payment amount: ${{amount}} payment mode: {{payment_mode}}. ', 1, '{{patient_name}} {{patient_id}} {{opd_no}} {{date}} {{amount}} {{payment_mode}} {{transaction_id}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (7, 'add_opd_medication_dose', 'New OPD Medication Dose', 'Consultant Doctor {{doctor_name}} has given medicine {{medicine_name}} Category is {{medicine_category}} Dosage {{dosage}} for OPD patient number is  {{opd_no}} patient name is {{patient_name}} medicine time  {{date}} {{time}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) OPD Number: {{opd_no}} you have been given the Medicine is {{medicine_name}} Dose ({{dosage}}) medicine time {{date}} {{time}}.', 1, '{{patient_name}} {{patient_id}}  {{opd_no}} {{case_id}} \r\n{{date}} {{time}}  {{medicine_name}} {{dosage}} {{medicine_category}}  {{doctor_name}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (8, 'add_nurse_note', 'New IPD Nurse Note', 'Add New Nurse Note for IPD Number: ({{ipd_no}}) Patient: {{patient_name}} ({{patient_id}}) Case ID: {{case_id}} with consultant doctor  {{doctor_name}}. \r\n\r\nNurse Note Details:\r\n(1) Nurse Name: {{nurse_name}} ({{nurse_id}})\r\n(2) Note: {{note}}\r\n(3) Comment: {{comment}}', 1, 'Dear {{patient_name}} ({{patient_id}}) IPD Number: ({{ipd_no}}) and Case ID: {{case_id}} your consultant doctor is {{doctor_name}}. \r\n\r\nNurse Note Details:\r\n(1) Nurse Name: {{nurse_name}} ({{nurse_id}})\r\n(2) Note: {{note}}\r\n(3) Comment: {{comment}}', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{doctor_name}} {{date}} {{nurse_name}} {{nurse_id}} {{note}} {{comment}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (9, 'move_in_ipd_from_opd', 'Patient Move in IPD From OPD', 'Patient {{patient_name}} ({{patient_id}}) move in IPD From OPD. Symptoms Details: {{symptoms_description}} and known allergies is  {{any_known_allergies}}. The patient is being shifted from opd to ipd whose consultant doctor is {{doctor_name}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) you have been shifted from OPD to IPD consultant doctor is {{doctor_name}}. Check your symptoms details {{symptoms_description}} and known allergies {{any_known_allergies}}.\r\n\r\n', 1, '{{patient_name}} {{patient_id}} {{symptoms_description}} {{any_known_allergies}} {{appointment_date}} {{doctor_name}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (10, 'add_opd_operation', 'New OPD Operation', 'OPD Number: ({{opd_no}}) Patient: {{patient_name}} ({{patient_id}}) Case id: {{case_id}} has been shifted to the operation ward. Consultant Doctor is {{doctor_name}} .\r\n\r\nOperation Details.\r\nOperation Name: {{operation_name}}\r\nOperation Date: {{operation_date}}', 1, 'Dear {{patient_name}} {{patient_id}} your operation {{operation_name}} date is on {{operation_date}} and your consultant doctor is {{doctor_name}}.', 1, '{{patient_name}} {{patient_id}} {{opd_no}} {{case_id}} {{operation_name}} {{operation_date}} {{doctor_name}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (11, 'ipd_visit_created', 'New IPD Visit Created', 'IPD Visit has been created for {{patient_name}} ({{patient_id}}) with Doctor: {{doctor_name}}. Patient Symptoms Details are {{symptoms_description}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) your IPD visit has been created .', 1, '{{patient_name}} {{patient_id}} {{symptoms_description}} {{admission_date}} {{doctor_name}} {{bed_location}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (12, 'notification_ipd_prescription_created', 'Notification IPD Prescription Created', 'Prescription({{prescription_no}}) for IPD ({{ipd_no}}) prescribe by: {{priscribe_by}}. \r\n\r\nPrescription  Details-\r\nFinding Description: {{finding_description}}\r\nMedicine Name: {{medicine}}\r\nRadiology Test: {{radilogy_test}}\r\nPathology Test: {{pathology_test}}\r\n{{priscribe_by}}', 1, 'Dear {{patient_name}} {{patient_id}} your IPD prescription number {{prescription_no}} is prescribe by: {{priscribe_by}}. \r\n\r\nPrescription  Details-\r\n Finding Description: {{finding_description}}\r\n Medicine Name : {{medicine}}\r\n Radiology Test: {{radilogy_test}}\r\n Pathology Test: {{pathology_test}}', 1, '{{prescription_no}} {{ipd_no}} {{finding_description}} {{medicine}} {{radilogy_test}} {{pathology_test}} {{priscribe_by}} {{generated_by}} {{patient_name}} {{patient_id}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (14, 'add_ipd_operation', 'Add IPD Operation', 'Patient Name : {{patient_name}} ({{patient_id}}) IPD Number : {{ipd_no}} Case Id : {{case_id}} has been shifted to the operation ward. Whose doctor is {{doctor_name}}.\r\n\r\nOperation Details-\r\n(1) Operation Name: {{operation_name}}\r\n(2) Operation  Date:  {{operation_date}}', 1, 'Dear {{patient_name}} ({{patient_id}}) your operation {{operation_name}} date is on {{operation_date}} with {{doctor_name}}.', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{operation_name}} {{operation_date}} {{doctor_name}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (15, 'add_ipd_generate_bill', 'Add IPD Generate Bill', 'Generated bill for IPD Number {{ipd_no}}  Patient Name {{patient_name}} {{patient_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}', 1, 'Dear {{patient_name}} {{patient_id}}  your IPD bill is generated for Case Id {{case_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{net_amount}} {{total}} {{tax}} {{paid}} {{due}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (16, 'add_ipd_patient_charge', 'Add IPD Patient Charge', 'Add Charge for IPD Patient Name : {{patient_name}} ({{patient_id}}) IPD Number ({{ipd_no}}) has applied charge {{charge_type}}, category  {{charge_category}}, and Name {{charge_name}} total quantity {{qty}} . Now total net amount {{net_amount}} date {{date}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) IPD Number {{ipd_no}} you have applied charge name is {{charge_type}}, category {{charge_category}} ,charge name {{charge_name}}  and total quantity {{qty}} now your net amount {{net_amount}} and date {{date}}.', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{charge_type}} {{charge_category}} {{charge_name}} {{qty}} {{net_amount}} {{date}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (17, 'add_ipd_payment', 'Add IPD Payment', 'Payment has been received from Patient Name: {{patient_name}} ({{patient_id}}) IPD NO: {{ipd_no}} transaction id: {{transaction_id}} payment date: {{date}} payment amount: {{amount}} payment mode: {{payment_mode}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) IPD: {{ipd_no}} we have received your payment amount ({{amount}}) transaction id: {{transaction_id}} payment date: {{date}} payment mode: {{payment_mode}} .', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{date}} {{amount}} {{payment_mode}} {{transaction_id}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (18, 'add_ipd_medication_dose', 'Add IPD Medication Dose', 'Doctor {{doctor_name}}  has given medicine {{medicine_name}} Category is {{medicine_category}} Dosage {{dosage}} to Patient:  {{patient_name}} {{patient_id}} at {{date}} {{time}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) IPD Number {{ipd_no}} you have been given the {{medicine_name}} dose {{dosage}} of medicine at {{date}} {{time}}.', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{date}} {{time}} {{medicine_name}} {{dosage}} {{medicine_category}} {{doctor_name}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (20, 'add_consultant_register', 'Add Consultant Register', 'New Consultant Register: {doctor_name}} has been added  some instructions: {{instruction}} on date {{applied_date}} for the patients {{patient_name}} ({{patient_id}}) of IPD {{ipd_no}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) IPD Number: ({{ipd_no}}). Consultant: {{doctor_name}} has added some instructions: {{instruction}} on applied date {{applied_date}}.', 1, '{{patient_name}} {{patient_id}} {{ipd_no}} {{case_id}} {{applied_date}} {{instruction_date}} {{doctor_name}} {{instruction}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (22, 'pharmacy_generate_bill', 'Pharmacy Generate Bill', 'Pharmacy Bill Generated for Patient: {{patient_name}} ({{patient_id}}) Case ID: {{case_id}}.\r\n\r\nPharmacy Bill Details-\r\nTotal Amount: {{total}}\r\nNet Amount: {{net_amount}}\r\nDiscount: {discount}} \r\nTax: {{tax}}\r\nPaid Amount  $ {{paid}}\r\nDue Amount  $ {{due_amount}}', 1, 'Dear {{patient_name}} {{patient_id}} your pharmacy bill is generated. \r\n\r\nBill Details-\r\nTotal Amount: {{total}}\r\nNet Amount: {{net_amount}}\r\nDiscount: {{discount}}\r\nTax: {{tax}}\r\nPaid Amount: {{paid}}\r\nDue Amount: {{due_amount}}', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{medicine_details}} {{doctor_name}} {{total}} {{discount}} {{tax}} {{net_amount}} {{date}} {{paid}} {{due_amount}}', '', '', 'pharmacy', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (23, 'add_medicine', 'Add Medicine', 'New Add Medicine Details: \r\n\r\nMedicine Name  {{medicine_name}} , \r\nMedicine Category  {{medicine_category}} ,\r\nMedicine Company  {{medicine_company}} ,\r\nMedicine Composition  {{medicine_composition}} ,\r\nMedicine Group {{medicine_group}} , \r\nUnit {{unit}} ,\r\nPacking  {{unit_packing}} ,', 1, '', 0, '{{medicine_name}} {{medicine_category}} {{medicine_company}} {{medicine_composition}} {{medicine_group}} {{unit}} {{unit_packing}}', '', '', 'pharmacy', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (24, 'add_bad_stock', 'Add Bad Stock', 'Add Bad Stock Details :\r\n\r\nBatch No {{batch_no}}\r\nExpiry Date  {{expiry_date}}\r\nOutward Date   {{outward_date}}  \r\n Total Qty  {{qty}}', 1, '', 0, '{{batch_no}} {{expiry_date}} {{outward_date}} {{qty}}', '', '', 'pharmacy', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (25, 'purchase_medicine', 'Purchase Medicine', 'Purchase Medicine Details :\r\nSupplier Name: {{supplier_name}} \r\nMedicine Details: {{medicine_details}}\r\nPurchase Date: {{purchase_date}}\r\nInvoice Number:  {{invoice_number}}\r\nTotal: {{total}}\r\nDiscount: {{discount}} \r\nTax: {{tax}}\r\nNet Amount: {{net_amount}}', 1, '', 0, '{{supplier_name}} {{medicine_details}} {{purchase_date}} {{invoice_number}} {{total}} {{discount}} {{tax}} {{net_amount}}', '', '', 'pharmacy', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (26, 'pathology_investigation', 'Pathology Investigation', 'Pathology Test Report for Patient: {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Pathology test assign by {{doctor_name}}. pathology charge- total amount {{total}}, discount {{discount}} ,tax {{tax}}  net amount is {{net_amount}} and total paid amount {{paid_amount}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Your pathology test bill number is {{bill_no}} and total amount {{total}}, tax {{tax}}, discount {{discount}} so now your net amount is {{net_amount}}.  You have paid your total amount {{paid_amount}}.', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{date}} {{doctor_name}}  {{total}} {{discount}} {{tax}} {{net_amount}} {{paid_amount}}', '', '', 'pathology', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (27, 'pathology_sample_collection', 'Pathology Sample Collection', 'Pathology Bill Number {{bill_no}} Patient: {{patient_name}} ({{patient_id}}) Case id: {{case_id}}. Sample Collected  by  {{sample_collected_person_name}} on {{collected_date}} from {{pathology_center}} and report expected date is {{expected_date}}.', 1, 'Dear {{patient_name}} {{patient_id}} Case id: {{case_id}}  your pathology test sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{pathology_center}} . Pathology Test report expected date {{expected_date}}. ', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{pathology_center}} {{expected_date}} {{doctor_name}}', '', '', 'pathology', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (28, 'pathology_test_report', 'Pathology Test Report', 'Pathology Test Report Bill Number {{bill_no}} for Patient Name is {{patient_name}} {{patient_id}} Case id {{case_id}} and test approved by {{approved_by}} on {{approve_date}} . Pathology Test {{test_name}} sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{pathology_center}} and Expected date {{expected_date}} . {{doctor_name}}', 1, 'Dear {{patient_name}} {{patient_id}} Case id  {{case_id}}. Your Pathology Test {{test_name}} sample collected by {{sample_collected_person_name}} on  {{collected_date}} from {{pathology_center}} .', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{pathology_center}} {{expected_date}} {{approved_by}} {{approve_date}} {{doctor_name}}', '', '', 'pathology', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (29, 'radiology_investigation', 'Radiology Investigation', 'Radiology Test Report for Patient: {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Radiology test assign by {{doctor_name}}. Test Charge total amount {{total}}, total discount {{discount}}, tax {{tax}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) case id: {{case_id}}. Your Radiology test bill number is {{bill_no}},  total bill amount {{total}} tax {{tax}}, discount {{discount}} so now your net amount {{net_amount}} and total paid amount is {{paid}}. ', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{date}} {{doctor_name}}  {{total}} {{net_amount}} {{paid}} {{discount}} {{tax}}', '', '', 'radiology', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (30, 'radiology_sample_collection', 'Radiology Sample Collection', 'Radiology Bill Number: {{bill_no}} for Patient: {{patient_name}} ({{patient_id}}) Case id: {{case_id}}. Radiology test name is {{test_name}} and sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{radiology_center}} and report expected date is {{expected_date}}.', 1, 'Dear {{patient_name}} {{patient_id}} Case id: {{case_id}}  your radiology test is {{test_name}} and  sample collected by {{sample_collected_person_name}} on {{collected_date}} from {{radiology_center}}. Test report expected date {{expected_date}}. ', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{radiology_center}} {{expected_date}} {{doctor_name}}', '', '', 'radiology', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (31, 'radiology_test_report', 'Radiology Test Report', 'Radiology Bill Number {{bill_no}} Patient Name {{patient_name}} ({{patient_id}}) Case id ( {{case_id}}). Sample Collected  by  {{sample_collected_person_name}} on {{collected_date}} from {{radiology_center}} and Expected date is {{expected_date}}.', 1, 'Dear {{patient_name}} {{patient_id}} Case id ({{case_id}}) your radiology test sample collected by {{sample_collected_person_name}} on {{collected_date}} from  {{radiology_center}}. radiology test report expected date {{expected_date}} .', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{test_name}} {{sample_collected_person_name}} {{collected_date}} {{radiology_center}} {{expected_date}} {{approved_by}} {{approved_date}} {{doctor_name}}', '', '', 'radiology', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (32, 'add_bag_stock', 'Add Bag Stock', 'New Add Bag Stock Details- Donor Name: {{donor_name}}, Blood Group: ({{blood_group}}) and contact number {{contact_no}} . Donate bag details blood bag number ({{bag}}) and charge {{charge_name}} donated date {{donate_date}}. Total amount {{total}} discount {{discount}} tax {{tax}} so total net amount is {{net_amount}}.', 1, '', 0, '{{donor_name}} {{blood_group}} {{contact_no}} {{donate_date}} {{bag}} {{charge_name}} {{total}} {{discount}} {{tax}} {{net_amount}}', '', '', 'blood_bank', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (33, 'blood_issue', 'Blood Issue', 'Blood issue for Bill Number {{bill_no}} Patient: {{patient_name}} ({{patient_id}}) Case Id {{case_id}} . Patient blood group is {{blood_group}} and bag number ({{bag}}) issue on {{issue_date}}, reference by {{reference_name}}. Applied charge name is {{charge_name}} and total amount {{total}}, discount {{discount}}, tax {{tax}}, now total net amount{{net_amount}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) case id: {{case_id}} your bill number {{bill_no}} blood group {{blood_group}} bag number is {{bag}} charge name  {{charge_name}} issue on {{issue_date}} reference by {{reference_name}} .Total amount {{total}}, discount {{discount}}, tax {{tax}} now your total net amount {{net_amount}}.', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{issue_date}} {{reference_name}} {{blood_group}} {{bag}} {{charge_name}} {{total}} {{discount}} {{tax}} {{net_amount}} ', '', '', 'blood_bank', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (34, 'add_component_of_blood', 'Add Component of Blood', '{{component_name}} component has been added on the bag number {{bag}} of Blood Group {{blood_group}} .', 1, '', 0, '{{blood_group}} {{bag}} {{ component_name}} {{component_bag}}', '', '', 'blood_bank', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (35, 'component_issue', 'Component Issue', 'Component Issue for  Bill Number {{bill_no}} Patient Name is {{patient_name}} ({{patient_id}}) Case Id: {{case_id}}.  Blood group {{blood_group}} Component: {{component}}, bag number {{bag}} issue on {{issue_date}}  reference by {{reference_name}}. Applied charge name {{charge_name}} total amount {{total}}  discount {{discount}} tax {{tax}} now total net amount {{net_amount}}.', 1, 'Dear {{patient_name}} ({{patient_id}}) {{case_id}} you have issued a component {{component}} Bag number is {{bag}}  blood group is {{blood_group}} issue on  {{issue_date}} reference by {{reference_name}} . Total amount {{total}} Discount {{discount}} Tax {{tax}} now your total net amount  is {{net_amount}}.', 1, '{{patient_name}} {{patient_id}} {{case_id}} {{bill_no}} {{issue_date}} {{reference_name}} {{blood_group}} {{component}} {{bag}} {{charge_name}} {{total}} {{discount}} {{tax}} {{net_amount}} ', '', '', 'blood_bank', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (36, 'live_opd_consultation_add', 'Live OPD Consultation Add', 'Live Consultation for  OPD {{opd_no}} Patient  Name {{patient_name}} {{patient_id}}  with Consultant Doctor {{doctor_name}} {{doctor_id}} . Live consulatent Title  {{consultation_title}} Date {{consultation_date}} minutes {{consultation_date}} {{consultation_duration_minutes}}.', 1, 'Dear {{patient_name}} {{patient_id}} your live consultation subject {{consultation_title}} date {{consultation_date}} minute {{consultation_duration_minutes}}  with Consultant Doctor {{doctor_name}} ({{doctor_id}}).', 1, '{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{opd_no}} {{checkup_id}} {{doctor_id}} {{doctor_name}}', '', '', 'live_consultation', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (37, 'live_opd_consultation_start', 'Live Opd Consultation Start', 'patient_name: {{patient_name}} patient_id: {{patient_id}} consultation_title: {{consultation_title}} consultation_date: {{consultation_date}}  consultation_duration_minutes: {{consultation_duration_minutes}} opd_no: {{opd_no}} checkup_id: {{checkup_id}} doctor_name: {{doctor_name}}', 1, 'patient_name: {{patient_name}} patient_id: {{patient_id}} consultation_title: {{consultation_title}} consultation_date: {{consultation_date}}  consultation_duration_minutes: {{consultation_duration_minutes}} opd_no: {{opd_no}} checkup_id: {{checkup_id}} doctor_name: {{doctor_name}}', 1, '{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{opd_no}} {{checkup_id}} {{doctor_name}}', '', '', 'live_consultation', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (38, 'live_meeting_start', 'Live Meeting Start', 'Live Meeting has been created for Staff: {{staff_list}}  Meeting Title is {{meeting_title}}  and Meeting Date {{meeting_date}} Meeting Duration Minutes: {{meeting_duration_minutes}}.', 1, '', 0, '{{meeting_title}} {{meeting_date}} {{meeting_duration_minutes}} {{staff_list}}', '', '', 'live_consultation', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (39, 'live_meeting_add', 'Live Meeting Add', 'Live Meeting Created for Staff {{staff_list}} and  Meeting Title is {{meeting_title}} on Meeting Date {{meeting_date}} Meeting Duration Minutes{{meeting_duration_minutes}} .', 1, '', 0, '{{meeting_title}} {{meeting_date}} {{meeting_duration_minutes}} {{staff_list}}', '', '', 'live_consultation', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (40, 'add_referral_payment', 'Add Referral Payment', 'Patient Name {{patient_name}} ({{patient_id}}) in {{patient_type}} Bill number {{bill_no}} and patient bill amount is {{patient_bill_amount}}. Commission percentage of total bill {{commission_percentage}}. Commission amount {{commission_amount}} has been given to the payee {{payee}}.', 1, '', 0, '{{patient_name}} {{patient_id}} {{patient_type}} {{bill_no}} {{patient_bill_amount}} {{payee}} {{commission_percentage}} {{commission_amount}}', '', '', 'referral', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (41, 'patient_certificate_generate', 'Patient Certificate Generate', 'Patient Name {{patient_name}} {{patient_id}} certificate {{certificate_name}} has been generated. OPD/ IPD number {{opd_ipd_no}}.', 1, 'Dear Patient {{patient_name}} {{patient_id}} OPD / IPD number is {{opd_ipd_no}}  your certificate {{certificate_name}} has been generated.', 1, '{{patient_name}} {{patient_id}} {{opd_ipd_no}} {{certificate_name}}', '', '', 'certificate', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (42, 'patient_id_card_generate', 'remaining', 'ID Card is generated for Patient Name {{patient_name}} {{patient_id}} .', 1, 'Dear {{patient_name}} {{patient_id}} your id card is generated .', 1, '{{patient_name}} {{patient_id}}  {{id_card_template}}', '', '', 'certificate', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (43, 'generate_staff_id_card', 'Generate Staff ID Card', 'Staff ID card is generated for Role: {{role}}, staff name {{staff_name}} suename {{staff_surname}} employee id: {{employee_id}}.', 1, '', 0, '{{role}} {{staff_name}} {{staff_surname}} {{employee_id}} {{id_card_template}}', '', '', 'certificate', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (44, 'create_ambulance_call', 'Create Ambulance Call', '{{patient_name}} {{patient_id}} has booked an ambulance on {{date}} his charge name {{charge_name}} tax {{tax}}  net amount {{net_amount}} and total paid  amount {{paid_amount}}.\r\n\r\nAmbulance Details \r\n\r\nVehicle Model  {{vehicle_model}}\r\nDriver Name  {{driver_name}}', 1, 'Dear {{patient_name}} {{patient_id}} your ambulance is booked on {{date}} . Charge applied {{charge_name}}, tax {{tax}} net amount is {{net_amount}} and your paid amount is {{paid_amount}} .\r\n\r\nAmbulance Details-\r\nVehicle Model: {{vehicle_model}}\r\nDriver Name: {{driver_name}}', 1, '{{patient_name}} {{patient_id}} {{vehicle_model}} {{driver_name}} {{date}} {{charge_name}} {{tax}} {{net_amount}} {{paid_amount}}', '', '', 'ambulance', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (45, 'add_birth_record', 'Add Birth Record', 'Patient {{mother_name}} ({{mother_id}}) has given birth to a new baby {{child_name}} on {{birth_date}}.', 1, 'Dear {{mother_name}} {{mother_id}} case id : {{case_id}} your baby {{child_name}} is born on {{birth_date}}.', 1, '{{mother_name}} {{mother_id}} {{child_name}} {{birth_date}} {{case_id}}', '', '', 'birth_death_record', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (46, 'add_death_record', 'Add Death Record', 'Patient {{patient_name}} ({{patient_id}}) Case id :{{case_id}} has died on {{death_date}}.', 1, '', 0, '{{case_id}} {{patient_name}} {{patient_id}} {{death_date}}', '', '', 'birth_death_record', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (47, 'staff_enabale_disable', 'Staff Enabale/Disable', 'Staff Name: {{staff_name}} surname: {{staff_surname}} Employment ID: ({{employee_id}}) has been {{status}}.', 1, '', 0, '{{staff_name}} {{staff_surname}} {{employee_id}} {{status}}', '', '', 'human_resource', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (48, 'staff_generate_payroll', 'Staff Generate Payroll', 'Payroll Generated for  Month {{month}} year {{year}}  Role {{role}} . Basic Salary is {{basic_salary}} Earning  {{earning}} Deduction {{deduction}} Gross salary  {{gross_salary}}.  Now Total Net Salary {{net_salary}}.', 1, '', 0, '{{role}} {{month}} {{year}} {{basic_salary}} {{earning}} {{deduction}} {{gross_salary}} {{tax_amount}} {{net_salary}}', '', '', 'human_resource', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (49, 'staff_leave', 'Staff Leave', 'Staff {{staff_name}} {{staff_surname}} ({{employee_id}}) has applied leave on Date {{apply_date}} for leave {{days}} days. date {{leave_date}} . Currently Leave Status is {{leave_status}} .', 1, '', 0, '{{apply_date}} {{leave_type}} {{leave_date}} {{days}} {{staff_name}} {{staff_surname}} {{employee_id}}\r\n{{leave_status}}', '', '', 'human_resource', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (50, 'staff_leave_status', 'Staff Leave Status', 'Staff Name {{staff_name}} {{staff_surname}} {{employee_id}} has applied leave for {{days}} days. leave date: {{leave_date}}, Leave Status:  {{leave_status}}.', 1, '', 0, '{{apply_date}} {{leave_type}} {{leave_date}} {{days}} {{staff_name}} {{staff_surname}} {{employee_id}}\r\n{{leave_status}}', '', '', 'human_resource', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (51, 'live_ipd_consultation_add', 'Live IPD Consultation Add', 'Live Consultation for IPD {{ipd_no}} Patient  Name {{patient_name}} {{patient_id}} with Consultant Doctor {{doctor_name}} {{doctor_id}} . Live consulatent Title  {{consultation_title}} Date {{consultation_date}} minutes {{consultation_date}} {{consultation_duration_minutes}}.', 1, 'Dear {{patient_name}} {{patient_id}} your live consultation subject {{consultation_title}} date {{consultation_date}} minute {{consultation_duration_minutes}}  with Consultant Doctor {{doctor_name}} ({{doctor_id}}).', 1, '{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}} \r\n{{ipd_no}} {{doctor_id}} {{doctor_name}}', '', '', 'live_consultation', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (52, 'live_ipd_consultation_start', 'Live IPD Consultation Start', 'IPD No {{ipd_no}} Patient Name {{patient_name}} {{patient_id}}. Live Consultation Doctor {{doctor_name}}. \r\n\r\nLive Consultation Details.\r\nConsultation Title {{consultation_title}}\r\nConsultation Date  {{consultation_date}}\r\nConsultation Duration Minutes  {{consultation_duration_minutes}}', 1, 'Dear patient patient_name: {{patient_name}} patient_id: {{patient_id}} , your live consultation consultation_title: {{consultation_title}} has been scheduled on Consultation Date: {{consultation_date}} for the duration of consultation_duration_minutes: {{consultation_duration_minutes}} minute, ipd_no: {{ipd_no}} and your consultant doctor doctor_name: {{doctor_name}}  please do not share the link to any body.', 1, '{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{ipd_no}} {{doctor_name}}', '', '', 'live_consultation', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (53, 'add_ipd_discharge_patient', 'Add IPD Discharge Patient', 'IPD Patient: {{patient_name}}({{patient_id}}) status: ({{discharge_status}}) on {{discharge_date}}.', 1, 'Dear {{patient_name}} {{patient_id}} you have been {{discharge_status}} on {{discharge_date}}.', 1, '{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{ipd_no}} {{case_id}}', '', '', 'ipd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (54, 'add_opd_discharge_patient', 'Add OPD Discharge Patient', 'OPD Patient {{patient_name}} {{patient_id}} discharge status: {discharge_status}} on {{discharge_date}}.', 1, '\r\nDear {{patient_name}} {{patient_id}} you have been {{discharge_status}} on {{discharge_date}}.', 1, '{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{opd_no}} {{case_id}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (55, 'add_payroll_payment', 'Add Payroll Payment', 'Month {{month}} salary amount {{payment_amount}} has been given to staff name {{staff}} on date {{payment_date}}.', 1, 'staff: {{staff}} payment_amount: {{payment_amount}} month: {{month}} year: {{year}} payment_mode: {{payment_mode}} payment_date: {{payment_date}}\r\n', 0, '{{staff}} {{payment_amount}} {{month}} {{year}} {{payment_mode}} {{payment_date}}', '', '', 'human_resource', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (56, 'add_opd_generate_bill', 'Add OPD Generate Bill', 'Generated bill for OPD Number {{opd_id}}  Patient Name {{patient_name}} {{patient_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}', 1, 'Dear {{patient_name}} {{patient_id}}  your OPD bill is generated for Case Id {{case_id}} .\r\n\r\nBill Details\r\nTotal Amount {{total}}\r\nNet Amount {{net_amount}}\r\nTax  {{tax}}\r\nPaid Amount   {{paid}}\r\nDue Amount   {{due}}', 1, '{{patient_name}} {{patient_id}} {{opd_id}} {{case_id}} {{net_amount}} {{total}} {{tax}} {{paid}} {{due}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (57, 'patient_consultation_add', 'Patient Consultation Add', 'Live Consultation for Patient  Name {{patient_name}} {{patient_id}}  with Consultant Doctor {{doctor_name}} . Live consulatent Title  {{consultation_title}} Date {{consultation_date}} minutes {{consultation_date}} {{consultation_duration_minutes}}.', 1, 'Dear {{patient_name}} {{patient_id}} your live consultation subject {{consultation_title}} date {{consultation_date}} minute {{consultation_duration_minutes}}  with Consultant Doctor {{doctor_name}}.', 1, '{{patient_name}} {{patient_id}} {{consultation_title}} {{consultation_date}} {{consultation_duration_minutes}}  {{checkup_id}} {{doctor_name}}', '', '', 'live_consultation', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (58, 'opd_patient_discharge_revert', 'opd_patient_discharge_revert', 'patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} opd_no: {{opd_no}} case_id: {{case_id}}', 1, 'patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} opd_no: {{opd_no}} case_id: {{case_id}}', 1, '{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{opd_no}} {{case_id}}', '', '', 'opd', 1, '2021-09-17 02:54:13');
INSERT INTO `system_notification_setting` (`id`, `event`, `subject`, `staff_message`, `is_staff`, `patient_message`, `is_patient`, `variables`, `url`, `patient_url`, `notification_type`, `is_active`, `created_at`) VALUES (59, 'ipd_patient_discharge_revert', 'ipd_patient_discharge_revert', 'patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} ipd_no: {{ipd_no}} case_id: {{case_id}}', 1, 'patient_name: {{patient_name}} patient_id: {{patient_id}} discharge_status: {{discharge_status}} discharge_date: {{discharge_date}} ipd_no: {{ipd_no}} case_id: {{case_id}}', 1, '{{patient_name}} {{patient_id}} {{discharge_status}} {{discharge_date}} {{ipd_no}} {{case_id}}', '', '', 'opd', 1, '2021-09-17 02:54:13');


#
# TABLE STRUCTURE FOR: tax_category
#

DROP TABLE IF EXISTS `tax_category`;

CREATE TABLE `tax_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `percentage` float(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `tax_category` (`id`, `name`, `percentage`, `created_at`) VALUES (1, 'HEW', '0.00', '2021-12-12 18:00:05');
INSERT INTO `tax_category` (`id`, `name`, `percentage`, `created_at`) VALUES (2, 'MAT', '15.00', '2022-04-03 12:36:38');
INSERT INTO `tax_category` (`id`, `name`, `percentage`, `created_at`) VALUES (3, 'OPD', '15.00', '2022-05-06 15:00:08');


#
# TABLE STRUCTURE FOR: transactions
#

DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `section` varchar(50) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `case_reference_id` int(11) DEFAULT NULL,
  `opd_id` int(11) DEFAULT NULL,
  `ipd_id` int(11) DEFAULT NULL,
  `pharmacy_bill_basic_id` int(11) DEFAULT NULL,
  `pathology_billing_id` int(11) DEFAULT NULL,
  `radiology_billing_id` int(11) DEFAULT NULL,
  `blood_donor_cycle_id` int(11) DEFAULT NULL,
  `blood_issue_id` int(11) DEFAULT NULL,
  `ambulance_call_id` int(11) DEFAULT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `attachment` varchar(250) DEFAULT NULL,
  `attachment_name` text DEFAULT NULL,
  `amount_type` varchar(10) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `cheque_no` varchar(100) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `case_reference_id` (`case_reference_id`),
  KEY `opd_id` (`opd_id`),
  KEY `ipd_id` (`ipd_id`),
  KEY `pharmacy_bill_basic_id` (`pharmacy_bill_basic_id`),
  KEY `pathology_billing_id` (`pathology_billing_id`),
  KEY `radiology_billing_id` (`radiology_billing_id`),
  KEY `blood_donor_cycle_id` (`blood_donor_cycle_id`),
  KEY `blood_issue_id` (`blood_issue_id`),
  KEY `ambulance_call_id` (`ambulance_call_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_10` FOREIGN KEY (`ambulance_call_id`) REFERENCES `ambulance_call` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_11` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`case_reference_id`) REFERENCES `case_references` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`opd_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_4` FOREIGN KEY (`ipd_id`) REFERENCES `ipd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_5` FOREIGN KEY (`pharmacy_bill_basic_id`) REFERENCES `pharmacy_bill_basic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_6` FOREIGN KEY (`pathology_billing_id`) REFERENCES `pathology_billing` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_7` FOREIGN KEY (`radiology_billing_id`) REFERENCES `radiology_billing` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_8` FOREIGN KEY (`blood_donor_cycle_id`) REFERENCES `blood_donor_cycle` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_9` FOREIGN KEY (`blood_issue_id`) REFERENCES `blood_issue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (1, 'payment', 'OPD', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.01', 'Cash', NULL, NULL, '2021-12-20 09:00:00', '', 1, '2021-12-17 17:06:33');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (2, 'payment', 'OPD', 2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.03', 'Cash', NULL, NULL, '2022-01-19 11:00:00', '', 1, '2022-01-17 08:01:38');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (3, 'payment', 'Ambulance', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2000.00', 'Cash', NULL, NULL, '2022-04-08 17:24:00', NULL, 1, '2022-04-03 14:26:24');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (4, 'payment', 'Appointment', 1, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, '57.50', 'Cash', NULL, NULL, '2022-05-02 19:55:08', NULL, 1, '2022-05-02 16:55:08');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (5, 'payment', 'OPD', 1, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '114.99', 'Cash', NULL, NULL, '2022-05-02 07:55:00', NULL, 1, '2022-05-06 15:57:03');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (6, 'payment', 'OPD', 1, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '114.99', 'Cash', NULL, NULL, '2022-05-13 08:15:00', NULL, 5, '2022-05-06 16:25:45');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (7, 'payment', 'Pharmacy', 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '86.25', 'Cash', NULL, NULL, '2022-05-06 08:54:00', '', 7, '2022-05-06 17:54:52');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (8, 'payment', 'OPD', 1, 6, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '114.99', 'Cash', NULL, NULL, '2022-05-13 08:15:00', NULL, 3, '2022-05-07 11:37:25');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (9, 'payment', 'OPD', 2, 7, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '114.99', 'Cash', NULL, NULL, '2022-01-19 11:00:00', NULL, 1, '2022-06-13 07:43:29');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (10, 'payment', 'OPD', 1, 8, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '114.99', 'Cash', NULL, NULL, '2022-05-13 08:15:00', NULL, 1, '2022-06-23 08:43:46');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (11, 'payment', 'ፋርማሲ', 1, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '948.75', 'Cash', NULL, NULL, '2022-07-08 12:44:00', '', 1, '2022-07-08 09:46:17');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (12, 'payment', 'OPD', 1, 9, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '114.99', 'Cash', NULL, NULL, '2022-05-17 08:35:00', NULL, 1, '2022-07-09 13:40:06');
INSERT INTO `transactions` (`id`, `type`, `section`, `patient_id`, `case_reference_id`, `opd_id`, `ipd_id`, `pharmacy_bill_basic_id`, `pathology_billing_id`, `radiology_billing_id`, `blood_donor_cycle_id`, `blood_issue_id`, `ambulance_call_id`, `appointment_id`, `attachment`, `attachment_name`, `amount_type`, `amount`, `payment_mode`, `cheque_no`, `cheque_date`, `payment_date`, `note`, `received_by`, `created_at`) VALUES (13, 'payment', 'Radiology', 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '', '', NULL, '114.99', 'Cheque', '01234567890', '2022-07-04', '2022-07-09 05:17:00', '', 1, '2022-07-09 14:18:53');


#
# TABLE STRUCTURE FOR: unit
#

DROP TABLE IF EXISTS `unit`;

CREATE TABLE `unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(100) NOT NULL,
  `unit_type` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (1, '(U/L)', 'patho', '2022-05-06 16:32:32');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (2, 'Cells / cubic millimeter', 'patho', '2022-05-06 16:32:51');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (3, 'million/mm3', 'patho', '2022-05-06 16:33:00');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (4, 'Nanometer', 'patho', '2022-05-06 16:33:08');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (5, 'Dalton (Da)', 'patho', '2022-05-06 16:33:19');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (6, 'mmol/L', 'patho', '2022-05-06 16:33:28');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (7, 'Micrometer (oi)', 'patho', '2022-05-06 16:33:38');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (8, 'CT Scan', 'radio', '2022-05-06 16:40:12');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (9, 'MRI', 'radio', '2022-05-06 16:40:21');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (10, 'Mammography', 'radio', '2022-05-06 16:40:33');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (11, 'HVL', 'radio', '2022-05-06 16:40:43');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (12, 'KHz', 'radio', '2022-05-06 16:40:50');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (13, 'X-RAY', 'radio', '2022-05-06 16:41:19');
INSERT INTO `unit` (`id`, `unit_name`, `unit_type`, `created_at`) VALUES (14, 'ECO-ECG', 'radio', '2022-05-06 16:41:33');


#
# TABLE STRUCTURE FOR: userlog
#

DROP TABLE IF EXISTS `userlog`;

CREATE TABLE `userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `ipaddress` varchar(100) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `login_datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (1, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.95.187', 'Chrome 97.0.4692.36, Linux', '2021-12-12 12:52:23');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (2, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.95.187', 'Chrome 93.0.4577.82, Linux', '2021-12-12 15:14:51');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (3, 'michaelktd@merqconsultancy.org', 'Admin', '197.156.95.187', 'Chrome 93.0.4577.82, Linux', '2021-12-12 15:16:45');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (4, 'michaelktd@merqconsultancy.org', 'Admin', '197.156.95.187', 'Chrome 93.0.4577.82, Linux', '2021-12-12 15:17:47');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (5, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.95.187', 'Opera 65.2.3381.61420, Android', '2021-12-12 17:29:58');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (6, 'michaelktd7@gmail.com', 'Nurse', '197.156.95.187', 'Firefox 93.0, Android', '2021-12-12 17:44:12');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (7, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.92', 'Chrome 97.0.4692.56, Linux', '2021-12-17 16:04:00');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (8, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.92', 'Chrome 97.0.4692.56, Linux', '2021-12-17 17:16:01');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (9, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.92', 'Chrome 93.0.4577.82, Linux', '2021-12-17 17:30:04');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (10, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.92', 'Opera 65.2.3381.61420, Android', '2021-12-17 17:49:08');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (11, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.92', 'Chrome 97.0.4692.56, Linux', '2021-12-18 07:33:12');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (12, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.92', 'Chrome 97.0.4692.56, Linux', '2021-12-18 12:04:02');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (13, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Chrome 97.0.4692.56, Linux', '2021-12-20 08:18:25');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (14, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Chrome 97.0.4692.56, Linux', '2021-12-23 07:22:19');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (15, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Chrome 96.0.4664.113, Linux', '2021-12-23 11:26:33');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (16, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Chrome 97.0.4692.56, Linux', '2021-12-24 06:59:52');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (17, 'michaelktd7@gmail.com', 'Nurse', '197.156.107.60', 'Firefox 91.0, Linux', '2021-12-25 15:28:50');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (18, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Firefox 91.0, Linux', '2021-12-25 16:53:26');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (19, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Chrome 96.0.4664.113, Linux', '2021-12-29 13:22:01');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (20, 'pat1', 'patient', '197.156.107.60', 'Chrome 96.0.4664.113, Linux', '2021-12-29 13:38:04');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (21, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Firefox 96.0, Windows 10', '2021-12-30 11:15:22');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (22, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Firefox 91.0, Linux', '2022-01-04 08:37:20');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (23, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.60', 'Firefox 91.0, Linux', '2022-01-04 11:56:32');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (24, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.207', 'Firefox 91.0, Linux', '2022-01-07 15:18:43');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (25, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.120', 'Firefox 91.0, Linux', '2022-01-15 08:50:40');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (26, 'administrator@merqconsultancy.org', 'Super Admin', '196.189.57.154', 'Firefox 97.0, Windows 10', '2022-01-17 07:53:23');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (27, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.107.120', 'Firefox 97.0, Windows 10', '2022-01-17 13:54:38');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (28, 'administrator@merqconsultancy.org', 'Super Admin', '196.189.57.154', 'Firefox 97.0, Windows 10', '2022-01-26 07:28:17');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (29, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.162', 'Firefox 91.0, Linux', '2022-03-17 10:58:03');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (30, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.111.234', 'Firefox 91.0, Linux', '2022-04-02 12:38:33');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (31, 'pat1', 'patient', '197.156.111.234', 'Firefox 91.0, Linux', '2022-04-02 12:51:49');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (32, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.111.234', 'Firefox 91.0, Linux', '2022-04-02 16:05:28');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (33, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.111.234', 'Opera 67.1.3508.63168, Android', '2022-04-02 17:49:23');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (34, 'pat1', 'patient', '197.156.111.234', 'Opera 67.1.3508.63168, Android', '2022-04-02 17:59:11');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (35, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.126', 'Firefox 91.0, Linux', '2022-04-03 11:25:27');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (36, 'michaelktd@gmail.com', 'Doctor', '197.156.103.126', 'Firefox 91.0, Linux', '2022-04-03 12:08:54');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (37, 'pat3', 'patient', '197.156.103.126', 'Firefox 91.0, Linux', '2022-04-03 13:01:56');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (38, 'pat1', 'patient', '197.156.103.126', 'Firefox 91.0, Linux', '2022-04-03 13:23:39');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (39, 'michaelktd@gmail.com', 'Doctor', '197.156.103.126', 'Firefox 91.0, Linux', '2022-04-03 13:29:18');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (40, 'michaelktd@gmail.com', 'Doctor', '197.156.103.126', 'Chrome 100.0.4896.60, Linux', '2022-04-03 13:30:56');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (41, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.126', 'Firefox 91.0, Linux', '2022-04-03 13:35:10');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (42, 'michaelktd@gmail.com', 'Doctor', '197.156.103.126', 'Firefox 91.0, Linux', '2022-04-03 13:42:40');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (43, 'merqsys@gmail.com', 'Receptionist', '197.156.103.126', 'Chrome 100.0.4896.60, Linux', '2022-04-03 14:30:48');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (44, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.126', 'Opera 67.1.3508.63168, Android', '2022-04-03 18:21:28');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (45, 'michaelktd@gmail.com', 'Doctor', '197.156.103.177', 'Firefox 99.0, Windows 10', '2022-04-04 11:09:13');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (46, 'pat1', 'patient', '197.156.103.177', 'Firefox 99.0, Windows 10', '2022-04-04 11:11:04');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (47, 'pat1', 'patient', '197.156.103.177', 'Firefox 99.0, Windows 10', '2022-04-04 11:12:00');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (48, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.177', 'Firefox 91.0, Linux', '2022-04-04 12:17:55');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (49, 'michaelktd@gmail.com', 'Doctor', '41.216.105.95', 'Chrome 99.0.4844.84, Windows 10', '2022-04-04 13:00:03');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (50, 'pat1', 'patient', '197.156.103.177', 'Firefox 91.0, Linux', '2022-04-05 06:53:32');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (51, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.177', 'Firefox 91.0, Linux', '2022-04-05 06:54:46');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (52, 'pat1', 'patient', '196.189.38.70', 'Chrome 50.0.2661.102, Windows 10', '2022-04-05 07:32:56');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (53, 'pat4', 'patient', '196.189.38.70', 'Chrome 99.0.4844.51, Linux', '2022-04-06 08:14:50');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (54, 'pat1', 'patient', '196.189.38.70', 'Chrome 99.0.4844.51, Linux', '2022-04-06 08:18:14');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (55, 'michaelktd@gmail.com', 'Doctor', '196.189.38.70', 'Chrome 99.0.4844.51, Linux', '2022-04-06 08:25:20');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (56, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.157', 'Firefox 91.0, Linux', '2022-04-06 11:13:17');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (57, 'michaelktd@gmail.com', 'Doctor', '197.156.86.45', 'Chrome 100.0.4896.58, Android', '2022-04-10 08:21:29');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (58, 'michaelktd@gmail.com', 'Doctor', '41.216.120.106', 'Chrome 100.0.4896.75, Windows 10', '2022-04-11 15:20:18');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (59, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.39', 'Firefox 100.0, Windows 10', '2022-04-18 15:22:32');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (60, 'pat1', 'patient', '197.156.103.13', 'Firefox 91.0, Linux', '2022-04-19 14:48:56');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (61, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.13', 'Firefox 91.0, Linux', '2022-04-19 15:25:38');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (62, 'pat1', 'patient', '197.156.103.13', 'Opera 67.1.3508.63168, Android', '2022-04-19 17:47:35');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (63, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.13', 'Opera 67.1.3508.63168, Android', '2022-04-19 18:50:23');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (64, 'pat1', 'patient', '196.189.38.70', 'Chrome 100.0.4896.127, Linux', '2022-04-21 09:37:47');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (65, 'michaelktd@gmail.com', 'Doctor', '196.189.38.70', 'Chrome 100.0.4896.127, Linux', '2022-04-21 09:39:33');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (66, 'pat1', 'patient', '197.156.103.13', 'Firefox 91.0, Linux', '2022-04-22 12:19:24');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (67, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.197', 'Firefox 100.0, Windows 10', '2022-04-27 11:17:35');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (68, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.197', 'Firefox 91.0, Linux', '2022-04-27 12:53:02');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (69, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.197', 'Firefox 100.0, Windows 10', '2022-04-30 14:07:47');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (70, 'pat1', 'patient', '197.156.86.197', 'Firefox 100.0, Windows 10', '2022-04-30 14:08:02');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (71, 'pat1', 'patient', '196.188.181.114', 'Chrome 101.0.4951.41, Linux', '2022-05-01 15:28:49');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (72, 'michaelktd@gmail.com', 'Doctor', '196.188.181.114', 'Chrome 101.0.4951.41, Linux', '2022-05-01 15:31:25');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (73, 'administrator@merqconsultancy.org', 'Super Admin', '196.188.55.163', 'Firefox 100.0, Windows 10', '2022-05-02 11:04:04');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (74, 'pat1', 'patient', '196.188.55.163', 'Firefox 100.0, Windows 10', '2022-05-02 11:04:25');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (75, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.197', 'Firefox 91.0, Linux', '2022-05-02 14:09:09');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (76, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.197', 'Opera 68.3.3557.64528, Android', '2022-05-02 17:12:08');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (77, 'pat1', 'patient', '197.156.86.197', 'Firefox 100.0, Windows 10', '2022-05-03 08:41:56');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (78, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.197', 'Firefox 100.0, Windows 10', '2022-05-03 08:43:40');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (79, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.228', 'Firefox 91.0, Linux', '2022-05-03 15:59:06');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (80, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.37', 'Firefox 91.0, Linux', '2022-05-04 13:07:48');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (81, 'pat1', 'patient', '197.156.86.37', 'Firefox 91.0, Linux', '2022-05-04 13:08:51');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (82, 'pat1', 'patient', '197.156.103.230', 'Chrome 100.0.4896.127, Windows 10', '2022-05-05 15:00:17');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (83, 'michaelktd@gmail.com', 'Doctor', '196.189.80.17', 'Chrome 100.0.4896.127, Windows 10', '2022-05-05 15:05:57');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (84, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.37', 'Firefox 91.0, Linux', '2022-05-06 14:12:07');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (85, 'michaelktd@gmail.com', 'Doctor', '197.156.86.37', 'Firefox 91.0, Linux', '2022-05-06 15:58:43');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (86, 'merqerp@gmail.com', 'Pharmacist', '197.156.86.37', 'Firefox 91.0, Linux', '2022-05-06 17:52:56');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (87, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.37', 'Firefox 101.0, Windows 10', '2022-05-07 10:05:54');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (88, 'pat1', 'patient', '197.156.86.37', 'Firefox 101.0, Windows 10', '2022-05-07 11:00:17');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (89, 'michaelktd7@gmail.com', 'Nurse', '197.156.86.37', 'Firefox 101.0, Windows 10', '2022-05-07 11:12:53');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (90, 'pat1', 'patient', '197.156.86.37', 'Firefox 101.0, Windows 10', '2022-05-07 11:33:29');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (91, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.37', 'Firefox 101.0, Windows 10', '2022-05-07 11:42:14');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (92, 'pat1', 'patient', '197.156.86.37', 'Firefox 101.0, Windows 10', '2022-05-07 11:43:54');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (93, 'pat1', 'patient', '197.156.86.37', 'Firefox 91.0, Linux', '2022-05-07 12:31:09');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (94, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.64.106', 'Firefox 91.0, Linux', '2022-05-09 09:06:43');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (95, 'michaelktd@gmail.com', 'Doctor', '196.190.60.246', 'Chrome 38.0.2125.102, Android', '2022-05-09 11:58:50');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (96, 'administrator@merqconsultancy.org', 'Super Admin', '196.189.38.70', 'Firefox 91.0, Linux', '2022-05-10 08:40:44');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (97, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.64.106', 'Firefox 101.0, Windows 10', '2022-05-11 07:55:45');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (98, 'administrator@merqconsultancy.org', 'Super Admin', '196.189.38.70', 'Firefox 91.0, Linux', '2022-05-12 07:26:37');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (99, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.77.141', 'Firefox 101.0, Windows 10', '2022-05-12 13:08:08');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (100, 'pat1', 'patient', '197.156.77.141', 'Firefox 101.0, Windows 10', '2022-05-12 13:08:43');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (101, 'pat1', 'patient', '196.191.221.163', 'Firefox 101.0, Windows 10', '2022-05-14 12:46:10');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (102, 'administrator@merqconsultancy.org', 'Super Admin', '196.191.221.163', 'Firefox 101.0, Windows 10', '2022-05-14 12:47:09');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (103, 'pat1', 'patient', '196.191.61.239', 'Firefox 101.0, Windows 10', '2022-05-17 13:38:43');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (104, 'administrator@merqconsultancy.org', 'Super Admin', '196.191.61.239', 'Firefox 101.0, Windows 10', '2022-05-17 13:39:08');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (105, 'pat1', 'patient', '196.191.61.239', 'Firefox 101.0, Windows 10', '2022-05-17 14:55:17');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (106, 'administrator@merqconsultancy.org', 'Super Admin', '196.191.61.239', 'Firefox 101.0, Windows 10', '2022-05-17 14:59:31');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (107, 'administrator@merqconsultancy.org', 'Super Admin', '196.191.61.239', 'Opera 69.0.3606.64982, Android', '2022-05-17 17:01:51');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (108, 'pat1', 'patient', '197.156.118.239', 'Firefox 91.0, Linux', '2022-05-24 16:30:09');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (109, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.118.239', 'Firefox 91.0, Linux', '2022-05-24 16:33:16');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (110, 'administrator@merqconsultancy.org', 'Super Admin', '196.189.38.70', 'Firefox 91.0, Linux', '2022-06-13 07:32:55');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (111, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.111.137', 'Firefox 102.0, Windows 10', '2022-06-14 13:52:48');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (112, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.212', 'Firefox 91.0, Linux', '2022-06-23 08:34:43');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (113, 'pat1', 'patient', '197.156.103.212', 'Firefox 91.0, Linux', '2022-06-23 08:37:43');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (114, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.103.114', 'Firefox 103.0, Windows 10', '2022-07-02 16:33:31');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (115, 'pat1', 'patient', '197.156.103.114', 'Firefox 103.0, Windows 10', '2022-07-02 17:28:06');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (116, 'pat1', 'patient', '197.156.103.114', 'Firefox 103.0, Windows 10', '2022-07-02 17:46:32');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (117, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.219', 'Firefox 103.0, Windows 10', '2022-07-08 09:31:41');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (118, 'pat1', 'patient', '197.156.86.219', 'Firefox 103.0, Windows 10', '2022-07-08 09:36:21');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (119, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.86.219', 'Firefox 103.0, Windows 10', '2022-07-09 13:02:27');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (120, 'pat1', 'patient', '197.156.86.219', 'Firefox 103.0, Windows 10', '2022-07-09 13:24:29');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (121, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.118.211', 'Firefox 103.0, Windows 10', '2022-07-15 12:55:04');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (122, 'administrator@merqconsultancy.org', 'Super Admin', '197.156.111.176', 'Firefox 103.0, Windows 10', '2022-07-20 19:57:50');
INSERT INTO `userlog` (`id`, `user`, `role`, `ipaddress`, `user_agent`, `login_datetime`) VALUES (123, 'administrator@merqconsultancy.org', 'Super Admin', '196.191.52.222', 'Firefox 103.0, Windows 10', '2022-07-23 11:17:38');


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `childs` text DEFAULT NULL,
  `role` varchar(30) NOT NULL,
  `verification_code` varchar(200) NOT NULL,
  `is_active` varchar(10) DEFAULT 'yes',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `users` (`id`, `user_id`, `username`, `password`, `childs`, `role`, `verification_code`, `is_active`, `created_at`) VALUES (1, 1, 'pat1', '01234567', NULL, 'patient', '', 'yes', '2022-04-02 12:44:24');
INSERT INTO `users` (`id`, `user_id`, `username`, `password`, `childs`, `role`, `verification_code`, `is_active`, `created_at`) VALUES (2, 2, 'pat2', '8oa8a8', NULL, 'patient', '', 'yes', '2022-01-17 07:57:52');
INSERT INTO `users` (`id`, `user_id`, `username`, `password`, `childs`, `role`, `verification_code`, `is_active`, `created_at`) VALUES (3, 3, 'pat3', '7suwzb', NULL, 'patient', '', 'yes', '2022-04-03 13:01:55');
INSERT INTO `users` (`id`, `user_id`, `username`, `password`, `childs`, `role`, `verification_code`, `is_active`, `created_at`) VALUES (4, 4, 'pat4', 'bveibs', NULL, 'patient', '', 'yes', '2022-04-06 08:14:49');


#
# TABLE STRUCTURE FOR: users_authentication
#

DROP TABLE IF EXISTS `users_authentication`;

CREATE TABLE `users_authentication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) DEFAULT NULL,
  `token` varchar(200) NOT NULL,
  `expired_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: vehicles
#

DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `vehicle_no` varchar(20) DEFAULT NULL,
  `vehicle_model` varchar(100) NOT NULL DEFAULT 'None',
  `manufacture_year` varchar(4) DEFAULT NULL,
  `vehicle_type` varchar(100) NOT NULL,
  `driver_name` varchar(50) DEFAULT NULL,
  `driver_licence` varchar(50) NOT NULL DEFAULT 'None',
  `driver_contact` varchar(20) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `vehicles` (`id`, `vehicle_no`, `vehicle_model`, `manufacture_year`, `vehicle_type`, `driver_name`, `driver_licence`, `driver_contact`, `note`, `created_at`) VALUES (1, 'AMB-001', 'Toyota Landcruiser Longbase', '2020', 'Owned', 'Bekele Kebede', 'DRV-Lic12345678', '0913391985', 'Our Ambulance Driver', '2022-04-03 14:24:17');


#
# TABLE STRUCTURE FOR: visit_details
#

DROP TABLE IF EXISTS `visit_details`;

CREATE TABLE `visit_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `opd_details_id` int(11) DEFAULT NULL,
  `organisation_id` int(11) DEFAULT NULL,
  `patient_charge_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `cons_doctor` int(11) DEFAULT NULL,
  `case_type` varchar(200) NOT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `symptoms_type` int(11) DEFAULT NULL,
  `symptoms` varchar(200) DEFAULT NULL,
  `bp` varchar(100) DEFAULT NULL,
  `height` varchar(100) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `pulse` varchar(200) DEFAULT NULL,
  `temperature` varchar(200) DEFAULT NULL,
  `respiration` varchar(200) DEFAULT NULL,
  `known_allergies` varchar(100) DEFAULT NULL,
  `patient_old` varchar(50) DEFAULT NULL,
  `casualty` varchar(200) DEFAULT NULL,
  `refference` varchar(200) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `note` text DEFAULT NULL,
  `note_remark` mediumtext DEFAULT NULL,
  `payment_mode` varchar(100) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `live_consult` varchar(50) NOT NULL,
  `can_delete` varchar(11) NOT NULL DEFAULT 'yes',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `generated_by` (`generated_by`),
  KEY `opd_details_id` (`opd_details_id`),
  KEY `organisation_id` (`organisation_id`),
  KEY `cons_doctor` (`cons_doctor`),
  KEY `patient_charge_id` (`patient_charge_id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `visit_details_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `visit_details_ibfk_2` FOREIGN KEY (`opd_details_id`) REFERENCES `opd_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `visit_details_ibfk_3` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE,
  CONSTRAINT `visit_details_ibfk_4` FOREIGN KEY (`cons_doctor`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `visit_details_ibfk_5` FOREIGN KEY (`patient_charge_id`) REFERENCES `patient_charges` (`id`) ON DELETE SET NULL,
  CONSTRAINT `visit_details_ibfk_6` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (1, 1, NULL, 1, 1, 4, 'ANC', '2021-12-20 09:00:00', NULL, '', '', '', '', '', '', '', '', NULL, 'no', '', NULL, '', NULL, 'Cash', 1, 'yes', 'no', '2021-12-17 17:06:33');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (2, 2, NULL, 2, 2, 4, 'COVID 19', '2022-01-19 11:00:00', 1, 'Dry Caugh', '120/80', '190', '90', '71', '31', '16', '', NULL, 'yes', '', NULL, '', NULL, 'Cash', 1, 'yes', 'no', '2022-01-17 08:01:38');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (3, 3, NULL, 3, 4, 5, '', '2022-05-02 07:55:00', NULL, '', '', '', '', '', '', '', NULL, NULL, NULL, '', NULL, 'test Note', NULL, '', 1, 'yes', 'no', '2022-05-02 16:55:08');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (4, 4, NULL, 4, 5, 5, '', '2022-05-02 07:55:00', 9, 'Asthma\r\nAsthma is a condition in which your airways narrow and swell and may produce extra mucus. This can make breathing difficult and trigger coughing, a whistling sound (wheezing) when you breathe ', '120/80', '168', '67', '73', '36', '90', '', 'no', 'no', '', NULL, '', NULL, 'Cash', 1, 'no', 'no', '2022-05-06 15:57:03');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (5, 5, 1, 5, 6, 5, '', '2022-05-13 08:15:00', 9, 'Asthma\r\nAsthma is a condition in which your airways narrow and swell and may produce extra mucus. This can make breathing difficult and trigger coughing, a whistling sound (wheezing) when you breathe ', '120/80', '168', '67', '73', '36', '90', '', 'yes', 'yes', '', NULL, '', NULL, 'Cash', 5, 'yes', 'no', '2022-05-06 16:25:45');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (6, 6, 1, 6, 8, 5, '', '2022-05-13 08:15:00', 3, 'Fever\r\nPatient is having a high temperature Head Ache with Fever further Diagnosis is required!', '120/80', '168', '67', '73', '36', '90', '', 'no', 'no', '', NULL, '', NULL, 'Cash', 3, 'yes', 'no', '2022-05-07 11:37:25');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (7, 7, 2, 7, 9, 5, '', '2022-01-19 11:00:00', 10, 'trauma\r\nraped', '120/80', '190', '90', '71', '31', '16', 'iogiguhgjhkhgjhgk', 'yes', 'no', '', NULL, 'hghgcjhcjvhcj', NULL, 'Cash', 1, 'no', 'no', '2022-06-13 07:43:29');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (8, 8, 1, 8, 10, 5, '', '2022-05-13 08:15:00', 3, 'Fever\r\nPatient is having a high temperature Head Ache with Fever further Diagnosis is required!', '120/80', '168', '67', '73', '36', '90', 'pen', 'no', 'no', '', NULL, '', NULL, 'Cash', 1, 'yes', 'no', '2022-06-23 08:43:46');
INSERT INTO `visit_details` (`id`, `opd_details_id`, `organisation_id`, `patient_charge_id`, `transaction_id`, `cons_doctor`, `case_type`, `appointment_date`, `symptoms_type`, `symptoms`, `bp`, `height`, `weight`, `pulse`, `temperature`, `respiration`, `known_allergies`, `patient_old`, `casualty`, `refference`, `date`, `note`, `note_remark`, `payment_mode`, `generated_by`, `live_consult`, `can_delete`, `created_at`) VALUES (9, 9, 2, 9, 12, 5, '', '2022-05-17 08:35:00', 5, 'Cramps and injuries\r\nMuscle pain: Muscle spasms, cramps and injuries can all cause muscle pain. Some infections or tumors may also lead to muscle pain. Tendon and ligament pain: Ligaments and tendons ', '120/80', '168', '67', '73', '36', '90', 'pen', 'no', 'yes', '', NULL, '', NULL, 'Cash', 1, 'yes', 'no', '2022-07-09 13:40:06');


#
# TABLE STRUCTURE FOR: visitors_book
#

DROP TABLE IF EXISTS `visitors_book`;

CREATE TABLE `visitors_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) DEFAULT NULL,
  `purpose` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact` varchar(12) NOT NULL,
  `id_proof` varchar(50) NOT NULL,
  `visit_to` varchar(20) NOT NULL,
  `ipd_opd_staff_id` int(11) DEFAULT NULL,
  `related_to` varchar(60) NOT NULL,
  `no_of_pepple` int(11) NOT NULL,
  `date` date NOT NULL,
  `in_time` varchar(20) NOT NULL,
  `out_time` varchar(20) NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `image` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: visitors_purpose
#

DROP TABLE IF EXISTS `visitors_purpose`;

CREATE TABLE `visitors_purpose` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitors_purpose` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: zoom_settings
#

DROP TABLE IF EXISTS `zoom_settings`;

CREATE TABLE `zoom_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zoom_api_key` varchar(200) DEFAULT NULL,
  `zoom_api_secret` varchar(200) DEFAULT NULL,
  `use_doctor_api` int(1) DEFAULT 1,
  `use_zoom_app` int(1) DEFAULT 1,
  `opd_duration` int(11) DEFAULT NULL,
  `ipd_duration` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `zoom_settings` (`id`, `zoom_api_key`, `zoom_api_secret`, `use_doctor_api`, `use_zoom_app`, `opd_duration`, `ipd_duration`, `created_at`) VALUES (1, 'BGE4yvYSQEC5MyxaptgQJQ', 'eJDdilXOy5qotAAoEORASssonfreMZejqj1l', 1, 1, 15, 15, '2022-04-03 12:25:10');


