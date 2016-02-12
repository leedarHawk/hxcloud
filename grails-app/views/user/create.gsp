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

</head>

<body>
<div style="margin: 10px">
    <g:form action="save" class="form-horizontal">
        <input name="mobile" class="form-control">
        <g:link action="sendMail">aaa</g:link>
        <g:submitButton name="save" class="btn btn-danger"></g:submitButton>
    </g:form>
</div>
</body>
</html>