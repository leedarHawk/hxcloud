<%--
  Created by IntelliJ IDEA.
  User: bsnpb0j
  Date: 2/13/2016
  Time: 1:10 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>register</title>

    <SCRIPT type="text/javascript">
        $(function(){
            $("#J-mobile-checkcode").on("focus",function(){

                if($(".J-mobile-changeCheckcode")[0]==null){
                    $(this).after($('<IMG class="ui-mobile-checkcode-imgcode-img J-mobile-changeCheckcode" title="clickRefreshPicVerifyCode" alt="clickRefreshPicVerifyCode"  src="../register/certPic?r=1"/> <A class="text-tree-view J-mobile-changeCheckcode" href="#">看不清,换一张 </A>'));
                    $(".J-mobile-changeCheckcode").on('click',function (e){
                        e.preventDefault();
                        $("#J-mobile-checkcode").val("").trigger("focus");
                        var src = $(".ui-mobile-checkcode-imgcode-img").attr("src");
                        src = src.substring(0, src.indexOf("r=") + 2);
                        $(".ui-mobile-checkcode-imgcode-img").attr("src", src + Math.random());
                    });
                }
            });

            $("#J-email-checkcode").on("focus",function(){
                if($(".J-email-changeCheckcode")[0]==null){
                    $(this).after($('<IMG class="ui-email-checkcode-imgcode-img J-email-changeCheckcode" title="clickRefreshPicVerifyCode" alt="clickRefreshPicVerifyCode"  src="../register/certPic?r=2"/> <A class="text-tree-view J-email-changeCheckcode" href="#">看不清,换一张 </A>'));
                    $(".J-email-changeCheckcode").on('click',function (e){
                        e.preventDefault();
                        $("#J-email-checkcode").val("").trigger("focus");
                        var src = $(".ui-email-checkcode-imgcode-img").attr("src");
                        src = src.substring(0, src.indexOf("r=") + 2);
                        $(".ui-email-checkcode-imgcode-img").attr("src", src + Math.random());
                    });
                }
            });
        });
        function setTab(name,cursel,n){
            for(i=1;i<=n;i++){
                //  var menu=document.getElementById(name+i);
                var menu = $("#"+name+i);
                i==cursel?menu.attr("class","active"):menu.attr("class","last");
                var con=document.getElementById("con_"+name+"_"+i);
                //   menu.className=i==cursel?"hover":"";
                con.style.display=i==cursel?"block":"none";
            }
        }


        var tw = 150;
        var offsetX = 0;
        var offsetY = 20;
        var toolTipSTYLE;
        function initToolTips()
        {
            toolTipSTYLE = document.getElementById("toolTipLayer").style;
            toolTipSTYLE.visibility = "visible";
            toolTipSTYLE.display = "none";
            document.onmousemove = moveToMouseLoc;

        }
        function toolTip(msg)
        {
            if(msg == "") // hide
            {
                //toolTipSTYLE.display = "none";
            }
            else // show
            {

                document.getElementById("toolTipLayer").innerHTML = msg;
                //toolTipSTYLE.display='block';
            }
        }

        function moveToMouseLoc(e)
        {
            var x = e.pageX;
            var y = e.pageY;
            //toolTipSTYLE.left = x + offsetX;
            //toolTipSTYLE.top = y + offsetY;
            return true;
        }
    </SCRIPT>
</head>

