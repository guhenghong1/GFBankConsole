//城市加载组件
Do.add("cityCascade", {
   path: "/proxy/www/js/service/jquery.cityCascade.js",
   type: "js"
});
Do.add("uploadify-css", {
   path: "/proxy/www/widget/uploadify-3.2/uploadify.css",
   type: "css"
});
// 上传图片组件
Do.add("uploadify", {
   path: "/proxy/www/widget/uploadify-3.2/jquery.uploadify.js",
   type: "js",
   requires: ["uploadify-css"]
});
//表单验证组件
Do.add('j-validate', {
   path: "/proxy/www/js/jquery/plugins/jquery.validate.min.js",
   type: "js"
});
/**
 * 区长个人资料设置页面JS
 * @type type
 */
var personalSetting = {
   init: function() {
      var _this = this;
      _this.initUploadify();
      _this.initCity();
      _this.validate();
      $("body").keypress(function(e) {//键盘监听事件
         var keycode = e.which || e.keyCode;
         if (keycode === 13 || keycode === 10) {
            $("#agent_form").submit();
         }
      });
   },
   /**
    * 初始化省市区
    * @returns {undefined}
    */
   initCity: function() {
      var city = $.cityCascade({
         province: "#province",
         city: "#city"
      });
      city.setDefaultCity($("#hid_province").val(), $("#hid_city").val(), $("#hid_county").val());
   },
   /**
    * 初始化图片上传组件
    */
   initUploadify: function() {
      $("#uploader_file_input").html('<input type="file" id="uploader_file" name="Filedata"/>');
      Do("uploadify", function() {
         $("#uploader_file").uploadify({
            "swf": "/proxy/www/widget/uploadify-3.2/uploadify.swf",
            "uploader": $("#hidden-uploader-url").val(),
            "buttonText": "更改头像",
            "fileObjName": "Filedata",
            "auto": true,
            "height": 25,
            "width": 110,
            "fileSizeLimit": "0",
            "fileTypeExts": "*.png;*.gif;*.jpg;*.bmp;*.jpeg",
            "fileTypeDesc": "图片文件",
            "formData": {
               type: "image"
            },
            onUploadSuccess: function(file, data, response) {
               console.log("-- data -->" + data);
               $("#head_img").attr("src", data);
               //截取图片路径 http://www.zhuyiqi.net/upload/2014/07/22/other/696d9294-674b-e771-d8f3-0f70f00d05c9.gif
               var imgUrl = data.substr(data.lastIndexOf("/upload"));
               //设置图片路径到隐藏域
               $("#headphoto").val(imgUrl);
            }
         });
      });
   },
   /**
    * 验证表单
    * @returns {undefined}
    */
   validate: function() {
      var _this = this;
      Do('j-validate', function() {
         //自定义验证方法，验证联系地址
         $.validator.addMethod(
                 "isFullAddress", //方法名
                 function() { //验证逻辑
                    var province = $("#province option:selected").val();
                    var city = $("#city option:selected").val();
                    var county = $("#county option:selected").val();
                    var flag = false;
                    if (province !== "0" &&
                            (province === "9" || province === "1" || province === "22" || province === "2")) {
                       if (city !== "0") {
                          flag = true;
                       }
                    } else {
                       if (province !== "0" && city !== "0" && county !== "0") {
                          flag = true;
                       }
                    }
                    return flag;
                 },
                 " * 请输入正确的联系地址" //提示信息
                 );
         //验证手机号码
         $.validator.addMethod(
                 "isMobile",
                 function(value) {
                    var mobile_reg = /^[1][3-8]+\d{9}$/;
                    return mobile_reg.test(value);
                 },
                 " * 请输入正确的手机号码"
                 );
         $("#agent_form").validate({
            rules: {
               name: 'required',
               mobile: {
                  required: true,
                  isMobile: true
               },
               address: {
                  required: true,
                  isFullAddress: true
               }
            },
            messages: {
               name: " * 请输入昵称",
               mobile: {
                  required: " * 请输入手机号码",
                  isMobile: " * 请输入正确的手机号码"
               },
               address: {
                  required: " * 请输入联系地址",
                  isFullAddress: " * 请输入正确的联系地址"
               }
            },
            submitHandler: function(form) {
               _this.ajaxSubmit();
            }
         });
      });
   },
   /**
    * 异步表单提交
    * @returns {undefined}
    */
   ajaxSubmit: function() {
//      alert($("#agent_form").serialize());
      $.ajax({
         url: "/proxy/api/agent/updateAgentInfo",
         type: "post",
         data: $("#agent_form").serialize(), //获取表单所有数据
         success: function(date) {
            console.log(date);
            alert("修改成功");
            window.location.reload();
         }
      });
   }
};
Do("cityCascade", function() {
   personalSetting.init();
});

