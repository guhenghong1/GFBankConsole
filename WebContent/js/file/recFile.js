var RecFile = {
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
	               {field: 'deptName', title: '来文单位', align:'center', width: 100},
	               {field: 'fileNo', title: '来文字号', align:'center', width: 200},
	               {field: 'fileTitle', title: '发文标题', align:'center', width: 200},
	               {field: 'keyWords', title: '来文文关键词', width: 100},
	               {field: 'status', title: '状态', align:'center', width: 100},
	               {field: 'secretLevel', title: '来文保密级别', align:'center', width: 100},
	               {field: 'emgLevel', title: '来文紧急级别', align:'center', width: 100},
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
		$('#qrecFileForm').form('clear');
		$("#qrfw").window("open");
	},
	// 新增弹窗
	add : function() {
		$('#recFileForm').form('clear');
		$("#rfw").window("open");
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
				var data = JSON.parse(data);
				if(!!data.obj) {
					var file = data.obj;
					$("#mfileId").val(file.fileId);
					$("#mdeptName").val(file.deptName);
					$("#mfileNo").val(file.fileNo);
					$("#mfileTitle").val(file.fileTitle);
					$("#mkeyWords").val(file.keyWords);
					$("#mstatus").val(file.status);
					$("#msecretLevel").val(file.secretLevel);
					$("#memgLevel").val(file.emgLevel);
//					$("#mattachment").val(file.attachment);
					$('#mcreateDate').datetimebox('setValue', file.createDateStr);
					
					$('#mdeptId').combotree('setValue', file.deptId);
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
				var data = JSON.parse(data);
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#recFile").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
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
				var url = "../file/download.do?filePath="+filePath;
				window.open(url);
			}
		});
	}
}

// 添加文件
var addFile = function() {
//	var isNull = Common.verify("recFileForm");
//	console.log("isNull   "+isNull);
//	if(isNull) {
//		return false;
//	}
    $('#recFileForm').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		    data = JSON.parse(data);
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
	$('#mrecFileForm').form('submit',{
		success:function(data){
			data = JSON.parse(data);
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
        	fileId: $("#qFileId").val(),  
        	keyWords: $("#qkeyWords").val(),  
            deptId: $("#qdeptId").combobox('getValue')  
        });  
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

$(function() {
	RecFile.init();
	
});