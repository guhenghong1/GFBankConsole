package com.bank.console.business.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.business.form.WarrantForm;
import com.bank.console.business.vo.WarrantVO;
import com.bank.console.common.BusinessConstant;
import com.bank.console.common.DBIndex.CommonService;
import com.bank.console.mapper.WarrantMapper;
import com.bank.console.system.service.TableIdService;

@Service
public class WarrantService {
	@Autowired
	private WarrantMapper warrantMapper;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private CommonService commonService;
	
//	@Autowired
//	private TableIdService tableIdService;
	
	private static final String TABLE_NAME = "tb_warrant";
	
	public static final int CARD = 0;	//权证证号
	public static final int DEPT = 1;	//部门
	public static final int REMARK = 2;	//备注
	
	/**
	 * 新增文件
	 * @param Warrant
	 * @return
	 * @throws Exception 
	 */
	public int addWarrant(WarrantForm form) throws Exception {
		long nextId = commonService.getNextId(TABLE_NAME);
		form.setId(nextId + "");
		int res = warrantMapper.addWarrant(form);
		String deptName = form.getDeptName();
		dictionaryService.addDictionary(deptName, DEPT);
		
		String cardName = form.getCardName();
		dictionaryService.addDictionary(cardName, CARD);
		
		String remarkName = form.getRemarkName();
		dictionaryService.addDictionary(remarkName, REMARK);
		
		return res;
	}
	
	/**
	 * 修改文件
	 * @param Warrant
	 * @return
	 */
	public int updateWarrant(WarrantForm form) {
		int res = warrantMapper.updateWarrant(form);
		String deptName = form.getDeptName();
		dictionaryService.addDictionary(deptName, DEPT);
		
		String cardName = form.getCardName();
		dictionaryService.addDictionary(cardName, CARD);
		
		String remarkName = form.getRemarkName();
		dictionaryService.addDictionary(remarkName, REMARK);
		return res;
	}
	
	/**
	 * 删除文件
	 * @param WarrantId
	 * @return
	 */
	public int deleteWarrant(String id) {
		return warrantMapper.deleteWarrant(id);
	}

	/**
	 * 获取文件列表
	 * @param Warrant
	 * @return
	 */
	public List<WarrantVO> getWarrantList(WarrantForm form) {
		List<WarrantVO> listw = new ArrayList<WarrantVO>();
		List<WarrantVO> list = warrantMapper.getWarrantList(form);
		for(WarrantVO w : list) {
			String statusStr = BusinessConstant.WARRANT_STATUS.get(w.getStatus()+"");
			w.setStatusStr(statusStr);
			listw.add(w);
		}
		return listw;
	}
	
	/**
	 * 获取文件详情
	 * @param Warrant
	 * @return
	 */
	public WarrantVO getWarrantInfo(String id) {
		return warrantMapper.getWarrantInfo(id);
	}
	
	/**
	 * 获取数量
	 * @param Warrant
	 * @return
	 */
	public int getWarrantSum(WarrantForm form) {
		return warrantMapper.getWarrantSum(form);
	}
	
	public String getNextId() {
		String id = warrantMapper.getMaxid();
		if(StringUtils.isEmpty(id)){
			return "1";
		}
		int maxId = Integer.parseInt(warrantMapper.getMaxid());
		maxId += 1;
		return maxId + "";
	}
}
