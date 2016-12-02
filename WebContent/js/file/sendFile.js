var SendFile = {
	_this : this,
	params : {
		fileId:"",
		fileTitle:"",
		keyWords:"",
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
	      $('#sendFile').datagrid({
	         fitColumns: true,
	         pagination: true,
	         singleSelect: true,
	         selectOnCheck: false,
	         pageSize: 10,
	         width: 1100,
			 height:400,
			 rownumbers:"true",
			 queryParams:_this.params,
	         url: '../sendFile/getFileList.do',
	         columns: [[
//	               {field: 'ck', checkbox: true, align:'center', width: 30},
	               {field: 'fileId', title: '编号', align:'center', width: 100},
	               {field: 'deptId', title: '单位', align:'center', width: 100},
	               {field: 'fileNo', title: '字号', align:'center', width: 200},
	               {field: 'fileTitle', title: '发文标题', align:'center', width: 200},
	               {field: 'keyWords', title: '文关键词', width: 100},
	               {field: 'author', title: '拟稿人', align:'center', width: 100},
	               {field: 'checkAuthor', title: '核查人', align:'center', width: 100},
	               {field: 'signAuthor', title: '签发人', align:'center', width: 100},
//	               {field: 'secretLevel', title: '保密级别', align:'center', width: 100},
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
		$('#qsendFileForm').form('clear');
		$("#qsfw").window("open");
	},
	// 新增弹窗
	add : function() {
		$('#sendFileForm').form('clear');
		Common.clearSpanMsg("sendFileForm");
		$("#sfw").window("open");
		$("#sfw").window("refresh");
	},

	// 编辑弹窗
	edit : function(m) {
		if(m == 1) { //详情
			$("#msfw .operate").css("display", "");
		} else {
			$("#msfw .operate").css("display", "none");
		}
		Common.clearSpanMsg("msendFileForm");
		var _this = this;
		var row = $("#sendFile").datagrid("getSelected");
//		console.log(row);
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var fileId = row.fileId
		$.ajax({
			url : "../sendFile/getFileInfo.do",
			data : {
				"fileId" : fileId
			},
			success : function(data) {
				var data = eval('('+data+')');
				if(!!data.obj) {
					var file = data.obj;
					$("#msfw .mfileId").val(file.fileId);
					$("#msfw .mdeptName").val(file.deptName);
					$("#msfw .mfileNo").val(file.fileNo);
					$("#msfw .mfileTitle").val(file.fileTitle);
					$("#msfw .mkeyWords").val(file.keyWords);
					$("#msfw .mauthor").val(file.author);
					$("#msfw .mcheckAuthor").val(file.checkAuthor);
					$("#msfw .msignAuthor").val(file.signAuthor);
					$("#msfw .msecretLevel").val(file.secretLevel);
//					$("#mattachment").val(file.attachment);
					$('#msfw .mcreateDate').datetimebox('setValue', file.createDateStr);
					$("#msfw .mdeptId").val(file.deptId);
//					$('#mdeptIds').combotree('setValue', file.deptId);
//					var deptIdArr = [];
//					var deptIdStr = file.deptId;
//					deptIdArr = deptIdStr.split(",");
////					for(var i = 0; i< deptIdStr.split(",").length; i++) {
////						deptIdArr.push(deptIdStr[i]);
////					}
//					$('#mdeptId').combotree('setValues', deptIdArr);
				}
			}
		});
		$("#msfw").window("open");
		$("#msfw").window("refresh");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#sendFile").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var fileId = row.fileId;
		$.ajax({
			url : "../sendFile/deleteFile.do",
			data : {
				"fileId" : fileId
			},
			success : function(data) {
				console.log(data)
				var data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#sendFile").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	},
	
	//下载
	download : function() {
		var _this = this;
		var row = $("#sendFile").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var fileId = row.fileId;
		$.ajax({
			url : "../sendFile/findFile.do",
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
	var isNull = Common.verify("sendFileForm");
	console.log("isNull== "+isNull);
	if(isNull) {
		//return false;
	}
    $('#sendFileForm').form('submit',{
    	 onSubmit:function(){
//             return $(this).form('enableValidation').form('validate');
         },
    	   success:function(data){
    		    data = eval('('+data+')');
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#sfw").window("close");
    		    	$("#sendFile").datagrid("reload");
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateFile = function() {
	var isNull = Common.verify("msendFileForm");
	console.log("isNull== "+isNull);
	if(isNull) {
		//return false;
	}
	$('#msendFileForm').form('submit',{
		success:function(data){
			data = eval('('+data+')');
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#msfw").window("close");
				$("#sendFile").datagrid("reload");
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//查询
var queryFile = function() {
        $('#sendFile').datagrid('load', {  
        	fileId: $(".querySendFile .qFileId").val(),  
        	fileTitle: $(".querySendFile .qFileTitle").val(),  
        	keyWords: $(".querySendFile .qkeyWords").val(),  
            startDate: $(".querySendFile .qstartDate").datetimebox('getValue'),  
            endDate: $(".querySendFile .qendDate").datetimebox('getValue')
        });  
}  

//重置
var clearQuery = function() {
	$(".querySendFile .qFileId").val("");
	$(".querySendFile .qFileTitle").val("");
	$(".querySendFile .qkeyWords").val("");
	$(".querySendFile .qstartDate").datetimebox('clear');
	$(".querySendFile .qendDate").datetimebox('clear');
}

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#msendFileForm').form('clear');
//		$("#msfw").window("close");
	} else {
		$('#sendFileForm').form('clear');
//		$("#sfw").window("close");
	}
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
	SendFile.init();
	
	verifyBlurInput();
});