<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	String userId = (String)session.getAttribute("sessionUserId");
	pageContext.setAttribute("userId", userId);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <title>BankConsole平台</title>
      <head>
         <style type="text/css">
         	.logo {
         		margin:0 auto;
         		margin-top: 60px;
         		padding:10px;
         		text-align:center;
         	}
         </style>
         <link href="jquery-easyui-1.3.2/themes/icon.css" rel="stylesheet" type="text/css"/>
         <link href="jquery-easyui-1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
         <script type="text/javascript" src="jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
         <script src="jquery-easyui-1.3.2/jquery.easyui.min.js" type="text/javascript"></script>
         <script src="jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
         <script type="text/javascript">
         	$(function() {
         		$.ajax({
         			type:"post",
         			data: {
         				"userId":"${userId}"
         			},
         			url: "${basePath}/main/signOut.do",
         			data: function(data) {
         				
         			}
         		}); 
         	});
         </script>
         <script type="text/javascript">
            $(function() {
            	$("#password").val("");
            	
               $("#form").keypress(function(e) {
                  var keycode = e.which || e.keyCode;
                  if (keycode == 13 || keycode == 10) {
                     $("#login").click();
                  }
               });
               $("#login").click(function() {
                  if ($("#name").val() == "") {
                     $("#msg").text("帐号不能为空");
                  } else if ($("#password").val() == "") {
                     $("#msg").text("密码不能为空")
                  } else {
                     $.ajax({
                        type: "post",
                        url: "${basePath}/main/login.do",
                        data: {
                           userId: $("#name").val(),
                           pass: $("#password").val()
                        },
                        success: function(data) {
                           //json = JSON.parse(json);
                           var json = eval('('+data+')');
                           console.log(json.code);
                           if (json.code == 1) {
                              window.location.href = "${basePath}/main/index.do";
                           } else {
                        	   $(".err_msg").html(json.msg)
                           }
                        }
                     })
                  }
               });
            })
         </script>
      </head>
      <body class="login">
               <!-- <h1>BankConsole平台</h1> -->
            <div class="logo">
            	<img src="${basePath}/images/logo.jpg"/>
            </div>
            <div class="content" >
               <!--错误信息提示-->
               <form id="form" type="post">
	               <h3 class="form-title">办公系统综合平台</h3>
                  <div class="input">
                     <input type="text" id="name" placeholder="请输入登录账号"/>
                     <input type="password" id="password" placeholder="请输入登录密码"/>
                     <div class="btn">
                     	<span class="err_msg" style="color:red"></span>
                        <a class="btn_login" id="login" href="javascript:;">登录</a>
                     </div>
                  </div>
               </form>
            </div>
            <div class="copy_right">
               <p> </p>

               <p>
               </p>
            </div>
      </body>
</html>