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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/user_style/register-page-style.css">
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-select.min.css">
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-select.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("select").selectpicker();
	
	var currentTabName = window.location.hash;
	if (currentTabName === "" || (currentTabName !== "#account-form" && currentTabName !== "#past-info-form" && currentTabName !== "#present-info-form"))
		currentTabName = "#account-form";
	
	openTab(currentTabName);
	
	/*
		bind button click event
	*/
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
					if ($("#input-name").val().trim().length > 1 && $("#input-name").val().trim().length < 20) {
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
	
	/*
		bind selector click event
	*/
	$("button[data-id='from-province']").click(function() {
		if ($("#from-province option:last").val() == 0) {
			$.ajax( {
				url: "../ajax/getAllProvinceList",
				type: "POST",
				dataType: "JSON",
			}).done(function( json ) {
				$.each(json.list, function(i, pr) {
					$("#from-province").append("<option value='" + pr.id + "'>" + pr.name + "</option>");
				});
				$("#from-province").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
	});
	$("button[data-id='present-province']").click(function() {
		if ($("#present-province option:last").val() == 0) {
			$.ajax( {
				url: "../ajax/getAllProvinceList",
				type: "POST",
				dataType: "JSON",
			}).done(function( json ) {
				$.each(json.list, function(i, pr) {
					$("#present-province").append("<option value='" + pr.id + "'>" + pr.name + "</option>");
				});
				$("#present-province").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
	});
	/*
		bind selector change event
	*/
	$(".selectpicker").change(function() {
		isAllFilled();
	});
	$("#from-province").change(function() {
		if ($(this).val() != 0) {
			$.ajax( {
				url: "../ajax/getCityListByProvinceId",
				type: "POST",
				dataType: "JSON",
				data: {
					provinceId: $(this).val()
				}
			}).done(function( json ) {
				$("#from-city").html("");
				$("#from-city").prop("disabled", false);
				$("#from-city").append("<option value='0'></option>");
				$.each(json.list, function(i, ct) {
					$("#from-city").append("<option value='" + ct.id + "'>" + ct.name + "</option>");
				});
				$("#from-city").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
		else {
			$("#from-city").html("");
			$("#from-city").append("<option value='0'></option>");
			$("#from-city").prop("disabled", true);
			$("#from-city").selectpicker("refresh");
		}
	});
	$("#present-province").change(function() {
		if ($(this).val() != 0) {
			// fetch city list
			$.ajax( {
				url: "../ajax/getCityListByProvinceId",
				type: "POST",
				dataType: "JSON",
				data: {
					provinceId: $(this).val()
				}
			}).done(function( json ) {
				$("#present-city").html("");
				$("#present-city").prop("disabled", false);
				$("#present-city").append("<option value='0'></option>");
				$.each(json.list, function(i, ct) {
					$("#present-city").append("<option value='" + ct.id + "'>" + ct.name + "</option>");
				});
				$("#present-city").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
			// fetch college list
			$.ajax( {
				url: "../ajax/getCollegeListByProvinceId",
				type: "POST",
				dataType: "JSON",
				data: {
					provinceId: $(this).val()
				}
			}).done(function( json ) {
				$("#college").html("");
				$("#college").prop("disabled", false);
				$("#college").append("<option value='0'></option>");
				$.each(json.list, function(i, clg) {
					$("#college").append("<option value='" + clg.id + "'>" + clg.name + "</option>");
				});
				$("#college").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
		else {
			$("#present-city").html("");
			$("#present-city").append("<option value='0'></option>");
			$("#present-city").prop("disabled", true);
			$("#present-city").selectpicker("refresh");
			$("#college").html("");
			$("#college").append("<option value='0'></option>");
			$("#college").prop("disabled", true);
			$("#college").selectpicker("refresh");
		}
	});
	$("#present-city").change(function() {
		if ($(this).val() != 0) {
			$.ajax( {
				url: "../ajax/getCollegeListByCityId",
				type: "POST",
				dataType: "JSON",
				data: {
					cityId: $(this).val()
				}
			}).done(function( json ) {
				$("#college").html("");
				$("#college").prop("disabled", false);
				$("#college").append("<option value='0'></option>");
				$.each(json.list, function(i, clg) {
					$("#college").append("<option value='" + clg.id + "'>" + clg.name + "</option>");
				});
				$("#college").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
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
			url: "register/do",
			type: "POST",
			dataType: "JSON",
			data: {
				email : $("#input-email").val().trim(),
				name : $("#input-name").val(),
				password : $("#input-password").val(),
				senior: $("#input-senior").val().trim(),
				fromProvince : $("#from-province").children("option:selected").val(),
				fromCity : $("#from-city").children("option:selected").val(),
				presentProvince : $("#present-province").children("option:selected").val(),
				presentCity : $("#present-city").children("option:selected").val(),
				college : $("#college").children("option:selected").val(),
				major : $("#input-major").val().trim()
			}
		}).done(function( json ) {
			switch (json.code) {
				case 1 :
					BootstrapDialog.show({
						type: BootstrapDialog.TYPE_SUCCESS,
						closable: false,
						title: "恭喜你，注册成功！",
						message: "现转到<a href='../user"+ json.userName + "'>用户个人页</a>，若未能自动打开请点击左边超链接进入"
					});
					setTimeout(function() {
						window.location.href="../user/" + json.userName;
					}, 3000);
					break;
				default:
					BootstrapDialog.show({
						type: BootstrapDialog.TYPE_DANGER,
						title: "注册失败！",
						message: "请重试"
					});
			}
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
				<input id="input-name" type="text" class="form-control" placeholder="Nickname（大于1个字符，小于20个字符）">
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
				<input id="input-senior" type="text" class="form-control" placeholder="My Senior High School">
			</div>
			<h1><small>省份</small></h1>
			<select id="from-province" class="selectpicker" title="高中所在省份" data-live-search="true">
				<option value="0"></option>
			</select>
			<h1><small>城市</small></h1>
			<select id="from-city" class="selectpicker" title="高中所在城市" data-live-search="true" disabled>
				<option value="0"></option>
			</select>
		</div>
		<div id="present-info-form" style="display: none;">
			<h1><small>所在省份</small></h1>
			<select id="present-province" class="selectpicker" title="大学所在省份" data-live-search="true">
				<option value="0"></option>
			</select>
			<h1><small>所在城市</small></h1>
			<select id="present-city" class="selectpicker" title="大学所在省份" data-live-search="true" disabled>
				<option value="0"></option>
			</select>
			<h1><small>我的大学</small></h1>
			<select id="college" class="selectpicker" title="大学名称" data-live-search="true" disabled>
				<option value="0"></option>
			</select>
			<div class="input-group">
				<span class="input-group-addon">所学专业</span>
				<input id="input-major" type="text" class="form-control" placeholder="My Major">
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