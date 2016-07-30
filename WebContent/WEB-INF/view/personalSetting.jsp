<%-- 
    Document   : 区长个人资料
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
   String gid = request.getParameter("gid");
   Map agentMap = new HashMap();
   agentMap.put("agentId", CookieUtil.getCookieValue(request, "agentId"));
   //获取区长登录信息，查看是登录
   JSONObject isLogin = HttpUtil.getJsonByPost("http://api" + domain + "/agent/getAgentInfo", agentMap);
   //如果未登录，返回登录界面
   if (isLogin.getInt("code") != 10010) {
      response.sendRedirect("http://qz" + domain);
      return;
   }
   agentMap.put("gid", gid);
   JSONObject agent = HttpUtil.getJsonByPost("http://api" + domain + "/agent/getAgentInfoById", agentMap);
   pageContext.setAttribute("agent", agent);
   pageContext.setAttribute("gid", gid);
%>
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <script type="text/javascript" src="/proxy/www/js/commons/do.js"></script>
      <script type="text/javascript" src="jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
      <link href="css/qz_settings.css" rel="stylesheet" type="text/css"/>
      <title>个人资料设置</title>
   </head>
   <body style="margin:0px; background-color:#f2f2f2">
      <div class="header" id="header">
         <div class="bg"></div>
         <!--logo-->
         <div class="logo" title="点击回首页"><a href="http://qz${domain}">住一起小区网</a></div>
      </div>
      <div id="qz_resetPsw">
         <div id="qz_resetPsw_top">
            <p>个人资料</p>
         </div>
         <div id="qz_resetPsw_center">
            <input id="hidden-uploader-url" type="hidden" value="http://upload${domain}/imgUtil/uploadFile.php"/>
            <input type="hidden" id="hid_province" value="${agent.get("PROVINCEID")}"/>
            <input type="hidden" id="hid_city" value="${agent.get("CITYID")}"/>
            <input type="hidden" id="hid_county" value="${agent.get("COUNTYID")}"/>
            <div id="" style="float: right;margin: 20px 50px 0 0;color: #0000ff;font-size: 14px"><a href="modifyPsw.jsp">修改密码</a></div>
            <form id="agent_form" method="post">
               <input type="hidden" name="id" value="${agent.get("ID")}"/>
               <input type="hidden" id="headphoto" name="headphoto" value=""/>
               <table class="qz_resetPsw_table">
                  <tr>
                     <td class="tb_l">
                        头像:
                     </td>
                     <td>
                        <img id="head_img" height="110" width="110" style="height:110px;width:110px;background-color:#fff" src="${agent.get("HEADPHOTO")}" title="我的头像">
                        <span id="uploader_file_input"></span>
                        <p style="color: #999; font-size: 11px">提示：更改此头像，所有关联的代理小区头像将更改为此头像</p>
                     </td>
                     <td><label id="lab_headImg"></label></td>
                  </tr>
                  <tr>
                     <td class="tb_l">
                        昵称:
                     </td>
                     <td>
                        <input id="tb_name" type="text" name="name" value="${agent.get("NAME")}" placeholder="请输入昵称"/>
                        <label id="lab_name"></label>
                     </td>
                     <td></td>
                  </tr>
                  <tr>
                     <td class="tb_l">
                        登录邮箱:
                     </td>
                     <td>
                        <input id="tb_email" type="text" name="email" value="${agent.get("EMAIL")}" disabled="false"/>
                        <label id="lab_email"></label>
                     </td>
                     <td></td>
                  </tr>
                  <tr>
                     <td class="tb_l">
                        联系方式:
                     </td>
                     <td>
                        <input id="tb_phone" type="text" name="mobile" value="${agent.get("MOBILE")}"/>
                        <label id="lab_phone"></label>
                     </td>
                     <td></td>
                  </tr>
                  <tr>
                     <td class="tb_l">
                        联系地址:
                     </td>
                     <td>
                        <select id="province" name="province" >
                           <option value="0">请选择省</option>
                        </select>
                        <select id="city" name="city">
                           <option value="0">请选择城市</option>
                        </select>
                        <select id="county" name ="county">
                           <option value="0">请选择县/区</option>
                        </select>
                        <br/>
                        <input id = "address" type="text" name="address" value="${agent.get("ADDRESS")}" style="margin-top:5px;width:350px"/>
                        <label id="lab_address"></label>
                     </td>
                     <td></td>
                  </tr>
                  <tr>
                     <td></td>
                     <td style="text-align: center">
                        <input id="resetPsw_btn" type="submit" value="保存"/>
                     </td>
                     <td></td>
                  </tr>
               </table>
            </form>
            <div id="qz_resetPsw_tip">
               <p></p>
            </div>
         </div>

         <div class="copy_right">
            <p>Copyright © 2009-2014 zhuyiqi.com </p>
            <p><a target="new" href="http://www.zhuyiqi.com/company/index.jsp?tab=tab1">广州互动生活网络科技有限公司</a> 版权所有</p>
         </div>
      </div>
      <script src="personalSetting.js" type="text/javascript"></script>
   </body>
</html>
