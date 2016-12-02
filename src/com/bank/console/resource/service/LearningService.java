package com.bank.console.resource.service;

import java.io.File;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bank.console.common.ConfigProperty;
import com.bank.console.common.FilePath;
import com.bank.console.common.DBIndex.CommonService;
import com.bank.console.common.util.DateUtil;
import com.bank.console.common.util.FileUtil;
import com.bank.console.mapper.LearningMapper;
import com.bank.console.resource.form.LearningForm;
import com.bank.console.resource.vo.LearningVO;
import com.bank.console.system.service.TableIdService;

@Service
public class LearningService {
	@Autowired
	private LearningMapper learningMapper;
	@Autowired
	private CommonService commonService;
//	@Autowired
//	private TableIdService tableIdService;
	
	private static final String TABLE_NAME = "tb_learning_materials";
	
	/**
	 * 新增
	 * @param Learning
	 * @return
	 * @throws Exception 
	 */
	public int addLearning(LearningForm form) throws Exception {
		String nextId = commonService.getNextId(TABLE_NAME) + "";
		form.setId(nextId);
		
		String path = ConfigProperty.UPLOAD_FILE_PATH + File.separator + FilePath.LEARN_FILE + File.separator 
				+ DateUtil.formateDateToStr(new Date(), DateUtil.str2DayFormate);
		MultipartFile fileItem = form.getFileItem();
		path = path.replace("\\", "/");
		String attachment = FileUtil.saveFile(fileItem, path);
		form.setAttachment(attachment);
		
		return learningMapper.addLearning(form);
	}
	
	/**
	 * 
	 * @param Learning
	 * @return
	 * @throws Exception 
	 */
	public int updateLearning(LearningForm form) throws Exception {
		String path = ConfigProperty.UPLOAD_FILE_PATH + File.separator + FilePath.LEARN_FILE + File.separator 
				+ DateUtil.formateDateToStr(new Date(), DateUtil.str2DayFormate);
		MultipartFile fileItem = form.getFileItem();
		path = path.replace("\\", "/");
		String attachment = FileUtil.saveFile(fileItem, path);
		form.setAttachment(attachment);
		return learningMapper.updateLearning(form);
	}
	
	/**
	 * 
	 * @param Learning
	 * @return
	 */
	public int updateViewCount(String id) {
		return learningMapper.updateViewCount(id);
	}
	
	/**
	 * 删除
	 * @param LearningId
	 * @return
	 */
	public int deleteLearning(String id) {
		return learningMapper.deleteLearning(id);
	}

	/**
	 * 获取列表
	 * @param Learning
	 * @return
	 */
	public List<LearningVO> getLearningList(LearningForm form) {
		return learningMapper.getLearningList(form);
	}
	
	/**
	 * 获取详情
	 * @param Learning
	 * @return
	 */
	public LearningVO getLearningInfo(String id) {
		return learningMapper.getLearningInfo(id);
	}
	
	/**
	 * 获取数量
	 * @param Learning
	 * @return
	 */
	public int getLearningSum(LearningForm form) {
		return learningMapper.getLearningSum(form);
	}
	
}
