/*
SQLyog v10.2 
MySQL - 5.6.21-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tb_send_file` (
	`fileId` varchar (300),
	`deptId` varchar (300),
	`fileNo` varchar (600),
	`fileTitle` varchar (600),
	`keyWords` varchar (600),
	`author` varchar (300),
	`secretLevel` varchar (30),
	`checkAuthor` varchar (300),
	`signAuthor` varchar (1500),
	`createDate` datetime ,
	`updateDate` datetime ,
	`attachment` varchar (600)
); 
insert into `tb_send_file` (`fileId`, `deptId`, `fileNo`, `fileTitle`, `keyWords`, `author`, `secretLevel`, `checkAuthor`, `signAuthor`, `createDate`, `updateDate`, `attachment`) values('432','0101','3421','4321','4321','5423','2','542','543','2016-09-27 00:19:50','2016-09-27 00:19:50','D://uploadFile/sendFile//1474906790426.txt');
