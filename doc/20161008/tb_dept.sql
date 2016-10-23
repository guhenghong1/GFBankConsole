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
	`isLeaf` int (11),
	`status` tinyint (1),
	`address` varchar (3000),
	`isSalesDept` int (11),
	`remark` varchar (6000)
); 
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('0001','总行','0000','0','0','0','永丰大道','0',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('1000','综合部','0001','1','0','0','永丰大道','0',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('1100','裕丰社区银行','2000','2','1','0','永丰大道','1',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('1200','永丰社区银行','1000','2','1','0',NULL,'1',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('2000','客户部','0001','1','1','0',NULL,'0',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('3000','营业部','0001','1','1','0',NULL,'1',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('4000','广场支行','0001','1','1','0',NULL,'1',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('5000','羊口支行','0001','1','1','0',NULL,'1',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('6000','五都支行','0001','1','1','0',NULL,'1',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('7000','下溪支行','0001','1','1','0',NULL,'1',NULL);
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('7010','上饶支行','0001','1',NULL,'0','范德萨','1','法第三方');
insert into `tb_dept` (`deptId`, `deptName`, `superDeptId`, `level`, `isLeaf`, `status`, `address`, `isSalesDept`, `remark`) values('7020','玉山支行','7010','2',NULL,'0','范德萨','1','范德萨发的');
