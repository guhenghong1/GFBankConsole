/*
SQLyog v10.2 
MySQL - 5.6.21-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tb_conference` (
	`id` varchar (300),
	`name` varchar (1500),
	`time` datetime ,
	`place` varchar (600),
	`persons` varchar (600),
	`emphasis` varchar (600),
	`content` varchar (6000),
	`remark` varchar (6000),
	`createDate` datetime 
); 
insert into `tb_conference` (`id`, `name`, `time`, `place`, `persons`, `emphasis`, `content`, `remark`, `createDate`) values('21','1234','2016-09-13 00:00:00','fdsa','fdsafds','fdsa','fsad','fas','2016-09-30 22:48:55');
