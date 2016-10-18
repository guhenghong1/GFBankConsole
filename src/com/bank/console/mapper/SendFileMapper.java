package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.file.form.SendFileForm;
import com.bank.console.file.vo.SendFileVO;

@Repository
public interface SendFileMapper {
	//新增文件
		int addFile(SendFileForm file);
		
		//修改文件
		int updateFile(SendFileForm file);
		
		//删除文件
		int deleteFile(String fileId);
		
		//获取文件详情
		SendFileVO getFileInfo(String fileId);
		
		//查询列表
		List<SendFileVO> getFileList(SendFileForm file);
		
		//查询数量
		int getFileSum(SendFileForm file);
		
		/**
		 * 
		 */
		String getMaxFileId();
}
