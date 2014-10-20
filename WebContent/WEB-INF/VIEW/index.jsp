<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="include.jsp" flush="true" />
<script type="text/javascript">
$(document).ready(function() {
	console.log(document.cookie);
});
</script>
<title>KC.com</title>
</head>
<body>
<jsp:include page="top-float-bar.jsp" flush="true" />
Let's <a href="about">kick</a> the club
<div class="well"><a href="<%=basepath%>/user/login">用户登录</a></div>
<div class="well"><a href="<%=basepath%>/user/register" target="_blink">新用户注册</a></div>
<div class="well"><a href="<%=basepath%>/data" target="_blink">数据操作</a></div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><hr>
</body>
</html>