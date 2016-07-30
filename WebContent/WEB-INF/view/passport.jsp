<%-- 
    Document   : 区长找回密码
    Created on : 2014-7-7, 13:14:41
    Author     : mdn
--%>
<%@page import="qz.util.RequestUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   String domain = RequestUtil.getDomain(request);
   request.setAttribute("domain", domain);
%>
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <script type="text/javascript" src="jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
      <link href="css/qz_settings.css" rel="stylesheet" type="text/css"/>
      <script src="passport.js" type="text/javascript"></script>
      <title>找回密码-安全验证</title>
      <script type="text/javascript">
         $(function() {
            $("body").keypress(function(e) {//键盘监听事件
               var keycode = e.which || e.keyCode;
               if (keycode === 13 || keycode === 10) {
                  doResetPsw($("#tb_email").val(), $("#tb_phone").val());
               }
            });
         });
      </script>
   </head>
   <body style="margin:0px; background-color:#f2f2f2">
      <div class="header" id="header">
         <div class="bg"></div>
         <!--logo-->
         <div class="logo" title="点击回首页"><a href="http://qz${domain}">住一起小区网</a></div>
      </div>
      <div id="qz_resetPsw">
         <div id="qz_resetPsw_top">
            <p>找回密码</p>
         </div>
         <div id="qz_resetPsw_center">
            <table class="qz_resetPsw_table">
               <tr>
                  <td class="tb_l">
                     登录邮箱:
                  </td>
                  <td>
                     <input id="tb_email" type="text" value="" placeholder="请输入登录邮箱" onblur="checkEmail()"/>
                  </td>
                  <td><label id="lab_email"></label></td>
               </tr>
               <tr>
                  <td class="tb_l">
                     手机号码:
                  </td>
                  <td>
                     <input id="tb_phone" type="text" value="" placeholder="输入注册时绑定的手机号码"onblur="checkPhone()"/>
                  </td>
                  <td><label id="lab_phone"></label></td>
               </tr>
               <tr>
                  <td></td>
                  <td style="float:right;text-align: center"><input id="resetPsw_btn" type="button" value="提交" onclick="mysubmit()"/></td>
                  <td></td>
               </tr>
            </table>

            <div id="qz_resetPsw_tip">
               <p>* 手机号码必须和登录邮箱绑定的手机一致</p>
               <p>* 提交之后，系统会向您发送手机短信，请注意查看</p>
               <p>* 为了您的帐号安全，请收到短信后，登录<a href="http://qz${domain}">qz${domain}</a>重新设置您的密码</p>
            </div>
         </div>

      <div class="copy_right">
         <p>Copyright © 2009-2014 zhuyiqi.com </p>

         <p><a target="new" href="http://www.zhuyiqi.com/company/index.jsp?tab=tab1">广州互动生活网络科技有限公司</a> 版权所有</p>
      </div>
      </div>

   </body>
</html>
