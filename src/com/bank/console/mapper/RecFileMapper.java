package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.file.form.RecFileForm;
import com.bank.console.file.model.RecFile;
import com.bank.console.file.vo.RecFileVO;

@Repository
public interface RecFileMapper {
	//新增文件
	int addFile(RecFileForm file);
	
	//修改文件
	int updateFile(RecFileForm file);
	
	//删除文件
	int deleteFile(String fileId);
	
	//获取文件详情
	RecFileVO getFileInfo(String fileId);
	
	//查询列表
	List<RecFileVO> getFileList(RecFileForm file);
	
	//查询数量
	int getFileSum(RecFileForm file);
	
	/**
	 * 
	 */
	String getMaxFileId();
}
