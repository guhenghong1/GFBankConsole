<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%> 
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
<style type="text/css">
   .select{
   		  width:160px;
   }
</style>
	<script type="text/javascript" src="${basePath}/js/common/common.js?u=${times}"></script>
	<script type="text/javascript" src="${basePath}/js/dept/org.js?u=${times}"></script>
<div class="org" style="padding: 20px">
    <div style="margin-bottom: 10px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="Org.edit(0)">详情</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Org.edit(1)">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Org.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Org.deleteOrg()">删除</a>
    </div>
    <table id="org" class="easyui-treegrid" title="部门机构列表" style="width:700px;height:400px"
            data-options="
                iconCls: 'icon-ok',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                url: '${basePath}/dept/getOrgTree.do',
                method: 'get',
                idField: 'deptId',
                treeField: 'deptName',
                showFooter: true
            ">
        <thead>
            <tr>
                <th data-options="field:'deptName',width:120,align:'left',editor:'numberbox'">名称</th>
                <th data-options="field:'deptId',width:80,editor:'text'">编号</th>
                <th data-options="field:'isSalesDept',width:80,editor:'datebox'">是否为营业部</th>
                <th data-options="field:'address',width:80,editor:'datebox'">地址</th>
                <!-- <th data-options="field:'progress',width:120,formatter:formatProgress,editor:'numberbox'">Progress</th> -->
            </tr>
        </thead>
    </table>
    <div id="orgw" class="easyui-window" title="新增部门机构"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="orgForm" method="post" action="${basePath}/dept/addDept.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>机构名称：<font style="color: red">*</font></label></td>
					<td><input class="deptName required" name="deptName" type="text" value=""></input>
					<span class = "deptNamemsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>父节点：<font style="color: red">*</font></label></td>
					<td> 
						<input  name="superDeptId" class="easyui-combotree superDeptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false,animate:true,lines:true" style="width:160px">
						<span class = "superDeptIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>是否为营业部：</label></td>
					<td><select class="isSalesDept select" name="isSalesDept">
					  <option value ="1">是</option>
					  <option value ="0">否</option>
					</select></td>
				</tr>
				<tr>
					<td><label>机构级别：</label></td>
					<td><select class="level select" name="level">
					  <option value ="0">总行</option>
					  <option value ="1">一级机构</option>
					  <option value ="2">二级机构</option>
					  <option value ="3">三级机构</option>
					</select></td>
				</tr>
 				<tr>
					<td><label>地址：</label></td>
					<td>
						<input class="address" name="address" type="text" value=""></input>
					</td>  
				</tr>
				<tr>
	        		<td><label>备注：</label></td>
	        		<td colspan=""><textarea class="remark" name="remark" style="width: 300px; height: 80px;"></textarea></td>
        		</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addOrg()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#orgw').window('close')">取消</a>
			</div>
		</form>
		</div>
    <div id="morgw" class="easyui-window" title="部门机构"
			data-options="modal:true,closed:true,iconCls:'icon-save'"
			style="width: 500px; height: 400px; padding: 10px;">
		<form id="morgForm" method="post" action="${basePath}/dept/updateDept.do" enctype="multipart/form-data">  
			<table>
				<tr>
					<td><label>机构编号：<font style="color: red">*</font></label></td>
					<td><input class="mdeptId required" name="deptId" type="text" value="" readonly="readonly"></input>
					<span class = "deptIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>机构名称：<font style="color: red">*</font></label></td>
					<td><input class="mdeptName required" name="deptName" type="text" value=""></input>
					<span class = "deptNamemsg" class="msg"></span>
					</td>
				</tr>
 				<tr>
					<td><label>父节点：<font style="color: red">*</font></label></td>
					<td> 
						<input name="superDeptId" class="easyui-combotree msuperDeptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false,animate:true,lines:true" style="width:160px">
						<span class = "superDeptIdmsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td><label>是否为营业部：</label></td>
					<td><select class="misSalesDept select" name="isSalesDept">
					  <option value ="1">是</option>
					  <option value ="0">否</option>
					</select></td>
				</tr>
				<tr>
					<td><label>机构级别：</label></td>
					<td><select class="mlevel select" name="level">
					  <option value ="0">总行</option>
					  <option value ="1">一级机构</option>
					  <option value ="2">二级机构</option>
					  <option value ="3">三级机构</option>
					</select></td>
				</tr>
 				<tr>
					<td><label>地址：</label></td>
					<td>
						<input class="maddress" name="address" type="text" value=""></input>
					</td>  
				</tr>
				<tr>
	        		<td><label>备注：</label></td>
	        		<td colspan=""><textarea class="mremark" name="remark" style="width: 300px; height: 80px;"></textarea></td>
        		</tr>
			</table>
			<div style="margin: 20px 0;">
				<a href="javascript:void(0)" class="easyui-linkbutton update" id="add" onclick="updateOrg()">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton cancle" onclick="clearForm()">取消</a>
			</div>
		</form>
		</div>
    </div>
</body>
</html>