/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : water

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-09-29 20:47:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_send_repair
-- ----------------------------
DROP TABLE IF EXISTS `tb_send_repair`;
CREATE TABLE `tb_send_repair` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `equipment_id` varchar(100) DEFAULT NULL COMMENT '设备编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='送修表';

-- ----------------------------
-- Records of tb_send_repair
-- ----------------------------
INSERT INTO `tb_send_repair` VALUES ('1', '1', '2016-09-29 20:27:27', '2016-09-29 20:27:27');
INSERT INTO `tb_send_repair` VALUES ('2', '2', '2016-09-29 20:46:05', '2016-09-29 20:46:05');
