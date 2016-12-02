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
	<script type="text/javascript" src="${basePath}/js/business/warrant.js?u=${times}"></script>
	<div class="warrant" style="padding: 20px">
		<div id="tb" style="height: auto" menu="${menu}">
			<div class="add" style="display:${menu eq 'add'? '':'none'}">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="Warrant.edit(0)">详情</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Warrant.add()">新增</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="Warrant.printApply()">打印申请表</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="Warrant.printInOrder()">打印入库单</a>
			</div>
			<div class="updateUpdate" style="display:${menu eq 'updateStatus'? '':'none'}">	
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Warrant.edit(1)">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" style="display:none" onclick="Warrant.deleteOp()">删除</a>
			</div>
			<div class="updateUpdate" style="display:${menu eq 'updateStatus'? '':'none'}">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Warrant.edit(2)">详情</a>
				<!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="Warrant.edit(2)">删除</a> -->
			</div>
		</div>
<!--         <div class="query" style="padding: 5px">  
           <label>编号：</label><input type="text" id = "qId" name="qId" style="width:150px"/>  
           <label>借款人：</label><input type="text" id = "qborrower" name="borrower" style="width:150px"/>  
           <label>状态：</label><select id="qstatus" name="status" class="easyui-combobox" panelHeight="auto" style="width:100px">  
                <option value="-1">全部</option>  
                <option value="0">待入库</option>  
                <option value="1">已入库</option>  
                <option value="2">出库</option>  
            </select>  
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryWarrant()">查询</a>  
        </div> -->
        <div class="queryWarrant">
	        <table>
	        	<tr>
	           <td><label>编号：</label></td><td><input type="text" class = "qId"  style="width:150px"/></td>  
	           <td><label>借款人：</label></td><td><input type="text" class = "qborrower"  style="width:150px"/></td>  
	           <td><label>状态：</label></td>
	           <td>
		           <select id="qstatus" name="status" class="easyui-combobox qstatus" panelHeight="auto" style="width:100px">  
		                <option value="-1">全部</option>  
		                <option value="0">待入库</option>  
		                <option value="1">已入库</option>  
		                <option value="2">出库</option>  
	            	</select>
	           </td>  
	            </tr>
	            <tr>
	            <td><label>开始时间：</label></td>
	            <td><input id="qstartDate" class="easyui-datetimebox qstartDate"
							data-options="required:false,showSeconds:true,formatter:myformatter,parser:myparser" label="Select DateTime:" labelPosition="top" style="width:160px">
	            </td>
	            <td><label>结束时间：</label></td>
	            <td><input id="qendDate" class="easyui-datetimebox qendDate"
							data-options="required:false,showSeconds:true,formatter:myformatter,parser:myparser" label="Select DateTime:" labelPosition="top" style="width:160px">
	            </td>
	            <td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryWarrant()">查询</a></td>
	            <td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="clearQuery()">重置</a></td>
	            </tr>
	            </table>
            </div>
		<table id="warrant" rownumbers="true"></table>
		
		<div id="warw" class="easyui-window" title="添加权证"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="warrantForm" method="post" action="${basePath}/warrant/addWarrant.do" enctype="multipart/form-data">  
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
						<select  name="type" class="easyui-combobox type" data-options="required:false,missingMessage:'类型不能为空'" panelHeight="auto" style="width:160px">  
			                <!-- <option value=""></option>   -->
			                <option value="1">他项权证</option>  
			                <option value="2">存单</option>  
			                <option value="3">承兑汇票</option>  
			                <option value="4">其它</option>  
			            </select>
						<span id = "typemsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>借款人：<font style="color: red">*</font></label></td>
					<td>
						<input  class="borrower required" name="borrower" type="text" value=""></input>
						<span id = "borrowermsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>担保债权额度：<font style="color: red">*</font></label></td>
					<td><input name="normLimit" class="normLimit required" type="text" value=""></input>
						<span id = "normLimitmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>产权所有人：<font style="color: red">*</font></label></td>
					<td><input id="propertyOwner" name="propertyOwner" class="propertyOwner required" type="text" value=""></input>
						<span class = "propertyOwnermsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>权证证号：</label></td>
					<td><input class="cardName" name="cardName" type="text" value="" style="display:none"></input>
						<input id="cardId" class="easyui-combobox cardId" name="cardId"
    						data-options="required:false,missingMessage:'证号不能为空',valueField:'id',textField:'name',url:'${basePath}/warrant/getCardList.do'">
					</td>
				</tr>
				<tr>
					<td><label>登记部门：<font style="color: red">*</font></label></td>
					<td><input id="deptName" name= "deptName" class="deptName" type="text" value="" style="display:none"></input>
						<input id="deptId" class="easyui-combobox deptId" name="deptId"
    						data-options="required:false,missingMessage:'部门不能为空',valueField:'id',textField:'name',url:'${basePath}/warrant/getDeptList.do'">
					</td>
				</tr>
				<tr>
					<td><label>备注信息：<font style="color: red">*</font></label></td>
					<td><input id="remarkName" name= "remarkName" class="remarkName" type="text" value="" style="display:none"></input>
					<input id="remark" class="easyui-combobox remark" name="remark"
    						data-options="required:false,missingMessage:'备注不能为空',valueField:'id',textField:'name',url:'${basePath}/warrant/getRemarkList.do'">
					</td>
				</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton add" onclick="addWarrant()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#warw').window('close')">取消</a>
			</div>
		</form>
		</div>
		
		<div id="mwarw" class="easyui-window" title="修改权证"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="mwarrantForm" method="post" action="${basePath}/warrant/updateWarrant.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>编号：<font style="color: red">*</font></label></td>
					<td><input id="mid" class="mid required" name="id" type="text" value="" readonly="readonly"></input>
					<span class = "idmsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>权证类型：<font style="color: red">*</font></label></td>
					<td> 
						<select name="status" class="easyui-combobox mtype" panelHeight="auto" style="width:160px">  
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
						<input  class="mborrower required" name="borrower" type="text" value=""></input>
						<span class = "borrowermsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>担保债权额度：<font style="color: red">*</font></label></td>
					<td><input  name="normLimit" class="mnormLimit required" type="text" value=""></input>
						<span class = "normLimitmsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>产权所有人：<font style="color: red">*</font></label></td>
					<td><input  name="propertyOwner" class="mpropertyOwner" type="text" value=""></input>
						<span class = "propertyOwnermsg" class="msg"></span></td>
				</tr>
				<tr>
					<td><label>权证证号：</label></td>
					<td><input class="mcardName" name="cardName" type="text" value="" style="display:none"></input>
						<input  class="easyui-combobox mcardId" name="cardId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getCardList.do'">
					</td>
				</tr>
				<tr>
					<td><label>登记部门：<font style="color: red">*</font></label></td>
					<td><input id="mdeptName" name= "deptName" class="mdeptName" type="text" value="" style="display:none"></input>
						<input  class="easyui-combobox mdeptId" name="deptId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getDeptList.do'">
						<span class = "keyWordsmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>备注信息：<font style="color: red">*</font></label></td>
					<td><input  name= "remark" class="mremarkName" type="text" value="" style="display:none"></input>
					<input  class="easyui-combobox mremark" name="remarkId"
    						data-options="valueField:'id',textField:'name',url:'${basePath}/warrant/getRemarkList.do'">
						<span class = "remarkIdsmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>状态：<font style="color: red">*</font></label></td>
					<td><select  name="status" class="easyui-combobox mstatus" panelHeight="auto" style="width:160px">  
			                <option value="0">待入库</option>  
			                <option value="1">已入库</option>  
			                <option value="2">出库</option>  
			            </select>  
						<span class = "statussmsg" class="msg"></span>
					</td>
				</tr>
			</table>
			<div class="operate" style="margin: 20px 0;">
				<%-- <a href="javascript:void(0)" class="easyui-linkbutton add" style="display:${menu eq 'add'? '':'none'}" onclick="addWarrant()">保存</a> --%>
				<a href="javascript:void(0)" class="easyui-linkbutton update" style="" onclick="updateWarrant()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#mwarw').window('close')">取消</a>
			</div>
		</form>
		</div>
		 <script type="text/javascript">
		</script>
		</div>
</body>
</html>