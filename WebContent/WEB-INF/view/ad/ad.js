/*
 * Copyright (c) 2014. 广州互动生活网络科技有限公司.All Rights Reserved.
 */

/**
 * 广告模块初始化js
 * Created by ylh on 14-6-4.
 */
Do.add("constant", {
   path: "/proxy/www/js/global/constant.js",
   type: "js"
});
var gardenId;
var material_img = new Image();
var defaultImage = "/images/image200.jpg";
var Ad = {
   data: {
      url: "", uploader_url: $("#hidden-uploader-url").val()
   },
   init: function() {
      $('#ad-sub-menu').tabs({
         border: false,
         href: "/ad/desc.jsp",
         onSelect: function(title) {
         }
      });
      Do("jquery-plugin", function() {
         gardenId = $.getUrlParam("gid");
      });
      this.initEvent();
      this.customValidate();
      this.initUploadify();
   },
   initEvent: function() {
      var _this = this;
      $("#add_client_btn").click(function() {
         _this.addClientWithAddMaterials();
      });
      $("#select_client_btn").click(function() {
         _this.selectClient();
      });
      $("#search_client").click(function() {
         _this.searchClient();
      });
      $("#reset_search_key").click(function() {
         $("#contact_key").val("");
         $("#company_key").val("");
         _this.searchClient();
      });
      $("#select_client_ok").click(function() {
         _this.selectClientOk();
      });
      $('#select_client_list').datagrid({
         onDblClickCell: function(index, field, value) {
            _this.selectClientOk();
         }
      });
      $("#select_materials_btn").click(function() {
         _this.selectMaterials();
      });
      $("#edit_schedule_materials").focus(function() {
         _this.selectMaterials();
      });
      $("#add_materials_btn").click(function() {
         _this.addMaterialsWithAddSchedule();
      });
      $("#search_materials").click(function() {
         _this.searchMaterials();
      });
      $("#reset_search_materials_key").click(function() {
         $("#name_key").val("");
         $("#materials_contact_key").val("");
         $("#materials_company_key").val("");
         _this.searchMaterials();
      });
      $("#select_materials_ok").click(function() {
         _this.selectMaterialsOk();
      });
      $('#select_materials_list').datagrid({
         onDblClickCell: function(index, field, value) {
            // 广告物料地址、图片预览事件
            if (field === "URL") {
               window.open(value, "_blank");
            } else if (field === "ADDRESS") {
               var row = $("#select_materials_list").datagrid('getSelected');
               $("#img_preview").attr("src", value).attr("width", row.WIDTH).attr("height", row.HEIGHT);
               $("#materials_img_preview").dialog('open').dialog('setTitle', '物料图片预览');
            } else {
               _this.selectMaterialsOk();
            }
         }
      });
   },
   customValidate: function() {
      Do("constant", function() {
         $.extend($.fn.validatebox.defaults.rules, {
            startdateIsValid: {
               validator: function(value, param) {
                  var result = false;
                  var nowDate = new Date();
                  var startDateArr = value.split("-");
                  var startDate = new Date(startDateArr[0], startDateArr[1] - 1, startDateArr[2]);
                  if (startDate <= nowDate && (startDate.toLocaleDateString() !== nowDate.toLocaleDateString())) {
                     if ($("#edit_schedule_id").val().length !== 0) { // 表示修改
                        result = true;
                     } else {
                        $.messager.show({
                           title: '提示',
                           msg: "开始时间必须在当前时间之后！"
                        });
                     }
                  } else {
                     var id = $("#edit_schedule_id").val(); // 用于修改日程时进行校验
                     var position = $(param[0]).combo('getValue');
                     $.ajax({
                        async: false,
                        type: 'post',
                        url: '/proxy/api/ad/startdateIsValid',
                        data: {
                           id: id, targetId: gardenId, position: position, startdate: value
                        },
                        success: function(json) {
                           result = json;
                        }
                     });
                  }
                  return result;
               },
               message: '开始时间已有广告安排！'
            },
            scheduleIsValid: {
               validator: function(value, param) {
                  var id = $("#edit_schedule_id").val();
                  var position = $(param[0]).combo('getValue');
                  var startdate = $(param[1]).combo('getValue');
                  var result = false;
                  if (startdate) {
                     var startDateArr = startdate.split("-");
                     var endDateArr = value.split("-");
                     var startDate = new Date(startDateArr[0], startDateArr[1] - 1, startDateArr[2]);
                     var endDate = new Date(endDateArr[0], endDateArr[1] - 1, endDateArr[2]);
                     /*
                      * 检查广告安排时间是否大于代理小区的时间
                      */
                     var endDate2 = new Date(endDateArr[0], endDateArr[1]-1, endDateArr[2]);//用户设置的结束时间
                     //代理结束时间
                     var agentEndDate = $("#hidden-enddate").val().split("-");
                     agentEndDate = new Date(agentEndDate[0], agentEndDate[1]-1, agentEndDate[2].split(" ")[0]);
                     if (endDate2 > agentEndDate){
                        $.messager.show({
                           title:'提示',
                           msg:'广告结束时间不能大于小区代理结束时间'
                        });
                        return;
                     }
                     if (startDate <= endDate) {
                        $.ajax({
                           async: false,
                           type: 'post',
                           url: '/proxy/api/ad/scheduleIsValid',
                           data: {
                              id: id, targetId: gardenId, position: position, startdate: startdate, enddate: value
                           },
                           success: function(json) {
                              result = json;
                           }
                        });
                     } else {
                        $.messager.show({
                           title: '提示',
                           msg: "结束时间必须在开始时间之前！"
                        });
                     }
                  } else {
                     $.messager.show({
                        title: '提示',
                        msg: "请选择开始时间！"
                     });
                  }
                  return result;
               },
               message: '广告时间安排与已安排的广告日程有冲突！'
            },
            phoneNo: {
               validator: function(value, param) {
                  return (constant.regex.mobile.test(value) || constant.regex.phone.test(value));
               },
               message: '请输入正确的联系电话，如有区号请使用“-”隔开！'
            },
            materialImgNameIsValid: {
               validator: function(value, param) {
                  var result = false;
                  var id = $(param[0]).val();
                  var clientId = $(param[1]).val();
                  if (clientId.length === 0) { // 没有选客户
                     $.messager.show({
                        title: '提示',
                        msg: "请选择广告物料所属客户！"
                     });
                  } else {
                     $.ajax({
                        async: false,
                        type: 'post',
                        url: '/proxy/api/ad/materialImgNameIsValid',
                        data: {
                           id: id, clientId: clientId, name: value
                        },
                        success: function(json) {
                           result = json;
                        }
                     });
                  }
                  return result;
               },
               message: '该客户下已有同名的物料，请使用另外的名称！'
            }
         });
      });
   },
   initUploadify: function() {
      var _this = this;
      Do("uploadify", function() {
         $("#uploadify").uploadify({
            "swf": "/proxy/www/widget/uploadify-3.2/uploadify.swf",
            uploader: _this.data.uploader_url,
            "buttonImage": "/proxy/www/widget/uploadify-3.2/upload.png",
            "fileObjName": "Filedata",
            "queueID": "fileQueue",
            "queueSizeLimit": 5,
            "auto": true,
            "multi": false,
            "height": 28,
            "width": 78,
            "fileSizeLimit": "0",
            "fileTypeExts": "*.png;*.gif;*.jpg;*.bmp;*.jpeg",
            "fileTypeDesc": "图片文件(*.png;*.gif;*.jpg;*.bmp;*.jpeg)",
            "formData": {
               type: "image"
            },
            onInit: function() {
            },
            onUploadSuccess: function(file, data, response) {
               $("#materials_img").attr("src", data + "?890");
               var address = data.substr(data.lastIndexOf("/upload/"));
               $("#new_materials_img").val(address);
               material_img.src = data;
               $("#new_materials_type").val(data.substr(data.lastIndexOf(".") + 1));
            }
         });
      });
   },
   addClientWithAddMaterials: function() { // 添加物料时添加客户
      var _this = this;
      $('#new_client').dialog('open').dialog('setTitle', '添加广告客户');
      $('#new_client_fm').form('clear');
      _this.data.url = '/proxy/api/ad/addClient';
      $("#client_info_submit").unbind("click").click(function() {
         _this.submitClientWithAddMaterials();
      });
   },
   submitClientWithAddMaterials: function() { // 添加物料时提交客户信息
      var _this = this;
      var new_client_contact = $("#new_client_contact").val();
      var new_client_company = $("#new_client_company").val();
      Do("constant", function() {
         $('#new_client_fm').form('submit', {
            url: _this.data.url,
            onSubmit: function() {
               return $(this).form('validate');
            },
            success: function(json) {
               json = eval('(' + json + ')');
               if (json.result === constant.SYSCODE.SUCCESS) {
                  $('#new_client').dialog('close'); // close the dialog
                  $("#new_materials_clientid").val(json.msg);
                  $("#new_materials_client").val(new_client_company + "  " + new_client_contact).validatebox("validate");
                  $("#new_materials_name").validatebox("validate");
                  _this.data.url = '/proxy/api/ad/addMaterialImg';
               } else {
                  $.messager.show({
                     title: '保存结果',
                     msg: constant.messages.save_fail
                  });
               }
            }
         });
      });
   },
   selectClient: function() {
      $('#select_client_dialog').dialog('open').dialog('setTitle', '选择客户');
      $("#select_client_list").datagrid("reload");
   },
   searchClient: function() {
      var contactKey = $.trim($("#contact_key").val());
      var companyKey = $.trim($("#company_key").val());
      var url = "/proxy/api/ad/searchClients";
      $("#select_client_list").datagrid({
         queryParams: {
            contactKey: contactKey,
            companyKey: companyKey
         },
         url: url
      });
   },
   selectClientOk: function() {
      var row = $('#select_client_list').datagrid('getSelected');
      if (row) {
         $("#new_materials_clientid").val(row.ID);
         $("#new_materials_client").val(row.COMPANY + "  " + row.CONTACT).validatebox("validate");
         $("#new_materials_name").validatebox("validate");
         $('#select_client_dialog').dialog('close');
      }
   },
   selectMaterials: function() {
      $('#select_materials_dialog').dialog('open').dialog('setTitle', '选择广告物料');
      $("#select_materials_list").datagrid("reload");
   },
   searchMaterials: function() {
      var nameKey = $.trim($("#name_key").val());
      var contactKey = $.trim($("#materials_contact_key").val());
      var companyKey = $.trim($("#materials_company_key").val());
      var url = "/proxy/api/ad/searchMaterialsImg";
      $("#select_materials_list").datagrid({
         queryParams: {
            nameKey: nameKey,
            contactKey: contactKey,
            companyKey: companyKey
         },
         url: url
      });
   },
   selectMaterialsOk: function() {
      var row = $('#select_materials_list').datagrid('getSelected');
      if (row) {
         $("#edit_schedule_materials").val(row.NAME).validatebox("validate");
         $("#edit_schedule_materialId").val(row.ID);
         $('#select_materials_dialog').dialog('close');
      }
   },
   addMaterialsWithAddSchedule: function() { // 添加广告日程时添加图片物料
      var _this = this;
      $("#new_materials_client").unbind("focus").focus(function() {
         _this.selectClient();
      });
      $('#new_materials').dialog('open').dialog('setTitle', '添加广告物料');
      $('#new_materials_fm').form('clear');
      _this.data.url = '/proxy/api/ad/addMaterialImg';
      $("#materials_img").attr("src", defaultImage);
      $("#select_clent_div").show();
      $("#materials_img_submit").unbind("click").click(function() {
         _this.submitMaterialsWithAddSchedule();
      });
   },
   submitMaterialsWithAddSchedule: function() { // 添加广告日程时提交图片物料信息
      var _this = this;
      Do("constant", function() {
         var materials_form = $('#new_materials_fm');
         $("#new_materials_height").val(material_img.height);
         $("#new_materials_width").val(material_img.width);
         var materialsImg = $("#materials_img");
         if (materialsImg.attr("src") === defaultImage) {
            $.messager.show({
               title: '提示',
               msg: "请上传物料图片！"
            });
         } else if ($("#new_materials_clientid").val() === "") {
            $.messager.show({
               title: '提示',
               msg: "请选择所属客户！"
            });
         } else {
            var materials_name = $("#new_materials_name").val();
            materials_form.form('submit', {
               url: _this.data.url,
               onSubmit: function() {
                  return $(this).form('validate');
               },
               success: function(json) {
                  json = eval('(' + json + ')');
                  if (json.result === constant.SYSCODE.SUCCESS) {
                     $('#new_materials').dialog('close'); // close the dialog
                     materialsImg.attr("src", defaultImage);
                     $("#edit_schedule_materials").val(materials_name).validatebox("validate");
                     $("#edit_schedule_materialId").val(json.msg);
                     _this.data.url = '/proxy/api/ad/addGardenAdSchedule';
                  } else {
                     $.messager.show({
                        title: '保存结果',
                        msg: constant.messages.save_fail
                     });
                  }
               }
            });
         }
      });
   }
};
$(function() {
   Ad.init();
});
