/*
SQLyog v10.2 
MySQL - 5.6.21-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tb_user_menu` (
	`userId` varchar (300),
	`menuId` varchar (300)
); 
insert into `tb_user_menu` (`userId`, `menuId`) values('2341231234','2100');
insert into `tb_user_menu` (`userId`, `menuId`) values('2341231234','3100');
insert into `tb_user_menu` (`userId`, `menuId`) values('2341231234','4100');
insert into `tb_user_menu` (`userId`, `menuId`) values('admin','1000');
insert into `tb_user_menu` (`userId`, `menuId`) values('admin','1100');
insert into `tb_user_menu` (`userId`, `menuId`) values('admin','2100');
insert into `tb_user_menu` (`userId`, `menuId`) values('admin','2000');
