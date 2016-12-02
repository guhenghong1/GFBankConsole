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
	
#imgHeadPhoto{
     width:100px;
     height:100px;
     border-radius:50% ;
     margin:20px auto;
     cursor: pointer;
   }

   .select{
   		  width:181px;
   }

</style>
</head>
<body>
<style type="text/css">
   .select{
   		  width:160px;
   }
</style>
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.2/themes/default/easyui.css">
<%-- <script type="text/javascript" src="${basePath}/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${basePath}/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${basePath}/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${basePath}/js/easyui-lang-zh_CN.js"></script> --%>
<script type="text/javascript" src="${basePath}/js/common/common.js?u=${times}"></script>
<script type="text/javascript" src="${basePath}/js/common/comEasyui.js?u=${times}"></script>
<script type="text/javascript" src="${basePath}/js/user/user.js?u=${times}"></script>
<div class="qz-user">
    <div id="tb" style="height:auto">
    	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help',plain:true" onclick="User.edit(0)">详情</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="User.add()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="User.edit(1)">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="User.deleteUser()">删除</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-set',plain:true" onclick="User.setMenu()">功能菜单权限设置</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-export',plain:true" onclick="exportUser()">导出</a>
    </div> 
  	<div class="queryUser" style="padding-top: 5px"> 
  		<!-- <div style="padding-bottom: 5px">  -->
  		<table>
  			<tr>
			<td><label>用户工号：</label></td><td><input type="text" class = "quserId" name="quserId" style="width:150px"/></td>  
			<td><label>真实姓名：</label></td><td><input type="text" class = "qrealName" name="qrealName" style="width:150px"/></td> 
			<td><label>电话：</label></td><td><input type="text" class = "qphone" name="qphone" style="width:150px"/></td>  
			</tr>
<!-- 		</div>
		<div style="padding-bottom: 5px"> -->
		<tr>
			<td><label>手机号：</label></td><td><input type="text" class = "qmobile" name="qmobile" style="width:150px"/></td>  
			<td><label>部门：</label></td><td><input name="deptId" class="easyui-combotree qdeptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:150px"></td>  
			<td><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryUser()">查询</a></td>
		</tr>
		</table>
		<!-- /div>   -->
    </div> 
    
    <table id="tb_users" rownumbers="true"></table> 
    <div id="w" class="easyui-window" title="用户详情" data-options="modal:true,closed:true,cache:false,iconCls:'icon-save'" style="width:850px;height:550px;padding:10px;">
        <form id="userForm" method="post" action="${basePath}/user/addUser.do" enctype="multipart/form-data">
        <h2>一、个人基本信息</h2>
        <table class="userInfo">
        	<tr>
        		<td><label>用户工号：</label></td>
        		<td>
        			<input class="userId" name="userId" type="text" value=""></input>
        		</td>
        		<td><label>姓名：</label></td>
        		<td><input class="realName" name="realName" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>部门：</label></td>
        		<td>
        			<input name="deptId" class="easyui-combotree deptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:160px">
        		</td>
        		 <td><label>生日：</label></td>
        			<td><input name="birthdayStr" class="easyui-datebox birthday" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:160px"></td> 
        	</tr>
        	<tr>
        		<td><label>性别：</label></td>
        		<td>
        			<select name="sex" class="sex select">
					  <option value ="0">女</option>
					  <option value ="1">男</option>
					</select>
				</td>
        		<td><label>角色：</label></td>
        		<td>
        			<select  name="roleId" class="roleId select">
					  <option value ="1">普通用户</option>
					  <option value ="2">管理员</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>职务：</label></td>
        		<td>
        			<select name="position" class="position select">
					  <option value ="0">实习生</option>
					  <option value ="1">客户经理</option>
					  <option value ="2">部门经理</option>
					</select>
				</td>
        		<td><label>当前状态：</label></td>
        		<td>
        			<select name="status" class="status select">
					  <option value ="0">试用</option>
					  <option value ="1">转正</option>
					</select>
				</td>
        	</tr>
				<td><label>入行时间：</label></td>
        		<td>
        			<input name="entryDateStr" class="easyui-datebox entryDate" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:160px">
				</td>
        	<tr>
        	</tr>
        	<tr>
        		<td><label>籍贯：</label></td>
        		<td><input class="nativePlace" name="nativePlace" type="text" value=""></input></td>
        		<td><label>民族：</label></td>
        		<td><input class="nation" name="nation" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>政治面貌：</label></td>
        		<td>
        			<select name="politicsStatus" class="politicsStatus select">
					  <option value ="0">群众</option>
					  <option value ="1">团员</option>
					  <option value ="2">党员</option>
					</select>
        		</td>
        		<td><label>身份证号：</label></td>
        		<td><input class="certId" name="certId" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>电话：</label></td>
        		<td><input class="phone" name="phone" type="text" value=""></input></td>
        		<td><label>手机号：</label></td>
        		<td><input class="mobile" name="mobile" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>学校：</label></td>
        		<td><input class="school" name="school" type="text" value=""></input></td>
        		<td><label>学历：</label></td>
        		<td><select name="eduLevel" class="eduLevel select">
					  <option value ="0">大专</option>
					  <option value ="1">本科</option>
					  <option value ="2">研究生</option>
					  <option value ="3">博士</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>专业：</label></td>
        		<td><input class="major" name="major" type="text" value=""></input></td>
        		<td><label>邮箱：</label></td>
        		<td><input class="email" name = "email" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>家庭住址：</label></td>
        		<td colspan="3"><input class="homeAddress" name="homeAddress" type="text" value="" style="width: 400px; "></input></td>
        	</tr>
        	<tr>
        		<td><label>爱好特长：</label></td>
        		<td colspan="3"><textarea class="interest" name="interest" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
