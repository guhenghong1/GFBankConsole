<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 
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
<style type="text/css">
	th {
		text-align: center;
	}
</style>
</head>
<body>
<script type="text/javascript" src="${basePath}/js/common/common.js?u=${times}"></script>
<script type="text/javascript" src="${basePath}/js/common/comEasyui.js?u=${times}"></script>
<script type="text/javascript" src="${basePath}/js/user/user.js?u=${times}"></script>
<div class="qz-user">
    <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="User.edit()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="User.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="User.deleteUser()">删除</a>
    </div> 
  	<div class="query" style="padding-top: 5px"> 
  		<div style="padding-bottom: 5px"> 
			<label>用户工号：</label><input type="text" id = "quserId" name="quserId" style="width:150px"/>  
			<label>真实姓名：</label><input type="text" id = "qrealName" name="qrealName" style="width:150px"/>  
			<label>电话：</label><input type="text" id = "qphone" name="qphone" style="width:150px"/>  
		</div>
		<div style="padding-bottom: 5px">
			<label>手机号：</label><input type="text" id = "qmobile" name="qmobile" style="width:150px"/>  
			<label>部门：</label><input id="qdeptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:150px">  
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryUser()">查询</a>
		</div>  
    </div> 
    
    <table id="tb_users" rownumbers="true"></table> 
    <div id="w" class="easyui-window" title="用户详情" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:800px;height:600px;padding:10px;">
        <form id="userForm" method="post" action="${basePath}/user/addUser.do" enctype="multipart/form-data">
        <h2>一、个人基本信息</h2>
        <table class="userInfo">
        	<tr>
        		<td><label>用户工号：</label></td>
        		<td>
        			<input id="userId" name="userId" type="text" value=""></input>
        		</td>
        		<td><label>姓名：</label></td>
        		<td><input id="realName" name="realName" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>部门：</label></td>
        		<td>
        			<input id="deptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px">
        		</td>
        		 <td><label>生日：</label></td>
        			<td><input id="birthday" name="birthdayStr" class="easyui-datebox" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:100%;"></td> 
        	</tr>
        	<tr>
        		<td><label>性别：</label></td>
        		<td>
        			<select id="sex" name="sex">
					  <option value ="0">女</option>
					  <option value ="1">男</option>
					</select>
				</td>
        		<td><label>角色：</label></td>
        		<td>
        			<select id="roleId" name="roleId">
					  <option value ="1">普通用户</option>
					  <option value ="2">管理员</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>职务：</label></td>
        		<td>
        			<select id="position" name="position">
					  <option value ="0">实习生</option>
					  <option value ="1">客户经理</option>
					  <option value ="2">部门经理</option>
					</select>
				</td>
        		<td><label>当前状态：</label></td>
        		<td>
        			<select id="status" name="status">
					  <option value ="0">试用</option>
					  <option value ="1">转正</option>
					</select>
				</td>
        	</tr>
				<td><label>入行时间：</label></td>
        		<td>
        			<input id="entryDate" name="entryDateStr" class="easyui-datebox" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:100%;">
				</td>
        	<tr>
        	</tr>
        	<tr>
        		<td><label>籍贯：</label></td>
        		<td><input id="nativePlace" name="nativePlace" type="text" value=""></input></td>
        		<td><label>民族：</label></td>
        		<td><input id="nation" name="nation" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>政治面貌：</label></td>
        		<td>
        			<select id="politicsStatus" name="politicsStatus">
					  <option value ="0">群众</option>
					  <option value ="1">团员</option>
					  <option value ="2">党员</option>
					</select>
        		</td>
        		<td><label>身份证号：</label></td>
        		<td><input id="certId" name="certId" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>电话：</label></td>
        		<td><input id="phone" name="phone" type="text" value=""></input></td>
        		<td><label>手机号：</label></td>
        		<td><input id="mobile" name="mobile" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>学校：</label></td>
        		<td><input id="school" name="school" type="text" value=""></input></td>
        		<td><label>学历：</label></td>
        		<td><select id="eduLevel" name="eduLevel">
					  <option value ="0">大专</option>
					  <option value ="1">本科</option>
					  <option value ="2">研究生</option>
					  <option value ="3">博士</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>专业：</label></td>
        		<td><input id="major" name="major" type="text" value=""></input></td>
        		<td><label>邮箱：</label></td>
        		<td><input id="email" name = "email" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>家庭住址：</label></td>
        		<td colspan="3"><input id="homeAddress" name="homeAddress" type="text" value="" style="width: 400px; "></input></td>
        	</tr>
        	<tr>
        		<td><label>爱好特长：</label></td>
        		<td colspan="3"><textarea id="interest" name="interest" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
         	<tr>
				<td><label>身份证正面：</label></td>
				<td>
					<img id="imgFront" src=""></img>
					<input id="certFront" type="file" name="certFrontAttach">
				</td>  
				<td><label>身份证反面：</label></td>
				<td>
					<img id="imgBack" src=""></img>
					<input id="certBack" type="file" name="certBackAttach">
				</td>  
			</tr> 
        	<tr>
        		<td><label>其他备注：</label></td>
        		<td colspan="3"><textarea id="remark" name="remark" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
        </table>
        <h2>二、个人简历</h2>
        <table class="userSchool">
        	<tr>
	        	<th>起始时间</th>
	        	<th>毕业学校或工作单位</th>
	        	<th>备注</th>
	        </tr>
        	<tr class="schools">
        		<td><input class="time"  type="text" value=""></input></td>
        		<td><input class="schoolName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input></td>
        	</tr>
        	<tr class="schools">
        		<td><input class="time"  type="text" value=""></input></td>
        		<td><input class="schoolName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><input id="schoolList"  name= "schoolList" type="text" value="" style="display:none"></input></td>
        	</tr>
        </table>
        <h2>三、家庭关系</h2>
        <table class="userHome">
        	<tr>
	        	<th>称谓</th>
	        	<th>名称</th>
	        	<th>所在单位</th>
	        	<th>备注</th>
	        </tr>
        	<tr class="homes">
        		<td><input class="appellation"  type="text" value=""></input></td>
        		<td><input class="name"  type="text" value=""></input></td>
        		<td><input class="deptName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><input id="homeList"  name= "homeList" type="text" value="" style="display:none"></input></td>
        	</tr>
        </table>
        </form>
        <div style="margin:20px 0;">
