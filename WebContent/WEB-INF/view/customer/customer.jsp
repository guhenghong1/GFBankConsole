<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<script type="text/javascript" src="${basePath}/js/customer/customer.js?u=${times}"></script>
<div class="qz-user">
    <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Customer.edit()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Customer.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Customer.deleteCustomer()">删除</a>
    </div> 
  	<div class="query" style="padding-top: 5px"> 
  		<div style="padding-bottom: 5px"> 
			<label>用户工号：</label><input type="text" id = "qid" name="qid" style="width:150px"/>  
			<label>真实姓名：</label><input type="text" id = "qname" name="qname" style="width:150px"/> 
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryCustomer()">查询</a> 
		</div> 
    </div> 
    <table id="tb_customers" rownumbers="true"></table> 
    <div id="cuw" class="easyui-window" title="客户详情" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:500px;padding:10px;">
        <form id="cuForm">
        <table>
        	<tr>
        		<td width="80px"><label>客户编号：</label></td>
        		<td>
        			<input id="id" type="text"></input>
        		</td>
        	</tr>
        	<tr>
        		<td><label>客户经理：</label></td>
        		<td><input id="manager" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>客户姓名：</label></td>
        		<td><input id="name" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>客户类型：</label></td>
        		<td>
        			<select id="type">
					  <option value ="1">个人</option>
					  <option value ="2">对公</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>客户等级：</label></td>
        		<td>
        			<select id="grade">
					  <option value ="1">1级</option>
					  <option value ="2">2级</option>
					  <option value ="3">3级</option>
					  <option value ="4">4级</option>
					  <option value ="5">5级</option>
					  <option value ="6">6级</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>证件号码：</label></td>
        		<td><input id="cardNo" type="text"></input>（个人客户为身份证，对公客户为组织机构代码）</td>
        	</tr>
        	<tr>
        		<td><label>客户账号：</label></td>
        		<td><input id="account" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>客户生日：</label></td>
        		<td><input id="birthdayStr" class="easyui-datebox"></input></td>
        	</tr>
        	<tr>
        		<td><label>客户爱好：</label></td>
        		<td><input id="hobby" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>联系方式：</label></td>
        		<td><input id="contact" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>备注：</label></td>
        		<td><input id="remark" type="text"></input></td>
        	</tr>
        </table>
        </form>
        <div style="margin:20px 0;">
        <a href="javascript:void(0)" class="easyui-linkbutton" id="update" onclick="Customer.update()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="Customer.addCustomer()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">取消</a>
    </div>
    </div>
</div>
