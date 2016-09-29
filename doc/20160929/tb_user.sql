/*
SQLyog v10.2 
MySQL - 5.6.21-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tb_user` (
	`pass` varchar (600),
	`userId` varchar (300),
	`roleId` varchar (300),
	`phone` varchar (300),
	`realName` varchar (600),
	`deptId` varchar (300),
	`mobile` varchar (300),
	`email` varchar (300),
	`isDeleted` int (11),
	`createDate` datetime ,
	`updateDate` datetime ,
	`birthday` date ,
	`sex` int (1),
	`position` varchar (300),
	`positionSalary` varchar (300),
	`levelSalary` varchar (300),
	`performanceSalary` varchar (300),
	`interest` varchar (6000),
	`entryDate` datetime ,
	`nativePlace` varchar (300),
	`nation` varchar (300),
	`politicsStatus` varchar (300),
	`certId` varchar (300),
	`school` varchar (600),
	`eduLevel` varchar (300),
	`homeAddress` varchar (3000),
	`major` varchar (300),
	`remark` varchar (300),
	`status` varchar (300),
	`certFront` varchar (600),
	`certBack` varchar (600),
	`infoPdf` varchar (600)
); 
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values(NULL,'',NULL,NULL,NULL,'0102',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','12312312','1','234234','发光时代','0101','43245','3243243@qq.com',NULL,'2016-09-25 13:12:21','2016-09-25 13:12:21','2016-09-13','0','0',NULL,NULL,NULL,'范德萨发大水发','2016-09-14 00:00:00','江西','汉','0','432','下','0','发的发达','土木','发顺丰','0','D://uploadFile/cert//1474780297912.jpg','D://uploadFile/cert//1474780297918.jpg',NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','2312121','1','11111111','的撒发生','0102','1111111111','1111111@qq.com',NULL,'2016-09-25 21:24:13','2016-09-25 21:24:13','2016-09-13','1','2',NULL,NULL,NULL,'发大水发大水发','2016-09-20 00:00:00','上饶','满','2','11111111111','东大','3','发大水发大水发','软件','放大法发大水发','1','D://uploadFile/cert//1474809853903.jpg','D://uploadFile/cert//1474809853913.jpg',NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','23423143','1','11111111','的撒发生','0102','1111111111','1111111@qq.com',NULL,'2016-09-25 21:17:07','2016-09-25 21:17:07','2016-09-13','1','2',NULL,NULL,NULL,'发大水发大水发','2016-09-20 00:00:00','上饶','满','2','11111111111','东大','3','发大水发大水发','软件','放大法发大水发','1','D://uploadFile/cert//1474809423539.jpg','D://uploadFile/cert//1474809423600.jpg',NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','23423143213','1','11111111','的撒发生','0102','1111111111','1111111@qq.com',NULL,'2016-09-25 21:22:24','2016-09-25 21:22:24','2016-09-13','1','2',NULL,NULL,NULL,'发大水发大水发','2016-09-20 00:00:00','上饶','满','2','11111111111','东大','3','发大水发大水发','软件','放大法发大水发','1','D://uploadFile/cert//1474809744653.jpg','D://uploadFile/cert//1474809744657.jpg',NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','324','1','3454325','发给','0101','543252345','1021960409@qq.com',NULL,'2016-09-25 12:42:04','2016-09-25 12:42:04',NULL,'0','0',NULL,NULL,NULL,'发大水发斯蒂芬\r\n发顺丰',NULL,'江西','汉','0','345325','厦大','0','发送发大水发大厦发','土木','发大水发大厦','0',NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','3241312','1','23423','范德萨f','0101','4234312',NULL,NULL,'2016-09-25 11:50:30','2016-09-25 11:50:30',NULL,'0','0',NULL,NULL,NULL,'发大水发大厦',NULL,'江西','汉','0','345423432','厦大','0','发的发的是发','土木','法第三方爱发呆','0',NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','3242342','1','3454325','发给','0101','543252345','1021960409@qq.com',NULL,'2016-09-25 12:45:23','2016-09-25 12:45:23','2016-09-12','0','0',NULL,NULL,NULL,'发大水发斯蒂芬\r\n发顺丰',NULL,'江西','汉','0','345325','厦大','0','发送发大水发大厦发','土木','发大水发大厦','0',NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','34132','2','2342','放大发','0101','34214','234234@qq.com',NULL,'2016-09-25 21:47:51','2016-09-25 21:47:51','2016-09-13','1','1',NULL,NULL,NULL,'fadsfa','2016-09-13 00:00:00','广发','回','0','43214312','东大','1','fdsafads','软件','fdsafa','1','D://uploadFile/cert//1474811271556.jpg','D://uploadFile/cert//1474811271563.jpg',NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values(NULL,'3423','0','gg','asdf','0101','15889932784',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','34234','1','23423','法第三方','0102','324123','3243243@qq.com',NULL,'2016-09-25 11:55:31','2016-09-25 11:55:31',NULL,'0','0',NULL,NULL,NULL,'范德萨发生的\r\n发大水发大厦',NULL,'江西','汉','0','34254325','厦大','0','发大水发大厦','土木','发大水发大厦23','0',NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('21218cca77804d2ba1922c33e0151105','34532','1','324534','管是否规范','0101','4353','1021960409@qq.com',NULL,'2016-09-25 13:01:38','2016-09-25 13:01:38','2016-09-13','0','0',NULL,NULL,NULL,'发大水发大水发三\r\n发大水发的撒\r\n法第三方','2016-09-14 00:00:00','江西','汉','0','54325234','厦大','0','范德萨发的萨芬撒','土木','范德萨发大水','0',NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values(NULL,'4234','0','hhhh132423','回复','0101','15488993241',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert into `tb_user` (`pass`, `userId`, `roleId`, `phone`, `realName`, `deptId`, `mobile`, `email`, `isDeleted`, `createDate`, `updateDate`, `birthday`, `sex`, `position`, `positionSalary`, `levelSalary`, `performanceSalary`, `interest`, `entryDate`, `nativePlace`, `nation`, `politicsStatus`, `certId`, `school`, `eduLevel`, `homeAddress`, `major`, `remark`, `status`, `certFront`, `certBack`, `infoPdf`) values('202cb962ac59075b964b07152d234b70','admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
