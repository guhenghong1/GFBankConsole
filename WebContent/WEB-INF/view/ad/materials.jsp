<%--
  ~ Copyright (c) 2014. 广州互动生活网络科技有限公司.All Rights Reserved.
  --%>

<%--
    Document   : ad materials
    Created on : May 28, 2014, 10:06:01 AM
    Author     : ylh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div class="ad ad-materials">
    <div class="materials-list-table">
        <table id="ad_materials" toolbar="#materials_toolbar" pagination="true" idField="id"
               url="/proxy/api/ad/getMaterialsImg" pageSize="10"
               title="广告物料清单" class="easyui-datagrid" rownumbers="true" fitColumns="true" singleSelect="true">
            <thead>
            <tr>
                <th field="ID" width="30">编号</th>
                <th field="CLIENTID" hidden="true" width="10">客户编号</th>
                <th field="NAME" width="60">物料名称</th>
                <th field="URL" width="60">链接地址</th>
                <th field="ADDRESS" width="60">图片地址</th>
                <th field="HEIGHT" width="30">高（像素）</th>
                <th field="WIDTH" width="30">宽（像素）</th>
                <th field="TYPE" width="20">类型</th>
                <th field="REMARK" width="60">图片备注</th>
                <th field="CREATEDATE" width="50">创建时间</th>
                <th field="UPDATEDATE" width="50">修改时间</th>
                <th field="CONTACT" width="50">所属客户联系人</th>
                <th field="COMPANY" width="50">所属客户公司名称</th>
            </tr>
            </thead>
        </table>
    </div>
    <div id="materials_toolbar">
        <a id="add_materials" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"
           plain="true">添加广告图片物料</a>
        <a id="update_materials" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改广告图片物料</a>
        <%--<a id="delete_materials" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除广告图片物料</a>--%>
         <span class="search-client">
        物料名称：<input id="search_materials_name_key" placeholder="物料名称关键字"/>
        联系人：<input id="search_materials_contact_key" placeholder="联系人关键字"/>
        公司名称：<input id="search_materials_company_key" placeholder="公司名称关键字"/>
        </span>
        <a id="search_materials" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
           plain="true">查找</a>
        <a id="reset_search_materials_key" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload"
           plain="true">重置</a>
    </div>
</div>
<script type="text/javascript" src="/ad/materials.js"></script>