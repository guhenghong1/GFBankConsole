package com.bank.console.file.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bank.console.common.ConfigProperty;
import com.bank.console.common.FilePath;
import com.bank.console.common.util.FileUtil;
import com.bank.console.file.form.SendFileForm;
import com.bank.console.file.model.SendFile;
import com.bank.console.file.vo.SendFileVO;
import com.bank.console.mapper.SendFileMapper;

@Service
public class SendFileService {
	@Autowired
	private SendFileMapper sendFileMapper;
	
	
	/**
	 * 新增文件
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	public int addFile(SendFileForm form) throws Exception {
		String path = ConfigProperty.UPLOAD_FILE_PATH + File.separator + FilePath.SEND_FILE + File.separator;
		MultipartFile fileItem = form.getFileItem();
		String attachment = FileUtil.saveFile(fileItem, path);
		form.setAttachment(attachment);
		return sendFileMapper.addFile(form);
	}
	
	/**
	 * 修改文件
	 * @param file
	 * @return
	 */
	public int updateFile(SendFileForm file) {
		return sendFileMapper.updateFile(file);
	}
	
	/**
	 * 删除文件
	 * @param fileId
	 * @return
	 */
	public int deleteFile(String fileId) {
		return sendFileMapper.deleteFile(fileId);
	}

	/**
	 * 获取文件列表
	 * @param file
	 * @return
	 */
	public List<SendFileVO> getFileList(SendFileForm file) {
		return sendFileMapper.getFileList(file);
	}
	
	/**
	 * 获取文件详情
	 * @param file
	 * @return
	 */
	public SendFileVO getFileInfo(String fileId) {
		return sendFileMapper.getFileInfo(fileId);
	}
	
	/**
	 * 获取数量
	 * @param file
	 * @return
	 */
	public int getFileSum(SendFileForm file) {
		return sendFileMapper.getFileSum(file);
	}
}
