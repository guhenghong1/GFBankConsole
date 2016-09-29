/*
SQLyog v10.2 
MySQL - 5.6.21-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tb_materials_company` (
	`companyId` varchar (300),
	`company` varchar (300),
	`type` varchar (300),
	`scope` varchar (1500),
	`supplierA` varchar (1500),
	`mobileA` varchar (600),
	`supplierB` varchar (1500),
	`mobileB` varchar (600),
	`scoreLevel` varchar (30),
	`remark` varchar (6000),
	`createDate` datetime ,
	`updateDate` datetime 
); 
