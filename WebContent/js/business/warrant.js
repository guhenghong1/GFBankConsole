var Warrant = {
	_this : this,
	params : {
		id:"",
		borrower:"",
		status:-1,
		startDate:"",
		endDate:""
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
	      $('#warrant').datagrid({
	         fitColumns: true,
	         pagination: true,
	         singleSelect: true,
	         selectOnCheck: false,
	         pageSize: 10,
	         width: 1100,
			 height:400,
			 rownumbers:"true",
			 queryParams:_this.params,
	         url: '../warrant/getWarrantList.do',
	         columns: [[
	               {field: 'id', title: '编号', align:'center', width: 100},
	               {field: 'type', title: '权证类型', align:'center', width: 100},
	               {field: 'borrower', title: '借款人', align:'center', width: 200},
	               {field: 'normLimit', title: '担保债权额度', align:'center', width: 200},
	               {field: 'propertyOwner', title: '产权所有人', width: 100},
	               {field: 'cardName', title: '权证证号', align:'center', width: 100},
	               {field: 'deptName', title: '登记部门', align:'center', width: 100},
	               {field: 'remarkName', title: '备注信息', align:'center', width: 100},
	               {field: 'statusStr', title: '状态', align:'center', width: 100},
	               {field: 'createDateStr', title: '创建时间', align:'center', width: 120}	
	            ]],
	         onClickRow: function(index, rowData) {
	         },
	         onLoadSuccess: function() {
	         }
	        
	      });
	   },
	   
	// 新增弹窗
	add : function() {
		$('#warrantForm').form('clear');
		Common.clearSpanMsg("warrantForm");
		$("#warw").window("open");
		$("#warw").window("refresh");
	},

	// 编辑弹窗
	edit : function(m) {
		if(m == 0) {
			$("#mwarw .operate").css("display", "none");
		} else {
			$("#mwarw .operate").css("display", "");
		}
		var _this = this;
		var row = $("#warrant").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		Common.clearSpanMsg("mwarrantForm");
		
		var limit = $("#mwarw .mnormLimit").val();
		if(!isNaN(limit)){
		}else{
			$("#mwarw .mnormLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
			return false;
		}
		
		var id = row.id
		$.ajax({
			url : "../warrant/getWarrantInfo.do",
			data : {
				"id" : id
			},
			success : function(data) {
				data = eval('('+data+')');
				if(!!data.obj) {
					var warrant = data.obj;
					$("#mwarw .mid").val(warrant.id);
					$("#mwarw .mborrower").val(warrant.borrower);
					$("#mwarw .mnormLimit").val(warrant.normLimit);
					$("#mwarw .mpropertyOwner").val(warrant.propertyOwner);
					$('#mwarw .mtype').combobox('setValue', warrant.type);
					$('#mwarw .mstatus').combobox('setValue', warrant.status);
					$('#mwarw .mcardId').combobox('setText', warrant.cardName);
					$('#mwarw .mdeptId').combobox('setText', warrant.deptName);
					$('#mwarw .mremark').combobox('setText', warrant.remarkName);
//					$('#mwarw .mcardId').combobox('setValue', warrant.cardId);
//					$('#mwarw .mdeptId').combobox('setValue', warrant.deptId);
//					$('#mwarw .mremark').combobox('setValue', warrant.remark);
				}
			}
		});
		$("#mwarw").window("open");
		$("#mwarw").window("refresh");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#warrant").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id;
		$.ajax({
			url : "../warrant/deleteWarrant.do",
			data : {
				"id" : id
			},
			success : function(data) {
				console.log(data)
				data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#warrant").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	},
	
	//打印申请表
	printApply : function() {
		var _this = this;
		var row = $("#warrant").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id;
		window.open("../common/view.jsp?id="+id+"&type=warrant_apply");
	},
	
	//打印入库单
	printInOrder : function() {
		var _this = this;
		var row = $("#warrant").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id;
		window.open("../common/view.jsp?id="+id+"&type=warrant_in");
	}
}

// 添加文件
var addWarrant = function() {
	var limit = $("#warw .normLimit").val();
	if(!isNaN(limit)){
	}else{
		$("#warw .normLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
		return false;
	}
	
	var isNull = Common.verify("warw");
	console.log("isNull   "+isNull);
	if(isNull) {
//		return false;
	}
	
	
	var deptName = $("#warw .deptId").combobox("getText");
	$("#warw .deptName").val(deptName);
	
	var cardName = $("#warw .cardId").combobox("getText");
	$("#warw .cardName").val(cardName);
	
	var remarkName = $("#warw .remark").combobox("getText");
	$("#warw .remarkName").val(remarkName);
    $('#warrantForm').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		   data = eval('('+data+')');
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#warw").window("close");
    		    	$("#warrant").datagrid("reload");
    		    	$('#warw .cardId').combobox('reload'); 
    		    	$('#warw .deptId').combobox('reload'); 
    		    	$('#warw .remark').combobox('reload'); 
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateWarrant = function() {
	var limit = $("#mwarw .mnormLimit").val();
	if(!isNaN(limit)){
	}else{
		$("#mwarw .mnormLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
		return false;
	}
	
	var isNull = Common.verify("mwarrantForm");
	console.log("isNull   "+isNull);
	if(isNull) {
		return false;
	}
	var deptName = $("#mwarw .mdeptId").combobox("getText");
	$("#mwarw .mdeptName").val(deptName);
	
	var cardName = $("#mwarw .mcardId").combobox("getText");
	$("#mwarw .mcardName").val(cardName);
	
	var remarkName = $("#mwarw .mremark").combobox("getText");
	$("#mwarw .mremarkName").val(remarkName);
	$('#mwarrantForm').form('submit',{
		success:function(data){
			data = eval('('+data+')');
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#mwarw").window("close");
				$("#warrant").datagrid("reload");
		    	$('#mwarw .cardId').combobox('reload'); 
		    	$('#mwarw .deptId').combobox('reload'); 
		    	$('#mwarw .remark').combobox('reload'); 
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//查询
var queryWarrant = function() {
        $('#warrant').datagrid('load', {  
        	id: $(".queryWarrant .qId").val(),
        	borrower: $(".queryWarrant .qborrower").val(),
        	status: $(".queryWarrant .qstatus").combobox('getValue'),  
            startDate: $(".queryWarrant .qstartDate").datetimebox('getValue'),  
            endDate: $(".queryWarrant .qendDate").datetimebox('getValue')
        });  
}  

//重置
var clearQuery = function() {
	$(".queryWarrant .qId").val("");
	$(".queryWarrant .qborrower").val("");
	$(".queryWarrant .qstatus").combobox('clear');
	$(".queryWarrant .qstartDate").datetimebox('clear');
	$(".queryWarrant .qendDate").datetimebox('clear');
}

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#mwarrantForm').form('clear');
//		$("#mrfw").window("close");
	} else {
		$('#warrantForm').form('clear');
//		$("#rfw").window("close");
	}
}

$(function() {
	Warrant.init();
	
	Common.verifyBlur("mwarrantForm");
	Common.verifyBlur("warrantForm");
	
	$("#warw .normLimit").on('blur', function() {
		var _this = this;
		var limit = $(_this).val();
		if(!isNaN(limit)){
		}else{
			$(_this).next("span").html("<font style='color:red'>额度必须为数字</font>");
			return false;
		}
	});
	
	$("#mwarw .mnormLimit").on('blur', function() {
		var _this = this;
		var limit = $(_this).val();
		if(!isNaN(limit)){
		}else{
			$(_this).next("span").html("<font style='color:red'>额度必须为数字</font>");
			return false;
		}
	});

});