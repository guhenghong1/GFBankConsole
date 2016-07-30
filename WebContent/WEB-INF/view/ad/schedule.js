/*
 * Copyright (c) 2014. 广州互动生活网络科技有限公司.All Rights Reserved.
 */

/**
 * 广告日程JS
 *
 * Created by ylh on 14-6-10.
 * 广告投放时间单位：天
 * 若要更改投放时间单位，则需修改web端时间粒度（精确到小时、分钟或秒），将需要的精度时间传给Java服务端
 * Java服务端中，AdResource.java中修改所有的时间“投放时间拓展”处代码，
 * 使投放时间拓展到相应精度，并修改查询广告日程方法中的投放时间精度。
 */
var gardenId;
var schedule = {
   data: {
      isPublish: false // 添加广告日程模式
   },
   init: function() {
      this.data.isPublish = false;
      this.initEvent();
      Do("jquery-plugin", function() {
         gardenId = $.getUrlParam("gid");
         $("#edit_schedule_targetId").val(gardenId); // 设置目标小区Id
      });
      this.initScheduleDatagrid();
   },
   initEvent: function() {
      var _this = this;
      $("#add_schedule").click(function() {
         _this.newSchedule();
      });
      $("#update_schedule").click(function() {
         _this.editSchedule();
      });
      $("#schedule_info_submit").unbind("click").click(function() {
         _this.saveSchedule(_this.data.isPublish);
      });
      $("#search_schedule").click(function() {
         _this.searchSchedule();
      });
      $("#reset_search_schedule_key").click(function() {
         $("#search_position").combobox('setText', '所有').combobox('setValue', '');
         $("#search_status").combobox('setText', '所有').combobox('setValue', '');
         $("#search_startDate").datebox("setValue", "");
         $("#search_endDate").datebox("setValue", "");
         _this.searchSchedule();
      });
   },
   initScheduleDatagrid:function(){
      $('#ad_schedule').datagrid({
            url:"/proxy/api/ad/getGardenSchedules",
            queryParams: {
               gardenId: gardenId
            },
            title:"广告投放日程列表",
            toolbar:"#schedule_toolbar",
            pagination:true,
            idField:"ID",
            pageSize:10,
            rownumbers:true,
            fitColumns:true,
            singleSelect:true,
            columns:[[
                  {field:"ID",title:"编号",width:50},
                  {field:"MATERIALID",hidden:true,title:"物料编号"},
                  {field:"LOCATIONID",hideen:true,title:"位置编号"},
                  {field:"NAME",width:50,title:"物料名称"},
                  {field:"POSITION",width:50,title:"位置编码"},
                  {field:"STARTDATE",width:50,title:"投放开始时间"},
                  {field:"ENDDATE",width:50,title:"投放结束时间"},
                  {field:"COST",width:50,title:"广告费用"},
                  {field:"CREATEDATE",width:150,title:"创建时间"},
                  {field:"UPDATEDATE",width:150,title:"修改时间"},
                  {field: "ISOVER",title:"投放结束", width: 100, formatter:
                             function(value,row,index) {
                                var now = new Date();
                                var date = row["ENDDATE"].split("-");
                                var endate = new Date(date[0],date[1]-1,date[2]);
                                //转换时间格式，只对比年月日，不比较钟点时间。
                                now = new Date(now.toLocaleDateString()).getTime();
                                endate = new Date(endate.toLocaleDateString()).getTime();
//                                console.log(now+"---"+endate);
                                if(now>endate){
                                   return '<font style="color:red">是</font>';
                                }else{
                                   return '否';
                                }
                             }
                  }
               ]]
         });
   },
   scheduleIsOver: function(value, row, index) {
      alert(row['ENDDATE']);
   },
   newSchedule: function() {
      $('#edit_schedule').dialog('open').dialog('setTitle', '添加投放日程');
      $('#edit_schedule_fm').form('clear');
      $("#edit_schedule_position").combobox('enable').combobox('setText', 'R1').combobox('setValue', 'R1');
      $("#edit_schedule_startdate").combobox('enable');
      $("#edit_schedule_targetId").val(gardenId);
      Ad.data.url = '/proxy/api/ad/addGardenAdSchedule';
   },
   saveSchedule: function(isPublish) {
      Do("constant", function() {
         $("#edit_schedule_position").combobox('enable'); // 开启位置可用
         $("#edit_schedule_startdate").combobox('enable'); // 开启开始时间
         $('#edit_schedule_fm').form('submit', {
            url: Ad.data.url,
            onSubmit: function() {
               return $(this).form('validate');
            },
            success: function(json) {
               json = eval('(' + json + ')');
               if (json.result === constant.SYSCODE.SUCCESS) {
                  $('#edit_schedule').dialog('close'); // close the dialog
                  if (isPublish) {
                     $.messager.show({
                        title: '添加结果',
                        msg: json.msg
                     });
                  } else {
                     $('#ad_schedule').datagrid('reload'); // reload the user data
                     $.messager.show({
                        title: '修改结果',
                        msg: json.msg
                     });
                  }
               } else {
                  $("#edit_schedule_position").combobox('disable'); // 关闭位置可用
                  var nowDate = new Date();
                  var startDateArr = $("#edit_schedule_startdate").combo('getValue').split("-");
                  var startDate = new Date(startDateArr[0], startDateArr[1] - 1, startDateArr[2]);
                  if (nowDate.getTime() >= startDate.getTime()) { // 关闭开始时间可用
                     $("#edit_schedule_startdate").combobox('disable');
                  }
                  $.messager.show({
                     title: '保存结果',
                     msg: constant.messages.save_fail
                  });
               }
            }
         });
      });
   },
   editSchedule: function() {
      var row = $('#ad_schedule').datagrid('getSelected');
      if (row) {
         var nowDate = new Date();
         var startDateArr = row.STARTDATE.split("-");
         var endDateArr = row.ENDDATE.split("-");
         var startDate = new Date(startDateArr[0], startDateArr[1] - 1, startDateArr[2]);
         var endDate = new Date(endDateArr[0], endDateArr[1] - 1, endDateArr[2]);
         //结束日期+1天，目的是为了使用户可以修改最后一天的广告
         endDate = new Date(endDate.getFullYear(), endDate.getMonth(), endDate.getDate() + 1);
         if (nowDate.getTime() >= endDate.getTime()) {
            $.messager.show({
               title: '提示',
               msg: "该条广告已经投放完毕，不能修改！"
            });
         } else {
            $('#edit_schedule').dialog('open').dialog('setTitle', '修改广告物料');
            $('#edit_schedule_fm').form('load', row);
            if (nowDate.getTime() >= startDate.getTime()) {
               $("#edit_schedule_startdate").combobox('disable');
               $.messager.show({
                  title: '提示',
                  msg: "该条广告已经开始投放，不能修改开始时间！"
               });
            } else {
               $("#edit_schedule_startdate").combobox('enable');
            }
            $("#edit_schedule_position").combobox('disable');
            $("#edit_schedule_materialId").val(row.MATERIALID);
            Ad.data.url = '/proxy/api/ad/updateGardenAdSchedule';
         }
      } else {
         $.messager.show({
            title: '提示',
            msg: "请选择一条投放日程信息！"
         });
      }
   },
   searchSchedule: function() {
      var position = $("#search_position").combo('getValue');
      var status = $("#search_status").combo('getValue');
      var startDate = $("#search_startDate").combo('getValue');
      var endDate = $("#search_endDate").combo('getValue');
      var url = "/proxy/api/ad/searchGardenSchedules";
      $("#ad_schedule").datagrid({
         queryParams: {
            gardenId: gardenId,
            position: position,
            status: status,
            startDate: startDate,
            endDate: endDate
         },
         url: url
      });
   }
};
$(function() {
   schedule.init();
});