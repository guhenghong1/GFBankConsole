var SendFile = {
	_this : this,
	params : {
		fileId:"",
		keyWords:"",
		deptId:""
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
	               {field: 'deptName', title: '单位', align:'center', width: 100},
	               {field: 'fileNo', title: '字号', align:'center', width: 200},
	               {field: 'fileTitle', title: '发文标题', align:'center', width: 200},
	               {field: 'keyWords', title: '文关键词', width: 100},
	               {field: 'author', title: '拟稿人', align:'center', width: 100},
	               {field: 'checkAuthor', title: '核查人', align:'center', width: 100},
	               {field: 'signAuthor', title: '签发人', align:'center', width: 100},
	               {field: 'secretLevel', title: '保密级别', align:'center', width: 100},
	               {field: 'updateDateStr', title: '修改时间', align:'center', width: 120},	
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
		$("#sfw").window("open");
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
				var data = JSON.parse(data);
				if(!!data.obj) {
					var file = data.obj;
					$("#mfileIds").val(file.fileId);
					$("#mdeptNames").val(file.deptName);
					$("#mfileNos").val(file.fileNo);
					$("#mfileTitles").val(file.fileTitle);
					$("#mkeyWordss").val(file.keyWords);
					$("#mauthors").val(file.author);
					$("#mcheckAuthors").val(file.checkAuthor);
					$("#msignAuthors").val(file.signAuthor);
					$("#msecretLevels").val(file.secretLevel);
//					$("#mattachment").val(file.attachment);
					$('#mcreateDates').datetimebox('setValue', file.createDateStr);
					
					$('#mdeptIds').combotree('setValue', file.deptId);
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
				var data = JSON.parse(data);
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
				var url = "../file/download.do?filePath="+filePath;
				window.open(url);
			}
		});
	}
}

// 添加文件
var addFile = function() {
	var isNull = Common.verify("sendFileForm");
	if(isNull) {
		return false;
	}
    $('#sendFileForm').form('submit',{
    	 onSubmit:function(){
//             return $(this).form('enableValidation').form('validate');
         },
    	   success:function(data){
    		    data = JSON.parse(data);
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
	var isNull = Common.verify();
	if(isNull) {
		return false;
	}
	$('#msendFileForm').form('submit',{
		success:function(data){
			data = JSON.parse(data);
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
        	fileId: $("#qFileId").val(),  
        	keyWords: $("#qkeyWords").val(),  
            deptId: $("#qdeptId").combobox('getValue')  
        });  
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

$(function() {
	SendFile.init();
	
});