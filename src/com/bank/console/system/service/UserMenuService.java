package com.bank.console.system.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.common.util.StringUtil;
import com.bank.console.mapper.UserMenuMapper;
import com.bank.console.system.form.UserMenuForm;
import com.bank.console.system.model.UserMenu;
import com.bank.console.system.vo.UserMenuVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class UserMenuService {
	@Autowired
	private UserMenuMapper userMenuMapper;

	private static final String ROOTID = "0001"; // 根节点

	/**
	 * 设置用户的菜单项
	 * 
	 * @param form
	 * @return
	 */
	public int addUserMenu(UserMenuForm form) {
		String menuIdStr = form.getMenuIds();
		List<String> menuIds = StringUtil.str2List(menuIdStr, ",");

		int res = 1;
		for (String menuId : menuIds) {
			UserMenu userMenu = new UserMenu();
			userMenu.setUserId(form.getUserId());
			userMenu.setMenuId(menuId);
			res = userMenuMapper.addUserMenu(userMenu);
		}
		return res;
	}

	/**
	 * 删除用户的菜单项
	 * 
	 * @param form
	 * @return
	 */
	public int deleteUserMenu(String userId) {
		return userMenuMapper.deleteUserMenu(userId);
	}

	/**
	 * 获取用户的菜单项
	 * 
	 * @param userId
	 * @return
	 */
	public UserMenuForm getUserMenu(String userId) {
		List<UserMenuVO> userMenus = userMenuMapper.getUserMenuList(userId);

		List list = new ArrayList();
		Map<String, List> map = new HashMap<String, List>();
		for (UserMenuVO userMenu : userMenus) {
			String uId = userMenu.getUserId();
			String menuId = userMenu.getMenuId();

			if (!map.containsKey(uId)) {
				list = new ArrayList();
				list.add(menuId);
				map.put(uId, list);
			} else {
				list = map.get(uId);
				list.add(menuId);
				map.put(userId, list);
			}
		}

		String menuIds = StringUtil.list2Str(list, ",");
		UserMenuForm userMenuForm = new UserMenuForm();
		userMenuForm.setUserId(userId);
		userMenuForm.setMenuIds(menuIds);

		return userMenuForm;
	}

	/**
	 * 获取列表
	 * 
	 * @return
	 */
	public JSONArray getUserMenuTree(String userId) {
		List<UserMenuVO> menuList = userMenuMapper.getUserMenuList(userId);

		JSONArray childData = this.treeData(JSONArray.fromObject(menuList), ROOTID);
		JSONArray treeData = new JSONArray();

		treeData.addAll(childData);

		return treeData;
	}

	// 菜单树形结构
	public JSONArray treeData(JSONArray menuList, String parentId) {
		JSONArray childMenu = new JSONArray();
		for (int i = 0; i < menuList.size(); i++) {
			JSONObject json = menuList.getJSONObject(i);
			JSONObject menuJson = new JSONObject();

			String menuId = json.getString("menuId");
			String menuName = json.getString("menuName");
			String pid = json.getString("superMenuId");
			String linkUrl = json.getString("linkUrl");

			menuJson.put("menuId", menuId);
			menuJson.put("menuName", menuName);
			menuJson.put("pid", pid);
			menuJson.put("linkUrl", linkUrl);

			if (parentId.equals(pid)) {
				JSONArray childrenList = treeData(menuList, menuId);
				if (!childrenList.isEmpty()) {
					menuJson.put("children", childrenList);
				}
				childMenu.add(menuJson);
			}
		}
		return childMenu;
	}
}
