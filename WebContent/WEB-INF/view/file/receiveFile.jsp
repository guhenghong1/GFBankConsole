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
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="RecFile.edit(0)">详情</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="RecFile.edit(1)">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="RecFile.add()">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="RecFile.deleteOp()">删除</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="RecFile.print()">打印</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-export',plain:true" onclick="RecFile.download()">下载附件</a>
		</div>
         <div class="queryRecFile" style="">   
        <table>
        	<tr>
           <td><label>编号：</label></td><td><input type="text" class = "qFileId"  style="width:150px"/></td>  
           <td><label>标题：</label></td><td><input type="text" class = "qFileTitle"  style="width:150px"/></td>  
           <td><label>关键词：</label></td><td><input type="text" class = "qkeyWords" name="qkeyWords" style="width:150px"/></td>  
           <td><label>来文单位：</label></td>
           <td>
           		<input  class="easyui-combotree qdeptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false,animate:true,lines:true" style="width:160px">
            </td>
            </tr>
            <tr>
               <td><label>状态：</label></td>
               <td><select  class="easyui-combobox qstatus" panelHeight="auto" style="width:160px">
	                 <option value =""></option>
	                 <option value ="1">已阅</option>
					 <option value ="2">董事长处理中</option>
					 <option value ="3">已处理</option> 
	            </select>
	            </td>
            <td><label>开始时间：</label></td>
            <td><input class="easyui-datetimebox qstartDate"
						data-options="required:false,showSeconds:true,formatter:myformatter,parser:myparser" label="Select DateTime:" labelPosition="top" style="width:160px">
            </td>
            <td><label>结束时间：</label></td>
            <td><input class="easyui-datetimebox qendDate"
						data-options="required:false,showSeconds:true,formatter:myformatter,parser:myparser" label="Select DateTime:" labelPosition="top" style="width:160px">
            </td>
            <td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryFile()">查询</a></td>
            <td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="clearQuery()">重置</a></td>
            </tr>
            </table>  
         </div> 
		<table id="recFile" rownumbers="true"></table>
		
		<div id="rfw" class="easyui-window" title="添加收文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="recFileForm" method="post" action="${basePath}/recFile/addFile.do" enctype="multipart/form-data">  
			<table>
<!-- 				<tr>
					<td><label>来文编号：<font style="color: red">*</font></label></td>
					<td><input id="fileId" class="required" name="fileId" type="text" value=""></input>
					<span id = "fileIdmsg" class="msg"></span>
					</td>
				</tr> -->
<!--  				<tr>
					<td><label>来文时间：<font style="color: red">*</font></label></td>
					<td> 
						<input class="easyui-datetimebox" name ="createDateStr"
						data-options="required:true,missingMessage:'时间不能为空',showSeconds:true,formatter:fmt,parser:pas" label="Select DateTime:" labelPosition="top" style="width:181px">
						<span id = "createDatemsg" class="msg"></span>
					</td>
				</tr> -->
				<tr>
					<td><label>来文单位：<font style="color: red">*</font></label></td>
					<td>
						<input name="deptId" class="easyui-combotree deptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false,animate:true,lines:true,required:false,missingMessage:'单位不能为空'" style="width:160px">
						<span id = "deptIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>来文字号：<font style="color: red">*</font></label></td>
					<td><input name="fileNo" class="fileNo required" type="text" value=""></input><span id = "fileNomsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>发文标题：<font style="color: red">*</font></label></td>
					<td><input name="fileTitle" class="fileTitle required" type="text" value=""></input><span id = "fileTitlemsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>来文文关键词：</label></td>
					<td><input name= "keyWords" class="keyWords" type="text" value=""></input><span id = "keyWordsmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>状态：</label></td>
					<td><select class="easyui-combobox status" name="status" style="width: 160px">
					  <option value ="1">已阅</option>
					  <option value ="2">董事长处理中</option>
					  <option value ="3">已处理</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文保密级别：</label></td>
					<td><select class="secretLevel" name="secretLevel" style="width: 160px">
					  <option value ="1">普通</option>
					  <option value ="2">保密</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文紧急级别：</label></td>
					<td><select class="emgLevel" name="emgLevel" style="width: 160px">
					  <option value ="1">一般</option>
					  <option value ="2">紧急</option>
					</select></td>
				</tr>
 				<tr>
					<td><label>附件：</label></td>
					<td>
						<input class="attachment" type="file" name="fileItem" style="width:160px">
					</td>  
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addFile()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#rfw').window('close')">取消</a>
			</div>
		</form>
		</div>
		
		<div id="mrfw" class="easyui-window" title="收文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="mrecFileForm" method="post" action="${basePath}/recFile/updateFile.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>来文编号：</label></td>
					<td><input class="mfileId" name="fileId" type="text" value=""  readonly="readonly"></input>
					</td>
				</tr>
				<tr>
					<td><label>来文时间：</label></td>
					<td> 
						<input class="easyui-datetimebox mcreateDate" name = "createDateStr"
						data-options="required:false,showSeconds:false, formatter:fmt,parser:pas,animate:true,lines:true" label="Select DateTime:" labelPosition="top" style="width:160px">
					</td>
				</tr>
				<tr>
					<td><label>来文单位：</label></td>
					<td><input name="deptId" class="easyui-combotree mdeptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:160px"></td>
				</tr>
				<tr>
					<td><label>来文字号：<font style="color: red">*</font></label></td>
					<td><input name="fileNo" class="mfileNo required" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文标题：<font style="color: red">*</font></label></td>
					<td><input name="fileTitle" class="mfileTitle required" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>来文文关键词：</label></td>
					<td><input name= "keyWords" class="mkeyWords" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>状态：</label></td>
					<td><select class="easyui-combobox mstatus" name="status" style="width: 160px">
					  <option value ="1">已阅</option>
					  <option value ="2">董事长处理中</option>
					  <option value ="3">已处理</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文保密级别：</label></td>
					<td><select class="msecretLevel" name="secretLevel" style="width: 160px">
					  <option value ="1">普通</option>
					  <option value ="2">保密</option>
					</select></td>
				</tr>
				<tr>
					<td><label>来文紧急级别：</label></td>
					<td><select class="memgLevel" name="emgLevel" style="width: 160px">
					  <option value ="1">一般</option>
					  <option value ="2">紧急</option>
					</select></td>
				</tr>
				<tr>
					<td><label>附件：</label></td>
					<td>
						<input class="mattachment" type="file" name="fileItem" style="width:160px">
					</td>  
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton update" id="add" onclick="updateFile()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton cancle" onclick="$('#mrfw').window('close')">取消</a>
			</div>
		</form>
		</div>
		</div>
</body>
</html>