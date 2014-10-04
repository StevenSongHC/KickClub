<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../include.jsp" flush="true" />
<title>数据操作</title>
</head>
<body>
<div class="panel-body"><a href="<%=basepath%>/data/user">用户数据</a> ()条记录</div>
<div class="panel-body"><a href="<%=basepath%>/data/province">省份数据</a> ()条记录</div>
<div class="panel-body"><a href="<%=basepath%>/data/city">城市数据</a> ()条记录</div>
<div class="panel-body"><a href="<%=basepath%>/data/college">大学数据</a> ()条记录</div>
</body>
</html>