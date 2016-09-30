package com.bank.console.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bank.console.conference.form.ConferenceForm;
import com.bank.console.conference.vo.ConferenceVO;

@Repository
public interface ConferenceMapper {
	//新增文件
	int addConference(ConferenceForm form);
	
	//修改文件
	int updateConference(ConferenceForm form);
	
	//删除文件
	int deleteConference(String companyId);
	
	//获取文件详情
	ConferenceVO getConferenceInfo(String companyId);
	
	//查询列表
	List<ConferenceVO> getConferenceList(ConferenceForm form);
	
	//查询数量
	int getConferenceSum(ConferenceForm form);
	
	List<ConferenceVO> getAllConferenceList();
}
