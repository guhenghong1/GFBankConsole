package com.bank.console.dept.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.dept.vo.DeptVO;
import com.bank.console.mapper.DeptMapper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class DeptService {
	@Autowired
	private DeptMapper deptMapper;
	
	private static final String parentId = "0001";	//总行ID

	/**
	 * 获取列表
	 * 
	 * @return
	 */
	public List<DeptVO> getDeptTree() {
		List<DeptVO> deptList = deptMapper.getDeptList();

		JSONArray childData = this.treeData(JSONArray.fromObject(deptList), parentId);
		JSONArray treeData = new JSONArray();
		JSONObject root = new JSONObject();
		
		root.put("id", "0001");
		root.put("text", "总行");
		root.put("children", childData);
		
		treeData.add(root);
		
		return treeData;
	}

	// 菜单树形结构
	public JSONArray treeData(JSONArray deptList, String parentId) {
		JSONArray childDept = new JSONArray	();
		for (int i = 0 ; i< deptList.size(); i++) {
			JSONObject json = deptList.getJSONObject(i);
			JSONObject deptJson = new JSONObject();
			
			String deptId = json.getString("deptId");
			String deptName = json.getString("deptName");
			String pid = json.getString("superDeptId");
			
			deptJson.put("id", deptId);
			deptJson.put("text", deptName);
			deptJson.put("pid", pid);
			
			if (parentId.equals(pid)) {
				JSONArray childrenList = treeData(deptList, deptId);
				if(!childrenList.isEmpty()) {
					deptJson.put("children", childrenList);
				}
				childDept.add(deptJson);
			}
		}
		return childDept;
	}
	
	
}
