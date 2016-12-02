var WarrantUs = {
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
		      $('#warrantUs').datagrid({
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
			$('#warrantForm_us').form('clear');
			Common.clearSpanMsg("warrantForm_us");
			$("#warw_us").window("open");
			$("#warw_us").window("refresh");
		},

		// 编辑弹窗
		edit : function(m) {
			var limit = $('#mwarw_us .mstatus').combobox('getValue');
			console.log(isNaN(limit));
			if(!isNaN(limit)){
				console.log(isNaN(limit));
			}
			if(m == 0) {
				$("#mwarw_us .operate").css("display", "none");
			} else {
				$("#mwarw_us .operate").css("display", "");
			}
			var _this = this;
			var row = $("#warrantUs").datagrid("getSelected");
			if(!row) {
				Common.showMsg("请选择一条记录！");
				return false;
			}
			Common.clearSpanMsg("mwarrantForm_us");
			
			var limit = $("#mwarw_us .mnormLimit").val();
			if(!isNaN(limit)){
			}else{
				$("#mwarw_us .mnormLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
				return false;
			}
			
			var id = row.id
			$.ajax({
				url : "../warrant/getWarrantInfo.do",
				data : {
					"id" : id
				},
				success : function(data) {
					//var data = JSON.parse(data);
					data = eval('('+data+')');
					if(!!data.obj) {
						var warrant = data.obj;
						$("#mwarw_us .mid").val(warrant.id);
						$("#mwarw_us .mborrower").val(warrant.borrower);
						$("#mwarw_us .mnormLimit").val(warrant.normLimit);
						$("#mwarw_us .mpropertyOwner").val(warrant.propertyOwner);
						$('#mwarw_us .mtype').combobox('setValue', warrant.type);
						$('#mwarw_us .mstatus').combobox('setValue', warrant.status);
						$('#mwarw_us .mcardId').combobox('setText', warrant.cardName);
						$('#mwarw_us .mdeptId').combobox('setText', warrant.deptName);
						$('#mwarw_us .mremark').combobox('setText', warrant.remarkName);
//						$('#mwarw .mcardId').combobox('setValue', warrant.cardId);
//						$('#mwarw .mdeptId').combobox('setValue', warrant.deptId);
//						$('#mwarw .mremark').combobox('setValue', warrant.remark);
					}
				}
			});
			$("#mwarw_us").window("open");
		},
		
		//删除
		deleteOp : function() {
			var _this = this;
			var row = $("#warrantUs").datagrid("getSelected");
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
						$("#warrantUs").datagrid("reload");
					} else {
						Common.showMsg("删除失败");
					}
				}
			});
		},
		
		//打印申请表
		printApply : function() {
			var _this = this;
			var row = $("#warrantUs").datagrid("getSelected");
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
			var row = $("#warrantUs").datagrid("getSelected");
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
		var limit = $("#warw_us .normLimit").val();
		if(!isNaN(limit)){
		}else{
			$("#warw_us .normLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
			return false;
		}
		
		var isNull = Common.verify("warw_us");
		console.log("isNull   "+isNull);
		if(isNull) {
			//return false;
		}
		
		
		var deptName = $("#warw_us .deptId").combobox("getText");
		$("#warw_us .deptName").val(deptName);
		
		var cardName = $("#warw_us .cardId").combobox("getText");
		$("#warw_us .cardName").val(cardName);
		
		var remarkName = $("#warw_us .remark").combobox("getText");
		$("#warw_us .remarkName").val(remarkName);
	    $('#warrantForm_us').form('submit',{
	    	   success:function(data){
	    		   console.log(data);
	    		   data = eval('('+data+')');
	    		    if(data.code == 1) {
	    		    	Common.showMsg("添加成功");
	    		    	$("#warw_us").window("close");
	    		    	$("#warrantUs").datagrid("reload");
	    		    	$('#warw_us .cardId').combobox('reload'); 
	    		    	$('#warw_us .deptId').combobox('reload'); 
	    		    	$('#warw_us .remark').combobox('reload'); 
	    		    } else {
	    		    	Common.showMsg("添加失败");
	    		    }
	    	    }
	    });
	}

	// 添加文件
	var updateWarrant_Us = function() {
		var limit = $("#mwarw_us .mnormLimit").val();
		if(!isNaN(limit)){
		}else{
			$("#mwarw_us .mnormLimit").next("span").html("<font style='color:red'>额度必须为数字</font>");
			return false;
		}
		
		var status = $("#mwarw_us .stauts").combobox("getValue");
		
		var isNull = Common.verify("mwarrantForm_us");
		console.log("isNull   "+isNull);
		if(isNull) {
			//return false;
		}
		var deptName = $("#mwarw_us .mdeptId").combobox("getText");
		$("#mwarw_us .mdeptName").val(deptName);
		
		var cardName = $("#mwarw_us .mcardId").combobox("getText");
		$("#mwarw_us .mcardName").val(cardName);
		
		var remarkName = $("#mwarw_us .mremark").combobox("getText");
		$("#mwarw_us .mremarkName").val(remarkName);
		$('#mwarrantForm_us').form('submit',{
			success:function(data){
				data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("修改成功");
					$("#mwarw_us").window("close");
					$("#warrantUs").datagrid("reload");
			    	$('#mwarw_us .cardId').combobox('reload'); 
			    	$('#mwarw_us .deptId').combobox('reload'); 
			    	$('#mwarw_us .remark').combobox('reload'); 
				} else {
					Common.showMsg("修改失败");
				}
			}
		});
	}

	//查询
	var queryWarrant_Us = function() {
	        $('#warrantUs').datagrid('load', {  
	        	id: $(".queryWarrant_us .qId").val(),
	        	borrower: $(".queryWarrant_us .qborrower").val(),
	        	status: $(".queryWarrant_us .qstatus").combobox('getValue'),  
	            startDate: $(".queryWarrant_us .qstartDate").datetimebox('getValue'),  
	            endDate: $(".queryWarrant_us .qendDate").datetimebox('getValue')
	        });  
	}  

	//重置
	var clearQuery_Us = function() {
		$(".queryWarrant_us .qId").val("");
		$(".queryWarrant_us .qborrower").val("");
		$(".queryWarrant_us .qstatus").combobox('clear');
		$(".queryWarrant_us .qstartDate").datetimebox('clear');
		$(".queryWarrant_us .qendDate").datetimebox('clear');
	}

	//取消按钮
	var clearForm_Us = function(d) {
		if(d == 1) {
			$('#mwarrantForm_us').form('clear');
//			$("#mrfw").window("close");
		} else {
			$('#warrantForm_us').form('clear');
//			$("#rfw").window("close");
		}
	}

	$(function() {
		WarrantUs.init();
		
		Common.verifyBlur("mwarrantForm_us");
		Common.verifyBlur("warrantForm_us");
		
		$("#warw_us .normLimit").on('blur', function() {
			var _this = this;
			var limit = $(_this).val();
			if(!isNaN(limit)){
			}else{
				$(_this).next("span").html("<font style='color:red'>额度必须为数字</font>");
				return false;
			}
		});
		
		$("#mwarw_us.mnormLimit").on('blur', function() {
			var _this = this;
			var limit = $(_this).val();
			if(!isNaN(limit)){
			}else{
				$(_this).next("span").html("<font style='color:red'>额度必须为数字</font>");
				return false;
			}
		});
		
		$('#mwarw_us .mstatus').combobox({
			onChange: function(newValue,oldValue){
				var _this = this;
				if(newValue < oldValue) {
					console.log(oldValue);
					$(_this).combobox('reload');
					$(_this).combobox('select', '1');
//					$('#mwarw_us .mstatus').combobox('setValue', '1');
//					Common.showMsg("权证状态修改不符！");
				}
			}
		});
		
});