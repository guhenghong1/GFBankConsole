<%-- 
    Document   : index
    Created on : May 28, 2014, 10:05:39 AM
    Author     : xiangfei
--%>

<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="com.bank.console.common.util.DateUtil" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   int nowHour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
   Date now = new Date();
   String greetings;
   if (nowHour >= 6 && nowHour < 8) {
      greetings = "早上好，";
   } else if (nowHour >= 8 && nowHour < 12) {
      greetings = "上午好，";
   } else if (nowHour >= 11 && nowHour < 14) {
      greetings = "中午好，";
   } else if (nowHour >= 14 && nowHour < 19) {
      greetings = "下午好，";
   } else if (nowHour >= 19 && nowHour < 24) {
      greetings = "晚上好，";
   } else {
      greetings = "凌晨好，";
   }

   pageContext.setAttribute("greetings", greetings);
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	String userId = (String)session.getAttribute("sessionUserId");
	pageContext.setAttribute("userId", userId);
%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>BankConsole平台</title>
      <link rel="stylesheet" type="text/css" href="../css/qz.css">
      <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.2/themes/default/easyui.css">
      <link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.2/themes/icon.css">
      <script type="text/javascript" src="../jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
      <script type="text/javascript" src="../jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
      <script type="text/javascript" src="../jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
      <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
      <script type="text/javascript" src="../js/main.js"></script>
      <style type="text/css">
      .easyui-panel{
          background-color: #E0ECFF;
   		  border: 1px solid transparent
      }
      
    /*   左侧菜单 */
      .panel-title {
      	margin-left: 30px;
      }
      a.l-btn-plain {
      	margin-left: 30px;
      }
      #qz_menu {
      	margin-right: 25px;
      }
      </style>
   </head>
   <body style="margin:0;overflow-y: auto;">
      <input id="hidden-domain" type="hidden" value="${domain}"/>
      <input id="hidden-uploader-url" type="hidden" value="http://upload${domain}/imgUtil/uploadFile.php"/>
      <input id="hidden-agentId" type="hidden" value="${agentId}"/>
      <input id="hidden-gid" type="hidden" value="${gid}"/>
      <input id="hidden-enddate" type="hidden" value=""/>
      <div class="easyui-layout" fit="true">
         <div region="north" border="none" class="qz-top" style="z-index: 9999">
              <div style="float:left; margin-top: 10px">
              	<img src="${basePath}/images/logo.jpg" style="max-width:220px;"/>
              </div>
            <div id="qz_menu">
               <li class="qz_menu_li">
                  <a href="javascript:;" class="qz_set">${userId}</a>
                  <!--菜单列表-->
                  <div id="setMenu" class ="setMenu" style="display:none;">
                     <a href="${basePath}/main/toUpdatePwd.do" id="qz_safe">修改密码</a>
                     <a href="${basePath}/login.jsp" target="" id="qz_detail" >退出</a>
                  </div>
               </li>
            </div>

            <a style="float:right; margin:20px 20px 0 0"><span id="time"></span>
            </a>
         </div>
         <div class="qz-left" region="west" title="管理列表">
	         <div id="menu" class="easyui-accordion" data-options="fit:true,border:false">
	                 <div title="系统管理" data-options="selected:false" style="padding:10px;">
	                 	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('用户基本信息', '${basePath}/user/detail.do')" style="width:100px" data-options="plain:true">用户基本信息</a></div>
	                 	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('用户管理', '${basePath}/user/init.do')" style="width:100px" data-options="plain:true">用户管理</a></div>
	                 	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('角色管理')" style="width:100px" data-options="plain:true">角色管理</a></div>
	                 	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('菜单管理')" style="width:100px" data-options="plain:true">菜单管理</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('部门管理', '${basePath}/dept/init.do')" style="width:100px" data-options="plain:true">部门管理</a></div>
	                </div>
	                <div title="文件管理" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('收文处理', '${basePath}/recFile/init.do')" style="width:100px" data-options="plain:true">收文处理</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('发文处理', '${basePath}/sendFile/init.do')" style="width:100px" data-options="plain:true">发文处理</a></div>
	                    <!-- <div><a href="#" class="easyui-linkbutton"  onclick="openTab('文件查找')" style="width:100px" data-options="plain:true">文件查找</a></div> -->
	                </div>
	                <div title="会议公告管理" data-options="selected:false" style="padding:10px;">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('会议管理', '${basePath}/conference/init.do')" style="width:100px" data-options="plain:true">会议管理</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('建议公示', '${basePath}/advise/init.do')" style="width:100px" data-options="plain:true">建议公示</a></div>
	                </div>
	                <div title="客户关系管理" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('客户管理', '${basePath}/customer/init.do')" style="width:100px" data-options="plain:true">客户管理</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('故障分析报表')" style="width:100px" data-options="plain:true">故障分析报表</a></div>
	                </div>
	                <div title="物资设备管理" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('物资供应商管理', '${basePath}/materials/init.do')" style="width:100px" data-options="plain:true">物资供应商管理</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('设备管理', '${basePath}/equipment/init.do')" style="width:100px" data-options="plain:true">设备管理</a></div>
	                </div> 
	                <div title="业务应用" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('权证录入', '${basePath}/warrant/init.do?menu=add')" style="width:100px" data-options="plain:true">权证录入</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('权证信息修改', '${basePath}/warrant/init.do?menu=update')" style="width:100px" data-options="plain:true">权证信息修改</a></div>
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('权证出入库', '${basePath}/warrant/init.do?menu=updateStatus')" style="width:100px" data-options="plain:true">权证出入库</a></div>
	                </div>  
	                <div title="会计学习平台" style="padding:10px">
	                    <div><a href="#" class="easyui-linkbutton"  onclick="openTab('资料分享', '${basePath}/learn/init.do')" style="width:100px" data-options="plain:true">资料分享</a></div>
	                </div>   
            </div>
         </div>
         <div id="w_tabs" region="center" class="easyui-tabs"  fit="true">
         </div>
      </div>
      <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
      <!--区长安全设置dialog-->
      <div id="qz_psw_dialog" style="height: 300px;width: 700px;"></div>
   </body>
   <script>
   startTime();  
   function startTime() {  
           var today = new Date();  
           var y = today.getFullYear();  
           var M = today.getMonth()+1;  
           var d = today.getDate();  
           var w = today.getDay();  
           var h = today.getHours();  
           var m = today.getMinutes();  
           var s = today.getSeconds();  
           var week=['星期天','星期一','星期二','星期三','星期四','星期五','星期六'];  
           // add a zero in front of numbers<10  
           m = checkTime(m);  
           s = checkTime(s);
           var time = y+'/'+M+'/'+d+'&nbsp'+h+':'+m+':'+s+' '+week[w];
           $('#time').html(time);//可改变格式  
           t = setTimeout(startTime, 500);  
           function checkTime(i) {  
               if (i < 10) {  
                   i = "0" + i;  
               }  
               return i;  
           }  
       }  
   </script>
   <script>
   $(function() {
	  $("#qz_menu").mouseenter(function(){
		  $("#setMenu").css("display","block");
	  }); 
	  $("#qz_menu").mouseleave(function(){
		  $("#setMenu").css("display","none");
	  }); 
   });
   </script>
   <script>
   $(function() {
	    //initMenu();   
	   var menuDiv = "<div title=\"部门机构管理\" style=\"padding:10px;\"><div><a href=\"#\" class=\"easyui-linkbutton\"  onclick=\"openTab('部门管理', '${basePath}/dept/init.do')\" style=\"width:100px\" data-options=\"plain:true\">部门管理</a></div></div>";
	   
	   /*  $("#menu").append(menuDiv);  */
   });
   function initMenu() {
	    var superMenuTemp = "<div title='{superMenuName}' data-options='selected:false' style='padding:10px;'>"
		var childMenuTemp = "<div><a href='#' class='easyui-linkbutton'  onclick=\"openTab('{childMenuName}', '${basePath}/{linkUrl}')\" style='width:100px' data-options='plain:true'>{childMenuName}</a></div>";
		var userId = '${userId}';
		$.ajax({
			url: "${basePath}/menu/getUserMenuTree.do",
			data: {"userId":userId},
			success: function(data) {
				data = JSON.parse(data);
				var code = data.code;
				var menus = data.obj;
				if(code == 1 && !!menus) {
					for(var i = 0; i< menus.length; i++) {
						var spDiv = "";
						var menu = menus[i];
						var superMenuName = menu.menuName;
				   
						var children = menu.children;
						if(!!children) {
							for(var j=0; j<children.length; j++) {
								var chDiv = "";
								
								var chMenu = children[j];
								var chMenuName = chMenu.menuName;
								var linkUrl = chMenu.linkUrl;
								
								chDiv = childMenuTemp.replace(new RegExp(/{childMenuName}/g), chMenuName)
										.replace(new RegExp(/{linkUrl}/g), linkUrl);
								spDiv += chDiv;
							}
						}
						
				        $('#menu').accordion('add',{
			                 title:superMenuName,
			                 content:spDiv
			             });
					}
				}
			}
		})
	}
   </script>
</html>
