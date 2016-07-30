<%-- 
    Document   : ad
    Created on : May 28, 2014, 10:06:01 AM
    Author     : xiangfei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div class="ad ad-schedule">
    <div class="client-list-table">
       <!--广告投放数据列表-->
        <table id="ad_schedule">
        </table>
    </div>
    <div id="schedule_toolbar">
        <a id="add_schedule" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"
           plain="true">添加投放日程</a>
        <a id="update_schedule" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改投放日程</a>
        <%--<a id="delete_client" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除投放日程/a>--%>
        <span class="search-client">
            位置：
        <select id="search_position" class="easyui-combobox" editable="false" panelHeight="auto">
        <option value="">所有</option>
            <option value="R1">R1</option>
            <option value="R2">R2</option>
            <option value="R3">R3</option>
            <option value="R4">R4</option>
            <option value="R5">R5</option>
            <option value="R6">R6</option>
        </select>    状态：
            <select id="search_status" class="easyui-combobox" editable="false" panelHeight="auto">
            <option value="all">所有</option>
            <option value="before">已投放</option>
            <option value="running">正在投放</option>
            <option value="after">未投放</option>
        </select>
        开始时间： <input id="search_startDate" class="easyui-datebox">
        结束时间： <input id="search_endDate" class="easyui-datebox">
        </span>
        <a id="search_schedule" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
           plain="true">查找</a>
        <a id="reset_search_schedule_key" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload"
           plain="true">重置</a>
    </div>
</div>
<script type="text/javascript" src="/ad/schedule.js"></script>