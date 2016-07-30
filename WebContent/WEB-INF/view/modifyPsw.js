/**
 * 
 * 区长修改密码JS
 * @type type
 */
var modifyPsw = {
   init: function() {
      var _this = this;
      _this.safetySet();
      $("body").keypress(function(e) {//键盘监听事件
         var keycode = e.which || e.keyCode;
         if (keycode === 13 || keycode === 10) {
            modifyPsw.midfQzPassword();
         }
      });
   },
   //初始化密码输入框
   safetySet: function() {
      var _this = this;
      _this.initValidate(); // 初始化自定义校验
      $('#old_psw').validatebox({
         missingMessage: "输入正确的原密码",
         required: true,
         validType: 'eqOldPsw'
      });
      $('#new_psw').validatebox({
         missingMessage: "输入新密码，6-16位数字或字母组合",
         required: true,
         validType: 'psw'
      });
      $('#ag_psw').validatebox({
         missingMessage: "确保两次输入密码一致",
         required: true,
         validType: "agPsw['#new_psw']"
      });
      $('#resetPsw_btn').click(function() {
         _this.midfQzPassword();
      });
   },
   /**
    * 表单验证自定义规则
    * @returns {undefined}
    */
   initValidate: function() {
      var reg = /^.{6,16}$/;
      $.extend($.fn.validatebox.defaults.rules, {
         //检查旧密码是否一致
         eqOldPsw: {
            validator: function(value, param) {
               var flg;
               if (value.length > 0 && reg.test(value)) {
                  $.ajax({
                     async: false,
                     type: 'post',
                     url: '/proxy/api/agent/checkPassword',
                     data: {
                        password: value
                     },
                     success: function(json) {
                        flg = (json.code == 10010);
                     }
                  });
                  return flg;
               } else {
                  return false;
               }
            },
            message: '请输入正确的密码'
         },
         //检查密码格式
         psw: {
            validator: function(value, param) {
               return reg.test(value);
            },
            message: '密码长度必须是6-16位字符'
         },
         //验证重复输入密码
         agPsw: {
            validator: function(value, param) {
               return value == $(param[0]).val();
            },
            message: '两次密码不一致'
         }
      });
   },
   midfQzPassword: function() {
      $('#qz_psw_form').form('submit', {
         onSubmit: function() {
            if ($(this).form('validate')) {
               $.ajax({
                  type: 'post',
                  url: '/proxy/api/agent/modifyPassword',
                  data: {
                     password: $('#new_psw').val()
                  },
                  success: function(json) {
                     if (json.code == 10010) {
                        alert("修改成功，去登录界面");
                        //修改成功哦你，退出登录，重新登录
                        $.ajax({
                           type: "post",
                           url: "/proxy/api/agent/exit",
                           data: {
                           },
                           success: function() {
                              //刷新页面
                              window.location.reload();
                           }
                        });
                     }
                  }
               });
            } else {
               return false;
            }
         },
         success: function() {
         }
      });
   },
}
Do("lang-zh_CN", function() {
   modifyPsw.init();
});
