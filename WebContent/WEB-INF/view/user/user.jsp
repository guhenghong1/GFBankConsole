<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript" src="../js/user/user.js"></script>
<div class="qz-user">
    <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="User.edit()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="User.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="User.delete()">删除</a>
    </div> 
    <table id="qz_users" rownumbers="true"></table> 
    <div id="w" class="easyui-window" title="用户详情" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px;">
        <table>
        	<tr>
        		<td><label>用户名：</label></td>
        		<td>
        			<input id="userId" type="text" value="" style="display:none"></input>
        			<input id="userName" type="text" value="${user.userName}"></input>
        		</td>
        	</tr>
        	<tr>
        		<td><label>真实姓名：</label></td>
        		<td><input id="realName" type="text" value="${user.realName}"></input></td>
        	</tr>
        	<tr>
        		<td><label>角色：</label></td>
        		<td>
        			<select id="role">
					  <option value ="1">普通用户</option>
					  <option value ="2">管理员</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>客户：</label></td>
        		<td><input id="customer" type="text" value=""></input></td>
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
        <a href="javascript:void(0)" class="easyui-linkbutton" id="update" onclick="User.update()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="User.addUser()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">取消</a>
    </div>
    </div>
</div>
