package com.bank.console.conference.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.conference.form.ConferenceForm;
import com.bank.console.conference.vo.ConferenceVO;
import com.bank.console.mapper.ConferenceMapper;

@Service
public class ConferenceService {
	@Autowired
	private ConferenceMapper conferenceMapper;
	
	
	/**
	 * 新增文件
	 * @param conference
	 * @return
	 * @throws Exception 
	 */
	public int addConference(ConferenceForm form) throws Exception {
		return conferenceMapper.addConference(form);
	}
	
	/**
	 * 修改文件
	 * @param conference
	 * @return
	 */
	public int updateConference(ConferenceForm form) {
		return conferenceMapper.updateConference(form);
	}
	
	/**
	 * 删除文件
	 * @param conferenceId
	 * @return
	 */
	public int deleteConference(String id) {
		return conferenceMapper.deleteConference(id);
	}

	/**
	 * 获取文件列表
	 * @param conference
	 * @return
	 */
	public List<ConferenceVO> getConferenceList(ConferenceForm conference) {
		return conferenceMapper.getConferenceList(conference);
	}
	
	/**
	 * 获取文件详情
	 * @param conference
	 * @return
	 */
	public ConferenceVO getConferenceInfo(String id) {
		return conferenceMapper.getConferenceInfo(id);
	}
	
	/**
	 * 获取数量
	 * @param conference
	 * @return
	 */
	public int getConferenceSum(ConferenceForm form) {
		return conferenceMapper.getConferenceSum(form);
	}
	
	public List<ConferenceVO> getAllConferenceList(){
		return conferenceMapper.getAllConferenceList();
	}
}