<!--         <a href="javascript:void(0)" class="easyui-linkbutton" id="update" onclick="User.update()">保存</a> -->
        <a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="User.addUser()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">取消</a>
    	</div>
    </div>
    <div id="mw" class="easyui-window" title="用户详情" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:800px;height:600px;padding:10px;">
        <form id="muserForm" method="post" action="${basePath}/user/updateUser.do" enctype="multipart/form-data">
        <h2>一、个人基本信息</h2>
        <table class="userInfo">
        	<tr>
        		<td><label>用户工号：</label></td>
        		<td>
        			<input id="muserId" name="userId" type="text" value=""></input>
        		</td>
        		<td><label>姓名：</label></td>
        		<td><input id="mrealName" name="realName" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>部门：</label></td>
        		<td>
        			<input id="mdeptId" name="deptId" class="easyui-combotree" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:181px">
        		</td>
        		 <td><label>生日：</label></td>
        			<td><input id="mbirthday" name="birthdayStr" class="easyui-datebox" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:100%;"></td> 
        	</tr>
        	<tr>
        		<td><label>性别：</label></td>
        		<td>
        			<select id="msex" name="sex">
					  <option value ="0">女</option>
					  <option value ="1">男</option>
					</select>
				</td>
        		<td><label>角色：</label></td>
        		<td>
        			<select id="mroleId" name="roleId">
					  <option value ="1">普通用户</option>
					  <option value ="2">管理员</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>职务：</label></td>
        		<td>
        			<select id="mposition" name="position">
					  <option value ="0">实习生</option>
					  <option value ="1">客户经理</option>
					  <option value ="2">部门经理</option>
					</select>
				</td>
        		<td><label>当前状态：</label></td>
        		<td>
        			<select id="mstatus" name="status">
					  <option value ="0">试用</option>
					  <option value ="1">转正</option>
					</select>
				</td>
        	</tr>
				<td><label>入行时间：</label></td>
        		<td>
        			<input id="mentryDate" name="entryDateStr" class="easyui-datebox" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:100%;">
				</td>
        	<tr>
        	</tr>
        	<tr>
        		<td><label>籍贯：</label></td>
        		<td><input id="mnativePlace" name="nativePlace" type="text" value=""></input></td>
        		<td><label>民族：</label></td>
        		<td><input id="mnation" name="nation" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>政治面貌：</label></td>
        		<td>
        			<select id="mpoliticsStatus" name="politicsStatus">
					  <option value ="0">群众</option>
					  <option value ="1">团员</option>
					  <option value ="2">党员</option>
					</select>
        		</td>
        		<td><label>身份证号：</label></td>
        		<td><input id="mcertId" name="certId" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>电话：</label></td>
        		<td><input id="mphone" name="phone" type="text" value=""></input></td>
        		<td><label>手机号：</label></td>
        		<td><input id="mmobile" name="mobile" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>学校：</label></td>
        		<td><input id="mschool" name="school" type="text" value=""></input></td>
        		<td><label>学历：</label></td>
        		<td><select id="meduLevel" name="eduLevel">
					  <option value ="0">大专</option>
					  <option value ="1">本科</option>
					  <option value ="2">研究生</option>
					  <option value ="3">博士</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>专业：</label></td>
        		<td><input id="mmajor" name="major" type="text" value=""></input></td>
        		<td><label>邮箱：</label></td>
        		<td><input id="memail" name = "email" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>家庭住址：</label></td>
        		<td colspan="3"><input id="mhomeAddress" name="homeAddress" type="text" value="" style="width: 400px; "></input></td>
        	</tr>
        	<tr>
        		<td><label>爱好特长：</label></td>
        		<td colspan="3"><textarea id="minterest" name="interest" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
         	<tr>
				<td><label>身份证正面：</label></td>
				<td>
					<img id="mimgFront" src=""></img>
					<input id="mcertFront" type="file" name="certFrontAttach">
				</td>  
				<td><label>身份证反面：</label></td>
				<td>
					<img id="mimgBack" src=""></img>
					<input id="mcertBack" type="file" name="certBackAttach">
				</td>  
			</tr> 
        	<tr>
        		<td><label>其他备注：</label></td>
        		<td colspan="3"><textarea id="mremark" name="remark" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
        </table>
        <h2>二、个人简历</h2>
        <table class="muserSchool">
        	<tr>
	        	<th>起始时间</th>
	        	<th>毕业学校或工作单位</th>
	        	<th>备注</th>
	        </tr>
    <!--     	<tr class="mschools">
        		<td><input class="time"  type="text" value=""></input></td>
        		<td><input class="schoolName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input></td>
        	</tr> -->
        	<tr>
        		<td><input id="mschoolList"  name= "schoolList" type="text" value="" style="display:none"></input></td>
        	</tr>
        </table>
        <h2>三、家庭关系</h2>
        <table class="muserHome">
        	<tr>
	        	<th>称谓</th>
	        	<th>名称</th>
	        	<th>所在单位</th>
	        	<th>备注</th>
	        </tr>
     <!--    	<tr class="mhomes">
        		<td><input class="appellation"  type="text" value=""></input></td>
        		<td><input class="name"  type="text" value=""></input></td>
        		<td><input class="deptName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input></td>
        	</tr> -->
        	<tr>
        		<td><input id="mhomeList"  name= "homeList" type="text" value="" style="display:none"></input></td>
        	</tr>
        </table>
        </form>
        <div style="margin:20px 0;">
         <a href="javascript:void(0)" class="easyui-linkbutton" id="update" onclick="User.update()">保存</a> 
        <!-- <a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="User.addUser()">保存</a> -->
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">取消</a>
    	</div>
    </div>
</div>
</body>
</html>

