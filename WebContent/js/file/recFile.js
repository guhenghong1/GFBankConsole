var RecFile = {
	_this : this,
	params : {
		fileId:"",
		fileTitle:"",
		keyWords:"",
		deptId:"",
		status:"",
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
	      $('#recFile').datagrid({
	         fitColumns: true,
	         pagination: true,
	         singleSelect: true,
	         selectOnCheck: false,
	         pageSize: 10,
	         width: 1100,
			 height:400,
			 rownumbers:"true",
			 queryParams:_this.params,
	         url: '../recFile/getFileList.do',
	         columns: [[
//	               {field: 'ck', checkbox: true, align:'center', width: 30},
	               {field: 'fileId', title: '来文编号', align:'center', width: 100},
	               {field: 'fileTitle', title: '发文标题', align:'center', width: 200},
	               {field: 'deptName', title: '来文单位', align:'center', width: 100},
	               {field: 'fileNo', title: '来文字号', align:'center', width: 200},
	               {field: 'keyWords', title: '来文文关键词', align:'center',width: 100},
	               {field: 'status', title: '状态', align:'center', width: 100},
//	               {field: 'secretLevel', title: '来文保密级别', align:'center', width: 100},
//	               {field: 'emgLevel', title: '来文紧急级别', align:'center', width: 100},
	               {field: 'createDateStr', title: '创建时间', align:'center', width: 120},	
//	               {field: 'attachment', title: '操作', align:'center', width: 300},
	            ]],
	         onClickRow: function(index, rowData) {
	         },
	         onLoadSuccess: function() {
	         }
	        
	      });
	   },
	   

		// 查询弹窗
	query : function() {
		$('#qrecFileForm').form('clear');
		$("#qrfw").window("open");
	},
	// 新增弹窗
	add : function() {
		$('#recFileForm').form('clear');
		Common.clearSpanMsg("recFileForm");
		$("#rfw").window("open");
		$("#rfw").window("refresh");
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
		Common.clearSpanMsg("mrecFile");
		var _this = this;
		var row = $("#recFile").datagrid("getSelected");
//		console.log(row);
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var fileId = row.fileId
		$.ajax({
			url : "../recFile/getFileInfo.do",
			data : {
				"fileId" : fileId
			},
			success : function(data) {
				var data = eval('('+data+')');
				if(!!data.obj) {
					var file = data.obj;
					$("#mrfw .mfileId").val(file.fileId);
					$("#mrfw .mdeptName").val(file.deptName);
					$("#mrfw .mfileNo").val(file.fileNo);
					$("#mrfw .mfileTitle").val(file.fileTitle);
					$("#mrfw .mkeyWords").val(file.keyWords);
					$("#mrfw .mstatus").val(file.status);
					$("#mrfw .msecretLevel").val(file.secretLevel);
					$("#mrfw .memgLevel").val(file.emgLevel);
//					$("#mattachment").val(file.attachment);
					$('#mrfw .mcreateDate').datetimebox('setValue', file.createDateStr);
					
					$('#mrfw .mdeptId').combotree('setValue', file.deptId);
//					var deptIdArr = [];
//					var deptIdStr = file.deptId;
//					for(var i = 0; i< deptIdStr.split(","); i++) {
//						deptIdArr.push(deptIdStr[i]);
//					}
//					$('#mdeptId').combotree('setValues', deptIdArr);
				}
			}
		});
		$("#mrfw").window("open");
		$("#mrfw").window("refresh");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#recFile").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var fileId = row.fileId;
		$.ajax({
			url : "../recFile/deleteFile.do",
			data : {
				"fileId" : fileId
			},
			success : function(data) {
				console.log(data)
				var data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#recFile").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	},
	
	//打印
	print : function() {
		var _this = this;
		var row = $("#recFile").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.fileId;
		window.open("../common/view.jsp?id="+id+"&type=file_handling");
	},
	
	//下载
	download : function() {
		var _this = this;
		var row = $("#recFile").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var fileId = row.fileId;
		$.ajax({
			url : "../recFile/findFile.do",
			data : {
				"fileId" : fileId
			},
			success : function(data) {
				console.log(data)
				var filePath = data;
				if(!filePath) {
					Common.showMsg("附件为空");
					return false;
				}
				var url = "../file/download.do?filePath="+filePath;
				window.open(url);
			}
		});
	}
}

// 添加文件
var addFile = function() {
	var isNull = Common.verify("recFileForm");
	console.log("isNull   "+isNull);
	if(isNull) {
		//return false;
	}
    $('#recFileForm').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		    data = eval('('+data+')');
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#rfw").window("close");
    		    	$("#recFile").datagrid("reload");
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateFile = function() {
	var isNull = Common.verify("mrecFileForm");
	console.log("isNull   "+isNull);
	if(isNull) {
		//return false;
	}
	$('#mrecFileForm').form('submit',{
		success:function(data){
			data = eval('('+data+')');
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#mrfw").window("close");
				$("#recFile").datagrid("reload");
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//查询
var queryFile = function() {
        $('#recFile').datagrid('load', {  
        	fileId: $(".queryRecFile .qFileId").val(),  
        	fileTitle: $(".queryRecFile .qFileTitle").val(),  
        	keyWords: $(".queryRecFile .qkeyWords").val(),  
        	status: $(".queryRecFile .qstatus").combobox('getValue'),  
            deptId: $(".queryRecFile .qdeptId").combobox('getValue'),  
            startDate: $(".queryRecFile .qstartDate").datetimebox('getValue'),  
            endDate: $(".queryRecFile .qendDate").datetimebox('getValue')
        });  
}  

//重置
var clearQuery = function() {
	$(".queryRecFile .qFileId").val("");
	$(".queryRecFile .qFileTitle").val("");
	$(".queryRecFile .qkeyWords").val("");
	$(".queryRecFile .qstatus").combobox('clear');
	$(".queryRecFile .qdeptId").combobox('clear');
	$(".queryRecFile .qstartDate").datetimebox('clear');
	$(".queryRecFile .qendDate").datetimebox('clear');
}

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#mrecFileForm').form('clear');
//		$("#mrfw").window("close");
	} else {
		$('#recFileForm').form('clear');
//		$("#rfw").window("close");
	}
}

var verifyBlurInput = function() {
	$('#mrecFileForm').on('blur','.required',function(){
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
	
	$('#recFileForm').on('blur','.required',function(){
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
	RecFile.init();
	
	verifyBlurInput();
});