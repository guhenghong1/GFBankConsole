/*
 * Copyright (c) 2014. 广州互动生活网络科技有限公司.All Rights Reserved.
 */

/**
 * 广告位说明Js
 * Created by ylh on 14-6-16.
 */
var gardenId;
var desc = {
    init: function () {
        var _this = this;
        var nowDate = new Date();
        Do("jquery-plugin", function () {
            gardenId = $.getUrlParam("gid");
            $("#preview_date").datebox({
                onSelect: function (date) {
                    _this.initSlider(date);
                }
            }).datebox("setValue", $.toCNString(nowDate).substring(0, 10));
        });
        _this.initSlider(nowDate);
        $("#publish_ad_btn").click(function () {
            schedule.newSchedule();
            schedule.data.isPublish = true; // 设置为直接发布广告模式
        });
    },
    preview: function (date) {
        this.setAdDefault(); // 将广告位的广告设置重置
        $.ajax({
            type: 'post',
            url: '/proxy/api/ad/getGardenAdValues',
            data: {
                gardenId: gardenId, date: date
            },
            success: function (json) {
                var jsonArray = json.rows;
                for (var i = 0; i < jsonArray.length; i++) {
                    var ad = jsonArray[i];
                    var position = ad.POSITION;
                    $("#ad_" + position + "_url").attr("href", ad.URL);
                    $("#ad_" + position + "_address").attr("src", ad.ADDRESS);
                }
            }
        });
    },
    initSlider: function (date) {
        var _this = this;
        var day = date.getDate();
        var yearMonth = $.toCNString(date).substring(0, 8); // '2014-06-'
        var monthDays = _this.getDays(date);
        var rule = [yearMonth + "01", '|', yearMonth + "10", '|', yearMonth + "20", '|', yearMonth + monthDays];
        $("#date_slider").slider({
            min: 1,
            max: monthDays,
            rule: rule,
            onChange: function (newValue, oldValue) {
                var viewDate;
                if (newValue < 10) {
                    viewDate = yearMonth + "0" + newValue;
                } else {
                    viewDate = yearMonth + newValue;
                }
                _this.preview(viewDate); // 预览广告
                $("#preview_date").datebox("setValue", viewDate);
            }}).slider("setValue", day);
    },
    getDays: function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        if (m === 2) {
            return y % 4 === 0 ? 29 : 28;
        } else if (m === 1 || m === 3 || m === 5 || m === 7 || m === 8 || m === 10 || m === 12) {
            return 31;
        } else {
            return 30;
        }
    },
    setAdDefault: function () { // 广告重置
        var defaultImg = "/images/image200.jpg";
        $(".location-desc").find(".sidebar").find("a").each(function () {
            $(this).attr("href", "");
        }).find("img").each(function () {
            $(this).attr("src", defaultImg);
        });
    }
};
$(function () {
    desc.init();
});