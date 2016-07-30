<%-- 
    Document   : 区长修改密码
    Created on : 2014-7-7, 13:14:41
    Author     : mdn
--%>
<%@page import="qz.util.CookieUtil"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="qz.util.HttpUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="qz.util.RequestUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   String domain = RequestUtil.getDomain(request);
   request.setAttribute("domain", domain);
   Map agentMap = new HashMap();
   agentMap.put("agentId", CookieUtil.getCookieValue(request, "agentId"));
   //获取区长登录信息，查看是登录
   JSONObject isLogin = HttpUtil.getJsonByPost("http://api" + domain + "/agent/getAgentInfo", agentMap);
   //如果未登录，返回登录界面
   if (isLogin.getInt("code") != 10010) {
      response.sendRedirect("http://qz" + domain);
      return;
   }
%>
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link href="css/qz_settings.css" rel="stylesheet" type="text/css"/>
      <script type="text/javascript" src="/proxy/www/js/commons/do.js"></script>
      <script type="text/javascript" src="jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
      <title>个人资料设置</title>
      <script type="text/javascript">
         Do.add('jeasyui-css', {
            path: '/jquery-easyui-1.3.2/themes/default/easyui.css',
            type: 'css'
         });
         Do.add('jeasyui-icon-css', {
            path: '/jquery-easyui-1.3.2/themes/icon.css',
            type: 'css'
         });
         Do.add("lang-zh_CN", {
            path: "/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js",
            type: "js",
            requires: ["jeasyui"]
         });
         Do.add("jeasyui", {
            path: "/jquery-easyui-1.3.2/jquery.easyui.min.js",
            type: "js",
            requires: ["jeasyui-icon-css", "jeasyui-css"]
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
            <p>修改密码</p>
         </div>
         <div id="qz_resetPsw_center">
            <form id="qz_psw_form">
               <input type="hidden" name="id" value="${id}"/>
               <table class="qz_resetPsw_table">
                  <tr>
                     <td class="tb_l">
                        原密码:
                     </td>
                     <td>
                        <input id="old_psw" type="password" value="" placeholder="请输入原密码" onblur=""/>
                        <label id="lab_name"></label>
                     </td>
                     <td></td>
                  </tr>
                  <tr>
                     <td class="tb_l">
                        新密码:
                     </td>
                     <td>
                        <input id="new_psw" type="password" value="" placeholder="请输入新密码"/>
                     </td>
                     <td><label id="lab_email"></label></td>
                  </tr>
                  <tr>
                     <td class="tb_l">
                        重复密码:
                     </td>
                     <td>
                        <input id="ag_psw" type="password" placeholder="请再输入一次新密码" value=""/>
                        <label id="lab_phone"></label>
                     </td>
                     <td></td>
                  </tr>
                  <tr>
                     <td></td>
                     <td style="text-align: right">
                        <input id="resetPsw_btn" type="button" value="提交" onclick="modifyPsw.midfQzPassword()"/>
                     </td>
                     <td></td>
                  </tr>
               </table>
            </form>
            <div id="qz_resetPsw_tip">
               <!--<p>* 确保两次输入的新密码一致</p>-->
               <p>* 忘记原密码,怎么办？<a href="passport.jsp">点击这里</a></p>
            </div>
         </div>

         <div class="copy_right">
            <p>Copyright © 2009-2014 zhuyiqi.com </p>
            <p><a target="new" href="http://www.zhuyiqi.com/company/index.jsp?tab=tab1">广州互动生活网络科技有限公司</a> 版权所有</p>
         </div>
      </div>
      <script src="modifyPsw.js" type="text/javascript"></script>
   </body>
</html>