<!--         	<tr>
				<td><label>头像：</label></td>
				<td>
					<img id="imgHeadPhoto" src=""></img>
					<input id="headPhoto" type="file" name="headPhotoAttach">
				</td>
			</tr>  --> 
         	<tr>
				<td><label>身份证正面：</label></td>
				<td>
					<img class="imgFront" src=""></img>
					<input class="certFront" type="file" name="certFrontAttach">
				</td>  
				<td><label>身份证反面：</label></td>
				<td>
					<img class="imgBack" src=""></img>
					<input class="certBack" type="file" name="certBackAttach">
				</td>  
			</tr> 
        	<tr>
        		<td><label>其他备注：</label></td>
        		<td colspan="3"><textarea class="remark" name="remark" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
        </table>
        <h2>二、个人简历</h2>
        <table class="userSchool">
        	<tr>
	        	<th>起始时间</th>
	        	<th>毕业学校或工作单位</th>
	        	<th>备注&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="addSchoolEle()"><img src="${basePath}/images/add.png"/></a></th>
	        </tr>
        	<tr class="schools">
        		<td><input class="time"  type="text" value=""></input></td>
        		<td><input class="schoolName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input>
        		<a href='javascript:void(0)' onclick='removeEle(this)'><img src='../images/remove.png'/></a>
        		</td>
        	</tr>
