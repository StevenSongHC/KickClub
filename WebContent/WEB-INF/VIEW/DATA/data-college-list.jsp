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
		var newInput = "<tr><td>" + newId + "</td><td><input type='text'></td><td>" + $("#province-select").html() + "</td><td><select><option></option></select></td><td><input type='text'></td></tr>";
		createNewInput(newInput);
		
		$("#content-list tr:last td:nth-child(3)").change(function() {
			$.ajax( {
				url: "../ajax/getCityListByProvinceId",
				type: "POST",
				dataType: "JSON",
				data: {
					provinceId: $("#content-list tr:last td:nth-child(3) select").val()
				}
			}).done(function( json ) {
				var citySelect = $("#content-list tr:last td:nth-child(4) select");
				citySelect.empty();
				citySelect.append("<option></option>");
				$.each(json.list, function(i, ct) {
					citySelect.append("<option value='" + ct.id + "'>" + ct.name + "</option>");
				});
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		});
	});
	
	$("#y-o-n #confirm").click(function() {
		var jsonDataAttr = "{collegeName:'" + $("#content-list tr:last td:nth-child(2) input[type='text']").val() + 
						   "',provinceId:" + $("#content-list tr:last td:nth-child(3) select").val() + 
						   ",cityId:" + $("#content-list tr:last td:nth-child(4) select").val() + 
						   ",collegeIntro:'" + $("#content-list tr:last td:nth-child(5) input[type='text']").val() + "'}";
		insertData("college", jsonDataAttr);
		console.log(jsonDataAttr);
	});
	
	
});
</script>
<title>大学数据</title>
</head>
<body>
<h1>COLLEGE DATA</h1>
<div id="main">
	<table id="content-list" class="table table-hover">
		<tr>
			<td width="10">id</td>
			<td width="30%">name</td>
			<td width="15%">province</td>
			<td width="15">city</td>
			<td width="30">intro</td>
		</tr>
	<c:forEach items="${collegeList}" var="clg">
		<tr>
			<td>${clg.id}</td>
			<td>${clg.name}</td>
			<td>${clg.province}</td>
			<td>${clg.city}</td>
			<td>${clg.intro}</td>
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