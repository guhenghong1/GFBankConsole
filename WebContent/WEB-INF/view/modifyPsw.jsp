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
            body {
               background: url(images/bg.png) repeat-x;
            }

            .header {
               background: #eee;
            }

            .header .bg {
            
               margin: 0 auto;
               width: 960px;
            }

            .header .bg .logo {
               text-align: center;
            }

            .lgin {
               margin: 0 auto;
               margin-top: 3%;
               width: 600px;
               height: 300px;
            }

            .title {
               margin-bottom: 30px;
            }

            .title h1 {
               text-align: center;
               color: #ddd;
               font-size: 58px;
               font-weight: bold;
               word-spacing: 20px;
            }

            .title h2 {
               text-align: center;
               color: white;
               font-size: 26px;
               font-weight: bold;
            }

            .login {
               -moz-border-radius: 10px;
               -webkit-border-radius: 10px;
               border-radius: 10px;
               behavior: url(border-radius.htc);
               border: 1px solid #96c664;
               overflow: hidden;
               height: 320px;
               position: relative;
               width: 465px;
               margin: auto;
            }

            .login.bg {
               position: absolute;
               background: white;
               opacity: 0.8;
               filter: alpha(opacity=80);
              /*  height: 100%; */
            }

            .login .input {
               position: absolute;
               top: 40px;
               left: 50px;
            }

            .login span {
             /*   position: absolute; */
               left: 0px;
            }

            .login input {
               width: 200px;
               height: 40px;
               line-height: 50px;
               border: 1px solid #ddd;
               margin-bottom: 15px;
               padding: 0 10px;
               color: #474747;
            }

            .btn {
               position: relative;
               /* text-align: right; */
               margin-bottom: 20px;
               padding-right: 70px;
            }

            .btn_login{
               display: inline-block;
               background: #4f9716;
               font-size: 18px;
               color: white;
               padding: 5px 15px;
               border-radius: 5px;
               border: 1px solid #ddd;
               text-decoration: none;
            }

            .btn_login:hover {
               text-decoration: none;
               background: #93c660;
            }
            .btn_forgetPsw{
               text-decoration: none;
               color:#666;
               font-size:10px;
            }
            .btn_forgetPsw:hover{
               color:#4f9716
            }

            .copy_right a {
               margin-right: 20px;
            }

            .copy_right a,
            .copy_right {
               margin-top: 160px;
               text-align: center;
               font-size: 14px;
               color: #474747;
               text-shadow: 1px 1px 3px #ddd;
            }
         </style>
         <link href="${basePath}/jquery-easyui-1.3.2/themes/icon.css" rel="stylesheet" type="text/css"/>
         <link href="${basePath}/jquery-easyui-1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
         <script type="text/javascript" src="${basePath}/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
         <script src="${basePath}/jquery-easyui-1.3.2/jquery.easyui.min.js" type="text/javascript"></script>
         <script src="${basePath}/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
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
               $("#form").keypress(function(e) {
                  var keycode = e.which || e.keyCode;
                  if (keycode == 13 || keycode == 10) {
                     $("#login").click();
                  }
               });
               
               $("#userId").blur(function() {
            	   if ($("#userId").val() == "") {
                       $(".userIdMsg").html("帐号不能为空!");
                    } else {
                    	$(".userIdMsg").html("");
                    }
               });
               $("#oriPwd").blur(function() {
            	   if ($("#oriPwd").val() == "") {
                       $(".oriPwdMsg").html("原始不能为空!");
                    } else {
                    	$(".oriPwdMsg").html("");
                    }
               });
               $("#newPwd").blur(function() {
            	   if ($("#newPwd").val() == "") {
                       $(".newPwdMsg").html("新密码不能为空!");
                    } else {
                    	$(".newPwdMsg").html("");
                    }
               });
               $("#newPwd1").blur(function() {
            	   if ($("#newPwd1").val() == "") {
                       $(".newPwd1Msg").html("密码不能为空!");
                    } else {
                    	$(".newPwd1Msg").html("");
                    }
            	   if ($("#newPwd1").val() != $("#newPwd").val()) {
                       $(".newPwd1Msg").text("两次输入的密码一不一致!")
                    }
               });
               
               $("#login").click(function() {
                  if ($("#userId").val() == "") {
                	  $(".userIdMsg").html("帐号不能为空!");
                  } else if ($("#oriPwd").val() == "") {
                	  $(".oriPwdMsg").html("原始不能为空!");
                  } else if ($("#newPwd").val() == "") {
                	  $(".newPwdMsg").html("新密码不能为空!");
                  } else if ($("#newPwd1").val() == "") {
                	  $(".newPwd1Msg").html("密码不能为空!");
                  } else if ($("#newPwd1").val() != $("#newPwd").val()) {
                	  $(".newPwd1Msg").text("两次输入的密码一不一致!")
                  }else {
                     $.ajax({
                        type: "post",
                        url: "${basePath}/main/updateUserPwd.do",
                        data: {
                           userId: $("#userId").val(),
                           oriPwd: $("#oriPwd").val(),
                           newPwd: $("#newPwd").val()
                        },
                        success: function(json) {
                           json = JSON.parse(json);
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
               
               $("#cancle").click(function() {
            	  $("input").each(function(){
            		  if($(this).attr("id") != "userId") {
	            		  $(this).val("");
            		  }
            	  }); 
               });
            })
         </script>
      </head>
      <body>
         <div class="lgin fn-clear">
            <div class="title">
               <h2>BankConsole平台</h2>
               <h1>BankConsole平台</h1>
            </div>
            <div class="login bg" >
               <!--错误信息提示-->
               <span ><font id="msg" color="red"></font></span>
               <form id="form" type="post">
                  <div class="input">
                  	<div>
                    	<label><input type="text" id="userId" value="${userId}" readonly="readonly" placeholder="请输入登录账号"/><label>
                    	<label><span class="userIdMsg" style="color:red"></span></label>
                     </div>
                     <div>
                     	<label><input type="password" id="oriPwd" placeholder="请输入原始密码"/><label>
                     	<label><span class="oriPwdMsg" style="color:red"></span></label>
                     </div>
                     <div>
                     	<label><input type="password" id="newPwd" placeholder="请输入新密码"/><label>
                     	<label><span class="newPwdMsg" style="color:red"></span></label>
                     </div>
                     <div>
	                     <label><input type="password" id="newPwd1" placeholder="请再次输入新密码"/><label>
	                     <label><span class="newPwd1Msg" style="color:red"></span></label>
                     </div>
                     <div class="btn">
                     	<div>
                     		<span class="err_msg" style="color:red"></span>
                     	</div>
                     	<div>
	                        <a class="btn_login" id="login" href="javascript:;">确认</a>
	                        <a class="btn_login" id="cancle" href="javascript:;">取消</a>
                     	</div>
                     </div>
                  </div>
               </form>
            </div>
            <div class="copy_right">
               <p> </p>

               <p>
               </p>
            </div>
         </div>
      </body>
</html>