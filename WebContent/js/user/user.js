var User = {
	params : {
		userId:"",
		realName:"",
		deptId:"",
		mobile:"",
		phone:""
	},
   init: function() {
      this.initDg();
   },
   /**
    * 初始化用户列表
    * @returns {undefined}
    */
   initDg: function() {
      var _this = this;
      $('#tb_users').datagrid({
         fitColumns: true,
         pagination: true,
         singleSelect: true,
         pageSize: 10,
         width: 1000,
		 height: 350,
		 rownumbers:"true",
		 queryParams:_this.params,
         url: '../user/getUserList.do',
         columns: [[
               {field: 'userId', title: '用户工号', width: 100},
               {field: 'realName', title: '真实姓名', width: 100},
               {field: 'roleName', title: '角色', width: 100},
               {field: 'deptName', title: '部门', width: 100},
               {field: 'phone', title: '电话', width: 100},
               {field: 'mobile', title: '手机号', width: 100},
               {field: 'email', title: '电子邮件', width: 120}
            ]],
         onClickRow: function(index, rowData) {
         },
         onLoadSuccess: function() {
         }
        
      });
   },
   /**
    * 获取用户详细信息
    * @param {type} row 当前用户信息(json）
    * @returns {undefined}
    */
   getDetail: function(row) {
      var _this = this;
      var temp = $("#userDetail-template").html();
      Do("mustache", function() {
         if (row.ISPASSED == 1)
            row['ISPASSED'] = '通过';
         else
            row['ISPASSED'] = '不通过';
         //每次打开前，清空userDetail
         $("#userDetail").html("");
         //先把信息添加到userDetail中，然后再显示用户信息
         $("#userDetail").append(Mustache.to_html(temp, row));
         $('#userInfo').show();
      });
     
      $("#userInfo").dialog({
         title: '用户信息',
         width: 680,
         height: 350,
         modal: true,
         buttons: [{
               text: "去TA的主页",
               handler:function(){
                  window.open("http://person"+$('#hidden-domain').val()+"/"+row.JIAID); 
               }
         },{
               text: text,
               iconCls: icon,
               handler: function() {
                  if (flg) {
                     //审核用户不通过方法
                     _this.auditNotPassed();
                  } else {
                     //审核用户通过方法
                     _this.auditPassed();
                  }
                  $("#userInfo").window('close');
               }
            }]
      });
   },
   /**
    * 用户审核通过
    * @returns {undefined}
    */
   auditPassed: function() {
      var _this = this;
      var row = $("#tb_users").datagrid("getSelected");
      if (row == null) {
         $.messager.alert('提示信息', "请选择用户");
      } else {
         _this.auditOfCommonAjax(_this, 'auditPass', row);
      }

   },
   
   showMsg: function(msg) {
   	   $.messager.alert('提示', msg);
   },
   
   //编辑用户弹窗
   edit:function() {
   	var _this = this;
   	$("#add").css("display", "none");
   	$("#update").css("display", "");
   	var row = $("#tb_users").datagrid("getSelected");
   	var userId = row.userId;
   	var role = row.role;
   	if(role == 2) {
   		_this.showMsg('权限不够');
   		return;
   	}
   	console.log(row.userId);
	$.ajax({
		url:"../user/getUserInfo.do",
		data:{"userId":userId},
		success: function(data) {
			var user = JSON.parse(data);
			$("#userId").val(user.userId);
			$("#userName").val(user.userName);
			$("#realName").val(user.realName);
			$("#role").val(user.role);
			$("#customer").val(user.customer);
			$("#mobile").val(user.mobile);
			$("#email").val(user.email);
		}
	});
   	$("#w").window("open");
   },
   
   //修改用户
   update: function() {
   		var _this = this;
		var userId = $("#userId").val();
		var userName = $("#userName").val();
		var realName = $("#realName").val();
		var role = $("#role").val();
		var customer = $("#customer").val();
		var mobile = $("#mobile").val();
		var email = $("#email").val();
		var params = {
			"userId" : userId,
			"userName" : userName,
			"realName" : realName,
			"role" : role,
			"customer" : customer,
			"mobile" : mobile,
			"email" : email
		};
		$.ajax({
			url: "../user/updateUser.do",
			data: params,
			type:"post",
			success: function(data) {
				var result = JSON.parse(data);
				if(result.code == 1) {
					_this.showMsg("修改成功");
				} else {
					_this.showMsg("修改失败");
				}
				
				$("#w").window("close");
				$("#tb_users").datagrid("reload");
			}
		}); 	
   },
   
   //新增用户弹窗
   add: function() {
   		var _this = this;
   		$("#tb_users").datagrid("unselectAll");
   		$("#add").css("display", "");
   		$("#update").css("display", "none");
   		$("#w").window("open");
   },
   
   //新增用户
   addUser: function() {
   		var _this = this;
   		var userId = $("#userId").val();
		var userName = $("#userName").val();
		var realName = $("#realName").val();
		var role = $("#role").val();
		var customer = $("#customer").val();
		var mobile = $("#mobile").val();
		var email = $("#email").val();
		var params = {
			"userName" : userName,
			"realName" : realName,
			"role" : role,
			"customer" : customer,
			"mobile" : mobile,
			"email" : email
		};
		$.ajax({
			url: "../user/addUser.do",
			data: params,
			type:"post",
			success: function(data) {
				var result = JSON.parse(data);
				if(result.code == 1) {
					_this.showMsg("添加成功");
				} else {
					_this.showMsg("添加失败");
				}
				
				$("#w").window("close");
				$("#tb_users").datagrid("reload");
			}
		}); 	
   },
   
   //删除用户  
   deleteUser : function() {
   		var _this = this;
   		var row = $("#tb_users").datagrid("getSelected");
   		var userId = row.userId;
   		$("#w").window("close");
   		var role = row.role;
   		if(role == 2) {
   			_this.showMsg('权限不够');
   			return;
   		}
   		$.ajax({
   			url:"../user/deleteUser.do",
   			data:{"userId":userId},
   			type:"post",
   			success:function(data) {
   				var result = JSON.parse(data);
				if(result.code == 1) {
					_this.showMsg("删除成功");
				} else {
					_this.showMsg("删除失败");
				}
				$("#tb_users").datagrid("reload");
   			}
   		});
   }
}

//查询
var queryUser = function() {
        $('#tb_users').datagrid('load', {  
        	userId: $("#quserId").val(),  
        	realName: $("#qrealName").val(),  
            deptId: $('#qdeptId').combotree('getValue'),
            phone: $("#qphone").val(),  
            mobile: $("#qmobile").val()  
        });  
} 

$(function() {
	User.init();
});

