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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/user-register-page-style.css">
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-select.min.css">
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-select.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("select").selectpicker();
	
	var currentTabName = window.location.hash;
	if (currentTabName === "" || (currentTabName !== "#account-form" && currentTabName !== "#past-info-form" && currentTabName !== "#present-info-form"))
		currentTabName = "#account-form";
	
	openTab(currentTabName);
	
	$("#form-header>li").click(function() {
		openTab($(this).attr("tabName"));
	});
	$("#fill-more").click(function() {
		openTab("#past-info-form");
	});
	$("#fill-done").click(function() {
		
	});
	/*
		complete the register process
	*/
	$("#fill-done").click(function() {
		$("#alert-box>div").hide();
		if ($("#input-email").val().trim().length > 0) {
			if (validateEmail()) {
				if ($("#input-name").val().trim().length > 0) {
					if ($("#input-name").val().trim().length > 1 && $("#input-name").val().trim().length < 10) {
						if ($("#input-password").val().length != 0) {
							if ($("#input-password").val().length >= 7) {
								if ($("#input-password").val() !== "1234567") {
									if($("#input-repeat-password").val().trim().length > 0) {
										if ($("#input-repeat-password").val() === $("#input-password").val()) {
											submit();
										}
										else
											$("#different-password").show();
									}
									else
										$("#empty-repeat-password").show();
								}
								else
									$("#bad-password").show();
							}
							else
								$("#bad-password-length").show();
						}
						else
							$("#empty-password").show();
					}
					else
						$("#bad-name-length").show();
				}
				else
					$("#empty-name").show();
			}
			else
				$("#invalid-email").show();
		}
		else
			$("#empty-email").show();
	});
	
	$(".form-control").blur(function() {
		isAllFilled();
	});
	$("#account-form .form-control").blur(function() {
		var flag = true;
		$("#account-form .input-group").each(function(i, e) {
			if($(e).find(".form-control").val().trim() === "")
				flag = false;
		});
		if (flag)
			$("#fill-more").css("background-color", "#e6e6e6");
		else
			$("#fill-more").css("background-color", "#fff");
	});
	
	$(".selectpicker").change(function() {
		isAllFilled();
	});
	
	function openTab(tabName) {
		$("#main ul>li").removeClass("active");
		$("#main ul>li[tabName='" + tabName + "']").addClass("active");
		$("#form-container>div").hide();
		$(tabName).show("100");
	}
	
	function isAllFilled() {
		var flag = true;
		$(".input-group>input").each(function(i, e) {
			if ($(e).val().trim() === "")
				flag = false;
		});
		$(".selectpicker").each(function(i, e) {
			if ($(e).val() === "NULL")
				flag = false;
		});
		if (flag)
			$("#fill-done").removeClass("btn-info").addClass("btn-primary");
		else
			$("#fill-done").removeClass("btn-primary").addClass("btn-info");
		return flag;;
	}
	
	function validateEmail() {
		var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		return reg.test($("#input-email").val().trim());
	}
	
	function submit() {
		$.ajax( {
			url: "doRegister",
			type: "POST",
			dataType: "JSON",
			data: {
				email : $("#input-email").val().trim()
			}
		}).done(function( json ) {
			alert(json.msg);
		}).fail(function() {
			alert("FAIL");
		}).error(function (XMLHttpRequest, textStatus, errorThrown) {
			$("body").append(XMLHttpRequest.responseText);
		});
	}
	
});
</script>
<title>新用户注册</title>
</head>
<body>
<div id="main">
	<ul id="form-header" class="nav nav-tabs nav-justified" role="tablist">
		<li role="presentation" tabName="#account-form" class="active"><a href="#account-form">* 新账号</a></li>
		<li role="presentation" tabName="#past-info-form"><a href="#past-info-form">我的高中</a></li>
		<li role="presentation" tabName="#present-info-form"><a href="#present-info-form">我的大学</a></li>
	</ul>
	<div id="form-container">
		<div id="account-form">
			<div class="input-group">
				<span class="input-group-addon">邮箱</span>
				<input id="input-email" type="text" class="form-control" placeholder="Email">
			</div>
			<div class="input-group">
				<span class="input-group-addon">昵称</span>
				<input id="input-name" type="text" class="form-control" placeholder="Nickname（大于1个字符，小于10个字符）">
			</div>
			<div class="input-group">
				<span class="input-group-addon">密码</span>
				<input id="input-password" type="password" class="form-control" placeholder="don't use 1234567（至少7位）">
			</div>
			<div class="input-group">
				<span class="input-group-addon">重复验证密码</span>
				<input id="input-repeat-password" type="password" class="form-control">
			</div>
			<div id="fill-more" class="btn btn-default">让大家了解我更多<font size="4" color="#ccc">▶</font></div>
		</div>
		<div id="past-info-form" style="display: none;">
			<div class="input-group">
				<span class="input-group-addon">高中名字</span>
				<input type="text" class="form-control" placeholder="My Senior High School">
			</div>
			<h1><small>省份</small></h1>
			<select id="from-province" class="selectpicker">
				<option>NULL</option>
				<option>海南</option>
				<option>广东</option>
			</select>
			<h1><small>城市</small></h1>
			<select id="from-city" class="selectpicker">
				<option>NULL</option>
				<option>1</option>
				
			</select>
		</div>
		<div id="present-info-form" style="display: none;">
			<h1><small>所在省份</small></h1>
			<select id="present-province" class="selectpicker">
				<option>NULL</option>
				<option>海南</option>
				<option>广东</option>
			</select>
			<h1><small>所在城市</small></h1>
			<select id="present-city" class="selectpicker">
				<option>NULL</option>
				<option>1</option>
			</select>
			<h1><small>我的大学</small></h1>
			<select id="present-city" class="selectpicker">
				<option>NULL</option>
				<option>1</option>
			</select>
			<div class="input-group">
				<span class="input-group-addon">所学专业</span>
				<input type="text" class="form-control" placeholder="My Major">
			</div>
		</div>
	</div>
	<div style="text-align: center;"><div id="fill-done" class="btn btn-info btn-lg" role="button">完成</div></div>
	<div id="alert-box">
		<div id="empty-email" class="alert alert-warning" role="alert">请填上邮箱地址</div>
		<div id="empty-name" class="alert alert-warning" role="alert">请写上你的昵称</div>
		<div id="empty-password" class="alert alert-warning" role="alert">请输入密码</div>
		<div id="empty-repeat-password" class="alert alert-warning" role="alert">请再输入一次密码</div>
		<div id="invalid-email" class="alert alert-danger" role="alert">无效邮箱</div>
		<div id="repeat-email" class="alert alert-danger" role="alert">该邮箱已被注册使用</div>
		<div id="bad-name-length" class="alert alert-danger" role="alert">昵称长度不符合要求</div>
		<div id="repeat-name" class="alert alert-danger" role="alert">该昵称已被注册，再想想</div>
		<div id="bad-password-length" class="alert alert-danger" role="alert">密码太短啦</div>
		<div id="bad-password" class="alert alert-warning" role="alert">从前有个人密码是1234567，然后他的号就没了</div>
		<div id="different-password" class="alert alert-danger" role="alert">密码前后不一</div>
	</div>
</div>
</body>
</html>