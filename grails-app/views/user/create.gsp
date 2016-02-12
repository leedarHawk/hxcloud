<%--
  Created by IntelliJ IDEA.
  User: hawk
  Date: 2/12/16
  Time: 11:06 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
    <script>
        function test(){
            var user = {
                uname:"www",
                mobileIpt:"zzzz",
                birthday:"bbb"
            };
            $.ajax({
                url:'testJson',
                data: JSON.stringify(user),
                type: 'post',
                dataType:'json',
                contentType:"application/json",
                success:function(msg){
                    console.log(msg.name)
                    console.log(msg);
                }

            })
        }
    </script>
</head>

<body>
<div style="margin: 10px">
    <g:form action="save" class="form-horizontal">
        <input name="mobile" class="form-control">
        <g:link action="sendMail">aaa</g:link>
        <g:submitButton name="save" class="btn btn-danger"></g:submitButton>
    </g:form>
    <a href="#" onclick="test()">test json</a>
</div>
</body>
</html>