<!--         	<tr class="schools">
        		<td><input class="time"  type="text" value=""></input></td>
        		<td><input class="schoolName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input>
        		<a href='javascript:void(0)' onclick='removeEle(this)'><img src='../images/remove.png'/></a>
        		</td>
        	</tr> -->
        	<tr>
        		<td><input id="schoolList"  name= "schoolList" type="text" value="" style="display:none"></input>
        		</td>
        	</tr>
        </table>
        <h2>三、家庭关系</h2>
        <table class="userHome">
        	<tr>
	        	<th>称谓</th>
	        	<th>名称</th>
	        	<th>所在单位</th>
	        	<th>备注&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="addHomeEle()"><img src="${basePath}/images/add.png"/></a></th>
	        </tr>
        	<tr class="homes">
        		<td><input class="appellation"  type="text" value=""></input></td>
        		<td><input class="name"  type="text" value=""></input></td>
        		<td><input class="deptName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input>
        		<a href='javascript:void(0)' onclick='removeEle(this)'><img src='../images/remove.png'/></a></td>
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
    <div id="mw" class="easyui-window" title="用户详情" data-options="modal:true,closed:true,cache:false,iconCls:'icon-save'" style="width:850px;height:550px;padding:10px;">
        <form id="muserForm" method="post" action="${basePath}/user/updateUser.do" enctype="multipart/form-data">
        <h2>一、个人基本信息</h2>
        <table class="userInfo">
        	<tr>
        		<td><label>用户工号：</label></td>
        		<td>
        			<input class="muserId" name="userId" type="text" value="" readonly="readonly"></input>
        		</td>
        		<td><label>姓名：</label></td>
        		<td><input class="mrealName" name="realName" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>部门：</label></td>
        		<td>
        			<input name="deptId" class="easyui-combotree mdeptId" data-options="url:'../dept/getDeptTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:false" style="width:160px">
        		</td>
        		 <td><label>生日：</label></td>
        			<td><input name="birthdayStr" class="easyui-datebox mbirthday" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:160px"></td> 
        	</tr>
        	<tr>
        		<td><label>性别：</label></td>
        		<td>
        			<select name="sex" class="msex select">
					  <option value ="0">女</option>
					  <option value ="1">男</option>
					</select>
				</td>
        		<td><label>角色：</label></td>
        		<td>
        			<select name="roleId" class="mroleId select">
					  <option value ="1">普通用户</option>
					  <option value ="2">管理员</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>职务：</label></td>
        		<td>
        			<select name="position" class="mposition select">
					  <option value ="0">实习生</option>
					  <option value ="1">客户经理</option>
					  <option value ="2">部门经理</option>
					</select>
				</td>
        		<td><label>当前状态：</label></td>
        		<td>
        			<select name="status" class="mstatus select">
					  <option value ="0">试用</option>
					  <option value ="1">转正</option>
					</select>
				</td>
        	</tr>
				<td><label>入行时间：</label></td>
        		<td>
        			<input name="entryDateStr" class="easyui-datebox mentryDate" label="Customized Format:" labelPosition="top" data-options="formatter:myformatter,parser:myparser" style="width:160px">
				</td>
        	<tr>
        	</tr>
        	<tr>
        		<td><label>籍贯：</label></td>
        		<td><input class="mnativePlace" name="nativePlace" type="text" value=""></input></td>
        		<td><label>民族：</label></td>
        		<td><input class="mnation" name="nation" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>政治面貌：</label></td>
        		<td>
        			<select name="politicsStatus" class="mpoliticsStatus select">
					  <option value ="0">群众</option>
					  <option value ="1">团员</option>
					  <option value ="2">党员</option>
					</select>
        		</td>
        		<td><label>身份证号：</label></td>
        		<td><input class="mcertId" name="certId" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>电话：</label></td>
        		<td><input class="mphone" name="phone" type="text" value=""></input></td>
        		<td><label>手机号：</label></td>
        		<td><input class="mmobile" name="mobile" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>学校：</label></td>
        		<td><input class="mschool" name="school" type="text" value=""></input></td>
        		<td><label>学历：</label></td>
        		<td><select name="eduLevel" class="meduLevel select">
					  <option value ="0">大专</option>
					  <option value ="1">本科</option>
					  <option value ="2">研究生</option>
					  <option value ="3">博士</option>
					</select>
				</td>
        	</tr>
        	<tr>
        		<td><label>专业：</label></td>
        		<td><input class="mmajor" name="major" type="text" value=""></input></td>
        		<td><label>邮箱：</label></td>
        		<td><input class="memail" name = "email" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>家庭住址：</label></td>
        		<td colspan="3"><input class="mhomeAddress" name="homeAddress" type="text" value="" style="width: 400px; "></input></td>
        	</tr>
        	<tr>
        		<td><label>爱好特长：</label></td>
        		<td colspan="3"><textarea class="minterest" name="interest" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
         	<tr>
				<td><label>身份证正面：</label></td>
				<td>
					<img class="mimgFront" src=""></img>
					<input class="mcertFront" type="file" name="certFrontAttach">
				</td>  
				<td><label>身份证反面：</label></td>
				<td>
					<img class="mimgBack" src=""></img>
					<input class="mcertBack" type="file" name="certBackAttach">
				</td>  
			</tr> 
        	<tr>
        		<td><label>其他备注：</label></td>
        		<td colspan="3"><textarea class="mremark" name="remark" style="width: 400px; height: 80px;"></textarea></td>
        	</tr>
        </table>
        <h2>二、个人简历</h2>
        <table class="muserSchool">
        	<tr>
	        	<th>起始时间</th>
	        	<th>毕业学校或工作单位</th>
	        	<th>备注&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="addSchoolEle(1)"><img src="${basePath}/images/add.png"/></a></th>
	        	<%-- <th><a href="javascript:void(0)" onclick="addSchoolEle(1)"><img src="${basePath}/images/add.png"/></a></th> --%>
	        </tr>
  <!--        	<tr class="mschools" style="display:none">
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
	        	<th>备注<a href="javascript:void(0)" onclick="addHomeEle(1)"><img src="${basePath}/images/add.png"/></a></th>
	        </tr>
     <!--     	<tr class="mhomes" style="display:none">
        		<td><input class="appellation"  type="text" value=""></input></td>
        		<td><input class="name"  type="text" value=""></input></td>
        		<td><input class="deptName"  type="text" value=""></input></td>
        		<td><input class="remark"  type="text" value=""></input></td>
        	</tr>  -->
        	<tr>
        		<td><input id="mhomeList"  name= "homeList" type="text" value="" style="display:none"></input></td>
        	</tr>
        </table>
        </form>
        <div id="userMenuw" class="easyui-window" title="设置菜单" data-options="modal:true,closed:true,cache:false,iconCls:'icon-save'" style="width:400px;height:300px;padding:10px;">
        <form id="userMenuForm" method="post" action="${basePath}/user/addUserMenu.do" enctype="multipart/form-data">
        <table class="userInfo">
        	<tr>
        		<td><label>用户工号：</label></td>
        		<td>
        			<input class="menuUserId" name="userId" type="text" value="" readonly="readonly"></input>
        		</td>
        	</tr>
        	<tr>
        		<td><label>姓名：</label></td>
        		<td><input class="menuRealName" name="realName" type="text" value=""></input></td>
        	</tr>
        	<tr>
        		<td><label>菜单：</label></td>
        		<td>
        			 <input name="menuIds" class="easyui-combotree amenuIds" data-options="url:'../menu/getMenuTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:true" style="width:200px"> 
        			<!-- <input id="amenuIds" name="menuIds" class="easyui-tree" data-options="url:'../menu/getMenuTree.do',method:'get',label:'Select Nodes:',labelPosition:'top',multiple:true" style="width:160px"> -->
        		</td>
        	</tr>
        	</table>
        	</form>
        	<a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="addUserMenu()">保存</a>
        	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#userMenuw').window('close')">取消</a>
        </div>
        <div style="margin:20px 0;">
         <a href="javascript:void(0)" class="easyui-linkbutton update" id="update" onclick="User.updateUser()">保存</a> 
        <!-- <a href="javascript:void(0)" class="easyui-linkbutton" id="add" onclick="User.addUser()">保存</a> -->
        <a href="javascript:void(0)" class="easyui-linkbutton cancle" onclick="$('#mw').window('close')">取消</a>
    	</div>
    </div>
</div>
</body>
</html>

