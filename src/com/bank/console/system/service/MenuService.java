package com.bank.console.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bank.console.common.ConfigProperty;
import com.bank.console.common.DBIndex.CommonService;
import com.bank.console.mapper.MenuMapper;
import com.bank.console.mapper.MenuOperateMapper;
import com.bank.console.mapper.UserMenuMapper;
import com.bank.console.system.form.MenuForm;
import com.bank.console.system.model.MenuOperate;
import com.bank.console.system.vo.MenuVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class MenuService {
	@Autowired
	private MenuMapper menuMapper;
	@Autowired
	private UserMenuMapper userMenuMapper;
	@Autowired
	private MenuOperateMapper menuOperateMapper;
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private TableIdService tableIdService;
	
	private static final String TABLE_NAME = "tb_menu";
	
	private static final String ID = "menuId";
	
	private static final String ROOTID = ConfigProperty.MENU_ROOT_ID;	//根节点
	
	public int addMenu(MenuForm form) {
		String nextId = commonService.getNextId(TABLE_NAME, ID) + "";
		form.setMenuId(nextId);
		return menuMapper.addMenu(form);
	}
	
	public int updateMenu(MenuForm form) {
		return menuMapper.updateMenu(form);
	}
	
	public int deleteMenu(String menuId) {
		return menuMapper.deleteMenu(menuId);
	}
	
	public MenuVO getMenuInfo(String menuId) {
		return menuMapper.getMenuInfo(menuId);
	}
	
	/**
	 * 获取列表
	 * 
	 * @return
	 */
	public JSONArray getLevelMenuTree() {
		List<MenuVO> menuList = menuMapper.getLevelMenuList(ROOTID);

		JSONArray childData = this.treeData(JSONArray.fromObject(menuList), ROOTID);
		JSONArray treeData = new JSONArray();
		JSONObject root = new JSONObject();
		
		root.put("id", "0001");
		root.put("text", "菜单");
		root.put("children", childData);
		
		treeData.add(root);
		
		return treeData;
	}
	
	/**
	 * 获取列表
	 * 
	 * @return
	 */
	public JSONArray getMenuTree() {
		List<MenuVO> menuList = menuMapper.getMenuList();
		
		JSONArray childData = this.treeData(JSONArray.fromObject(menuList), ROOTID);
		
//		buildOperate(childData);
		JSONArray treeData = new JSONArray();
		JSONObject root = new JSONObject();
		
		root.put("id", "0001");
		root.put("text", "菜单");
		root.put("children", childData);
		
		treeData.add(root);
		
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
					
//					List<MenuOperate> mopList = menuOperateMapper.getMenuOperate(menuId);
//					if(mopList.size()>0) {
//					childrenList = new JSONArray();
//					for(MenuOperate mo : mopList) {
//						String moId = mo.getMenuId();
//						String opId = mo.getOperId();
//						String opName = mo.getOperName();
//						String iconCls = mo.getIconCls();
//						
//						JSONObject jsonOp = new JSONObject();
//						jsonOp.put("id", opId);
//						jsonOp.put("text", opName);
//						jsonOp.put("iconCls", iconCls);
//						
//						childrenList.add(jsonOp);
//					}
//					menuJson.put("children", childrenList);
//						childMenu.add(menuJson);
//					}
				}
			}
			return childMenu;
		}
	
	private void buildOperate(JSONArray childData) {
		for (int i = 0; i < childData.size(); i++) {
			JSONObject json = childData.getJSONObject(i);
			String menuId = json.getString("id");
			List<MenuOperate> mopList = menuOperateMapper.getMenuOperate(menuId);

			if (mopList.size() > 0) {
				JSONArray childrenList = new JSONArray();
				for (MenuOperate mo : mopList) {
					String moId = mo.getMenuId();
					String opId = mo.getOperId();
					String opName = mo.getOperName();
					String iconCls = mo.getIconCls();

					JSONObject jsonOp = new JSONObject();
					jsonOp.put("id", opId);
					jsonOp.put("text", opName);
					jsonOp.put("iconCls", iconCls);

					childrenList.add(jsonOp);
				}
				json.put("children", childrenList);
			}
		}
	}
}
