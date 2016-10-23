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
/*Table structure for table `tb_learning_materials` */

CREATE TABLE `tb_learning_materials` (
  `id` varchar(100) DEFAULT NULL COMMENT '编号',
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `attachment` varchar(200) DEFAULT NULL COMMENT '附件',
  `viewCount` int(11) DEFAULT NULL COMMENT '浏览数',
  `createDate` date DEFAULT NULL,
  `updateDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_learning_materials` */

insert  into `tb_learning_materials`(`id`,`title`,`remark`,`attachment`,`viewCount`,`createDate`,`updateDate`) values ('1','开口111','科技和空间','D://uploadFile/learn/20161021/顾恒鸿 - 副本.doc',34,'2016-10-21','2016-10-21');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
