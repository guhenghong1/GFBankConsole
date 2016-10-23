<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript" src="${basePath}/js/common/common.js?u=${times}"></script>
	<script type="text/javascript" src="${basePath}/js/common/comEasyui.js?u=${times}"></script>
	<script type="text/javascript" src="${basePath}/js/resource/learn.js?u=${times}"></script>
	<div class="Learn" style="padding: 20px">
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="Learn.edit(0)">详情</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Learn.edit(1)">编辑</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Learn.add()">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Learn.deleteOp()">删除</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-upload',plain:true" onclick="Learn.download()">下载附件</a>
		</div>
        <div class="query" style="padding: 5px">  
           <label>编号：</label><input type="text" id = "qId" name="idd" style="width:150px"/>  
           <label>标题：</label><input type="text" id = "qTitle" name="title" style="width:150px"/>  
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryLearn()">查询</a>  
        </div> 
		<table id="learn" rownumbers="true"></table>
		
		<div id="lw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="learnForm" method="post" action="${basePath}/learn/addLearn.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>标题：<font style="color: red">*</font></label></td>
					<td>
						<input id="title" class="required" name="title" type="text" value=""></input>
						<span id = "titlemsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>备注：<font style="color: red">*</font></label></td>
					<td><textarea id="remark" name="remark" style="width: 250px; height: 80px;"></textarea></td>
				</tr>
				<tr>
					<td><label>学习资料：</label></td>
					<td>
						<input id="attachment" type="file" name="fileItem" style="width:181px">
					</td>  
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addLearn()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
		
		<div id="mlw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="mLearnForm" method="post" action="${basePath}/learn/updateLearn.do" enctype="multipart/form-data">  
			<table>
 				<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="mid" class="required" name="id" type="text" value="" readonly="readonly"></input>
					<span id = "midmsg" class="msg"></span>
					</td>
				</tr> 
				<tr>
					<td><label>标题：<font style="color: red">*</font></label></td>
					<td>
						<input id="mtitle" class="required" name="title" type="text" value=""></input>
						<span id = "mtitlemsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>备注：<font style="color: red">*</font></label></td>
					<td><textarea id="mremark" name="remark" style="width: 250px; height: 80px;"></textarea></td>
				</tr>
				<tr>
					<td><label>学习资料：</label></td>
					<td>
						<input id="mattachment" type="file" name="fileItem" style="width:181px">
					</td>  
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="updateLearn()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
</body>
</html>