CREATE TABLE `facility` (
  `code` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255)
);

CREATE TABLE `opening_info` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `facility_code` int NOT NULL,
  `business_day_start` varchar(255),
  `opening_hours_start` varchar(255),
  `business_day_end` varchar(255),
  `opening_hours_end` varchar(255)
);

CREATE TABLE `manager` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `account` varchar(20)	NOT NULL UNIQUE,
  `password` blob(20) NOT NULL,
  `name` varchar(255),
  `facility_code` int,
  `user_type` SET('admin', 'employee', 'temporary')
);