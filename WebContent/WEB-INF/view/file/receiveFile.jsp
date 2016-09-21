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
	<script type="text/javascript" src="${basePath}/js/file/recFile.js?u=${times}"></script>
	<div class="recFile" style="padding: 20px">
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="RecFile.edit()">编辑</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="RecFile.add()">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="RecFile.deleteOp()">删除</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="RecFile.download()">打印</a>
		</div>
        <div class="query" style="padding: 5px">  
           <label>来文编号：</label><input type="text" id = "qFileId" name="qFileId" style="width:150px"/>  
           <label>关键词：</label><input type="text" id = "qkeyWords" name="qkeyWords" style="width:150px"/>  
           <label>总行：</label><select id="qdeptId" class="easyui-combobox" panelHeight="auto" style="width:100px">  
                <option value="1">总行</option>  
                <option value="2">支行</option>  
            </select>  
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryFile()">查询</a>  
        </div> 
		<table id="recFile" rownumbers="true"></table>
		
		<div id="rfw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="recFileForm" method="post" action="${basePath}/recFile/addFile.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>来文编号：<span style="color: red">*</span></label></td>
					<td><input id="fileId" name="fileId" type="text" value=""></input>
					</td>
				</tr>
				<tr>
					<td><label>来文时间：</label><span style="color: red">*</span></td>
					<td> 
						<input class="easyui-datetimebox" name = "createDate"
						data-options="required:false,showSeconds:false,formatter:fmt" label="Select DateTime:" labelPosition="top" style="width:181px">
					</td>
				</tr>
				<tr>
					<td><label>来文单位：<span style="color: red">*</span></label></td>
					<td>
						<input id="deptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px">
					</td>
				</tr>
				<tr>
					<td><label>来文字号：<span style="color: red">*</span></label></td>
					<td><input id="fileNo" name="fileNo" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文标题：</label></td>
					<td><input id="fileTitle" name="fileTitle" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>来文文关键词：<span style="color: red">*</span></label></td>
					<td><input id="keyWords" name= "keyWords" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>状态：</label></td>
					<td><select id="state" name="state">
					  <option value ="1">已阅</option>
					  <option value ="1">董事长处理中</option>
					  <option value ="2">已处理</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文保密级别：</label></td>
					<td><select id="secretLevel" name="secretLevel">
					  <option value ="1">普通</option>
					  <option value ="2">保密</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文紧急级别：</label></td>
					<td><select id="emgLevel" name="emgLevel">
					  <option value ="1">一般</option>
					  <option value ="2">紧急</option>
					</select></td>
				</tr>
				<tr>
					<td><label>附件：</label></td>
					<td>
						<input id="attachment" type="file" name="fileItem" style="width:181px">
					</td>  
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addFile()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
		
		<div id="mrfw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="mrecFileForm" method="post" action="${basePath}/recFile/updateFile.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>来文编号：</label></td>
					<td><input id="mfileId" name="fileId" type="text" value=""></input>
					</td>
				</tr>
				<tr>
					<td><label>来文时间：</label></td>
					<td> 
						<input id="mcreateDate" class="easyui-datetimebox" name = "createDate"
						data-options="required:false,showSeconds:false, formatter:fmt" label="Select DateTime:" labelPosition="top" style="width:150px">
					</td>
				</tr>
				<tr>
					<td><label>来文单位：</label></td>
					<td><input id="mdeptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:100%"></td>
				</tr>
				<tr>
					<td><label>来文字号：</label></td>
					<td><input id="mfileNo" name="fileNo" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文标题：</label></td>
					<td><input id="mfileTitle" name="fileTitle" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>来文文关键词：</label></td>
					<td><input id="mkeyWords" name= "keyWords" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>状态：</label></td>
					<td><select id="mstate" name="state">
					  <option value ="1">已阅</option>
					  <option value ="1">董事长处理中</option>
					  <option value ="2">已处理</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文保密级别：</label></td>
					<td><select id="msecretLevel" name="secretLevel">
					  <option value ="1">普通</option>
					  <option value ="2">保密</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文紧急级别：</label></td>
					<td><select id="memgLevel" name="emgLevel">
					  <option value ="1">一般</option>
					  <option value ="2">紧急</option>
					</select></td>
				</tr>
				<tr>
					<td><label>附件：</label></td>
					<td><img src=""/>
						<input id="mattachment" type="file" name="fileItem">
					</td>  
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="updateFile()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm(1)">取消</a>
			</div>
		</form>
		</div>
		 <script type="text/javascript">
/* 			function add() {
				alert("111");
			} */
		</script>
</body>
</html>