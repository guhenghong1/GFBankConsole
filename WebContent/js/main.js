var Main = {
   op: {
      bol: false
   },
   init: function() {
      this.initEvent();
      this.initGardenList();
   },
   initEvent: function() {
      var _this = this;
      $(".garden").live("click", function() {
         $(".garden").removeClass("selected");
         $(this).addClass("selected");
      });
      $(".enter").live("click", function(e) {
         var target = e.currentTarget;
         $.ajax({
            type: "post",
            url: "/proxy/api/agent/changeGardenManager",
            data: {
               gardenId: $(target).attr("data-id")
            },
            success: function() {
            }
         });
      });
      //éåºç»å½
      $("#exit").click(function() {
         _this.exitLogin();
      });
      //ç³»ç»è®¾ç½®èå
      $("#qz_menu").hover(function(e) { //é¼ æ ç»è¿å®å¨è®¾ç½®æ¶ï¼æ¾ç¤ºèå
         $('#setMenu').toggle();
      });
   },
   exitLogin: function() {
      $.ajax({
         type: "post",
         url: "/proxy/api/agent/exit",
         data: {
         },
         success: function() {
            window.location.href = "/index.jsp";
         }
      });
   }
   
};

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
});
