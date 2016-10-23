/*
SQLyog v10.2 
MySQL - 5.6.21-log : Database - water
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `tb_warrant` */

CREATE TABLE `tb_warrant` (
  `id` varchar(100) DEFAULT NULL COMMENT '编号',
  `type` varchar(100) DEFAULT NULL COMMENT '权证类型',
  `borrower` varchar(200) DEFAULT NULL COMMENT '借款人',
  `normLimit` int(225) DEFAULT NULL COMMENT '额度单位万元',
  `propertyOwner` varchar(200) DEFAULT NULL COMMENT '产权所有人',
  `cardId` varchar(500) DEFAULT NULL COMMENT '权证证号',
  `deptId` varchar(500) DEFAULT NULL COMMENT '登记部门',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `updateDate` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(11) DEFAULT NULL COMMENT '状态0待入库  1已入库  2出库'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_warrant` */

insert  into `tb_warrant`(`id`,`type`,`borrower`,`normLimit`,`propertyOwner`,`cardId`,`deptId`,`remark`,`createDate`,`updateDate`,`status`) values ('1','1','林丹',10,'林丹','权证证号1','市政','贷款10','2016-10-10 22:51:37','2016-10-10 22:51:37',0);
insert  into `tb_warrant`(`id`,`type`,`borrower`,`normLimit`,`propertyOwner`,`cardId`,`deptId`,`remark`,`createDate`,`updateDate`,`status`) values ('2','2','林丹',10,'林丹','权证证号1','市政','贷款10','2016-10-10 22:54:58','2016-10-10 22:54:58',0);
insert  into `tb_warrant`(`id`,`type`,`borrower`,`normLimit`,`propertyOwner`,`cardId`,`deptId`,`remark`,`createDate`,`updateDate`,`status`) values ('3','0','林丹',10,'林丹','权证证号1','市政','贷款10','2016-10-10 22:56:52','2016-10-10 22:56:52',0);
insert  into `tb_warrant`(`id`,`type`,`borrower`,`normLimit`,`propertyOwner`,`cardId`,`deptId`,`remark`,`createDate`,`updateDate`,`status`) values ('4','3','林丹',10,'林丹','权证证号1','市政','贷款10','2016-10-10 22:57:28','2016-10-10 22:57:28',0);
insert  into `tb_warrant`(`id`,`type`,`borrower`,`normLimit`,`propertyOwner`,`cardId`,`deptId`,`remark`,`createDate`,`updateDate`,`status`) values ('5','1','林丹1',10,'林丹1','证号1','市政','贷款10','2016-10-10 23:37:52','2016-10-10 23:37:52',0);
insert  into `tb_warrant`(`id`,`type`,`borrower`,`normLimit`,`propertyOwner`,`cardId`,`deptId`,`remark`,`createDate`,`updateDate`,`status`) values ('6','0','顾',100,'顾','证号10','银行','贷款100w','2016-10-18 22:43:57','2016-10-18 22:43:57',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
