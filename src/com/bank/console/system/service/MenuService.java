package com.bank.console.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.mapper.MenuMapper;
import com.bank.console.mapper.UserMenuMapper;
import com.bank.console.system.vo.MenuVO;
import com.bank.console.system.vo.UserMenuVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class MenuService {
	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private UserMenuMapper userMenuMapper;
	
	private static final String ROOTID = "0001";	//根节点
	
	/**
	 * 获取列表
	 * 
	 * @return
	 */
	public JSONArray getMenuTree() {
		List<MenuVO> menuList = menuMapper.getMenuList();

		JSONArray childData = this.treeData(JSONArray.fromObject(menuList), ROOTID);
		JSONArray treeData = new JSONArray();
		JSONObject root = new JSONObject();
		
//		root.put("id", "0001");
//		root.put("text", "菜单");
//		root.put("children", childData);
		
		treeData.addAll(childData);
		
		return treeData;
	}
	
	// 菜单树形结构
	public JSONArray treeData(JSONArray menuList, String parentId) {
		JSONArray childMenu = new JSONArray	();
		for (int i = 0 ; i< menuList.size(); i++) {
			JSONObject json = menuList.getJSONObject(i);
			JSONObject menuJson = new JSONObject();
			
			String menuId = json.getString("menuId");
			String menuName = json.getString("menuName");
			String pid = json.getString("superMenuId");
			String linkUrl = json.getString("linkUrl");
			
			menuJson.put("id", menuId);
			menuJson.put("text", menuName);
			menuJson.put("pid", pid);
			menuJson.put("linkUrl", linkUrl);
			
			if (parentId.equals(pid)) {
				JSONArray childrenList = treeData(menuList, menuId);
				if(!childrenList.isEmpty()) {
					menuJson.put("children", childrenList);
				}
				childMenu.add(menuJson);
			}
		}
		return childMenu;
	}
	
}
