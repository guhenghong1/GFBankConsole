<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
	
	String userId = (String)request.getAttribute("userId");
	pageContext.setAttribute("userId", userId);
%>
<style type="text/css">
	.detail li {
		list-style: none;
    	margin-top: 10px;
	}
	.detail span {margin-left: 10px;}
	
</style>
<div id="userInfo" style="">
    <div id="userDetail" style="font-size: 14px; margin: 20px 20px 20px 20px">
    	<ul class="detail">
    		<li></li>
    		<li><lable>姓名：</lable><span class="name"></span></li>
    		<li><lable>性别：</lable><span class="sex"></span></li>
    		<li><lable>部门：</lable><span class="dept"></span></li>
    		<li><lable>生日：</lable><span class="birthday"></span></li>
    		<li><lable>电话：</lable><span class="phone"></span></li>
    		<li><lable>手机号：</lable><span class="mobile"></span></li>
    		<li class="coll"><lable>本月同事生日：</lable></li>
    		<li class="customer"><lable>本月客户生日：</lable></li>
    	</ul>
    </div>
</div>
<script type="text/javascript">
$(function() {
	$.ajax({
		url:"../user/getBasicUserInfo.do",
		data:{
			userId:"${userId}"
		},
		success:function(data) {
			var data = JSON.parse(data);
			var userInfo = data.obj;
			//console.log(data);
			var user = userInfo.user;
			//console.log(JSON.stringify(user));
			var colleagueList = userInfo.colleagueList;
			var customerList = userInfo.customerList;
			
			$(".name").html(user.realName);
			$(".sex").html(user.sex);
			$(".dept").html(user.deptName);
			$(".birthday").html(user.birthdayStr);
			$(".phone").html(user.phone);
			$(".mobile").html(user.mobile);
			
			buildColleague(colleagueList);
			buildCustomer(customerList);
		}
	});
	
	function buildColleague(colleagueList) {
		var collDiv = "";
		for(var i = 0; i< colleagueList.length; i++) {
			var colleague = colleagueList[i];
			var coll = "<span style='color:red' class='coll_"+colleague.userId+"'><"+colleague.realName+"  "+colleague.birthdayStr+"></span>";
			collDiv += coll;
		}
		$(".coll").append(collDiv);
	}
	
	function buildCustomer(customerList) {
		var customerDiv = "";
		for(var i = 0; i< customerList.length; i++) {
			var customer = customerList[i];
			var cus = "<span style='color:red' class='coll_"+customer.id+"'><"+customer.name+"  "+customer.birthdayStr+"></span>";
			customerDiv += cus;
		}
		$(".customer").append(customerDiv);
	}
});
</script>