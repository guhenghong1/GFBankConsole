var Menu = {
	_this : this,
	params : {
		menuId:"",
		keyWords:"",
		menuId:""
	},
	init : function() {
	},

	// 新增弹窗
	add : function() {
		$('#menuForm').form('clear');
		$("#menuw").window("open");
	},

	// 编辑弹窗
	edit : function(m) {
		var _this = this;
		var row = $("#menua").treegrid("getSelected");
//		console.log(row);
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var menuId = row.id
		console.log("menuId= "+menuId);
		$.ajax({
			url : "../menu/getMenuInfo.do",
			data : {
				"menuId" : menuId
			},
			type:"post",
			success : function(data) {
				var data = eval('('+data+')');
				if(!!data.obj) {
					var menu = data.obj;
					$("#mMenuw .mmenuId").val(menu.menuId);
					$("#mMenuw .mmenuName").val(menu.menuName);
					$("#mMenuw .mlinkUrl").val(menu.linkUrl);
					$("#mMenuw .mremark").val(menu.remark);
					
					$('#mMenuw .msuperMenuId').combotree('setValue', menu.superMenuId);
					
					$('#menua').treegrid('reload');
				}
			}
		});
		$("#mMenuw").window("open");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#menua").treegrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var menuId = row.id;
		$.ajax({
			url : "../menu/deleteMenu.do",
			data : {
				"menuId" : menuId
			},
			success : function(data) {
				console.log(data)
				var data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$('#menua').treegrid('reload');
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	}
}

// 添加文件
var addMenu = function() {
//	var isNull = Common.verify("menuForm");
//	console.log("isNull   "+isNull);
//	if(isNull) {
//		return false;
//	}
    $('#menuForm').form('submit',{
    	   success:function(data){
    		   data = JSON.parse(data);
    		    //data = eval('('+data+')');
    		   //alert(data);
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#menuw").window("close");
    		    	$('#menua').treegrid('reload');
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateMenu = function() {
	$('#mMenuForm').form('submit',{
		success:function(data){
			data = eval('('+data+')');
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#mMenuw").window("close");
				$('#menua').treegrid('reload');
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#mMenuForm').form('clear');
//		$("#mrfw").window("close");
	} else {
		$('#menuForm').form('clear');
//		$("#rfw").window("close");
	}
}

$(function() {
	Menu.init();
	
});