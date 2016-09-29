/*
SQLyog v10.2 
MySQL - 5.6.21-log : Database - water
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`water` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `water`;

/*Table structure for table `tb_materials_company` */

DROP TABLE IF EXISTS `tb_materials_company`;

CREATE TABLE `tb_materials_company` (
  `companyId` varchar(100) DEFAULT NULL COMMENT '供应商编号',
  `company` varchar(100) DEFAULT NULL COMMENT '供应商',
  `type` varchar(100) DEFAULT NULL COMMENT '服务类型',
  `scope` varchar(500) DEFAULT NULL COMMENT '服务范围',
  `supplierA` varchar(500) DEFAULT NULL COMMENT '联系人1',
  `mobileA` varchar(200) DEFAULT NULL COMMENT '联系电话',
  `supplierB` varchar(500) DEFAULT NULL COMMENT '联系人2',
  `mobileB` varchar(200) DEFAULT NULL COMMENT '联系电话',
  `scoreLevel` varchar(10) DEFAULT NULL COMMENT '服务评级',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `updateDate` datetime DEFAULT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_materials_company` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
