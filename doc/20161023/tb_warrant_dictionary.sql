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
/*Table structure for table `tb_warrant_dictionary` */

CREATE TABLE `tb_warrant_dictionary` (
  `id` varchar(100) DEFAULT NULL COMMENT '编号',
  `name` varchar(2000) DEFAULT NULL COMMENT '名称',
  `type` int(11) DEFAULT NULL COMMENT '词典类型 0证号  1部门  2备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_warrant_dictionary` */

insert  into `tb_warrant_dictionary`(`id`,`name`,`type`) values ('3','市政',0);
insert  into `tb_warrant_dictionary`(`id`,`name`,`type`) values ('4','证号1',0);
insert  into `tb_warrant_dictionary`(`id`,`name`,`type`) values ('5','贷款10',0);
insert  into `tb_warrant_dictionary`(`id`,`name`,`type`) values ('6','银行',1);
insert  into `tb_warrant_dictionary`(`id`,`name`,`type`) values ('7','证号10',0);
insert  into `tb_warrant_dictionary`(`id`,`name`,`type`) values ('8','贷款100w',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
