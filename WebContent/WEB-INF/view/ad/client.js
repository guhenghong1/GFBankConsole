/*
 * Copyright (c) 2014. 广州互动生活网络科技有限公司.All Rights Reserved.
 */

/**
 * Created by ylh on 14-6-4.
 */
var client = {
    init: function () {
        this.initEvent();
    },
    initEvent: function () {
        var _this = this;
        $("#add_client").click(function () {
            _this.newClient();
        });
        $("#update_client").click(function () {
            _this.editClient();
        });
        $("#client_info_submit").unbind("click").click(function () {
            _this.saveClient();
        });
        $("#search_client").click(function () {
            _this.searchClient();
        });
        $("#reset_search_key").click(function () {
            $("#contact_key").val("");
            $("#company_key").val("");
            _this.searchClient();
        });
    },
    newClient: function () {
        $('#new_client').dialog('open').dialog('setTitle', '添加广告客户');
        $('#new_client_fm').form('clear');
        Ad.data.url = '/proxy/api/ad/addClient';
    },
    saveClient: function () {
        Do("constant", function () {
            $('#new_client_fm').form('submit', {
                url: Ad.data.url,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (json) {
                    json = eval('(' + json + ')');
                    if (json.result === constant.SYSCODE.SUCCESS) {
                        $('#new_client').dialog('close'); // close the dialog
                        $('#ad_clients').datagrid('reload'); // reload the user data
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
    editClient: function () {
        var row = $('#ad_clients').datagrid('getSelected');
        if (row) {
            $('#new_client').dialog('open').dialog('setTitle', '修改广告客户');
            $('#new_client_fm').form('load', row);
            Ad.data.url = '/proxy/api/ad/updateClient';
        } else {
            $.messager.show({
                title: '提示',
                msg: "请选择一条客户信息！"
            });
        }
    },
    searchClient: function () {
        var contactKey = $.trim($("#contact_key").val());
        var companyKey = $.trim($("#company_key").val());
        var url = "/proxy/api/ad/searchClients";
        $("#ad_clients").datagrid({
            queryParams: {
                contactKey: contactKey,
                companyKey: companyKey
            },
            url: url
        });
    }
};
$(function () {
    client.init();
});