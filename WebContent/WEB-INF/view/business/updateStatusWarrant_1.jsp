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
	<script type="text/javascript" src="${basePath}/js/business/updateStatusWarrant.js?u=${times}"></script>
	<div class="warrant" style="padding: 20px">
		<div id="tb_us" style="height: auto">
			<div class="add" style="display:${menu eq 'add'? '':'none'}">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="WarrantUs.edit(0)">详情</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="WarrantUs.add()">新增</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="">打印申请表</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="">打印入库单</a>
			</div>
			<div class="update" style="display:${menu eq 'update'? '':'none'}">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="WarrantUs.edit(1)">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" style="display:none" onclick="WarrantUs.deleteOp()">删除</a>
			</div>
			<div class="update" style="display:${menu eq 'updateStatus'? '':'none'}">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="WarrantUs.edit(2)">详情</a>
				<!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="WarrantUs.edit(2)">删除</a> -->
			</div>
		</div>
        <div class="query" style="padding: 5px">  
           <label>编号：</label><input type="text" id = "qId_us" name="qId" style="width:150px"/>  
           <label>借款人：</label><input type="text" id = "qborrower_us" name="borrower" style="width:150px"/>  
           <label>状态：</label><select id="qstatus_us" name="status" class="easyui-combobox" panelHeight="auto" style="width:100px">  
                <option value="-1">全部</option>  
                <option value="0">待入库</option>  
                <option value="1">已入库</option>  
                <option value="2">出库</option>  
            </select>  
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryWarrant()">查询</a>  
        </div> 
		<table id="warrant_us" rownumbers="true"></table>
		
		<div id="warw_us" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="warrantForm_us" method="post" action="${basePath}/warrant/addWarrant.do" enctype="multipart/form-data">  
			<table>
	<!-- 			<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="id" class="required" name="id" type="text" value=""></input>
					<span id = "idmsg" class="msg"></span>
					</td>
				</tr> -->
 				<tr>
					<td><label>权证类型：<font style="color: red">*</font></label></td>
					<td> 
						<select id="type_us" name="type" class="easyui-combobox" panelHeight="auto" style="width:100px">  
			                <option value="0">他项权证</option>  
			                <option value="1">存单</option>  
			                <option value="2">承兑汇票</option>  
			                <option value="3">其它</option>  
			            </select>  
						<span id = "statusmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>借款人：<font style="color: red">*</font></label></td>
					<td>
						<input id="borrower_us" class="required" name="borrower" type="text" value=""></input>
						<span class = "borrowermsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>担保债权额度：<font style="color: red">*</font></label></td>
					<td><input id="normLimit" name="normLimit" class="required" type="text" value=""></input>
						<span class = "normLimitmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>产权所有人：<font style="color: red">*</font></label></td>
					<td><input id="propertyOwner_us" name="propertyOwner" class="required" type="text" value=""></input>
						<span class = "propertyOwnermsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>权证证号：</label></td>
					<td><input id="cardName_us" name="cardName" type="text" value="" style="display:none"></input>
						<span id = "WarrantTitlemsg_us" class="msg"></span>
						<input id="cardId_us" class="easyui-combobox" name="cardId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getCardList.do'">
					</td>
				</tr>
				<tr>
					<td><label>登记部门：<font style="color: red">*</font></label></td>
					<td><input id="deptName_us" name= "deptName" class="required" type="text" value="" style="display:none"></input>
						<input id="deptId_us" class="easyui-combobox" name="deptId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getDeptList.do'">
						<span class = "keyWordsmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>备注信息：<font style="color: red">*</font></label></td>
					<td><input id="remarkName_us" name= "remarkName" class="required" type="text" value="" style="display:none"></input>
					<input id="remark_us" class="easyui-combobox" name="remark"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getRemarkList.do'">
						<span class = "remarkIdsmsg" class="msg"></span>
					</td>
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton add" onclick="addWarrant()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
		
		<div id="mwarw_us" class="easyui-window" title="添加发文"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="mwarrantForm_us" method="post" action="${basePath}/warrant/updateWarrant.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="mid_us" class="required" name="id" type="text" value="" readonly="readonly"></input>
					<span class = "idmsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>权证类型：<font style="color: red">*</font></label></td>
					<td> 
						<select id="mtype_us" name="status" class="easyui-combobox" panelHeight="auto" style="width:181px">  
			                <option value="0">他项权证</option>  
			                <option value="1">存单</option>  
			                <option value="2">承兑汇票</option>  
			                <option value="3">其它</option>  
			            </select>  
						<span class = "typemsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>借款人：<font style="color: red">*</font></label></td>
					<td>
						<input id="mborrower_us" class="required" name="borrower" type="text" value=""></input>
						<span class = "borrowermsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>担保债权额度：<font style="color: red">*</font></label></td>
					<td><input id="mnormLimit_us" name="normLimit" class="required" type="text" value=""></input>
						<span class = "normLimitmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>产权所有人：<font style="color: red">*</font></label></td>
					<td><input id="mpropertyOwner_us" name="propertyOwner" class="required" type="text" value=""></input>
						<span class = "propertyOwnermsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>权证证号：</label></td>
					<td><input id="mcardName_us" name="cardName" type="text" value="" style="display:none"></input>
						<input id="mcardId_us" class="easyui-combobox" name="cardId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getCardList.do'">
					</td>
				</tr>
				<tr>
					<td><label>登记部门：<font style="color: red">*</font></label></td>
					<td><input id="mdeptName_us" name= "deptName" class="required" type="text" value="" style="display:none"></input>
						<input id="mdeptId_us" class="easyui-combobox" name="deptId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getDeptList.do'">
						<span class = "keyWordsmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>备注信息：<font style="color: red">*</font></label></td>
					<td><input id="mremarkName_us" name= "remark" class="required" type="text" value="" style="display:none"></input>
					<input id="mremark_us" class="easyui-combobox" name="remarkId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getRemarkList.do'">
						<span class = "remarkIdsmsg" class="msg"></span>
					</td>
				</tr>
				<tr style="display:${menu eq 'updateStatus'? '':'none'}">
					<td><label>状态：<font style="color: red">*</font></label></td>
					<td><select id="mstatus_us" name="status" class="easyui-combobox" panelHeight="auto" style="width:181px">  
			                <option value="0">待入库</option>  
			                <option value="1">已入库</option>  
			                <option value="2">出库</option>  
			            </select>  
						<span class = "statussmsg" class="msg"></span>
					</td>
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<%-- <a href="javascript:void(0)" class="easyui-linkbutton add" style="display:${menu eq 'add'? '':'none'}" onclick="addWarrant()">保存</a> --%>
				<a href="javascript:void(0)" class="easyui-linkbutton update" style="display:${(menu eq 'update' || menu eq 'updateStatus')? '':'none'}" onclick="updateWarrant()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
		 <script type="text/javascript">
/* 			function add() {
				alert("111");
			} */
		</script>
		</div>
</body>
</html>