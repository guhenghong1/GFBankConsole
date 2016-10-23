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
   edit:function(m) {
		if(m == 1) { //详情
			$(".update").css("display", "");
			$(".cancle").css("display", "");
		} else {
			$(".update").css("display", "none");
			$(".cancle").css("display", "none");
		}
   	var _this = this;
   	$('#userForm').form('clear');
   	var row = $("#tb_users").datagrid("getSelected");
	if(!row) {
		Common.showMsg("请选择一条记录！");
		return false;
	}
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
			$("#mdeptId").combotree("setValue", user.deptId);
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
			
			$('#mbirthday').datebox('setValue', user.birthdayStr);
			$('#mentryDate').datebox('setValue', user.entryDateStr);
			
			//个人简历
			var mschoolsTr = $(".muserSchool .mschools");
			if(!!mschoolsTr) {
				$(mschoolsTr).remove();
			}
			
			var schoolList = user.schoolList;
			var schoolTemp = "<tr class='mschools'>"
					+"<td><input class='mtime'  type='text' value='{time}'></input></td>"
					+"<td><input class='mschoolName'  type='text' value='{schoolName}'></input></td>"
					+"<td><input class='mremark'  type='text' value='{remark}'></input>"
					+"<a href='javascript:void(0)' onclick='removeEle(this)'><img src='../images/remove.png'/></a>"
					+"</td>"
					+"</tr>";
			var shTrDiv = "";
			
			if(schoolList.length == 0) {
//				$("#mschools").css("display", "block");
				var divTemp = "";
				divTemp = schoolTemp.replace("{time}", "")
				 		.replace("{schoolName}", "")
				 		.replace("{remark}", "");
				
				shTrDiv += divTemp;
			}
			
			$.each(schoolList, function(i, obj) {
				console.log("obj=  "+JSON.stringify(obj));
				var time = obj.time;
				console.log("time=  "+time);
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
				var divTemp = "";
				divTemp = schoolTemp.replace("{time}", time)
						.replace("{schoolName}", schoolName)
						.replace("{remark}", remark);
				
				shTrDiv += divTemp;
			});
			
			$(".muserSchool").append(shTrDiv);
			
			//家庭关系
			var mschoolsTr = $(".muserHome .mhomes");
			if(!!mschoolsTr) {
				$(mschoolsTr).remove();
			}
			var homeList = user.homeList;
			
			var homeTemp = "<tr class='mhomes'>"
				+"<td><input class='mappellation'  type='text' value='{appellation}'></input></td>"
				+"<td><input class='mname'  type='text' value='{name}'></input></td>"
				+"<td><input class='mdeptName'  type='text' value='{deptName}'></input></td>"
				+"<td><input class='mremark'  type='text' value='{remark}'></input>"
				+"<a href='javascript:void(0)' onclick='removeEle(this)'><img src='../images/remove.png'/></a>"
				+"</td>"
				+"</tr>";
			var hTrDiv = "";
			
			if(homeList.length == 0) {
				console.log("length=  "+homeList.length);
//				$("#mhomes").css("display", "block");
				var divTemp = "";
				divTemp = homeTemp.replace("{appellation}", "")
						.replace("{name}", "")
						.replace("{deptName}", "")
						.replace("{remark}", "");
				
				hTrDiv += divTemp;
			}
			
			$.each(homeList, function(i, obj) {
				console.log("home1=  "+obj.appellation);
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
				var divTemp = "";
				divTemp = homeTemp.replace("{appellation}", appellation)
						.replace("{name}", name)
						.replace("{deptName}", deptName)
						.replace("{remark}", remark);
				
				hTrDiv += divTemp;
			});
			
			console.log("hTrDiv==  "+hTrDiv);
			$(".muserHome").append(hTrDiv);
			
		}
	});
   	$("#mw").window('refresh').window("open");
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
			  console.log("class=  "+classAttr+"  val="+$(el).val());
			  if($(el).val()) {
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
	   console.log("val=  "+JSON.stringify(schoolList))
	   
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
//			   console.log($(el));
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
	   	$("#tb_users").datagrid("unselectAll");
	    $('#userForm').form('clear');
   		var _this = this;
//   		$('#userform')[0].reset();
   		$("#w").window('refresh').window("open");
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
		  var inputs = $(e).find("td input");
		  $(inputs).each(function(j, el){
			  /*console.log("j=  "+j+"  el=  "+$(el));*/
			  var classAttr = $(el).attr("class");
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
		   var inputs = $(e).find("td input");
		   $(inputs).each(function(j, el){
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
   },
   
   setMenu : function() {
	   $("#userMenuForm").form("clear");
	   
	   var row = $("#tb_users").datagrid("getSelected");
	   if(!row) {
		   Common.showMsg("请选择一条记录！");
		   return false;
	   }
	   var userId = row.userId;
	   var realName = row.realName;
	   
	   $("#userMenuw").window("open");
	   
	   $("#menuUserId").val(userId);
	   $("#menuRealName").val(realName);
	   
		$.ajax({
			url:"../user/getUserMenu.do",
			data:{"userId":userId},
			success: function(data) {
				data = JSON.parse(data);
				var menuIdArr = [];
				var menuIdStr = data.obj.menuIds;
				
				var len = menuIdStr.split(",").length;
				menuIdArr = menuIdStr.split(",");
				$('#amenuIds').combotree('setValues', menuIdArr);
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

//查询
var exportUser = function() {
	var params = {
		userId: $("#quserId").val(),  
		realName: $("#qrealName").val(),  
		deptId: $('#qdeptId').combotree('getValue'),
		phone: $("#qphone").val(),  
		mobile: $("#qmobile").val()
	}
	$.ajax({
		url:"../user/createCSV.do",
		data:params,
		success:function(data) {
			var filePath = data;
			var url = "../file/exportFile.do?filePath="+filePath;
			window.open(url);
		}
	});
} 

//添加菜单项
var addUserMenu = function() {
    $('#userMenuForm').form('submit',{
 	   success:function(data){
 		    data = JSON.parse(data);
 		    if(data.code == 1) {
 		    	Common.showMsg("添加成功");
 		    	$("#userMenuw").window("close");
// 				$("#tb_users").datagrid("reload");
 		    	window.location.href=window.location.href;
 		    } else {
 		    	Common.showMsg("添加失败");
 		    }
 	    }
    });
}

//增加个人简历
var addSchoolEle = function(m) {
	var schoolTemp = "";
	if(m == 1) {
		schoolTemp = "<tr class='mschools'>"
			+"<td><input class='mtime'  type='text' value='{time}'></input></td>"
			+"<td><input class='mschoolName'  type='text' value='{schoolName}'></input></td>"
			+"<td><input class='mremark'  type='text' value='{remark}'></input>"
			+"		<a href='javascript:void(0)' onclick=\"removeEle(this)\"><img src='../images/remove.png'/></a>"
			+"</td>"
			+"</tr>";
	} else {
		schoolTemp = "<tr class='schools'>"
			+"<td><input class='time'  type='text' value='{time}'></input></td>"
			+"<td><input class='schoolName'  type='text' value='{schoolName}'></input></td>"
			+"<td><input class='remark'  type='text' value='{remark}'></input>"
			+"		<a href='javascript:void(0)' onclick=\"removeEle(this)\"><img src='../images/remove.png'/></a>"
			+"</td>"
			+"</tr>";
	}
	var shTrDiv = "";
	var divTemp = "";
	divTemp = schoolTemp.replace("{time}", "")
		 	.replace("{schoolName}", "")
		 	.replace("{remark}", "");
	shTrDiv += divTemp;
	if(m == 1) {
		$(".muserSchool").append(shTrDiv);
	} else {
		$(".userSchool").append(shTrDiv);
	}
}

var addHomeEle = function(m) {
	var homeTemp = "";
	if(m == 1) {
		homeTemp = "<tr class='mhomes'>"
			+"<td><input class='mappellation'  type='text' value='{appellation}'></input></td>"
			+"<td><input class='mname'  type='text' value='{name}'></input></td>"
			+"<td><input class='mdeptName'  type='text' value='{deptName}'></input></td>"
			+"<td><input class='mremark'  type='text' value='{remark}'></input>"
			+"<a href='javascript:void(0)' onclick='removeEle(this)'><img src='../images/remove.png'/></a>"
			+"</td>"
			+"</tr>";
	} else {
		homeTemp = "<tr class='homes'>"
			+"<td><input class='appellation'  type='text' value='{appellation}'></input></td>"
			+"<td><input class='name'  type='text' value='{name}'></input></td>"
			+"<td><input class='deptName'  type='text' value='{deptName}'></input></td>"
			+"<td><input class='remark'  type='text' value='{remark}'></input>"
			+"<a href='javascript:void(0)' onclick='removeEle(this)'><img src='../images/remove.png'/></a>"
			+"</td>"
			+"</tr>";	
	}
	var hTrDiv = "";
	
	var divTemp = "";
	divTemp = homeTemp.replace("{appellation}", "")
			.replace("{name}", "")
			.replace("{deptName}", "")
			.replace("{remark}", "");
		
	hTrDiv += divTemp;
	if(m == 1) {
		$(".muserHome").append(hTrDiv);
	} else {
		$(".userHome").append(hTrDiv);
	}
}

var removeEle = function(_this) {
	console.log($(_this));
	console.log($(_this).parent().html());
	$(_this).parent().parent().remove();
}

$(function() {
	User.init();
	
	$("#headPhoto").on('change', function() {
		alert("1111");
		var _this = this;
		var val = $(_this).val();
		console.log("val=="+val);
		$("#imgHeadPhoto").attr("src", val);
	});
	
	$("#imgHeadPhoto").click(function() {
		$("#headPhoto").click();
		$("#headPhoto").on("change", function() {
			var objUrl = this.files[0];
			if(objUrl) {
				$("#imgHeadPhoto").attr("src", objUrl);
			}
		});
	});
	
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
	
//	initFormatCombotree("menuIds");
	
	$('#amenuIds').combotree({
//		onLoadSuccess:function(node, data){
//			var  node1=$("#menuIds").tree('getParent',node.target);
//		    $(tree).tree('check', node1.target);
//		},
		onCheck:function(node, checked){
//			console.log("node== "+node);
//			alert("target=="+node.target);
//			alert("text=="+node.text);  
//			if(checked){
//				checkNode($('#amenuIds').tree('getParent',node.target));
//			}
		}
//	onClick: function(node){
//		alert("target=="+n.target);
//		alert("text=="+node.text);  // alert node text property when clicked
//		checkNode(node);
//	}
	});
	
	function checkNode(node){
		console.log("node=="+node.target+" text="+node.text);
		if(!node){
			return;
		}else{
//			if(!!$('#amenuIds').tree('getParent',node.target)) {
//				checkNode($('#amenuIds').tree('getParent',node.target));
//			}
			console.log(" text="+node.text);
//			$('#amenuIds').combotree('tree').tree('check',node.target);
			
		}
	}
	
	
});


