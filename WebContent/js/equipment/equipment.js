var Equipment = {
	params : {
		location:"",
		name:"",
		inUse:""
	},
   init: function() {
      this.initDg();
   },
   /**
    * 初始化设备列表
    * @returns {undefined}
    */
   initDg: function() {
      var _this = this;
      $('#tb_equipments').datagrid({
         fitColumns: true,
         pagination: true,
         singleSelect: true,
         pageSize: 10,
         width: 1000,
		 height: 350,
		 rownumbers:"true",
		 queryParams:_this.params,
         url: '../equipment/getEquipmentList.do',
         columns: [[
               {field: 'id', title: '设备编号', width: 100},
               {field: 'name', title: '设备名称', width: 100},
               {field: 'type', title: '设备型号', width: 100},
               {field: 'location', title: '所在地', width: 100},
               {field: 'inUse', title: '状态', width: 100, 
            	   formatter:function(value){
                    	if(value == '1'){
                    		return "在用";
                    	}else if(value == '0'){
                    		return "报废";
                    	} else if(value == '2'){
                    		return "送修";
                    	}
                    }
               }
            ]],
         onClickRow: function(index, rowData) {
         },
         onLoadSuccess: function() {
         }
        
      });
   },
   /**
    * 获取设备详细信息
    * @param {type} row 当前用户信息(json）
    * @returns {undefined}
    */
   getDetail: function(row) {
      var _this = this;
      var temp = $("#equipmentDetail-template").html();
      Do("mustache", function() {
         if (row.ISPASSED == 1)
            row['ISPASSED'] = '通过';
         else
            row['ISPASSED'] = '不通过';
         //每次打开前，清空equipmentDetail
         $("#equipmentDetail").html("");
         //先把信息添加到equipmentDetail中，然后再显示用户信息
         $("#equipmentDetail").append(Mustache.to_html(temp, row));
         $('#equipmentInfo').show();
      });
     
      $("#equipmentInfo").dialog({
         title: '设备信息',
         width: 680,
         height: 350,
         modal: true,
         buttons: [{
               text: "去TA的主页",
               handler:function(){
                  window.open("http://person"+$('#hidden-domain').val()+"/"+row.JIAID); 
               }
         },{
               text: text,
               iconCls: icon,
               handler: function() {
                  if (flg) {
                     //审核用户不通过方法
                     _this.auditNotPassed();
                  } else {
                     //审核用户通过方法
                     _this.auditPassed();
                  }
                  $("#equipmentInfo").window('close');
               }
            }]
      });
   },
   
   showMsg: function(msg) {
   	   $.messager.alert('提示', msg);
   },
   
   //编辑用户弹窗
   edit:function(m) {
	$('#eqForm').form('clear');
	$("#eqw .tr_id").css("display", "");

	if(m == 0) {
		$(".eq .add").css("display", "none");
		$(".eq .update").css("display", "none");
		$(".eq .repair").css("display", "none");
	} else if(m == 2) {
		$(".eq .add").css("display", "none");
		$(".eq .update").css("display", "none");
		$(".eq .repair").css("display", "");
	} else {
		$(".eq .add").css("display", "none");
		$(".eq .repair").css("display", "none");
		$(".eq .update").css("display", "");
	}
   	var _this = this;
   	$("#add").css("display", "none");
   	$("#update").css("display", "");
   	var row = $("#tb_equipments").datagrid("getSelected");
	if(!row) {
		Common.showMsg("请选择一条记录！");
		return false;
	}
   	var id = row.id;
   	//console.log(JSON.stringify(row));
	$.ajax({
		url:"../equipment/getEquipmentInfo.do",
		data:{"id":id},
		success: function(data) {
			var equipment = eval('('+data+')');
			$("#eqw .id").val(equipment.id);
			$("#eqw .name").val(equipment.name);
			$("#eqw .type").val(equipment.type);
			$("#eqw .location").val(equipment.location);
			$("#eqw .inUse").val(equipment.inUse);
			$("#eqw .companyId").combobox("setValue", equipment.companyId);
			$("#eqw .buyTimeStr").datebox("setValue", equipment.buyTimeStr);
			$("#eqw .price").val(equipment.price);
			$("#eqw .remark").val(equipment.remark);
			$("#eqw .deptId").combotree("setValue", equipment.deptId);
		}
	});
   	$("#eqw").window("open");
   },
   
   //修改用户
   update: function() {
   		var _this = this;
		var id = $("#eqw .id").val();
		var name = $("#eqw .name").val();
		var type = $("#eqw .type").val();
		var location = $("#eqw .location").val();
		var inUse = $("#eqw .inUse").val();
		var companyId = $("#eqw .companyId").combobox("getValue");
		var buyTimeStr = $("#eqw .buyTimeStr").datebox("getValue");
		var price = $("#eqw .price").val();
		var remark = $("#eqw .remark").val();
		var deptId = $("#eqw .deptId").combotree("getValue");
		
		if(id == "" || id == null){
			alert("设备编号不能为空");
			return false;
		}
		if(name == "" || name == null){
			alert("设备名称不能为空");
			return false;
		}
		
		var params = {
			"id" : id,
			"name" : name,
			"type" : type,
			"location" : location,
			"inUse" : inUse,
			"companyId" : companyId,
			"buyTimeStr" : buyTimeStr,
			"price" : price,
			"remark" : remark,
			"deptId" : deptId
		};
		$.ajax({
			url: "../equipment/updateEquipment.do",
			data: params,
			type:"post",
			success: function(data) {
				var result = eval('('+data+')');
				if(result.code == 1) {
					_this.showMsg("修改成功");
				} else {
					_this.showMsg("修改失败");
				}
				
				$("#eqw").window("close");
				$("#tb_equipments").datagrid("reload");
			}
		}); 	
   },
   
   //新增用户弹窗
   add: function() {
   		var _this = this;
   		$("#tb_equipments").datagrid("unselectAll");
   		$(".eq .add").css("display", "");
   		$(".eq .update").css("display", "none");
   		$(".eqw .tr_id").css("display", "none");
   		$('#eqForm').form('clear');
   		$("#eqw").window("open");
   },
   
   //新增用户
   addEquipment: function() {
   		var _this = this;
   		var id = $("#eqw .id").val();
		var name = $("#eqw .name").val();
		var type = $("#eqw .type").val();
		var location = $("#eqw .location").val();
		var inUse = $("#eqw .inUse").val();
		var companyId = $("#eqw .companyId").combobox("getValue");
		var buyTimeStr = $("#eqw .buyTimeStr").datebox("getValue");
		var price = $("#eqw .price").val();
		var remark = $("#eqw .remark").val();
		var deptId = $("#eqw .deptId").combotree("getValue");
		
//		if(id == "" || id == null){
//			alert("设备编号不能为空");
//			return false;
//		}
		if(name == "" || name == null){
			alert("设备名称不能为空");
			return false;
		}
		if(type == "" || type == null){
			alert("设备型号不能为空");
			return false;
		}
		if(location == "" || location == null){
			alert("所在地不能为空");
			return false;
		}
		if(buyTimeStr == "" || buyTimeStr == null){
			alert("购入时间不能为空");
			return false;
		}
		if(price == "" || price == null){
			alert("购入价格不能为空");
			return false;
		}
		if(deptId == "" || deptId == null){
			alert("管理部门不能为空");
			return false;
		}
		
		var params = {
			"id" : id,
			"name" : name,
			"type" : type,
			"location" : location,
			"inUse" : inUse,
			"companyId" : companyId,
			"buyTimeStr" : buyTimeStr,
			"price" : price,
			"remark" : remark,
			"deptId" : deptId
		};
		$.ajax({
			url: "../equipment/addEquipment.do",
			data: params,
			type:"post",
			success: function(data) {
				var result = eval('('+data+')');
				if(result.code == 1) {
					_this.showMsg("添加成功");
				} else {
					_this.showMsg("添加失败");
				}
				
				$("#eqw").window("close");
				$("#tb_equipments").datagrid("reload");
			}
		}); 	
   },
   
   //删除用户  
   deleteEquipment : function() {
   		var _this = this;
   		var row = $("#tb_equipments").datagrid("getSelected");
		if(!row) {
			Common.showMsg("请选择一条记录！");
			return false;
		}
   		var id = row.id;
   		$("#eqw").window("close");
   		var role = row.role;
   		if(role == 2) {
   			_this.showMsg('权限不够');
   			return;
   		}
   		$.ajax({
   			url:"../equipment/deleteEquipment.do",
   			data:{"id":id},
   			type:"post",
   			success:function(data) {
   				var result = eval('('+data+')');
				if(result.code == 1) {
					_this.showMsg("删除成功");
				} else {
					_this.showMsg("删除失败");
				}
				$("#tb_equipments").datagrid("reload");
   			}
   		});
   },
   
   //送修
   sendRepair: function() {
	   	var _this = this;
  		var row = $("#tb_equipments").datagrid("getSelected");
  		
  		if(row == null){
  			alert("请选择设备");
  			return false;
  		}

  		var id = row.id;
  		$("#eqw").window("close");
  		
		$.messager.confirm('提示', '是否送修？', function(r){
			if(r){
				$.ajax({
					url: "../equipment/updateEquipment.do",
					data:{"equipmentId":id, "inUse":"2"},
					type:"post",
					success: function(data) {
						var result = eval('('+data+')');
						if(result.code == 1) {
							_this.showMsg("送修成功");
						} else {
							_this.showMsg("送修失败");
						}
						
						$("#eqw").window("close");
						$("#tb_equipments").datagrid("reload");
					}
				});
			}
		});
   }
}

//查询
var queryEquipment = function() {
        $('#tb_equipments').datagrid('load', {  
        	location: $(".queryEquip .qlocation").val(),  
        	name: $(".queryEquip .qname").val(),
        	inUse: $(".queryEquip .qinUse").val()
        });  
} 

//导出
var exportEq = function() {
	var params = {
			location: $(".queryEquip .qlocation").val(),  
        	name: $(".queryEquip .qname").val(),
        	inUse: $(".queryEquip .qinUse").val()
	}
	$.ajax({
		url:"../equipment/createCSV.do",
		data:params,
		success:function(data) {
			var filePath = data;
			var url = "../file/exportFile.do?filePath="+filePath;
			window.open(url);
		}
	});
} 
$(function() {
	Equipment.init();
});