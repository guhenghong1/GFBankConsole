var Learn = {
	_this : this,
	params : {
		id:"",
		title:"",
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
	      $('#learn').datagrid({
	         fitColumns: true,
	         pagination: true,
	         singleSelect: true,
	         selectOnCheck: false,
	         pageSize: 10,
	         width: 1100,
			 height:400,
			 rownumbers:"true",
			 queryParams:_this.params,
	         url: '../learn/getLearnList.do',
	         columns: [[
	               {field: 'id', title: '编号', align:'center', width: 100},
	               {field: 'title', title: '标题', align:'center', width: 100},
	               {field: 'viewCount', title: '浏览数', align:'center', width: 200},
	               {field: 'remark', title: '备注', align:'center', width: 100},
	               {field: 'createDateStr', title: '创建时间', align:'center', width: 120}	
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
		$('#learnForm').form('clear');
		$("#lw").window("open");
	},

	// 编辑弹窗
	edit : function(m) {
		var _this = this;
		var row = $("#learn").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id
		$.ajax({
			url : "../learn/getLearnInfo.do",
			data : {
				"id" : id
			},
			success : function(data) {
				var data = eval('('+data+')');
				if(!!data.obj) {
					var learn = data.obj;
					$("#mlw .mid").val(learn.id);
					$("#mlw .mtitle").val(learn.title);
					$("#mlw .mviewCount").val(learn.viewCount);
					$("#mlw .mremark").val(learn.remark);
				}
			}
		});
		$("#mlw").window("open");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#learn").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var companyId = row.companyId;
		$.ajax({
			url : "../learn/deleteLearn.do",
			data : {
				"id" : id
			},
			success : function(data) {
				console.log(data)
				var data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#learn").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	},
	//下载
	download : function() {
		var _this = this;
		var row = $("#learn").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id;
		$.ajax({
			url : "../learn/getLearnInfo.do",
			data : {
				"id" : id
			},
			success : function(data) {
				var data = eval('('+data+')');
				var learn = data.obj;
				console.log("data="+learn)
				
				var filePath = learn.attachment;
				//更新流量数
				updateViewCount(learn.id);
				
				var url = "../file/download.do?filePath="+filePath;
				window.open(url);
			}
		});
	}
}

// 添加
var addLearn = function() {
//	var isNull = Common.verify("reclearnForm");
//	console.log("isNull   "+isNull);
//	if(isNull) {
//		return false;
//	}
    $('#learnForm').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		    data = eval('('+data+')');
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#lw").window("close");
    		    	$("#learn").datagrid("reload");
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加
var updateLearn = function() {
	$('#mLearnForm').form('submit',{
		success:function(data){
			data = eval('('+data+')');
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#mlw").window("close");
				$("#learn").datagrid("reload");
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//更新流量数
var updateViewCount = function(id) {
	$.ajax({
		url : "../learn/updateViewCount.do",
		data : {
			"id" : id
		},
//		type:"post",
		success : function(data) {
//			var data = JSON.parse(data);
//			if(data.code == 1) {
//				Common.showMsg("删除成功");
//				$("#learn").datagrid("reload");
//			} else {
//				Common.showMsg("删除失败");
//			}
		}
	});
}
//查询
var queryLearn = function() {
        $('#learn').datagrid('load', {  
        	id: $(".queryLearn .qId").val(),
        	title: $(".queryLearn .qTitle").val(),
            startDate: $(".queryLearn .qstartDate").datetimebox('getValue'),  
            endDate: $(".queryLearn .qendDate").datetimebox('getValue')
        });  
}  

//重置
var clearQuery = function() {
	$(".queryLearn .qId").val("");
	$(".queryLearn .qTitle").val("");
	$(".queryLearn .qstartDate").datetimebox('clear');
	$(".queryLearn .qendDate").datetimebox('clear');
}

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#mLearnForm').form('clear');
		$("#mLearnForm").window("close");
	} else {
		$('#learnForm').form('clear');
		$("#learnForm").window("close");
	}
}

$(function() {
	Learn.init();
	
});