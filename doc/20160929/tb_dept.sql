/*
SQLyog v10.2 
MySQL - 5.6.21-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tb_dept` (
	`deptId` varchar (300),
	`deptName` varchar (600),
	`superDeptId` varchar (300),
	`level` varchar (30),
	`remark` varchar (6000),
	`isLeaf` int (11),
	`status` tinyint (1)
); 
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0001','总行','0000','0',NULL,'0','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0100','上饶支行','0001','1',NULL,'0','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0101','广丰支行','0100','2',NULL,'1','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0102','婺源支行','0100','2',NULL,'1','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0103','三清山支行','0100','2',NULL,'1','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0200','南昌支行','0001','1',NULL,'0','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0201','清湖支行','0200','2',NULL,'1','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0202','广场东路支行','0200','2',NULL,'1','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0203','老福山支行','0200','2',NULL,'1','0');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `remark`, `isLeaf`, `status`) values('0204','中山路支行','0200','2',NULL,'1','0');
