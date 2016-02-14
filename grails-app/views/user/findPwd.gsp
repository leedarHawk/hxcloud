<%--
  Created by IntelliJ IDEA.
  User: bsnpb0j
  Date: 2/14/2016
  Time: 9:49 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>findPwd</title>
    <SCRIPT type="text/javascript">
        $(function(){
            $("#data_verifyCode").on("focus",function(){
                if($(".J-mobile-changeCheckcode")[0]==null){
                    $(this).after($('<IMG class="ui-mobile-checkcode-imgcode-img J-mobile-changeCheckcode" title="clickRefreshPicVerifyCode" alt="clickRefreshPicVerifyCode"  src="../register/certPic?r=1"/> <A class="text-tree-view J-mobile-changeCheckcode" href="#">看不清,换一张 </A>'));
                    $(".J-mobile-changeCheckcode").on('click',function (e){
                        e.preventDefault();
                        $("#data_verifyCode").val("").trigger("focus");
                        var src = $(".ui-mobile-checkcode-imgcode-img").attr("src");
                        src = src.substring(0, src.indexOf("r=") + 2);
                        $(".ui-mobile-checkcode-imgcode-img").attr("src", src + Math.random());
                    });
                }
            });


        });
    </SCRIPT>
    <script type="text/javascript">
        function findpwdSubmit(){
            $("#showinfo").html("");
            var logname = $("#logName").val();
            var vcode = $("#data_verifyCode").val();
            if(logname.trim()==''){
                $("#showinfo").html("请输入用户名");
                return false;
            }
            if(vcode==''){
                $("#showinfo").html("请输入验证码");
                return false;
            }
            return true;
            //document.getElementById("findpwdform").submit();
        }
        var error= "${msginfo}";
        var uname = "${uname}";
        if(error!=null&&""!=error){
            $("#showinfo").html(error);
            $("#logName").val(uname);
        }
    </script>
</head>

<body>
<div class="section-account">
    <div class="scroll">
        <div class="acc-hd">
            <div class="wrap800">
                <a href="toLogin" class="to-log">登录</a>
            </div>
        </div>
        <div class="register">
            <div class="wrap800">
                <div class="reg-top"></div>
                <div class="reg-con">

                    <div class="reg-tab">
                        <div    class="reg-tab-bd">
                            <g:form id="findpwdform" action="findUser" method="post" onsubmit="return findpwdSubmit()">
                                <div class="item-btn">
                                    <span id="showinfo" class="tips-error"></span>
                                </div>
                                <table class="table">

                                    <tr>
                                        <td class="td-label">用户名
                                            <font color="red" style="font-weight: bold;">*</font>：</td>
                                        <td><input type="text" id="logName" name="logName" class="inp inp-lg"> </td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">验证码
                                            <font color="red" style="font-weight: bold;">*</font>：</td>
                                        <td><input  id="data_verifyCode"     name="verifyCode" type="text" class="inp-code"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">&nbsp;</td>
                                        <td>
                                            <input id="fm-regist-mobile-submit" style="border: 0;margin: 0px 74px;" class="btn" value="下一步" type="submit">
                                        </td>
                                    </tr>
                                </table>
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>