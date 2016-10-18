var Warrant = {
	_this : this,
	params : {
		id:"",
		borrower:"",
		status:-1
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
	      $('#warrant_u').datagrid({
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
	               {field: 'cardId', title: '权证证号', align:'center', width: 100},
	               {field: 'deptId', title: '登记部门', align:'center', width: 100},
	               {field: 'remark', title: '备注信息', align:'center', width: 100},
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
		$('#warrantForm_u').form('clear');
		$("#warw_u").window("open");
	},

	// 编辑弹窗
	edit : function(m) {
		var _this = this;
		var row = $("#warrant_u").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id
		$.ajax({
			url : "../warrant/getWarrantInfo.do",
			data : {
				"id" : id
			},
			success : function(data) {
				var data = JSON.parse(data);
				if(!!data.obj) {
					var warrant = data.obj;
					$("#mid").val(warrant.id);
					$("#mborrower").val(warrant.borrower);
					$("#mnormLimit").val(warrant.normLimit);
					$("#mpropertyOwner").val(warrant.propertyOwner);
					$('#mtype').combobox('setValue', warrant.type);
					$('#mstatus').combobox('setValue', warrant.status);
					$('#mcardId').combobox('setValue', warrant.cardId);
					$('#mdeptId').combobox('setValue', warrant.deptId);
					$('#mremark').combobox('setValue', warrant.remark);
				}
			}
		});
		$("#mwarw_u").window("open");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#warrant_u").datagrid("getSelected");
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
				var data = JSON.parse(data);
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#warrant_u").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	}
}

// 添加文件
var addWarrant = function() {
//	var isNull = Common.verify("recwarrantForm");
//	console.log("isNull   "+isNull);
//	if(isNull) {
//		return false;
//	}
	var deptName = $("#deptId").combobox("getText");
	$("#deptName").val(deptName);
	
	var cardName = $("#cardId").combobox("getText");
	$("#cardName").val(cardName);
	
	var remarkName = $("#remark").combobox("getText");
	$("#remarkName").val(remarkName);
    $('#warrantForm_u').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		    data = JSON.parse(data);
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#warw_u").window("close");
    		    	$("#warrant_u").datagrid("reload");
    		    	$('#cardId').combobox('reload'); 
    		    	$('#deptId').combobox('reload'); 
    		    	$('#remark').combobox('reload'); 
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateWarrant = function() {
	var deptName = $("#mdeptId").combobox("getText");
	$("#mdeptName").val(deptName);
	
	var cardName = $("#mcardId").combobox("getText");
	$("#mcardName").val(cardName);
	
	var remarkName = $("#mremark").combobox("getText");
	$("#mremarkName").val(remarkName);
	$('#mwarrantForm_u').form('submit',{
		success:function(data){
			data = JSON.parse(data);
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#mwarw_u").window("close");
		    	$("#warrant_u").datagrid("reload");
		    	$('#cardId').combobox('reload'); 
		    	$('#deptId').combobox('reload'); 
		    	$('#remark').combobox('reload'); 
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//查询
var queryWarrant = function() {
        $('#warrant_u').datagrid('load', {  
        	id: $("#qId").val(),
        	borrower: $("#qborrower").val(),
        	status:$("#qstatus").val()
        });  
}  

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#mwarrantForm_u').form('clear');
//		$("#mrfw").window("close");
	} else {
		$('#warrantForm_u').form('clear');
//		$("#rfw").window("close");
	}
}

$(function() {
	Warrant.init();
	
//	$.fn.combobox.defaults.filter = function(q, row){  
//	    var opts = $(this).combobox('options');  
//	    return row[opts.textField].indexOf(q) >= 0;  
//	}  
//	$('#deptId').combobox({
//		filter: function(q, row){
//			var opts = $(this).combobox('options');
//			return row[opts.textField].indexOf(q) == 0;
//		}
//	});
//	$('#cardId').combobox({
//		filter: function(q, row){
//			var opts = $(this).combobox('options');
//			return row[opts.textField].indexOf(q) == 0;
//		}
//	});
//	$('#remark').combobox({
//		filter: function(q, row){
//			var opts = $(this).combobox('options');
//			return row[opts.textField].indexOf(q) == 0;
//		}
//	});
});