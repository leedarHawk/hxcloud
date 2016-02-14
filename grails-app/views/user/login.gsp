<%--
  Created by IntelliJ IDEA.
  User: bsnpb0j
  Date: 2/13/2016
  Time: 1:11 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>login</title>

    <script type="text/javascript">

        $("#showPassword").focus(function() {
            var text_value = $(this).val();
            alert(text_value)
            if (text_value == this.defaultValue) {
                $("#showPassword").hide();
                $("#loginPassword").show().focus();
            }
        });
        $("#loginPassword").blur(function() {
            var text_value = $(this).val();
            if (text_value == "") {
                $("#showPassword").show();
                $("#loginPassword").hide();
            }
        });




        if (window != top) {
            top.location.href = window.location.href;
        }
        $(document).bind("keypress",function(e){
            var code;
            if  (!e){
                var e=window.event;
            }
            if(e.keyCode){
                code=e.keyCode;
            }else if(e.which){
                code   =   e.which;
            }
            if(code==13){
                loginFormSubmit();
            }
        });
        $(function(){
            var username = tools.cookie("defaultusername");
            if(username!=null&&username!=""){
                $("#userName").val(username);
                $("#savename").attr("checked","checked");
            }

            if($(".J-veri-changeCheckcode")[0]==null){
                $("#veriticationCode").after($('<IMG id="veritication" style="padding-left:5px;"  src="../register/certPic?r=1"/> <A class="text-tree-view J-veri-changeCheckcode" href="#">看不清,换一张 </A>'));
                $(".J-veri-changeCheckcode").on('click',function (e){
                    e.preventDefault();
                    $("#veritication").val("").trigger("focus");
                    var src = $("#veritication").attr("src");
                    src = src.substring(0, src.indexOf("r=") + 2);
                    $("#veritication").attr("src", src + Math.random());
                });
            }
        });
        loginFormSubmit = function(){
            $("#showTip").html("");
            var userNameFocus= document.getElementById("userName");
            var loginPasswordFocus= document.getElementById("loginPassword");
            var vcode = $("#veriticationCode").val();
            if(userNameFocus.value=="" ||userNameFocus.value=="手机号/邮箱/用户名" || loginPasswordFocus.value==""||loginPasswordFocus.value=="密码"){
                $("#showTip").html("请输入用户名与密码");
                return false;
            }
            if($("#veriticationCode").val()==""){
                $("#showTip").html("请输入验证码");
                return false;
            }
            // var options = {
            //  success:  function(data, statusText){

            // }  ,
            // url:       'login',
            // type:      'post',
            // dataType:  'json'
            // };
            // $('#loginForm').ajaxSubmit(options);
            if($("#savename").is(":checked")) {
                tools.cookie("defaultusername", $("#userName").val(),{expires:7});
            } else {
                tools.cookie("defaultusername", "");
            }
            return true;
            //var form= document.getElementById("loginForm");
            //form.submit();
        }
        var name ="${name}";
        if(name!=null&&""!=name){
            $("#userName").val(name);
            $("#loginPassword").focus();
        }
        var error= "${error}";
        if(error!=null&&""!=error){
            if(error=='reactive'){
                var activetip = "您的邮箱尚未激活 <a href='javascript:void(0);' onclick='reactive()' style='color: #8fc320' target=_blank>点击去激活</a>"
                $("#showTip").html(activetip); // 邮箱账户未激活处理
            }else{
                $("#showTip").html(error);
            }
        }
        function clearUserName(){
            var uname = $("#userName").val();
            $('#showTip').html('');
            if(uname=="手机号/邮箱/用户名"){
                $("#userName").val("");
            }
        }
        style="color:#666;"
        function reactive(){
            document.getElementById("activeForm").submit();
        }
    </script>
</head>

<body>
<div class="section-account">
    <div class="acc-hd">
        <div class="wrap800">

        </div>
    </div>
    <div class="login">
        <div class="wrap800">
            <div class="login-bd">
                <div class="login-top"></div>
                <div class="login-con">
                    <g:form action="login" method="post" id="loginForm" onsubmit="return loginFormSubmit()">
                        <div class="item-btn">
                            <span class="tips-error" id="showTip"></span>
                        </div>
                        <div class="item">
                            <input id="userName"  name="userName" type="text"  class="input-login" onfocus="clearUserName()" onblur="if(this.value==''){this.value='手机号/邮箱/用户名'}" value="手机号/邮箱/用户名" style="color:#666;"/>

                        </div>
                        <div class="item mt10">
                            <!-- <input type="text"  id="showPassword" name="showPassword" class="input-login" value="密码"  style="color:#666;" /> -->
                            密码：<input id="loginPassword" name="loginPassword" type="password" class="input-login">
                        </div>
                        <div class="item mt10">
                            <input id="veriticationCode"  name="veriticationCode" type="text"  class="inp-code-login" />
                        </div>
                        <div class="item-txt">
                            <label class="fl"><input id="savename" name="savename" type="checkbox">记住用户名</label>
                            <a href="/findPwd/index" class="fr">忘记密码？</a>
                        </div>
                        <div class="item-btn">
                            <input id="fm-login-submit" style="border: 0;margin: 0px 74px;" class="btn" value="登录" type="submit">
                        </div>
                    </g:form>
                    <g:form method="post" action="reactive" id="activeForm">
                        <input type="hidden"   name="reemail" value="${email}"/>
                    </g:form>
                    <div class="item-ft">
                        <a href="reactive" class="fl">没有账户？</a>
                        <a href="register" class="fr a-reg">立即注册</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>