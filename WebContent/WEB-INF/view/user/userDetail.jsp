<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="userInfo" style="display:none;">
    <div id="userDetail" style="font-size: 14px; margin: 20px 20px 20px 20px"></div>
</div>
<script id="userDetail-template" type="text/template">
    <table id="tb_user_info">
    <tr>
    <td colspan="4" style="text-align:center"><img src="{{HEADPHOTO}}" height="100" width="100" title="{{NICKNAME}}的头像"/></td>
    </tr>
    <tr>
    <th>名称</th>
    <td><input type="text" value="{{NICKNAME}}" readonly="true"></td>
    <th>Email</th>
    <td><input type="text" value="{{EMAIL}}" readonly="true"></td>
    </tr>
    <tr>
    <th>全名</th>
    <td><input type="text" value="{{FULLNAME}}" readonly="true"></td>
    <th>所在小区</th>
    <td><input type="text" value="{{GARDENNAME}}" readonly="true"></td>
    </tr>
    <tr>
    <th>ID</th>
    <td><input type="text" value="{{USERID}}" readonly="true"></td>
    <th>家家号</th>
    <td><input type="text" value="{{JIAID}}" readonly="true"></td>
    </tr>
    <tr>
    <th style="width:200px">状态</th>
    <td><input type="text" value="{{ISPASSED}}" readonly="true"></td>
    <th style="width:200px">加入日期</th>
    <td><input type="text" value="{{JOINDATE}}" readonly="true"></td>
    </tr>
    </table>
</script>