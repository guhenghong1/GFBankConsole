<%-- 
    Document   : ad
    Created on : May 28, 2014, 10:06:01 AM
    Author     : xiangfei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="/css/ad.css">
<div class="ad">
    <div id="ad-sub-menu" class="sub-menu">
        <div class="sub-item selected" title="广告位说明" href="/ad/desc.jsp"></div>
        <div class="sub-item" title="广告投放日程" href="/ad/schedule.jsp"></div>
        <div class="sub-item" title="广告物料" href="/ad/materials.jsp"></div>
        <div class="sub-item" title="广告客户" href="/ad/client.jsp"></div>
    </div>
</div>
<div style="display: none;">
<%--广告客户--%>
<div id="new_client" class="easyui-dialog" style="width:400px;height:360px;padding:10px 20px;"
     closed="true" buttons="#client_dlg-buttons">
    <div class="ftitle">客户信息</div>
    <form id="new_client_fm" method="post" novalidate>
        <div class="fitem">
            <label>联系人：</label>
            <input name="ID" type="hidden"/>
            <input id="new_client_contact" name="CONTACT" class="easyui-validatebox" required="true"/>
        </div>
        <div class="fitem">
            <label>公司名称：</label>
            <input id="new_client_company" name="COMPANY" class="easyui-validatebox"/>
        </div>
        <div class="fitem">
            <label>联系电话：</label>
            <input name="MOBILE" class="easyui-validatebox" required="true" validType="phoneNo"/>
        </div>
        <div class="fitem">
            <label>邮箱地址：</label>
            <input name="EMAIL" class="easyui-validatebox" validType="email"/>
        </div>
        <div class="fitem">
            <label class="uninput">备注：</label>
            <textarea name="REMARK"></textarea>
        </div>
    </form>
</div>
<div id="client_dlg-buttons">
    <a id="client_info_submit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#new_client').dialog('close')">取消</a>
</div>
<%--广告物料--%>
<div id="new_materials" class="easyui-dialog" style="width:600px;height:530px;padding:10px 20px;"
     closed="true" buttons="#materials_dlg-buttons">
    <div class="ftitle">图片物料信息</div>
    <form id="new_materials_fm" method="post" novalidate>
        <input id="new_materials_id" name="ID" type="hidden"/>
        <input id="new_materials_clientid" name="CLIENTID" type="hidden"/>
        <input id="new_materials_height" name="HEIGHT" type="hidden"/>
        <input id="new_materials_width" name="WIDTH" type="hidden"/>
        <input id="new_materials_type" name="TYPE" type="hidden"/>

        <div class="fitem">
            <label>名称：</label>
            <input id="new_materials_name" name="NAME" class="easyui-validatebox" required="true"
                   validType="materialImgNameIsValid['#new_materials_id','#new_materials_clientid']"/>
        </div>
        <div class="fitem">
            <label>链接地址：</label>
            <input name="URL" class="easyui-validatebox" validType="url"/>
        </div>
        <div class="fitem">
            <label class="uninput">物料图片：</label>

            <div style="display: inline-block;">
                <div style="display: inline-block;">
                    <img id="materials_img" width="200" height="200" src="/images/image200.jpg"/>
                </div>
                <div style="display: inline-block;vertical-align: top;">
                    <input id="new_materials_img" name="ADDRESS" type="hidden"/>
                    <input id="uploadify" class="uploadify" name="Filedata" type="file"/>
                </div>
            </div>
        </div>
        <div class="fitem">
            <label>所属客户：</label>
            <input id="new_materials_client" class="easyui-validatebox" required="true" readonly="readonly"/>

            <div id="select_clent_div" style="display: inline-block;">
                <a id="select_client_btn" href="javascript:;" class="btn">选择客户</a>
                <a id="add_client_btn" href="javascript:;" class="btn">添加客户</a>
            </div>
        </div>
        <div class="fitem">
            <label class="uninput">备注：</label>
            <textarea name="REMARK"></textarea>
        </div>
    </form>
</div>
<div id="materials_dlg-buttons">
    <a id="materials_img_submit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#new_materials').dialog('close')">取消</a>
</div>
<div id="select_client_dialog" class="easyui-dialog" style="width:580px;height:500px;padding:10px 20px;"
     closed="true" buttons="#select_client_dlg-buttons">
    <div class="ftitle">选择物料所属客户</div>
    <div class="select_client-list-table">
        <table id="select_client_list" toolbar="#select_client_toolbar" pagination="true" idField="id"
               url="/proxy/api/ad/getClients" pageSize="5"
               title="我的广告客户" class="easyui-datagrid" rownumbers="true" fitColumns="true" singleSelect="true">
            <thead>
            <tr>
                <th field="ID" hidden="true" width="10">编号</th>
                <th field="CONTACT" width="10">联系人</th>
                <th field="COMPANY" width="15">公司名称</th>
            </tr>
            </thead>
        </table>
    </div>
    <div id="select_client_toolbar">
        <span class="search-client">
            联系人：<input id="contact_key" class="width100" placeholder="联系人关键字"/>
            公司名称：<input id="company_key" class="width100" placeholder="公司名称关键字"/>
        </span>
        <a id="search_client" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
           plain="true">查找</a>
        <a id="reset_search_key" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload"
           plain="true">重置</a>
    </div>
