var Org = {
	_this : this,
	params : {
		deptId:"",
		keyWords:"",
		deptId:""
	},
	init : function() {
	},

	// 新增弹窗
	add : function() {
		$('#orgForm').form('clear');
		$("#orgw").window("open");
	},

	// 编辑弹窗
	edit : function(m) {
		if(m == 1) { //详情
			$(".update").css("display", "");
			$(".cancle").css("display", "");
		} else {
			$(".update").css("display", "none");
			$(".cancle").css("display", "none");
		}
		var _this = this;
		var row = $("#org").treegrid("getSelected");
//		console.log(row);
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var deptId = row.deptId
		$.ajax({
			url : "../dept/getDeptInfo.do",
			data : {
				"deptId" : deptId
			},
			success : function(data) {
				var data = JSON.parse(data);
				if(!!data.obj) {
					var org = data.obj;
					$("#mdeptId").val(org.deptId);
					$("#mdeptName").val(org.deptName);
					$("#mlevel").val(org.level);
					$("#misSalesDept").val(org.isSalesDept);
					$("#maddress").val(org.address);
					$("#mremark").val(org.remark);
//					$('#mcreateDate').datetimebox('setValue', org.createDateStr);
					
					$('#msuperDeptId').combotree('setValue', org.superDeptId);
				}
			}
		});
		$("#morgw").window("open");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#org").treegrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var deptId = row.deptId;
		$.ajax({
			url : "../dept/deleteDept.do",
			data : {
				"deptId" : deptId
			},
			success : function(data) {
				console.log(data)
				var data = JSON.parse(data);
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#org").treegrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	}
}

// 添加文件
var addOrg = function() {
//	var isNull = Common.verify("orgForm");
//	console.log("isNull   "+isNull);
//	if(isNull) {
//		return false;
//	}
    $('#orgForm').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		    data = JSON.parse(data);
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#orgw").window("close");
    		    	$("#org").treegrid("reload");
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateOrg = function() {
	$('#morgForm').form('submit',{
		success:function(data){
			data = JSON.parse(data);
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#morgw").window("close");
				$("#org").treegrid("reload");
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#morgForm').form('clear');
//		$("#mrfw").window("close");
	} else {
		$('#orgForm').form('clear');
//		$("#rfw").window("close");
	}
}

$(function() {
	Org.init();
	
});