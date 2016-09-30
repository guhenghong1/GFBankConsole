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
	<script type="text/javascript" src="${basePath}/js/meet/conference.js?u=${times}"></script>
	<div class="conference" style="padding: 20px">
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'',plain:true" onclick="Conference.edit(0)">详情</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Conference.edit(1)">编辑</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Conference.add()">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Conference.deleteOp()">删除</a>
		</div>
        <div class="query" style="padding: 5px">  
           <label>编号：</label><input type="text" id = "qId" name="id" style="width:150px"/>  
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryconference()">查询</a>  
        </div> 
		<table id="conference" rownumbers="true"></table>
		
		<div id="meetw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 480px; padding: 10px;">
		<form id="conferenceForm" method="post" action="${basePath}/conference/addConference.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="id" class="required" name="id" type="text" value=""></input>
					<span id = "idmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>会议名称：<font style="color: red">*</font></label></td>
					<td>
						<input id="name" class="required" name="name" type="text" value=""></input>
						<span id = "namemsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>会议时间：</label></td>
					<td><input id="time" class="easyui-datetimebox" name = "timeStr"
						data-options="required:false,showSeconds:false, formatter:fmt,parser:pas" label="Select DateTime:" labelPosition="top" style="width:150px">
				</td>
				</tr>
				<tr>
					<td><label>会议参与人员：</label></td>
					<td><input id="persons" name="persons" type="text" value=""></input>
					<span id = "personsmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>会议地点：<font style="color: red">*</font></label></td>
					<td><input id="place" name= "place" class="required" type="text" value=""></input>
					<span id = "placemsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>会议要素：<font style="color: red">*</font></label></td>
					<td><input id="emphasis" name= "emphasis" class="required" type="text" value=""></input>
					<span id = "emphasismsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>会议内容：<font style="color: red">*</font></label></td>
					<td><textarea id="content" name="content" style="width: 250px; height: 80px;"></textarea>
					</td>
				</tr>
				<tr>
					<td><label>备注：<font style="color: red">*</font></label></td>
					<td><textarea id="remark" name="remark" style="width: 250px; height: 80px;"></textarea></td>
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addConference()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
		
		<div id="umeetw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="mconferenceForm" method="post" action="${basePath}/conference/addConference.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="mid" class="required" name="id" type="text" value=""></input>
					<span id = "midmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>会议名称：<font style="color: red">*</font></label></td>
					<td>
						<input id="mname" class="required" name="name" type="text" value=""></input>
						<span id = "mnamemsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>会议时间：</label></td>
					<td><input id="mtime" class="easyui-datetimebox" name = "timeStr"
						data-options="required:false,showSeconds:false, formatter:fmt,parser:pas" label="Select DateTime:" labelPosition="top" style="width:150px">
				</td>
				</tr>
				<tr>
					<td><label>会议参与人员：</label></td>
					<td><input id="mpersons" name="persons" type="text" value=""></input>
					<span id = "mpersonsmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>会议地点：<font style="color: red">*</font></label></td>
					<td><input id="mplace" name= "place" class="required" type="text" value=""></input>
					<span id = "mplacemsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>会议要素：<font style="color: red">*</font></label></td>
					<td><input id="memphasis" name= "emphasis" class="required" type="text" value=""></input>
					<span id = "mmphasismsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>会议内容：<font style="color: red">*</font></label></td>
					<td><textarea id="mcontent" name="content" style="width: 250px; height: 80px;"></textarea>
					</td>
				</tr>
				<tr>
					<td><label>备注：<font style="color: red">*</font></label></td>
					<td><textarea id="mremark" name="remark" style="width: 250px; height: 80px;"></textarea></td>
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="updateConference()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
</body>
</html>