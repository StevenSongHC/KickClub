<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../include.jsp" flush="true" />
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/data_style/data-list-page-style.css">
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript"	src="<%=basepath%>/js/data-list-insert.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#add-data").click(function() {
		var newId = parseInt($("#content-list tr:last td:first").html()) + 1;
		var newInput = "<tr><td>" + newId + "</td><td><input type='text'></td><td>" + $("#province-select").html() + "</td></tr>";
		createNewInput(newInput);
	});
	
	$("#y-o-n #confirm").click(function() {
		var jsonDataAttr = "{cityName:'" + $("#content-list input[type='text']").val().trim() + "',provinceId:" + $("#content-list select").children("option:selected").val() + ",}";
		insertData("city", jsonDataAttr);
	});
	
});
</script>
<title>城市数据</title>
</head>
<body>
<h1>CITY DATA</h1>
<div id="main">
	<table id="content-list" border="1">
		<tr>
			<td width="30%">id</td>
			<td width="40%">name</td>
			<td width="30%">province</td>
		</tr>
	<c:forEach items="${cityList}" var="ct">
		<tr>
			<td>${ct.id}</td>
			<td>${ct.name}</td>
			<td>${ct.province}</td>
		</tr>
	</c:forEach>
	</table>
	<div class="function-bar">
		<span id="add-data" class="glyphicon glyphicon-plus"></span>
		<div id="y-o-n">
			<span id="confirm" class="glyphicon glyphicon-ok"></span>
			<span id="cancel" class="glyphicon glyphicon-remove"></span>
			<div style="clear:both;"></div>
		</div>
	</div>
	
<div id="province-select" style="display: none;">
<select>
	<option></option>
<c:forEach items="${provinceList}" var="pr">
	<option value="${pr.id}">${pr.name}</option>
</c:forEach>
</select>
</div>

</div>
</body>
</html>