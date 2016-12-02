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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <title>银行综合办公系统</title>
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
               margin-top: 10%;
               width: 600px;
               height: 220px;
               /* background-color: #fff; */
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
               height: 220px;
               position: relative;
               width: 465px;
               margin: auto;
            }

            .login.bg {
               background: white;
               opacity: 1;
               filter: alpha(opacity=100);
               height: 100%;
            }

            .login .input {
               position: absolute;
               top: 40px;
               left: 50px;
            }

            .login span {
               position: absolute;
               left: 0px;
            }

            .login input {
               width: 343px;
               height: 50px;
               line-height: 50px;
               border: 1px solid #ddd;
               margin-bottom: 15px;
               padding: 0 10px;
               color: #474747;
            }

            .btn {
               text-align: right;
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
         <style type="text/css">
         	.logo {
         		margin:0 auto;
         		margin-top: 60px;
         		/* padding:10px; */
         		text-align:center;
         		width:467px;
         	}
         	
         	.login .bg{
         	    background-color: #fff;
			    margin: 0 auto;
			    margin-bottom: 0px;
         	    /* width: 480px; */
         	}
         	
         	.body {
         		background-color: #F16727;
         	}
         </style>
         <link href="jquery-easyui-1.3.2/themes/icon.css" rel="stylesheet" type="text/css"/>
         <link href="jquery-easyui-1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
         <script type="text/javascript" src="jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
         <script src="jquery-easyui-1.3.2/jquery.easyui.min.js" type="text/javascript"></script>
         <script src="jquery-easyui-1.3.2/locale/easyui-lan\g-zh_CN.js" type="text/javascript"></script>
         <script type="text/javascript" src="js/json2.js"></script>
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
            	  var name = $("#name").val();
            	  var pass = $("#password").val();
                  if (name== "" || name == "请输入登录账号") {
                     $("#msg").text("帐号不能为空");
                     return false;
                  } 
                  if (pass == "" || pass == "请输入登录账号") {
                     $("#msg").text("密码不能为空");
                     return false;
                  } 
                     $.ajax({
                        type: "post",
                        url: "${basePath}/main/login.do",
                        data: {
                           userId: $("#name").val(),
                           pass: $("#password").val()
                        },
                        success: function(json) {
                           //json = JSON.parse(json);
                           json = eval('('+json+')');
                           console.log(JSON.stringify(json));
                           if (json.code == 1) {
                              window.location.href = "${basePath}/main/index.do";
                           } else {
                        	   $("#msg").html(json.msg)
                           }
                        }
                     })
                  
               });
            })
         </script>
         <script type="text/javascript">
            $(function() {
            	$("#name").focus(function() {
            		var _this = this;
            		var val = $(_this).val();
            		if(val == "请输入登录账号") {
	            		$("#name").val("");
            		}
            	});
            	$("#password").focus(function() {
            		$("#password").val("");
            	});
            	$("#name").blur(function() {
            		var _this = this;
            		var val = $(_this).val();
            		if(!val) {
 		           		$("#name").val("请输入登录账号");
            		}
            	});
            	$(".pass").blur(function() {
            		var _this = this;
            		if($(_this).attr('id')=='password1') {
	            		$(_this).hide(); 
	            		$('#password').show();
	            		$('#password').focus(); 
            		} else if($(_this).attr('id')=='password') {
          /*   			var val = $(_this).val();
            			if(!val) {
		            		$(_this).hide(); 
		            		$('#password1').show();
            			} */
            		}
            	});
            	
               	$(".pass").focus(function() {
            		var _this = this;
            		if($(_this).attr('id')=='password1') {
	            		$(_this).hide(); 
	            		$('#password').show();
	            		//$('#password').focus(); 
            		} else if($(_this).attr('id')=='password') {
	            		//$(_this).hide(); 
	            		//$('#password1').show();
            		}
            	});
            });
          </script>
      </head>
      <body class="body">
         <div class="lgin fn-clear">
            <div class="logo">
            	<img src="${basePath}/images/logo.jpg"/>
            </div>
            <div class="login bg" >
               <!--错误信息提示-->
               <!-- <span ><font id="msg" color="red"></font></span> -->
               <form id="form" type="post">
                  <div class="input">
                     <input type="text" id="name" value="请输入登录账号" placeholder="请输入登录账号"/>
                     <input type="password" id="password" class="pass" placeholder="请输入登录密码" style="display:none"/>
                     <input type="text" id="password1" class="pass" value="请输入登录密码"  placeholder="请输入登录密码"/>
                     <div class="btn">
                     	<!-- <span class="err_msg" style="color:red"></span> -->
                     	<span ><font id="msg" color="red"></font></span>
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
         </div>
      </body>
</html>