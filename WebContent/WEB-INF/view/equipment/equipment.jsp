<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<script type="text/javascript" src="${basePath}/js/equipment/equipment.js?u=${times}"></script>
<div class="qz-user">
    <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Equipment.edit()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Equipment.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Equipment.deleteEquipment()">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Equipment.sendRepair()">送修</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-export',plain:true" onclick="exportEq()">导出</a>
    </div> 
  	<div class="query" style="padding-top: 5px"> 
  		<div style="padding-bottom: 5px"> 
			<label>设备编号：</label><input type="text" id = "qid" name="qid" style="width:150px"/>  
			<label>设备名称：</label><input type="text" id = "qname" name="qname" style="width:150px"/> 
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryEquipment()">查询</a> 
		</div> 
    </div> 
    <table id="tb_equipments" rownumbers="true"></table> 
    <div id="eqw" class="easyui-window" title="设备详情" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:500px;padding:10px;">
        <form id="eqForm">
        <table>
        	<tr>
        		<td width="80px"><label>设备编号：</label></td>
        		<td>
        			<input id="id" type="text"></input>
        		</td>
        	</tr>
        	<tr>
        		<td><label>设备姓名：</label></td>
        		<td><input id="name" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>设备型号：</label></td>
        		<td><input id="type" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>所在地：</label></td>
        		<td><input id="location" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>设备状态：</label></td>
        		<td>
        			<select id="inUse">
					  <option value ="1">在用</option>
					  <option value ="0">报废</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>供应商：</label></td>
        		<td>
        			<input id="companyId" name="companyId" class="easyui-combobox" 
        			data-options="url:'../materials/getMaterialsBox.do',method:'get',valueField:'id',textField:'text',panelHeight:'auto'" 
        			style="width:181px">
				</td>
        	</tr>
        	<tr>
        		<td><label>购入时间：</label></td>
        		<td><input id="buyTimeStr" class="easyui-datebox"></input></td>
        	</tr>
        	<tr>
        		<td><label>购入价格：</label></td>
        		<td><input id="price" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>备注：</label></td>
        		<td><input id="remark" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>管理部门：</label></td>
        		<td>
        			<input id="deptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px">
				</td>
        	</tr>
        </table>
        </form>
        <div style="margin:20px 0;">
        <a href="javascript:void(0)" class="easyui-linkbutton" id="update" onclick="Equipment.update()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="Equipment.addEquipment()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">取消</a>
    </div>
    </div>
</div>
