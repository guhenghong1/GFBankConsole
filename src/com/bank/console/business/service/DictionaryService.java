package com.bank.console.business.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.business.model.Dictionary;
import com.bank.console.common.DBIndex.CommonService;
import com.bank.console.mapper.DictionaryMapper;
import com.bank.console.system.service.TableIdService;

@Service
public class DictionaryService {
	@Autowired
	private DictionaryMapper dictionaryMapper;
	@Autowired
	private TableIdService tableIdService;
	@Autowired
	private CommonService commonService;
	
	private static final String TABLE_NAME = "tb_warrant_dictionary";
	
	public int addDictionary(String name, int type) {
		if(StringUtils.isEmpty(name)) {
			return 1;
		}
		name = name.trim();
		Dictionary hisDic = this.getDictionaryInfo(name, type);
		if(hisDic != null && name.equals(hisDic.getName())) {
			return 1;
		}
		
		long nextId =commonService.getNextId(TABLE_NAME);
		Dictionary dic = new Dictionary();
		dic.setId(nextId);
		dic.setName(name);
		dic.setType(type);
		return dictionaryMapper.addDictionary(dic);
	}
	
	public List<Dictionary> getDictionaryList(String name, int type) {
		return dictionaryMapper.getDictionaryList(name, type);
	}
	
	public Dictionary getDictionaryInfo(String name, int type) {
		return dictionaryMapper.getDictionaryInfo(name, type);
	}
	
	public String getNextId() {
		String id = dictionaryMapper.getMaxid();
		if(StringUtils.isEmpty(id)) {
			return "1";
		}
		int maxId = Integer.parseInt(id);
		maxId += 1;
		return maxId +"";
	}
}
