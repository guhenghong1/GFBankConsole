package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.resource.form.LearningForm;
import com.bank.console.resource.vo.LearningVO;

@Repository
public interface LearningMapper {
	//
	int addLearning(LearningForm form);
	
	//
	int updateLearning(LearningForm form);
	
	int updateViewCount(String id);
	
	//
	int deleteLearning(String companyId);
	
	//
	LearningVO getLearningInfo(String id);
	
	//
	List<LearningVO> getLearningList(LearningForm form);
	
	//查询数量
	int getLearningSum(LearningForm form);
	
}
