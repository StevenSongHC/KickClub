<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
body {
	margin-top: 37px;
}
#top-bar {
	position: absolute;
	top: 0;
	width: 100%;
	background-color: rgba(153, 153, 153, 0.31);
	padding: 6px;
}
#right-container {
	float: right;
}
#user-bar img {
	width: 25px;
	height: 25px;
}
#user-bar span {
	padding: 6px;
	background-color: #999;
	border: 1px solid #808080;
	cursor: pointer;
	color: #d3d3d3;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#user-bar>span").hover(function() {
		$(this).css({"background-color" : "#808080", "border-color" : "#d3d3d3"});
	}, function() {
		$(this).css({"background-color" : "#999", "border-color" : "#808080"});
	});
	// LOGIN
	$("#user-bar #login").click(function() {
		BootstrapDialog.show({
			type: BootstrapDialog.TYPE_INFO,
			title: "请登录",
			message: "请重试"
		});
	});
	// REGISTER
	$("#user-bar #register").click(function() {
		window.open("user/register");
	});
	// HOMEPAGE
	$("#user-bar #user-photo").click(function() {
		window.location.href = "user";
	});
	// LOGOUT
	$("#user-bar #logout").click(function() {
		$.ajax( {
			url: "user/logout",
			type: "POST"
		}).done(function( json ) {
			window.location.reload();
		}).fail(function() {
			
		}).error(function (XMLHttpRequest, textStatus, errorThrown) {
			$("body").append(XMLHttpRequest.responseText);
		});
	});
});
</script>
<div id="top-bar">
	<div id="right-container">
		<div id="user-bar">
			
			<c:choose>
				<c:when test="${empty sessionScope.USER_SESSION}">
					<span id="login">登陆</span>
					<span id="register">注册</span>
				</c:when>
				<c:otherwise>
					<span id="user-photo"><img alt="${sessionScope.USER_SESSION.name}的头像" title="前往我的主页" src="${sessionScope.USER_SESSION.photo}"></span>
					<span id="user-name"><c:out value="${sessionScope.USER_SESSION.name}" /></span>
					<span><img title="查看我的所有消息" src="images/message.png" /></span>
					<span id="logout">登出</span>
				</c:otherwise>
			</c:choose>
			<div style="clear: both;"></div>
		</div>
	</div>
</div>