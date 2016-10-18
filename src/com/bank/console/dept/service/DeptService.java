package com.bank.console.dept.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.dept.form.DeptForm;
import com.bank.console.dept.vo.DeptVO;
import com.bank.console.mapper.DeptMapper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class DeptService {
	@Autowired
	private DeptMapper deptMapper;
	
	private static final String ROOTID = "0001";	//总行ID
	
	public int addDept(DeptForm form) {
		form.setDeptId(this.createDeptId());
		return deptMapper.addDept(form);
	}
	
	public int updateDept(DeptForm form) {
		return deptMapper.updateDept(form);
	}
	
	public int deleteDept(String deptId) {
		return deptMapper.deleteDept(deptId);
	}
	
	public DeptVO getDeptInfo(String deptId) {
		return deptMapper.getDeptInfo(deptId);
	}

	/**
	 * 获取列表
	 * 
	 * @return
	 */
	public List<DeptVO> getDeptTree() {
		List<DeptVO> deptList = deptMapper.getDeptList();

		JSONArray childData = this.treeData(JSONArray.fromObject(deptList), ROOTID);
		JSONArray treeData = new JSONArray();
		JSONObject root = new JSONObject();
		
		root.put("id", "0001");
		root.put("text", "总行");
		root.put("children", childData);
		
		treeData.add(root);
		
		return treeData;
	}
	
	/**
	 * 获取机构列表
	 * 
	 * @return
	 */
	public List<DeptVO> getOrgTree() {
		List<DeptVO> deptList = deptMapper.getDeptList();
		
		JSONArray childData = this.orgTreeData(JSONArray.fromObject(deptList), ROOTID);
		JSONArray treeData = new JSONArray();
		JSONObject root = new JSONObject();
		
		root.put("deptId", "0001");
		root.put("deptName", "总行");
		root.put("isSalesDept", "否");
		root.put("address", "广丰大道");
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
	
	// 菜单树形结构
	public JSONArray orgTreeData(JSONArray deptList, String parentId) {
		JSONArray childDept = new JSONArray	();
		for (int i = 0 ; i< deptList.size(); i++) {
			JSONObject json = deptList.getJSONObject(i);
			JSONObject deptJson = new JSONObject();
			
			String deptId = json.getString("deptId");
			String deptName = json.getString("deptName");
			String pid = json.getString("superDeptId");
			String address = json.getString("address");
			String isSalesDept = json.getString("isSalesDept");
			
			deptJson.put("deptId", deptId);
			deptJson.put("deptName", deptName);
			deptJson.put("pid", pid);
			deptJson.put("address", address);
			deptJson.put("isSalesDept", "1".equals(isSalesDept)? "是" : "否");
			
			if (parentId.equals(pid)) {
				JSONArray childrenList = orgTreeData(deptList, deptId);
				if(!childrenList.isEmpty()) {
					deptJson.put("children", childrenList);
				}
				childDept.add(deptJson);
			}
		}
		return childDept;
	}
	
	private String createDeptId() {
		String maxDeptId = deptMapper.getMaxDeptId();
		int maxId = Integer.parseInt(maxDeptId);
		maxId += 10;
		return maxId + "";
	}
	
}
