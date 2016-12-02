package com.bank.console.file.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bank.console.common.BusinessConstant;
import com.bank.console.common.ConfigProperty;
import com.bank.console.common.FilePath;
import com.bank.console.common.DBIndex.CommonService;
import com.bank.console.common.util.DateUtil;
import com.bank.console.common.util.FileUtil;
import com.bank.console.file.form.RecFileForm;
import com.bank.console.file.vo.RecFileVO;
import com.bank.console.mapper.RecFileMapper;

@Service
public class RecFileService {
	@Autowired
	private RecFileMapper recFileMapper;
	@Autowired
	private CommonService commonService;
//	@Autowired
//	private TableIdService tableIdService;
	
	private static final String TABLE_NAME = "tb_recevice_file";
	private static final String ID = "fileId";
	
	
	
	/**
	 * 新增文件
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	public int addFile(RecFileForm form) throws Exception {
		String path = ConfigProperty.UPLOAD_FILE_PATH + File.separator + FilePath.REC_FILE + File.separator 
				+ DateUtil.formateDateToStr(new Date(), DateUtil.str2DayFormate);
		MultipartFile fileItem = form.getFileItem();
		path = path.replace("\\", "/");
		String attachment = FileUtil.saveFile(fileItem, path);
		form.setAttachment(attachment);
		
		String nextId = commonService.getNextId(TABLE_NAME, ID) + "";
		form.setFileId(nextId);
		return recFileMapper.addFile(form);
	}
	
	/**
	 * 修改文件
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	public int updateFile(RecFileForm form) throws Exception {
		String path = ConfigProperty.UPLOAD_FILE_PATH + File.separator + FilePath.REC_FILE + File.separator 
				+ DateUtil.formateDateToStr(new Date(), DateUtil.str2DayFormate);
		MultipartFile fileItem = form.getFileItem();
		path = path.replace("\\", "/");
		String attachment = FileUtil.saveFile(fileItem, path);
		form.setAttachment(attachment);
		return recFileMapper.updateFile(form);
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
	public List<RecFileVO> getFileList(RecFileForm form) {
		List<RecFileVO> fileList = new ArrayList<RecFileVO>();
		List<RecFileVO> list = recFileMapper.getFileList(form);
		for(RecFileVO file : list) {
			file.setStatus(BusinessConstant.FILE_STATUS.get(file.getStatus()));
			fileList.add(file);
		}
		return fileList;
	}
	
	/**
	 * 获取文件详情
	 * @param file
	 * @return
	 */
	public RecFileVO getFileInfo(String fileId) {
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
