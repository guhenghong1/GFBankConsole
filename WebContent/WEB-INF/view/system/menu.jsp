<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%> 
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
	<script type="text/javascript" src="${basePath}/js/common/common.js?u=${times}"></script>
	<script type="text/javascript" src="${basePath}/js/system/menu.js?u=${times}"></script>
<div class="menu" style="padding: 20px">
    <div style="margin-bottom: 10px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="Menu.edit(0)">详情</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Menu.edit(1)">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Menu.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Menu.deleteOp()">删除</a>
    </div>
    <table id="menua" class="easyui-treegrid" title="菜单列表" style="width:700px;height:400px"
            data-options="
                iconCls: 'icon-ok',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                url: '${basePath}/menu/getMenuTree.do',
                method: 'get',
                idField: 'id',
                treeField: 'text',
                showFooter: true
            ">
        <thead>
            <tr>
                <th data-options="field:'text',width:120,align:'left',editor:'numberbox'">名称</th>
                <th data-options="field:'id',width:80,editor:'text'">编号</th>
                <th data-options="field:'linkUrl',width:80,editor:'datebox'">链接</th>
              <!--   <th data-options="field:'remark',width:80,editor:'datebox'">备注</th> -->
                <!-- <th data-options="field:'progress',width:120,formatter:formatProgress,editor:'numberbox'">Progress</th> -->
            </tr>
        </thead>
    </table>
    <div id="menuw" class="easyui-window" title="新增部门机构"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="menuForm" method="post" action="${basePath}/menu/addMenu.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>菜单名称：<font style="color: red">*</font></label></td>
					<td><input id="menuName" class="required" name="menuName" type="text" value=""></input>
					<span class = "menuNamemsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>父节点：<font style="color: red">*</font></label></td>
					<td> 
						<input id="superMenuId" name="superMenuId" class="easyui-combotree" data-options="url:'../menu/getLevelMenuTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false,animate:true,lines:true" style="width:181px">
						<span class = "superMenuIdmsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>链接：</label></td>
					<td>
						<input id="linkUrl" class="" name="linkUrl" type="text" value=""></input>
					</td>  
				</tr>
				<tr>
	        		<td><label>备注：</label></td>
	        		<td colspan=""><textarea id="remark" name="remark" style="width: 300px; height: 80px;"></textarea></td>
        		</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addMenu()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
    <div id="mMenuw" class="easyui-window" title="修改部门机构"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="mMenuForm" method="post" action="${basePath}/menu/updateMenu.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>机构编号：<font style="color: red">*</font></label></td>
					<td><input id="mmenuId" class="required" name="menuId" type="text" value=""></input>
					<span class = "menuIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>机构名称：<font style="color: red">*</font></label></td>
					<td><input id="mmenuName" class="required" name="menuName" type="text" value=""></input>
					<span class = "menuNamemsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>父节点：<font style="color: red">*</font></label></td>
					<td> 
						<input id="msuperMenuId" name="superMenuId" class="easyui-combotree" data-options="url:'../menu/getLevelMenuTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false,animate:true,lines:true" style="width:181px">
						<span class = "superMenuIdmsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>链接：</label></td>
					<td>
						<input id="mlinkUrl" class="" name="linkUrl" type="text" value=""></input>
					</td>  
				</tr>
				<tr>
	        		<td><label>备注：</label></td>
	        		<td colspan=""><textarea id="mremark" name="remark" style="width: 300px; height: 80px;"></textarea></td>
        		</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton update" id="add" onclick="updateMenu()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton cancle" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
    </div>
</body>
</html>