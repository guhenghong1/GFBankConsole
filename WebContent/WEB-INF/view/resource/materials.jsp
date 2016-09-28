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
	<script type="text/javascript" src="${basePath}/js/resource/materials.js?u=${times}"></script>
	<div class="Materials" style="padding: 20px">
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'',plain:true" onclick="Materials.edit(0)">详情</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Materials.edit(1)">编辑</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Materials.add()">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Materials.deleteOp()">删除</a>
		</div>
        <div class="query" style="padding: 5px">  
           <label>编号：</label><input type="text" id = "qCompanyId" name="qMaterialsId" style="width:150px"/>  
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryMaterials()">查询</a>  
        </div> 
		<table id="materials" rownumbers="true"></table>
		
		<div id="matw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="materialsForm" method="post" action="${basePath}/materials/addMaterials.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="companyId" class="required" name="companyId" type="text" value=""></input>
					<span id = "companyIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>公司名称：<font style="color: red">*</font></label></td>
					<td>
						<input id="company" class="required" name="company" type="text" value=""></input>
						<span id = "companymsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>供应商类型：</label></td>
					<td><select id="type" name="type">
					  <option value ="1">生活电器</option>
					  <option value ="1">五金材料</option>
					</select></td>
				</tr>
				<tr>
					<td><label>提供服务范围：</label></td>
					<td><input id="scope" name="scope" type="text" value=""></input>
					<span id = "scopemsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人1：<font style="color: red">*</font></label></td>
					<td><input id="supplierA" name= "supplierA" class="required" type="text" value=""></input>
					<span id = "supplierAmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人1：<font style="color: red">*</font></label></td>
					<td><input id="mobileA" name= "mobileA" class="required" type="text" value=""></input>
					<span id = "mobileAmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人2：<font style="color: red">*</font></label></td>
					<td><input id="supplierB" name= "supplierB" class="required" type="text" value=""></input>
					<span id = "supplierBmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人2：<font style="color: red">*</font></label></td>
					<td><input id="mobileB" name= "mobileB" class="required" type="text" value=""></input>
					<span id = "mobileBmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>备注：<font style="color: red">*</font></label></td>
					<td><textarea id="remark" name="remark" style="width: 250px; height: 80px;"></textarea></td>
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addMaterials()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
		
		<div id="umatw" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 450px; padding: 10px;">
		<form id="mMaterialsForm" method="post" action="${basePath}/materials/updateMaterials.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="mcompanyId" class="required" name="companyId" type="text" value=""></input>
					<span id = "mcompanyIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>公司名称：<font style="color: red">*</font></label></td>
					<td>
						<input id="mcompany" class="required" name="company" type="text" value=""></input>
						<span id = "mcompanymsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>供应商类型：</label></td>
					<td><select id="mtype" name="type">
					  <option value ="1">生活电器</option>
					  <option value ="1">五金材料</option>
					</select></td>
				</tr>
				<tr>
					<td><label>提供服务范围：</label></td>
					<td><input id="mscope" name="scope" type="text" value=""></input>
					<span id = "mscopemsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人1：<font style="color: red">*</font></label></td>
					<td><input id="msupplierA" name= "supplierA" class="required" type="text" value=""></input>
					<span id = "msupplierAmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人1：<font style="color: red">*</font></label></td>
					<td><input id="mmobileA" name= "mobileA" class="required" type="text" value=""></input>
					<span id = "mmobileAmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人2：<font style="color: red">*</font></label></td>
					<td><input id="msupplierB" name= "supplierB" class="required" type="text" value=""></input>
					<span id = "msupplierBmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>联系人2：<font style="color: red">*</font></label></td>
					<td><input id="mmobileB" name= "mobileB" class="required" type="text" value=""></input>
					<span id = "mmobileBmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>备注：<font style="color: red">*</font></label></td>
					<td><textarea id="mremark" name="remark" style="width: 250px; height: 80px;"></textarea></td>
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addMaterials()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
</body>
</html>