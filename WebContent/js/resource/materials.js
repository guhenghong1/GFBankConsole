var Materials = {
	_this : this,
	params : {
		companyId:""
	},
	init : function() {
		this.initDg();
	},
	 /**
	    * 初始化用户列表
	    * @returns {undefined}
	    */
	   initDg: function() {
	      var _this = this;
	      $('#materials').datagrid({
	         fitColumns: true,
	         pagination: true,
	         singleSelect: true,
	         selectOnCheck: false,
	         pageSize: 10,
	         width: 1100,
			 height:400,
			 rownumbers:"true",
			 queryParams:_this.params,
	         url: '../materials/getMaterialsList.do',
	         columns: [[
	               {field: 'companyId', title: '编号', align:'center', width: 100},
	               {field: 'company', title: '公司名称', align:'center', width: 100},
	               {field: 'type', title: '公司类型', align:'center', width: 200},
	               {field: 'scope', title: '提供服务范围', align:'center', width: 200},
	               {field: 'supplierA', title: '联系人', width: 100},
	               {field: 'mobileA', title: '联系电话', align:'center', width: 100},
	               {field: 'supplierB', title: '联系人', align:'center', width: 100},
	               {field: 'mobileB', title: '联系电话', align:'center', width: 100},
	               {field: 'scoreLevel', title: '评级', align:'center', width: 120},	
	               {field: 'updateDateStr', title: '修改时间', align:'center', width: 120}	
//	               {field: 'attachment', title: '操作', align:'center', width: 300},
	            ]],
	         onClickRow: function(index, rowData) {
	         },
	         onLoadSuccess: function() {
	         }
	        
	      });
	   },
	   
	// 新增弹窗
	add : function() {
		$('#materialsForm').form('clear');
		$("#matw").window("open");
	},

	// 编辑弹窗
	edit : function(m) {
		if(m != 1) { //详情
			$(".update").css("display", "none");
			$(".cancle").css("display", "none");
		}
		var _this = this;
		var row = $("#materials").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var companyId = row.companyId
		$.ajax({
			url : "../materials/getMaterialsInfo.do",
			data : {
				"companyId" : companyId
			},
			success : function(data) {
				var data = JSON.parse(data);
				if(!!data.obj) {
					var Materials = data.obj;
					$("#mcompanyId").val(Materials.companyId);
					$("#mcompany").val(Materials.company);
					$("#mtype").val(Materials.type);
					$("#mscope").val(Materials.scope);
					$("#msupplierA").val(Materials.supplierA);
					$("#mmobileA").val(Materials.mobileA);
					$("#msupplierB").val(Materials.supplierB);
					$("#mmobileB").val(Materials.mobileB);
					$("#mscoreLevel").val(Materials.scoreLevel);
					$("#mremark").val(Materials.remark);
					
				}
			}
		});
		$("#umatw").window("open");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#materials").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var companyId = row.companyId;
		$.ajax({
			url : "../materials/deleteMaterials.do",
			data : {
				"companyId" : companyId
			},
			success : function(data) {
				console.log(data)
				var data = JSON.parse(data);
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#materials").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	}
}

// 添加文件
var addMaterials = function() {
//	var isNull = Common.verify("recMaterialsForm");
//	console.log("isNull   "+isNull);
//	if(isNull) {
//		return false;
//	}
    $('#materialsForm').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		    data = JSON.parse(data);
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#matw").window("close");
    		    	$("#materials").datagrid("reload");
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateMaterials = function() {
	$('#mMaterialsForm').form('submit',{
		success:function(data){
			data = JSON.parse(data);
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#umatw").window("close");
				$("#materials").datagrid("reload");
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//查询
var queryMaterials = function() {
        $('#materials').datagrid('load', {  
        	companyId: $("#qCompanyId").val()  
        });  
}  

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#mMaterialsForm').form('clear');
//		$("#mrfw").window("close");
	} else {
		$('#materialsForm').form('clear');
//		$("#rfw").window("close");
	}
}

$(function() {
	Materials.init();
	
});