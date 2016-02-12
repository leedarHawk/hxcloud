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
<div class="container col-lg-6">
    <g:each in="userList" item="user">
        html....
    </g:each>
    <g:form action="save" class="form-horizontal">
        <input name="mobile" class="form-control">
        <g:submitButton name="save" class="btn btn-danger"></g:submitButton>
    </g:form>
</div>
</body>
</html>