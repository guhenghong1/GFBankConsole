package com.bank.console.file.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bank.console.common.ConfigProperty;
import com.bank.console.common.FilePath;
import com.bank.console.common.util.FileUtil;
import com.bank.console.file.form.RecFileForm;
import com.bank.console.file.model.RecFile;
import com.bank.console.file.vo.RecFileVO;
import com.bank.console.mapper.RecFileMapper;

@Service
public class RecFileService {
	@Autowired
	private RecFileMapper recFileMapper;
	
	
	/**
	 * 新增文件
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	public int addFile(RecFileForm form) throws Exception {
		String path = ConfigProperty.UPLOAD_FILE_PATH + File.separator + FilePath.REC_FILE + File.separator;
		MultipartFile fileItem = form.getFileItem();
		String attachment = FileUtil.saveFile(fileItem, path);
		form.setAttachment(attachment);
		return recFileMapper.addFile(form);
	}
	
	/**
	 * 修改文件
	 * @param file
	 * @return
	 */
	public int updateFile(RecFileForm file) {
		return recFileMapper.updateFile(file);
	}
	
	/**
	 * 删除文件
	 * @param fileId
	 * @return
	 */
	public int deleteFile(String fileId) {
		return recFileMapper.deleteFile(fileId);
	}

	/**
	 * 获取文件列表
	 * @param file
	 * @return
	 */
	public List<RecFileVO> getFileList(RecFileForm file) {
		return recFileMapper.getFileList(file);
	}
	
	/**
	 * 获取文件详情
	 * @param file
	 * @return
	 */
	public RecFile getFileInfo(String fileId) {
		return recFileMapper.getFileInfo(fileId);
	}
	
	/**
	 * 获取数量
	 * @param file
	 * @return
	 */
	public int getFileSum(RecFileForm file) {
		return recFileMapper.getFileSum(file);
	}
}