<body onload="initToolTips()">
<div class="section-account">
    <div class="scroll">
        <div class="acc-hd">
            <div class="wrap800">
                <h1><a href="#"></a></h1>
                <a href="toLogin" class="to-log">登录</a>
            </div>
        </div>
        <div class="register">
            <div class="wrap800">
                <div class="reg-top"></div>
                <div class="reg-con">
                    <div class="reg-step reg-step1"></div>
                    <!-- 进度条第二步添加样式reg-step2，第二步添加样式reg-step3 -->
                    <div class="reg-tab">
                        <div class="reg-tab-hd">
                            <ul>
                                <li id="RegTab1" class="active"><a style="cursor: pointer"  onclick="setTab('RegTab',1,2)">邮箱注册</a></li>
                                <li id="RegTab2" class="last"><a style="cursor: pointer"  onclick="setTab('RegTab',2,2)">手机注册</a></li>
                            </ul>
                        </div>
                        <!-- 手机注册 -->
                        <div  id="con_RegTab_2" style="display: none;" class="reg-tab-bd">
                            <g:form class="rform" action="mobileRegister" method="post">
                                <table class="table">
                                    <input name="mode" value="1" type="hidden">
                                    <tr>
                                        <td class="td-label" width="120px;">手机号码<font color="red">*</font>：</td>
                                        <td><input id="fm-regist-mobile" name="logName" type="text" class="inp inp-lg">
                                            <INPUT id=fm-regist-sendsms style="border: 0" class="btn_code"    value="getFreeVerifyCode" type=button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">短信验证码<font color="red">*</font>：</td>
                                        <td><input id="fm-regist-checkcode" name="txtCode" type="text" class="inp inp-lg"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">姓名<font color="red">*</font>：</td>
                                        <td><input type="text" name="userName" id="fm-regist-mobile-id-userName" class="inp inp-lg"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">登录密码<font color="red">*</font>：</td>
                                        <td>
                                            <input name="userPwd" id="fm-regist-mobile-password" type="password" class="inp inp-lg input" onmouseleave="toolTip('')" onmouseover="toolTip('请输入长度在6-20包含大小写字母、数字和标点符号（空格除外）任意两种以上的组合')">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">确认密码<font color="red">*</font>：</td>
                                        <td><input name="txtNormalPass2" id="fm-regist-mobile-repassword" type="password" class="inp inp-lg input" onmouseleave="toolTip('')" onmouseover="toolTip('请输入长度在6-20包含大小写字母、数字和标点符号（空格除外）任意两种以上的组合')"></td>
                                    </tr>

                                    <tr>
                                        <td class="td-label">验证码<font color="red">*</font>：</td>
                                        <td><input id="J-mobile-checkcode" name="txtYzm" type="text" class="inp-code"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">&nbsp;</td>
                                        <td>
                                            <input id="fm-regist-mobile-submit" style="border: 0;margin: 0px 74px;" class="btn" value="立即注册" type="submit">
                                        </td>
                                    </tr>
                                </table>
                            </g:form>
                        </div>
                        <!-- 邮箱注册 -->
                        <div style="display: block;" id="con_RegTab_1" class="reg-tab-bd">
                            <g:form class="rform" action="emailRegister" method="post">
                                <table class="table">
                                    <input name="mode" value="2" type="hidden">
                                    <tr>
                                        <td class="td-label" width="120px;">邮箱<font color="red">*</font>：</td>
                                        <td><input  id="fm-regist-id-email" name="logName" type="text" class="inp inp-lg"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">姓名<font color="red">*</font>：</td>
                                        <td><input id="fm-regist-email-id-userName" name="userName" type="text" class="inp inp-lg"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">登录密码<font color="red">*</font>：</td>
                                        <td><input id="fm-regist-email-password" name="userPwd" type="password" class="inp inp-lg input" onmouseout="toolTip('')" onmouseover="toolTip('请输入长度在6-20包含大小写字母、数字和标点符号（空格除外）任意两种以上的组合')"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">确认密码<font color="red">*</font>：</td>
                                        <td><input id="fm-regist-email-repassword" name="txtNormalPass2" type="password" class="inp inp-lg input" onmouseout="toolTip('')" onmouseover="toolTip('请输入长度在6-20包含大小写字母、数字和标点符号（空格除外）任意两种以上的组合')"></td>
                                    </tr>

                                    <tr>
                                        <td class="td-label">验证码<font color="red">*</font>：</td>
                                        <td><input id="J-email-checkcode" name="txtYzm" type="text" class="inp-code"></td>
                                    </tr>
                                    <tr>
                                        <td class="td-label">&nbsp;</td>
                                        <td>
                                            <input id="fm-regist-email-submit" style="border: 0;margin: 0px 74px;" class="btn" value="立即注册" type="submit">
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
<div id="toolTipLayer" style="position:absolute;"></div>
</body>
</html>