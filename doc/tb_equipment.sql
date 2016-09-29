/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : water

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-09-29 20:47:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_equipment
-- ----------------------------
DROP TABLE IF EXISTS `tb_equipment`;
CREATE TABLE `tb_equipment` (
  `id` varchar(100) NOT NULL COMMENT '设备编号',
  `name` varchar(200) DEFAULT NULL COMMENT '设备名称',
  `type` varchar(200) DEFAULT NULL COMMENT '设备型号',
  `location` varchar(100) DEFAULT NULL COMMENT '所在地',
  `in_use` int(2) DEFAULT NULL COMMENT '设备状态，1表示在用，0表示报废',
  `company_id` varchar(100) DEFAULT NULL COMMENT '供应商编号',
  `buy_time` date DEFAULT NULL COMMENT '购入时间',
  `price` varchar(50) DEFAULT NULL COMMENT '价格',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `dept_id` varchar(100) DEFAULT NULL COMMENT '部门编号',
  `status` int(2) DEFAULT '1' COMMENT '状态，1表示正常，0表示删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备表';

-- ----------------------------
-- Records of tb_equipment
-- ----------------------------
INSERT INTO `tb_equipment` VALUES ('1', '设备修改1', '型号1修改1', '行政部办公室1修改1', '1', '2', '2016-09-29', '123451', '备注修改1', '2', '1', '2016-09-29 17:57:32', '2016-09-29 19:16:26');
INSERT INTO `tb_equipment` VALUES ('11', '设备11', '型号1', '行政部办公室1', '1', '666661', '2016-09-29', '4561', '备注', '12221', '0', '2016-09-29 17:58:12', '2016-09-29 18:02:46');
INSERT INTO `tb_equipment` VALUES ('12', '123', '123', '123', '0', '2', '2016-09-29', '123', '123', '0102', '1', '2016-09-29 20:06:17', '2016-09-29 20:07:13');
INSERT INTO `tb_equipment` VALUES ('2', '设备2', '型号2', '中央', '1', '2', '2016-09-29', '559', '设备备注', '2', '1', '2016-09-29 19:15:20', '2016-09-29 19:15:20');
