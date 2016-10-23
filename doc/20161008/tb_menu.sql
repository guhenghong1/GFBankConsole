/*
SQLyog v10.2 
MySQL - 5.6.21-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tb_menu` (
	`menuId` varchar (300),
	`menuName` varchar (600),
	`superMenuId` varchar (300),
	`remark` varchar (6000),
	`linkUrl` varchar (3000)
); 
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('1000','部门机构管理','0001',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('0001','总菜单项','0000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('2000','系统管理','0001',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('2100','用户管理','2000','user/init.do','user/init.do');
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('2200','菜单管理','2000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('3000','文件管理','0001',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('3100','收文处理','3000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('3200','发文处理','3000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('4000','物资设备管理','0001',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('4100','设备管理','4000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('4200','供应商管理','4000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('5000','业务应用管理','0001',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('5100','权证录入','5000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('5200','权证信息修改','5000',NULL,NULL);
insert into `tb_menu` (`menuId`, `menuName`, `superMenuId`, `remark`, `linkUrl`) values('1100','机构管理','1000','/dept/init.do','/dept/init.do');
