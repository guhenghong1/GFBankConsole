/**
 * 邮箱失去焦点时触发
 */
function checkEmail() {
   var email_flg = false;
   //每次触发前清空提示
   $('#lab_email').html("").removeClass();
   email_flg = false;
   var email = $("#tb_email").val();
   var email_reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
   if (email.length <= 0) {
      return false;
   }
   if (!email_reg.test(email)) {
      $('#lab_email').html(" * 请填写正确的邮箱").addClass('label_nopass');
      return false;
   }
   $.ajax({
      type: 'post',
      url: '/proxy/api/agent/checkEmail',
      data: {
         email: email
      },
      async: false,
      success: function(data) {
         if (data == true) {
            //邮箱不存在
            $('#lab_email').html(" * 请填写正确的邮箱").addClass('label_nopass');
         } else {
            $('#lab_email').html("");
            email_flg = true;
         }
      }
   });
   return email_flg;
}

/**
 * 手机号码失去焦点时触发
 */
function checkPhone() {
   //每次触发前清空提示
   $('#lab_phone').html("").removeClass();
   var phone_reg = /^[1][3-8]+\d{9}$/;
   var phone = $("#tb_phone").val();
   if (phone.length <= 0) {
      return false;
   }
   if (!phone_reg.test(phone)) {
      $('#lab_phone').html(" * 请填写正确的手机号码").addClass('label_nopass');
      return false;
   }
   $('#lab_phone').html("");
   return true;
}

/**
 * 提交按钮事件
 */
function mysubmit() {
   if (checkEmail() && checkPhone()) {
      var email = $("#tb_email").val();
      var phone = $("#tb_phone").val();
      doResetPsw(email, phone);
   }
}
/**
 * 重置密码
 * @returns {undefined}
 */
function doResetPsw(email, phone) {
   $.ajax({
      type: 'post',
      url: '/proxy/api/agent/resetAgentPsw',
      data: {
         email: email,
         phone: phone
      },
      success: function(json) {
         if (json.result == 'success') {
            alert("提交成功,为了您的帐号安全，收到信息后请登录并修改密码");
            $('#resetPsw_btn').attr("disabled", true);
            setTimeout(function() {
               window.location.href = "index.jsp"
            }, 2000)
         } else {
            alert('提交失败，请确认邮箱或手机是否正确');
         }
      }
   });
}

