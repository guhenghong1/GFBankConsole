var Customer = {
	params : {
		id:"",
		name:""
	},
   init: function() {
      this.initDg();
   },
   /**
    * 初始化客户列表
    * @returns {undefined}
    */
   initDg: function() {
      var _this = this;
      $('#tb_customers').datagrid({
         fitColumns: true,
         pagination: true,
         singleSelect: true,
         pageSize: 10,
         width: 1000,
		 height: 350,
		 rownumbers:"true",
		 queryParams:_this.params,
         url: '../customer/getCustomerList.do',
         columns: [[
               {field: 'id', title: '客户编号', width: 100},
               {field: 'name', title: '客户名称', width: 100},
               {field: 'birthdayStr', title: '客户生日', width: 100},
               {field: 'grade', title: '客户等级', width: 100, 
            	   formatter:function(value){
                    	if(value == '1'){
                    		return "1级";
                    	}else if(value == '2'){
                    		return "2级";
                    	}else if(value == '3'){
                    		return "3级";
                    	}else if(value == '4'){
                    		return "4级";
                    	}else if(value == '5'){
                    		return "5级";
                    	}else if(value == '6'){
                    		return "6级";
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
    * 获取客户详细信息
    * @param {type} row 当前用户信息(json）
    * @returns {undefined}
    */
   getDetail: function(row) {
      var _this = this;
      var temp = $("#customerDetail-template").html();
      Do("mustache", function() {
         if (row.ISPASSED == 1)
            row['ISPASSED'] = '通过';
         else
            row['ISPASSED'] = '不通过';
         //每次打开前，清空customerDetail
         $("#customerDetail").html("");
         //先把信息添加到customerDetail中，然后再显示用户信息
         $("#customerDetail").append(Mustache.to_html(temp, row));
         $('#customerInfo').show();
      });
     
      $("#customerInfo").dialog({
         title: '客户信息',
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
                  $("#customerInfo").window('close');
               }
            }]
      });
   },
   
   showMsg: function(msg) {
   	   $.messager.alert('提示', msg);
   },
   
   //编辑用户弹窗
   edit:function() {
   	var _this = this;
   	$("#add").css("display", "none");
   	$("#update").css("display", "");
   	var row = $("#tb_customers").datagrid("getSelected");
   	var id = row.id;
   	var role = row.role;
   	if(role == 2) {
   		_this.showMsg('权限不够');
   		return;
   	}
   	console.log(row.id);
	$.ajax({
		url:"../customer/getCustomerInfo.do",
		data:{"id":id},
		success: function(data) {
			var customer = eval('('+data+')');
			$("#id").val(customer.id);
			$("#manager").val(customer.manager);
			$("#name").val(customer.name);
			$("#type").val(customer.type);
			$("#grade").val(customer.grade);
			$("#cardNo").val(customer.cardNo);
			$("#account").val(customer.account);
			$("#birthdayStr").datebox("setValue", customer.birthdayStr);
			$("#hobby").val(customer.hobby);
			$("#contact").val(customer.contact);
			$("#remark").val(customer.remark);
		}
	});
   	$("#cuw").window("open");
   },
   
   //修改用户
   update: function() {
   		var _this = this;
		var id = $("#id").val();
		var manager = $("#manager").val();
		var name = $("#name").val();
		var type = $("#type").val();
		var grade = $("#grade").val();
		var cardNo = $("#cardNo").val();
		var account = $("#account").val();
		var birthdayStr = $("#birthdayStr").datebox("getValue");
		var hobby = $("#hobby").val();
		var contact = $("#contact").val();
		var remark = $("#remark").val();
		
		if(id == "" || id == null){
			alert("客户编号不能为空");
			return false;
		}
		if(manager == "" || manager == null){
			alert("客户经理不能为空");
			return false;
		}
		if(name == "" || name == null){
			alert("客户名称不能为空");
			return false;
		}
		
		var params = {
			"id" : id,
			"manager" : manager,
			"name" : name,
			"type" : type,
			"grade" : grade,
			"cardNo" : cardNo,
			"account" : account,
			"birthdayStr" : birthdayStr,
			"hobby" : hobby,
			"contact" : contact,
			"remark" : remark
		};
		$.ajax({
			url: "../customer/updateCustomer.do",
			data: params,
			type:"post",
			success: function(data) {
				var result = eval('('+data+')');
				if(result.code == 1) {
					_this.showMsg("修改成功");
				} else {
					_this.showMsg("修改失败");
				}
				
				$("#cuw").window("close");
				$("#tb_customers").datagrid("reload");
			}
		}); 	
   },
   
   //新增用户弹窗
   add: function() {
   		var _this = this;
   		$('#cuForm').form('clear');
   		$("#tb_customers").datagrid("unselectAll");
   		$("#add").css("display", "");
   		$("#update").css("display", "none");
   		$("#cuw").window("open");
   },
   
   //新增用户
   addCustomer: function() {
   		var _this = this;
   		var id = $("#id").val();
		var manager = $("#manager").val();
		var name = $("#name").val();
		var type = $("#type").val();
		var grade = $("#grade").val();
		var cardNo = $("#cardNo").val();
		var account = $("#account").val();
		var birthdayStr = $("#birthdayStr").datebox("getValue");
		var hobby = $("#hobby").val();
		var contact = $("#contact").val();
		var remark = $("#remark").val();
		
		if(id == "" || id == null){
			alert("客户编号不能为空");
			return false;
		}
		if(manager == "" || manager == null){
			alert("客户经理不能为空");
			return false;
		}
		if(name == "" || name == null){
			alert("客户名称不能为空");
			return false;
		}
		
		var params = {
			"id" : id,
			"manager" : manager,
			"name" : name,
			"type" : type,
			"grade" : grade,
			"cardNo" : cardNo,
			"account" : account,
			"birthdayStr" : birthdayStr,
			"hobby" : hobby,
			"contact" : contact,
			"remark" : remark
		};
		$.ajax({
			url: "../customer/addCustomer.do",
			data: params,
			type:"post",
			success: function(data) {
				result = eval('('+data+')');
				if(result.code == 1) {
					_this.showMsg("添加成功");
				} else {
					_this.showMsg("添加失败");
				}
				
				$("#cuw").window("close");
				$("#tb_customers").datagrid("reload");
			}
		}); 	
   },
   
   //删除用户  
   deleteCustomer : function() {
   		var _this = this;
   		var row = $("#tb_customers").datagrid("getSelected");
   		var id = row.id;
   		$("#cuw").window("close");
   		var role = row.role;
   		if(role == 2) {
   			_this.showMsg('权限不够');
   			return;
   		}
   		$.ajax({
   			url:"../customer/deleteCustomer.do",
   			data:{"id":id},
   			type:"post",
   			success:function(data) {
   				result = eval('('+data+')');
				if(result.code == 1) {
					_this.showMsg("删除成功");
				} else {
					_this.showMsg("删除失败");
				}
				$("#tb_customers").datagrid("reload");
   			}
   		});
   }
}

//查询
var queryCustomer = function() {
        $('#tb_customers').datagrid('load', {  
        	id: $("#qid").val(),  
        	name: $("#qname").val()
        });  
} 

$(function() {
	Customer.init();
});