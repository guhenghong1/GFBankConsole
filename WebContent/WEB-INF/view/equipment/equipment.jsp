<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<style type="text/css">
   .select{
   		  width:160px;
   }
</style>
<script type="text/javascript" src="${basePath}/js/common/common.js?u=${times}"></script>
<script type="text/javascript" src="${basePath}/js/equipment/equipment.js?u=${times}"></script>
<div class="qz-user">
    <div id="tb" style="height:auto">
    	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="Equipment.edit(0)">详情</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="Equipment.edit(1)">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Equipment.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Equipment.deleteEquipment()">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="Equipment.edit(2)">送修</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-export',plain:true" onclick="exportEq()">导出</a>
    </div> 
  	<div class="queryEquip" style="padding-top: 5px"> 
  		<div style="padding-bottom: 5px"> 
			<label>设备名称：</label><input type="text" class = "qname" name="qname" style="width:150px"/> 
			<label>所在地：</label><input type="text" class = "qlocation" name="qlocation" style="width:150px"/> 
			<label>状态：</label>
	<!-- 		<input type="text" class = "qinUse" name="inUse" style="width:150px"/> -->
				<select class="qinUse select">
					  <option value =""></option>
					  <option value ="0">报废</option>
					  <option value ="1">在用</option>
					  <option value ="2">送修</option>
					</select> 
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryEquipment()">查询</a> 
		</div> 
    </div> 
    <table id="tb_equipments" rownumbers="true"></table> 
    <div id="eqw" class="easyui-window" title="设备详情" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:450px;height:420px;padding:10px;">
        <form id="eqForm">
        <table>
        	<tr class="tr_id" style="display:none">
        		<td width="80px"><label>设备编号：</label></td>
        		<td>
        			<input class="id" type="text" readonly="readonly"></input>
        		</td>
        	</tr>
        	<tr>
        		<td><label>设备姓名：</label></td>
        		<td><input class="name" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>设备型号：</label></td>
        		<td><input class="type" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>所在地：</label></td>
        		<td><input class="location" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>设备状态：</label></td>
        		<td>
        			<select class="inUse select">
					  <option value ="1">在用</option>
					  <option value ="0">报废</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>供应商：</label></td>
        		<td>
        			<input  name="companyId" class="easyui-combobox companyId" 
        			data-options="url:'../materials/getMaterialsBox.do',method:'get',valueField:'id',textField:'text',panelHeight:'auto'" 
        			style="width:160px">
				</td>
        	</tr>
        	<tr>
        		<td><label>购入时间：</label></td>
        		<td><input  class="easyui-datebox buyTimeStr"></input></td>
        	</tr>
        	<tr>
        		<td><label>购入价格：</label></td>
        		<td><input class="price" type="text"></input></td>
        	</tr>
        	<tr>
        		<td><label>备注：</label></td>
        		<td><input class="remark" type="text"></input></td>
        	</tr>
<!--         	<tr>
        		<td><label>管理部门：</label></td>
        		<td>
        			<input class="deptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px">
				</td>
        	</tr> -->
        		<tr>
					<td><label>管理部门：<font style="color: red">*</font></label></td>
					<td>
						<input name="deptId" class="easyui-combotree deptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false,animate:true,lines:true,required:false,missingMessage:'单位不能为空'" style="width:160px">
					</td>
				</tr>
        </table>
        </form>
        <div class="eq" style="margin:20px 0;">
        <a href="javascript:void(0)" class="easyui-linkbutton update"  onclick="Equipment.update()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton add"  onclick="Equipment.addEquipment()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton repair"  onclick="Equipment.sendRepair()" style="display:none">确认送修</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#eqw').window('close')">取消</a>
    </div>
    </div>
</div>
