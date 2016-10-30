ALTER TABLE `tb_warrant`
ADD COLUMN `manageNo`  int(10) NULL AUTO_INCREMENT COMMENT '管理编号' AFTER `status` FIRST,
ADD PRIMARY KEY (`manageNo`);