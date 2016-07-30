<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>
<%
%>
<html xmlns="http://www.w3.org/1999/xhtml">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <title>远程抄表云服务平台</title>
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
               opacity: 0.8;
               filter: alpha(opacity=80);
               height: 100%;
            }

            .login .input {
               position: absolute;
               top: 40px;
               left: 50px;
            }

            .login span {
               position: absolute;
               left: 50px;
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
         <link href="jquery-easyui-1.3.2/themes/icon.css" rel="stylesheet" type="text/css"/>
         <link href="jquery-easyui-1.3.2/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
         <script type="text/javascript" src="jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
         <script src="jquery-easyui-1.3.2/jquery.easyui.min.js" type="text/javascript"></script>
         <script src="jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
         <script type="text/javascript">
            $(function() {
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
                        url: "/proxy/api/agent/login",
                        data: {
                           name: $("#name").val(),
                           password: $("#password").val()
                        },
                        success: function(json) {
                           console.log(json);
                           if (json.code == 10010) {
                              window.location.href = "main.jsp";
                           } else {
                              alert(json.msg);
                           }
                        }
                     })
                  }
               });
            })
         </script>
      </head>
      <body>
         <div class="lgin fn-clear">
            <div class="title">
               <h2>远程抄表云服务平台</h2>
               <h1>远程抄表云服务平台</h1>
            </div>
            <div class="login bg" >
               <!--错误信息提示-->
               <span ><font id="msg" color="red"></font></span>
               <form id="form" type="post">
                  <div class="input">
                     <input type="text" id="name" placeholder="请输入登录账号"/>
                     <input type="password" id="password" placeholder="请输入登录密码"/>
                     <div class="btn">
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