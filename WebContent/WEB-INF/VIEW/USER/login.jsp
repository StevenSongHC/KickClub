<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请登录</title>
<jsp:include page="../include.jsp" flush="true" />
<script type="text/javascript">
$(document).ready(function() {
	$("body").load("<%=basepath%>/getLoginForm");
});
</script>
</head>
<body>

</body>
</html>