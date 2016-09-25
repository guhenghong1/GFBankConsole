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
			$("#muserId").val(user.userId);
			$("#mrealName").val(user.realName);
			$("#mroleId").val(user.roleId);
			$('#mdeptId').combotree('setValue', user.deptId);
			$("#mmobile").val(user.mobile);
			$("#mphone").val(user.phone);
			$("#memail").val(user.email);
			$("#msex").val(user.sex);
			$("#mnativePlace").val(user.nativePlace);
			$("#mposition").val(user.position);
			$("#mpositionSalary").val(user.positionSalary);
			$("#mlevelSalary").val(user.levelSalary);
			$("#mperformanceSalary").val(user.performanceSalary);
			$("#mstatus").val(user.status);
			$("#minterest").val(user.interest);
			$("#mnation").val(user.nation);
			$("#mnation").val(user.nation);
			$("#mpoliticsStatus").val(user.politicsStatus);
			$("#mcertId").val(user.certId);
			$("#mschool").val(user.school);
			$("#meduLevel").val(user.eduLevel);
			$("#mhomeAddress").val(user.homeAddress);
			$("#mmajor").val(user.major);
			$("#mremark").val(user.remark);
			
			$('#mbirthday').datebox('setValue', "'"+user.birthdayStr+"'");
			$('#mentryDate').datebox('setValue', "'"+user.entryDateStr+"'");
			
			//个人简历
			var schoolList = user.schoolList;
			var schoolTemp = "<tr class='mschools'>"
					+"<td><input class='mtime'  type='text' value='{time}'></input></td>"
					+"<td><input class='mschoolName'  type='text' value='{schoolName}'></input></td>"
					+"<td><input class='mremark'  type='text' value='{remark}'></input></td>"
					+"</tr>";
			var shTrDiv = "";
			
			if(schoolList.length == 0) {
				schoolTemp = schoolTemp.replace("{time}", "");
				schoolTemp = schoolTemp.replace("{schoolName}", "");
				schoolTemp = schoolTemp.replace("{remark}", "");
				
				shTrDiv += schoolTemp;
			}
			
			$.each(schoolList, function(i, obj) {
				console.log("obj=  "+obj);
				var time = obj.time;
				if(!time) {
					time = "";
				}
				var schoolName = obj.schoolName;
				if(!schoolName) {
					schoolName = "";
				}
				var remark = obj.remark;
				if(!remark) {
					remark = "";
				}
				schoolTemp = schoolTemp.replace("{time}", time);
				schoolTemp = schoolTemp.replace("{schoolName}", schoolName);
				schoolTemp = schoolTemp.replace("{remark}", remark);
				
				shTrDiv += schoolTemp;
			});
			
			$(".muserSchool").append(shTrDiv);
			//家庭关系
			var homeList = user.homeList;
			
			var homeTemp = "<tr class='mhomes'>"
				+"<td><input class='mappellation'  type='text' value='{appellation}'></input></td>"
				+"<td><input class='mname'  type='text' value='{name}'></input></td>"
				+"<td><input class='mdeptName'  type='text' value='{deptName}'></input></td>"
				+"<td><input class='mremark'  type='text' value='{remark}'></input></td>"
				+"</tr>";
			var hTrDiv = "";
			
			if(homeList.length == 0) {
				homeTemp = schoolTemp.replace("{appellation}", "");
				homeTemp = schoolTemp.replace("{name}", "");
				homeTemp = schoolTemp.replace("{deptName}", "");
				homeTemp = schoolTemp.replace("{remark}", "");
				
				hTrDiv += homeTemp;
			}
			
			$.each(homeList, function(i, obj) {
				console.log("obj=  "+obj);
				var appellation = obj.appellation;
				if(!appellation) {
					appellation = "";
				}
				var name = obj.name;
				if(!name) {
					name = "";
				}
				var deptName = obj.deptName;
				if(!deptName) {
					deptName = "";
				}
				var remark = obj.remark;
				if(!remark) {
					remark = "";
				}
				homeTemp = schoolTemp.replace("{appellation}", appellation);
				homeTemp = schoolTemp.replace("{name}", name);
				homeTemp = schoolTemp.replace("{deptName}", deptName);
				homeTemp = schoolTemp.replace("{remark}", remark);
				
				hTrDiv += homeTemp;
			});
			
			$(".muserHome").append(hTrDiv);
			
		}
	});
   	$("#mw").window("open");
   },
   
   //修改用户
   updateUser: function() {
	   var schoolList = [];
	   $(".muserSchool .mschools").each(function(i, e){
		  var school = {
				  time:"",
				  schoolName:"",
				  remark:""
		  };
//		  console.log($(e).find("td input"))
		  var inputs = $(e).find("td input");
		  $(inputs).each(function(j, el){
			  var classAttr = $(el).attr("class");
			  if( $(el).val()) {
				  if(classAttr == 'mtime') {
					  school.time = $(el).val();
				  }
				  if(classAttr == 'mschoolName') {
					  school.schoolName = $(el).val();
				  }
				  if(classAttr == 'mremark') {
					  school.remark = $(el).val();
				  }
			  }
		  });
		  schoolList.push(school);
	   });
	   $("#mschoolList").val(JSON.stringify(schoolList));
//	   console.log("val=  "+JSON.stringify(schoolList))
	   
	   var homeList = [];
	   $(".muserHome .mhomes").each(function(i, e){
		   var home = {
				   appellation:"",
				   name:"",
				   deptName:"",
				   remark:""
		   };
//		  console.log($(e).find("td input"))
		   var inputs = $(e).find("td input");
		   $(inputs).each(function(j, el){
			   console.log($(el));
			   var classAttr = $(el).attr("class");
			   if($(el).val()) {
				   if(classAttr == 'mappellation') {
					   home.appellation = $(el).val();
				   }
				   if(classAttr == 'mname') {
					   home.name = $(el).val();
				   }
				   if(classAttr == 'mdeptName') {
					   home.deptName = $(el).val();
				   }
				   if(classAttr == 'mremark') {
					   home.remark = $(el).val();
				   }
			   }
		   });
		   homeList.push(home);
	   });
	   $("#mhomeList").val(JSON.stringify(homeList));
	   
		$('#muserForm').form('submit',{
			success:function(data){
				data = JSON.parse(data);
				if(data.code == 1) {
					Common.showMsg("修改成功");
					$("#mw").window("close");
					$("#tb_users").datagrid("reload");
				} else {
					Common.showMsg("修改失败");
				}
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
//	   var isNull = Common.verify("userForm");
//		console.log("isNull   "+isNull);
//		if(isNull) {
//			return false;
//		}
	   var schoolList = [];
	   var _schools = $("");
	   $(".schools").each(function(i, e){
		   console.log("i=  "+i+"  e=  "+$(e).html());
		  var school = {
				  time:"",
				  schoolName:"",
				  remark:""
		  };
//		  console.log($(e).find("td input"))
		  var tds = $(e).find("td");
		  $(tds).each(function(j, el){
			  /*console.log("j=  "+j+"  el=  "+$(el));*/
			  var classAttr = $(el).find("input").attr("class");
			  if( $(el).val()) {
				  if(classAttr == 'time') {
					  school.time = $(el).val();
				  }
				  if(classAttr == 'schoolName') {
					  school.schoolName = $(el).val();
				  }
				  if(classAttr == 'remark') {
					  school.remark = $(el).val();
				  }
			  }
		  });
		  schoolList.push(school);
	   });
	   $("#schoolList").val(JSON.stringify(schoolList));
	   console.log("val=  "+JSON.stringify(schoolList))
	   
	   var homeList = [];
	   $(".userHome .homes").each(function(i, e){
		   var home = {
				   appellation:"",
				   name:"",
				   deptName:"",
				   remark:""
		   };
//		  console.log($(e).find("td input"))
		   var tds = $(e).find("td");
		   $(tds).each(function(j, el){
			   console.log($(el));
			   var classAttr = $(el).attr("class");
			   if($(el).val()) {
				   if(classAttr == 'appellation') {
					   home.appellation = $(el).val();
				   }
				   if(classAttr == 'name') {
					   home.name = $(el).val();
				   }
				   if(classAttr == 'deptName') {
					   home.deptName = $(el).val();
				   }
				   if(classAttr == 'remark') {
					   home.remark = $(el).val();
				   }
			   }
		   });
		   homeList.push(home);
	   });
	   $("#homeList").val(JSON.stringify(homeList));
//	   console.log("val=  "+JSON.stringify(homeList))
	   
	    $('#userForm').form('submit',{
	    	   success:function(data){
	    		    data = JSON.parse(data);
	    		    if(data.code == 1) {
	    		    	Common.showMsg("添加成功");
	    		    	$("#w").window("close");
	    				$("#tb_users").datagrid("reload");
	    		    } else {
	    		    	Common.showMsg("添加失败");
	    		    }
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
	
	$("#certFront").change(function() {
		var _this = this;
		var val = $(_this).val();
		$("#imgFront").attr("src", val);
	});
	
	$("#certBack").change(function() {
		var _this = this;
		var val = $(_this).val();
		$("#imgBack").attr("src", val);
	});
	
	$("#mcertFront").change(function() {
		var _this = this;
		var val = $(_this).val();
		$("#mimgFront").attr("src", val);
	});
	
	$("#mcertBack").change(function() {
		var _this = this;
		var val = $(_this).val();
		$("#mimgBack").attr("src", val);
	});
});

