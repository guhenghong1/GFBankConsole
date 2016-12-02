var WarrantU = {
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
			$('#warrantForm_u').form('clear');
			Common.clearSpanMsg("warrantForm_u");
			$("#warw_u").window("open");
			$("#warw_u").window("refresh");
		},

		// 编辑弹窗
		edit : function(m) {
			if(m == 0) {
				$("#mwarw_u .operate").css("display", "none");
			} else {
				$("#mwarw_u .operate").css("display", "");
			}
			var _this = this;
			var row = $("#warrant_u").datagrid("getSelected");
			if(!row) {
				Common.showMsg("请选择一条记录！");
				return false;
			}
			Common.clearSpanMsg("mwarrantForm_u");
			
			var limit = $("#mwarw_u .mnormLimit").val();
			if(!isNaN(limit)){
			}else{
				$("#mwarw_u .mnormLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
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
						$("#mwarw_u .mid").val(warrant.id);
						$("#mwarw_u .mborrower").val(warrant.borrower);
						$("#mwarw_u .mnormLimit").val(warrant.normLimit);
						$("#mwarw_u .mpropertyOwner").val(warrant.propertyOwner);
						$('#mwarw_u .mtype').combobox('setValue', warrant.type);
						$('#mwarw_u .mstatus').combobox('setValue', warrant.status);
						$('#mwarw_u .mcardId').combobox('setText', warrant.cardName);
						$('#mwarw_u .mdeptId').combobox('setText', warrant.deptName);
						$('#mwarw_u .mremark').combobox('setText', warrant.remarkName);
//						$('#mwarw .mcardId').combobox('setValue', warrant.cardId);
//						$('#mwarw .mdeptId').combobox('setValue', warrant.deptId);
//						$('#mwarw .mremark').combobox('setValue', warrant.remark);
					}
				}
			});
			$("#mwarw_u").window("open");
			$("#mwarw_u").window("refresh");
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
					data = eval('('+data+')');
					if(data.code == 1) {
						Common.showMsg("删除成功");
						$("#warrant_u").datagrid("reload");
					} else {
						Common.showMsg("删除失败");
					}
				}
			});
		},
		
		//打印申请表
		printApply : function() {
			var _this = this;
			var row = $("#warrant_u").datagrid("getSelected");
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
			var row = $("#warrant_u").datagrid("getSelected");
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
		var limit = $("#warw_u .normLimit").val();
		if(!isNaN(limit)){
		}else{
			$("#warw_u .normLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
			return false;
		}
		
		var isNull = Common.verify("warw_u");
		console.log("isNull   "+isNull);
		if(isNull) {
			//return false;
		}
		
		
		var deptName = $("#warw_u .deptId").combobox("getText");
		$("#warw_u .deptName").val(deptName);
		
		var cardName = $("#warw_u .cardId").combobox("getText");
		$("#warw_u .cardName").val(cardName);
		
		var remarkName = $("#warw_u .remark").combobox("getText");
		$("#warw_u .remarkName").val(remarkName);
	    $('#warrantForm_u').form('submit',{
	    	   success:function(data){
	    		   console.log(data);
	    		   data = eval('('+data+')');
	    		    if(data.code == 1) {
	    		    	Common.showMsg("添加成功");
	    		    	$("#warw_u").window("close");
	    		    	$("#warrant_u").datagrid("reload");
	    		    	$('#warw_u .cardId').combobox('reload'); 
	    		    	$('#warw_u .deptId').combobox('reload'); 
	    		    	$('#warw_u .remark').combobox('reload'); 
	    		    } else {
	    		    	Common.showMsg("添加失败");
	    		    }
	    	    }
	    });
	}

	// 添加文件
	var updateWarrant_U = function() {
		var limit = $("#mwarw_u .mnormLimit").val();
		if(!isNaN(limit)){
		}else{
			$("#mwarw_u .mnormLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
			return false;
		}
		
		var isNull = Common.verify("mwarrantForm_u");
		console.log("isNull   "+isNull);
		if(isNull) {
			//return false;
		}
		var deptName = $("#mwarw_u .mdeptId").combobox("getText");
		$("#mwarw_u .mdeptName").val(deptName);
		
		var cardName = $("#mwarw_u .mcardId").combobox("getText");
		$("#mwarw_u .mcardName").val(cardName);
		
		var remarkName = $("#mwarw_u .mremark").combobox("getText");
		$("#mwarw_u .mremarkName").val(remarkName);
		$('#mwarrantForm_u').form('submit',{
			success:function(data){
				data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("修改成功");
					$("#mwarw_u").window("close");
					$("#warrant_u").datagrid("reload");
			    	$('#mwarw_u .cardId').combobox('reload'); 
			    	$('#mwarw_u .deptId').combobox('reload'); 
			    	$('#mwarw_u .remark').combobox('reload'); 
				} else {
					Common.showMsg("修改失败");
				}
			}
		});
	}

	//查询
	var queryWarrant_U = function() {
	        $('#warrant_u').datagrid('load', {  
	        	id: $(".queryWarrant_u .qId").val(),
	        	borrower: $(".queryWarrant_u .qborrower").val(),
	        	status: $(".queryWarrant_u .qstatus").combobox('getValue'),  
	            startDate: $(".queryWarrant_u .qstartDate").datetimebox('getValue'),  
	            endDate: $(".queryWarrant_u .qendDate").datetimebox('getValue')
	        });  
	}  

	//重置
	var clearQuery_U = function() {
		$(".queryWarrant_u .qId").val("");
		$(".queryWarrant_u .qborrower").val("");
		$(".queryWarrant_u .qstatus").combobox('clear');
		$(".queryWarrant_u .qstartDate").datetimebox('clear');
		$(".queryWarrant_u .qendDate").datetimebox('clear');
	}

	//取消按钮
	var clearForm_U = function(d) {
		if(d == 1) {
			$('#mwarrantForm_u').form('clear');
//			$("#mrfw").window("close");
		} else {
			$('#warrantForm_u').form('clear');
//			$("#rfw").window("close");
		}
	}

	$(function() {
		WarrantU.init();
		
		Common.verifyBlur("mwarrantForm_u");
		Common.verifyBlur("warrantForm_u");
		
		$("#warw_u .normLimit").on('blur', function() {
			var _this = this;
			var limit = $(_this).val();
			if(!isNaN(limit)){
			}else{
				$(_this).next("span").html("<font style='color:red'>额度必须为数字</font>");
				return false;
			}
		});
		
		$("#mwarw_u .mnormLimit").on('blur', function() {
			var _this = this;
			var limit = $(_this).val();
			if(!isNaN(limit)){
			}else{
				$(_this).next("span").html("<font style='color:red'>额度必须为数字</font>");
				return false;
			}
		});
});