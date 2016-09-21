<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<script type="text/javascript" src="${basePath}/js/user/user.js?u=${times}"></script>
<div class="qz-user">
    <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="User.edit()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="User.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="User.delete()">删除</a>
    </div> 
  	<div class="query" style="padding-top: 5px"> 
  		<div style="padding-bottom: 5px"> 
			<label>用户工号：</label><input type="text" id = "quserId" name="quserId" style="width:150px"/>  
			<label>真实姓名：</label><input type="text" id = "qrealName" name="qrealName" style="width:150px"/>  
			<label>电话：</label><input type="text" id = "qphone" name="qphone" style="width:150px"/>  
		</div>
		<div style="padding-bottom: 5px">
			<label>手机号：</label><input type="text" id = "qmobile" name="qmobile" style="width:150px"/>  
			<label>部门：</label><input id="qdeptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:150px">  
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryUser()">查询</a>
		</div>  
    </div> 
    <table id="tb_users" rownumbers="true"></table> 
    <div id="w" class="easyui-window" title="用户详情" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px;">
        <table>
        	<tr>
        		<td><label>用户工号：</label></td>
        		<td>
        			<input id="userId" type="text" value="${user.userId}"></input>
        		</td>
        	</tr>
        	<tr>
        		<td><label>真实姓名：</label></td>
        		<td><input id="realName" type="text" value="${user.realName}"></input></td>
        	</tr>
        	<tr>
        		<td><label>角色：</label></td>
        		<td>
        			<input id="roleId" type="text" value="" style="display:none"></input>
        			<input id="roleName" type="text" value=""></input>
        			<select id="roleId">
					  <option value ="1">普通用户</option>
					  <option value ="2">管理员</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>部门：</label></td>
        		<td>
        			<input id="deptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px">
        		</td>
        	</tr>
        	<tr>
        		<td><label>电话：</label></td>
        		<td><input id="phone" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>手机号：</label></td>
        		<td><input id="mobile" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>邮箱：</label></td>
        		<td><input id="email" type="text" value=""></input></td>
        	</tr>
        </table>
        <div style="margin:20px 0;">
<!--         <a href="javascript:void(0)" class="easyui-linkbutton" id="update" onclick="User.update()">保存</a> -->
        <a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="User.addUser()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">取消</a>
    </div>
    </div>
</div>
