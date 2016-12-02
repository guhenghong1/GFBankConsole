var Materials = {
	_this : this,
	params : {
		companyId:"",
		company:""
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
//	               {field: 'ck', checkbox: true, align:'center', width: 30},
	               {field: 'companyId', title: '编号', align:'center', width: 100},
	               {field: 'company', title: '供应商名称', align:'center', width: 100},
	               {field: 'scope', title: '供应范围', align:'center', width: 200},
	               {field: 'supplierA', title: '联系人', align:'center', width: 200},
	               {field: 'mobileA', title: '联系方式', width: 100},
	               {field: 'scoreLevel', title: '评级', align:'center', width: 100}
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
		Common.clearSpanMsg("materialsForm");
		$("#matw").window("open");
	},

	// 编辑弹窗
	edit : function(m) {
		if(m == 1) { //
			$("#umatw .update").css("display", "");
		} else {
			$("#umatw .update").css("display", "none");
		}
		Common.clearSpanMsg("mMaterialsForm");
		var _this = this;
		var row = $("#materials").datagrid("getSelected");
//		console.log(row);
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
				var data = eval('('+data+')');
				if(!!data.obj) {
					var company = data.obj;
					$("#umatw .mcompanyId").val(company.companyId);
					$("#umatw .mcompany").val(company.company);
					$("#umatw .mtype").val(company.type);
					$("#umatw .mscope").val(company.scope);
					$("#umatw .msupplierA").val(company.supplierA);
					$("#umatw .mmobileA").val(company.mobileA);
					$("#umatw .msupplierB").val(company.supplierB);
					$("#umatw .mmobileB").val(company.mobileB);
					$("#umatw .mscoreLevel").val(company.scoreLevel);
					$("#umatw .mremark").val(company.remark);
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
				var data = eval('('+data+')');
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
//	var isNull = Common.verify("sendFileForm");
//	console.log("isNull== "+isNull);
//	if(isNull) {
//		return false;
//	}
    $('#materialsForm').form('submit',{
    	 onSubmit:function(){
//             return $(this).form('enableValidation').form('validate');
         },
    	   success:function(data){
    		    data = eval('('+data+')');
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
//	var isNull = Common.verify("msendFileForm");
//	console.log("isNull== "+isNull);
//	if(isNull) {
//		return false;
//	}
	$('#mMaterialsForm').form('submit',{
		success:function(data){
			data = eval('('+data+')');
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
        	companyId: $(".queryComp .qCompanyId").val(),  
        	company: $(".queryComp .qCompany").val()
        });  
}  

//重置
var clearQuery = function() {
	$(".queryComp .qCompanyId").val("");
	$(".queryComp .qCompany").val("");
}


var verifyBlurInput = function() {
	$('#msendFileForm').on('blur','.required',function(){
		var _this = this;
		console.log("verifyBlurInput==  "+$(_this).attr("id"));
		if(!$(_this).val()) {
			var text = $(_this).parent().prev("td").find("label").text();
			text = text.replace("：*", "不能为空！");
			$(_this).next("span").html("<font style='color:red'> "+text+"</font>");
		} else {
			$(_this).next("span").html("");
		}
	});
	
	$('#sendFileForm').on('blur','.required',function(){
		var _this = this;
		console.log("verifyBlurInput==  "+$(_this).attr("id"));
		if(!$(_this).val()) {
			var text = $(_this).parent().prev("td").find("label").text();
			text = text.replace("：*", "不能为空！");
			$(_this).next("span").html("<font style='color:red'> "+text+"</font>");
		} else {
			$(_this).next("span").html("");
		}
	});
} 

$(function() {
	Materials.init();
	
	//verifyBlurInput();
});