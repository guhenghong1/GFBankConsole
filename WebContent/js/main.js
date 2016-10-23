var Main = {
//   op: {
//      bol: false
//   },
//   init: function() {
//      this.initEvent();
//      this.initGardenList();
//   },
//   initEvent: function() {
//      var _this = this;
//      $(".garden").live("click", function() {
//         $(".garden").removeClass("selected");
//         $(this).addClass("selected");
//      });
//      $(".enter").live("click", function(e) {
//         var target = e.currentTarget;
//         $.ajax({
//            type: "post",
//            url: "/proxy/api/agent/changeGardenManager",
//            data: {
//               gardenId: $(target).attr("data-id")
//            },
//            success: function() {
//            }
//         });
//      });
//      //éåºç»å½
//      $("#exit").click(function() {
//         _this.exitLogin();
//      });
//      //ç³»ç»è®¾ç½®èå
//      $("#qz_menu").hover(function(e) { //é¼ æ ç»è¿å®å¨è®¾ç½®æ¶ï¼æ¾ç¤ºèå
//         $('#setMenu').toggle();
//      });
//   },
//   exitLogin: function() {
//      $.ajax({
//         type: "post",
//         url: "/proxy/api/agent/exit",
//         data: {
//         },
//         success: function() {
//            window.location.href = "/index.jsp";
//         }
//      });
//   }
		
//        <div title="系统管理" data-options="selected:false" style="padding:10px;">
//     	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('用户管理', '${basePath}/user/init.do')" style="width:100px" data-options="plain:true">用户管理</a></div>
//     	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('角色管理')" style="width:100px" data-options="plain:true">角色管理</a></div>
//     	<div><a href="#" class="easyui-linkbutton"  onclick="openTab('菜单管理')" style="width:100px" data-options="plain:true">菜单管理</a></div>
//    </div>
};

var superMenuTemp = "<div title='{superMenuName}' data-options='selected:false' style='padding:10px;'>"
var childMenuTemp = "<div><a href='#' class='easyui-linkbutton'  onclick=\"openTab('{childMenuName}', '${basePath}/{linkUrl}')\" style='width:100px' data-options='plain:true'>用户管理</a></div>";


//打开tab菜单框
function openTab(title, url) {
	if($("#w_tabs").tabs('exists',title)) {
		$("#w_tabs").tabs("select",title);    
	} else {
		$('#w_tabs').tabs('add',{
		    title:title,
		    content:'',
		    width: 1000,
	        height: 1000,
	        modal: true,
	        closable:true,
	        resizable:true,
		    href:url
		});
	}
}
$(function() {
//   Main.init();
	openTab("用户基本信息","../user/detail.do");
});