</div>
<div id="select_client_dlg-buttons">
    <a id="select_client_ok" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">选择</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#select_client_dialog').dialog('close')">取消</a>
</div>
<div id="materials_img_preview" class="easyui-dialog" style="width:600px;height:400px;padding:10px;" closed="true">
    <img id="img_preview" src=""/>
</div>
<%--广告日程--%>
<div id="edit_schedule" class="easyui-dialog" style="width:480px;height:360px;padding:10px 20px;"
     closed="true" buttons="#schedule_dlg-buttons">
    <div class="ftitle">投放日程信息</div>
    <form id="edit_schedule_fm" method="post" novalidate>
        <div class="fitem">
            <label>位置编码：</label>
            <input id="edit_schedule_id" name="ID" type="hidden"/>
            <input id="edit_schedule_targetId" name="TARGETID" type="hidden"/>
            <input id="edit_schedule_materialId" name="MATERIALID" type="hidden"/>
            <input id="edit_schedule_locationId" name="LOCATIONID" type="hidden"/>
            <select id="edit_schedule_position" name="POSITION" class="easyui-combobox" required="true"
                    editable="false" style="width: 60px;" panelHeight="auto">
            <option value="R1">R1</option>
                <option value="R2">R2</option>
                <option value="R3">R3</option>
                <option value="R4">R4</option>
                <option value="R5">R5</option>
                <option value="R6">R6</option>
            </select>
        </div>
        <div class="fitem">
            <label>开始时间：</label>
            <input id="edit_schedule_startdate" name="STARTDATE" class="easyui-datebox" required="true"
                   validType="startdateIsValid['#edit_schedule_position']">
        </div>
        <div class="fitem">
            <label>结束时间：</label>
            <input id="edit_schedule_enddate" name="ENDDATE" class="easyui-datebox" required="true"
                   validType="scheduleIsValid['#edit_schedule_position','#edit_schedule_startdate']">
        </div>
        <div class="fitem">
            <label>广告内容：</label>
            <input id="edit_schedule_materials" readonly="readonly" name="NAME" class="easyui-validatebox"
                   required="true"/>
            <a id="select_materials_btn" href="javascript:;" class="btn">选择物料</a>
            <a id="add_materials_btn" href="javascript:;" class="btn">添加物料</a>
        </div>
        <div class="fitem">
            <label>广告费用：</label>
            <input name="COST" class="easyui-numberbox"/> 元
        </div>
    </form>
</div>
<div id="schedule_dlg-buttons">
    <a id="schedule_info_submit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#edit_schedule').dialog('close')">取消</a>
</div>
<div id="select_materials_dialog" class="easyui-dialog" style="width:750px;height:500px;padding:10px 20px;"
     closed="true" buttons="#select_materials_dlg-buttons">
    <div class="ftitle">选择广告投放物料</div>
    <div class="select_materials-list-table">
        <table id="select_materials_list" toolbar="#select_materials_toolbar" pagination="true" idField="id"
               url="/proxy/api/ad/getMaterialsImg" pageSize="5"
               title="广告物料清单" class="easyui-datagrid" rownumbers="true" fitColumns="true" singleSelect="true">
            <thead>
            <tr>
                <th field="ID" hidden="true" width="10">编号</th>
                <th field="NAME" width="20">物料名称</th>
                <th field="URL" width="25">链接地址</th>
                <th field="ADDRESS" width="25">图片地址</th>
                <th field="CONTACT" width="10">联系人</th>
                <th field="COMPANY" width="15">公司名称</th>
            </tr>
            </thead>
        </table>
    </div>
    <div id="select_materials_toolbar">
            <span class="search-client">
                物料名称：<input id="name_key" class="width100" placeholder="物料名称关键字"/>
                联系人：<input id="materials_contact_key" class="width100" placeholder="联系人关键字"/>
                公司名称：<input id="materials_company_key" class="width100" placeholder="公司名称关键字"/>
            </span>
        <a id="search_materials" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
           plain="true">查找</a>
        <a id="reset_search_materials_key" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload"
           plain="true">重置</a>
    </div>
</div>
<div id="select_materials_dlg-buttons">
    <a id="select_materials_ok" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok">选择</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#select_materials_dialog').dialog('close')">取消</a>
</div>
</div>
<script type="text/javascript" src="ad/ad.js"></script>