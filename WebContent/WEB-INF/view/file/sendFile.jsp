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
	<script type="text/javascript" src="${basePath}/js/file/sendFile.js?u=${times}"></script>
	<div class="sendFile" style="padding: 20px">
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'',plain:true" onclick="SendFile.edit(0)">详情</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="SendFile.edit(1)">编辑</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="SendFile.add()">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="SendFile.deleteOp()">删除</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="SendFile.download()">打印</a>
		</div>
        <div class="query" style="padding: 5px">  
           <label>发文编号：</label><input type="text" id = "qFileId" name="qFileId" style="width:150px"/>  
           <label>关键词：</label><input type="text" id = "qkeyWords" name="qkeyWords" style="width:150px"/>  
           <label>总行：</label><select id="qdeptId" class="easyui-combobox" panelHeight="auto" style="width:100px">  
                <option value="1">总行</option>  
                <option value="2">支行</option>  
            </select>  
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryFile()">查询</a>  
        </div> 
		<table id="sendFile" rownumbers="true"></table>
		
		<div id="sfw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="sendFileForm" method="post" action="${basePath}/sendFile/addFile.do" enctype="multipart/form-data">  
			<table>
<!-- 				<tr>
					<td><label>发文编号：<font style="color: red">*</font></label></td>
					<td><input id="fileId" class="required" name="fileId" type="text" value=""></input>
					<span id = "fileIdmsg" class="msg"></span>
					</td>
				</tr> -->
				<tr>
					<td><label>发文时间：<font style="color: red">*</font></label></td>
					<td> 
						<input class="easyui-datetimebox" name = "createDateStr"
						data-options="required:false,showSeconds:true,formatter:fmt,parser:pas" label="Select DateTime:" labelPosition="top" style="width:181px">
						<span id = "createDatemsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>发文单位：<font style="color: red">*</font></label></td>
					<td>
						<input id="deptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px">
						<span id = "deptIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>发文字号：<font style="color: red">*</font></label></td>
					<td><input id="fileNo" name="fileNo" class="required" type="text" value=""></input><span id = "fileNomsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>发文标题：</label></td>
					<td><input id="fileTitle" name="fileTitle" type="text" value=""></input><span id = "fileTitlemsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>发文文关键词：<font style="color: red">*</font></label></td>
					<td><input id="keyWords" name= "keyWords" class="required" type="text" value=""></input><span id = "keyWordsmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>发文拟稿人：</label></td>
					<td><input id="author" name= "author" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文核查人：</label></td>
					<td><input id="checkAuthor" name= "checkAuthor" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文签发人：</label></td>
					<td><input id="signAuthor" name= "signAuthor" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文保密级别：</label></td>
					<td><select id="secretLevel" name="secretLevel">
					  <option value ="1">普通</option>
					  <option value ="2">保密</option>
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
		
		<div id="msfw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="msendFileForm" method="post" action="${basePath}/sendFile/updateFile.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>发文编号：</label></td>
					<td><input id="mfileIds" name="fileId" type="text" value=""></input>
					</td>
				</tr>
				<tr>
					<td><label>发文时间：</label></td>
					<td> 
						<input id="mcreateDates" class="easyui-datetimebox" name = "createDateStr"
						data-options="required:false,showSeconds:false, formatter:fmt,parser:pas" label="Select DateTime:" labelPosition="top" style="width:150px">
					</td>
				</tr>
				<tr>
					<td><label>发文单位：</label></td>
					<td><input id="mdeptIds" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px"></td>
				</tr>
				<tr>
					<td><label>发文字号：</label></td>
					<td><input id="mfileNos" name="fileNo" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文标题：</label></td>
					<td><input id="mfileTitles" name="fileTitle" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文关键词：</label></td>
					<td><input id="mkeyWordss" name= "keyWords" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文拟稿人：</label></td>
					<td><input id="mauthors" name= "author" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文核查人：</label></td>
					<td><input id="mcheckAuthors" name= "checkAuthor" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文签发人：</label></td>
					<td><input id="msignAuthors" name= "signAuthor" type="text" value=""></input></td>
				</tr>
				<tr>
					<td><label>发文保密级别：</label></td>
					<td><select id="msecretLevels" name="secretLevel">
					  <option value ="1">普通</option>
					  <option value ="2">保密</option>
					</select></td>
				</tr>
				<tr>
					<td><label>附件：</label></td>
					<td><img src=""/>
						<input id="mattachments" type="file" name="fileItem">
					</td>  
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton update" id="add" onclick="updateFile()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton cancle" onclick="clearForm(1)">取消</a>
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