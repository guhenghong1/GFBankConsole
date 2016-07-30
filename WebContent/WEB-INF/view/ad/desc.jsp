<%--
  ~ Copyright (c) 2014. 广州互动生活网络科技有限公司.All Rights Reserved.
  --%>

<%--
  Created by IntelliJ IDEA.
  User: ylh
  Date: 14-6-4
  Time: 上午11:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="ad location-desc">
    <div class="location">
        <div class="desc-title">
            <div class="title">
                <h2>住一起小区网小区模块广告位说明</h2>
            </div>
        </div>
        <div class="desc-content">
            <div class="content">
                <div class="content-top">
                    <div class="gardenInfo">
                        <div class="garden-info"></div>
                        <div class="garden-img">
                            <div class="bg">
                                <a id="ad_M1_url" target="_blank" href="">
                                    <img id="ad_M1_address" src="/proxy/garden/images/ad4.jpg" width="566" height="150">
                                </a>
                            </div>
                            <div class="photo">
                                <img title="小区位置标示" height="150" width="150"
                                     src="http://api.map.baidu.com/staticimage?markers=113.350978,23.141019&center=113.350978,23.141019&zoom=18&width=200&height=200">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sidebar">
                <div class="ad-location R1" title="小区广告位R1">
                    <a id="ad_R1_url" target="_blank" href="">
                        <img id="ad_R1_address" src="/images/image200.jpg" width="150"
                             height="150"/></a>
                </div>
                <div class="ad-location R2" title="小区广告位R2">
                    <a id="ad_R2_url" target="_blank" href="">
                        <img id="ad_R2_address" src="/images/image200.jpg" width="150" height="150"/></a>
                </div>
                <div class="ad-location R3" title="小区广告位R3">
                    <a id="ad_R3_url" target="_blank" href="">
                        <img id="ad_R3_address" src="/images/image200.jpg" width="150" height="150"/></a>
                </div>
                <div class="ad-location R4" title="小区广告位R4">
                    <a id="ad_R4_url" target="_blank" href="">
                        <img id="ad_R4_address" src="/images/image200.jpg" width="150" height="150"/></a>
                </div>
                <div class="ad-location R5" title="小区广告位R5">
                    <a id="ad_R5_url" target="_blank" href="">
                        <img id="ad_R5_address" src="/images/image200.jpg" width="150" height="150"/></a>
                </div>
                <div class="ad-location R6" title="小区广告位R6">
                    <a id="ad_R6_url" target="_blank" href="">
                        <img id="ad_R6_address" src="/images/image200.jpg" width="150" height="150"/></a>
                </div>
            </div>
        </div>
    </div>
    <div class="preview-config">
        <div class="title">
            广告预览
        </div>
        <div class="preview-date">
            时间：<input id="preview_date" class="easyui-datebox" style="width: 150px;"/>
        </div>
        <div class="preview-date-slider">
            <input id="date_slider" class="easyui-slider" style="height:300px"
                   data-options="showTip: true,mode: 'v',reversed: false">
        </div>
        <div class="publish-ad">
            <a id="publish_ad_btn" href="javascript:;" class="btn">投放广告</a>
        </div>
    </div>
</div>
<script type="text/javascript" src="/ad/desc.js"></script>
<script type="text/javascript" src="/ad/schedule.js"></script>