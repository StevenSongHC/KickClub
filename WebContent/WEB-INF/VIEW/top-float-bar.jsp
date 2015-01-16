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
}
#right-container {
	float: right;
}
#user-bar img {
	width: 20px;
	height: 20px;
}
#user-bar div {
	display: inline-block;
	margin: 3px;
	padding: 3px;
	background-color: #999;
	border: 1px solid #808080;
	cursor: pointer;
	color: #d3d3d3;
}
</style>
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-hover-dropdown.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#user-bar>div").hover(function() {
		$(this).css({"background-color" : "#808080", "border-color" : "#d3d3d3"});
	}, function() {
		$(this).css({"background-color" : "#999", "border-color" : "#808080"});
	});
	// LOGIN
	$("#user-bar #login").click(function() {
		BootstrapDialog.show({
			type: BootstrapDialog.TYPE_INFO,
			title: "请登录",
			message: $("<div></div>").load("<%=basepath%>/getLoginForm")
		});
	});
	// REGISTER
	$("#user-bar #register").click(function() {
		window.open("user/register");
	});
	// LOGOUT
	$("#user-bar #logout").click(function() {
		$.ajax( {
			url: "<%=basepath%>/user/logout",
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
				<div id="login">登陆</div>
				<div id="register">注册</div>
			</c:when>
			<c:otherwise>
				<div id="user-title" class="dropdown">
					<a href="<%=basepath%>/user"><img alt="${sessionScope.USER_SESSION.name}的头像" title="前往我的主页" src="<%=basepath%>/${sessionScope.USER_SESSION.photo}"></a>
					<span class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">
						<c:out value="${sessionScope.USER_SESSION.name}" />
						<b class="caret"></b>
					</span>
					<ul class="dropdown-menu">
						<li><a href="#">My Subscription</a></li>
						<li><a href="#">My Clubs</a></li>
					</ul>
				</div>
				<div><a href="#"><img title="消息" src="<%=basepath%>/images/message.png" /> <span class="badge">0</span></a></div>
				<div><a href="<%=basepath%>/user/setting"><img title="设置" src="<%=basepath%>/images/setting.png" /></a></div>
				<div id="logout">登出</div>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</div>