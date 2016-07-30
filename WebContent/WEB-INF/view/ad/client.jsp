<%--
  ~ Copyright (c) 2014. 广州互动生活网络科技有限公司.All Rights Reserved.
  --%>

<%--
    Document   : ad client
    Created on : May 28, 2014, 10:06:01 AM
    Author     : ylh
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div class="ad ad-client">
    <div class="client-list-table">
        <table id="ad_clients" toolbar="#client_toolbar" pagination="true" idField="id"
               url="/proxy/api/ad/getClients" pageSize="10"
               title="我的广告客户" class="easyui-datagrid" rownumbers="true" fitColumns="true" singleSelect="true">
            <thead>
            <tr>
                <th field="ID" width="40">编号</th>
                <th field="CONTACT" width="50">联系人</th>
                <th field="COMPANY" width="100">公司名称</th>
                <th field="MOBILE" width="50">联系电话</th>
                <th field="EMAIL" width="50">邮箱地址</th>
                <th field="REMARK" width="50">备注</th>
                <th field="CREATEDATE" width="40">创建时间</th>
                <th field="UPDATEDATE" width="40">修改时间</th>
            </tr>
            </thead>
        </table>
    </div>
    <div id="client_toolbar">
        <a id="add_client" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"
           plain="true">添加客户信息</a>
        <a id="update_client" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改客户信息</a>
        <%--<a id="delete_client" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除客户信息</a>--%>
        <span class="search-client">
        联系人：<input id="contact_key" placeholder="联系人关键字"/>
        公司名称：<input id="company_key" placeholder="公司名称关键字"/>
        </span>
        <a id="search_client" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
           plain="true">查找</a>
        <a id="reset_search_key" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload"
           plain="true">重置</a>
    </div>
</div>
<script type="text/javascript" src="/ad/client.js"></script>