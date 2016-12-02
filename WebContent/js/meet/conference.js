var Conference = {
	_this : this,
	params : {
		id:""
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
	      $('#conference').datagrid({
	         fitColumns: true,
	         pagination: true,
	         singleSelect: true,
	         selectOnCheck: false,
	         pageSize: 10,
	         width: 1100,
			 height:400,
			 rownumbers:"true",
			 queryParams:_this.params,
	         url: '../conference/getConferenceList.do',
	         columns: [[
	               {field: 'id', title: '编号', align:'center', width: 100},
	               {field: 'name', title: '会议名称', align:'center', width: 100},
	               {field: 'timeStr', title: '会议时间', align:'center', width: 200},
	               {field: 'place', title: '会议地点', align:'center', width: 200},
	               {field: 'persons', title: '会议人员', width: 100},
	               {field: 'emphasis', title: '会议要素', align:'center', width: 100},
	               {field: 'content', title: '会议内容', align:'center', width: 100},
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
		$('#conferenceForm').form('clear');
		$("#meetw").window("open");
	},

	// 编辑弹窗
	edit : function(m) {
		if(m != 1) { //详情
			$(".update").css("display", "none");
			$(".cancle").css("display", "none");
		}
		var _this = this;
		var row = $("#conference").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id
		$.ajax({
			url : "../conference/getConferenceInfo.do",
			data : {
				"id" : id
			},
			success : function(data) {
				var data = eval('('+data+')');
				if(!!data.obj) {
					var conference = data.obj;
					$("#mid").val(conference.id);
					$("#mname").val(conference.name);
					$("#mplace").val(conference.place);
					$("#mpersons").val(conference.persons);
					$("#mcontent").val(conference.content);
					$("#mremark").val(conference.remark);
					$("#memphasis").val(conference.emphasis);
					$('#mtime').datetimebox('setValue', conference.timeStr);
				}
			}
		});
		$("#umeetw").window("open");
	},
	
	//删除
	deleteOp : function() {
		var _this = this;
		var row = $("#conference").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
		var id = row.id;
		$.ajax({
			url : "../conference/deleteConference.do",
			data : {
				"id" : id
			},
			success : function(data) {
				console.log(data)
				var data = eval('('+data+')');
				if(data.code == 1) {
					Common.showMsg("删除成功");
					$("#conference").datagrid("reload");
				} else {
					Common.showMsg("删除失败");
				}
			}
		});
	}
}

// 添加文件
var addConference = function() {
//	var isNull = Common.verify("recconferenceForm");
//	console.log("isNull   "+isNull);
//	if(isNull) {
//		return false;
//	}
    $('#conferenceForm').form('submit',{
    	   success:function(data){
    		   console.log(data);
    		    data = eval('('+data+')');
    		    if(data.code == 1) {
    		    	Common.showMsg("添加成功");
    		    	$("#meetw").window("close");
    		    	$("#conference").datagrid("reload");
    		    } else {
    		    	Common.showMsg("添加失败");
    		    }
    	    }
    });
}

// 添加文件
var updateConference = function() {
	$('#mconferenceForm').form('submit',{
		success:function(data){
			data = eval('('+data+')');
			if(data.code == 1) {
				Common.showMsg("修改成功");
				$("#umeetw").window("close");
				$("#conference").datagrid("reload");
			} else {
				Common.showMsg("修改失败");
			}
		}
	});
}

//查询
var queryconference = function() {
        $('#conference').datagrid('load', {  
        	id: $("#qId").val()  
        });  
}  

//取消按钮
var clearForm = function(d) {
	if(d == 1) {
		$('#mConferenceForm').form('clear');
//		$("#mrfw").window("close");
	} else {
		$('#conferenceForm').form('clear');
//		$("#rfw").window("close");
	}
}

$(function() {
	Conference.init();
	
});