
var material_img = new Image();
var defaultImage = "/images/image200.jpg";
var materials = {
    init: function () {
        this.initEvent();
        $("#ad_materials").datagrid({
            onDblClickCell: function (index, field, value) {  // 广告物料地址、图片预览事件
                if (field === "URL") {
                    window.open(value, "_blank");
                } else if (field === "ADDRESS") {
                    var row = $("#ad_materials").datagrid('getSelected');
                    $("#img_preview").attr("src", value).attr("width", row.WIDTH).attr("height", row.HEIGHT);
                    $("#materials_img_preview").dialog('open').dialog('setTitle', '物料图片预览');
                }
            }
        });
    },
    initEvent: function () {
        var _this = this;
        $("#add_materials").click(function () {
            _this.newMaterials();
        });
        $("#update_materials").click(function () {
            _this.editMaterials();
        });
        $("#materials_img_submit").unbind("click").click(function () {
            _this.saveMaterials();
        });
        $("#search_materials").click(function () {
            _this.searchMaterials();
        });
        $("#reset_search_materials_key").click(function () {
            $("#search_materials_name_key").val("");
            $("#search_materials_contact_key").val("");
            $("#search_materials_company_key").val("");
            _this.searchMaterials();
        });
    },
    newMaterials: function () {
        var _this = this;
        $("#new_materials_client").unbind("focus").focus(function () {
            _this.selectClient();
        });
        $('#new_materials').dialog('open').dialog('setTitle', '添加广告物料');
        $('#new_materials_fm').form('clear');
        Ad.data.url = '/proxy/api/ad/addMaterialImg';
        $("#materials_img").attr("src", defaultImage);
        $("#select_clent_div").show();
    },
    saveMaterials: function () {
        Do("constant", function () {
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
                materials_form.form('submit', {
                    url: Ad.data.url,
                    onSubmit: function () {
                        return $(this).form('validate');
                    },
                    success: function (json) {
                        json = eval('(' + json + ')');
                        if (json.result === constant.SYSCODE.SUCCESS) {
                            $('#new_materials').dialog('close'); // close the dialog
                            $('#ad_materials').datagrid('reload'); // reload the user data
                            materialsImg.attr("src", defaultImage);
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
    },
    editMaterials: function () {
        var row = $('#ad_materials').datagrid('getSelected');
        if (row) {
            $("#new_materials_client").unbind("focus").val(row.COMPANY + "  " + row.CONTACT);
            $('#new_materials').dialog('open').dialog('setTitle', '修改广告物料');
            $.messager.show({
                title: '提示',
                msg: "修改物料，不能更改客户信息！"
            });
            $('#new_materials_fm').form('load', row);
            $("#materials_img").attr("src", row.ADDRESS + "?80");
            $("#new_materials_clientid").val(row.CLIENTID);
            $("#select_clent_div").hide();
            Ad.data.url = '/proxy/api/ad/updateMaterialImg';
        } else {
            $.messager.show({
                title: '提示',
                msg: "请选择一条物料信息！"
            });
        }
    },
    searchMaterials: function () {
        var nameKey = $.trim($("#search_materials_name_key").val());
        var contactKey = $.trim($("#search_materials_contact_key").val());
        var companyKey = $.trim($("#search_materials_company_key").val());
        var url = "/proxy/api/ad/searchMaterialsImg";
        $("#ad_materials").datagrid({
            queryParams: {
                nameKey: nameKey,
                contactKey: contactKey,
                companyKey: companyKey
            },
            url: url
        });
    }
};
$(function () {
    materials.init();
});