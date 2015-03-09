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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/user_style/setting-page-style.css">
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-datepicker.css">
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-select.min.css">
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-datepicker.js"></script>
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-select.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#setting-content>div:not(#alert-box)").hide();
	$("#setting-content #profile").show();
	
	$("#ver-navi-bar .list-group:first").show();
	
	$("input[type='radio'][name='sexValue'][value=" + ${user.sex} + "]").attr("checked", "checked").parent().addClass("active");
	
	var userIntro = $("#setting-content #intro textarea").val();
	var userInterest = $("#setting-content #interest textarea").val();
	var userSex = $("input[type='radio'][name='sexValue']:checked").val();
	var userBirth = $("#setting-content #birthDate").val();
	var userWebsite = $("#setting-content #website").val().trim();
	var userName = $("input#name").val().trim();
	var userFromProvince = $("select#from-province").val();
	var userFromCity = $("select#from-city").val();
	var userSenior = $("input#senior-name").val().trim();
	var userPresentProvince = $("select#present-province").val();
	var userPresentCity = $("select#present-city").val();
	var userCollege = $("select#present-college").val();
	var userCollegeMajor = $("input#college-major").val().trim();
	var userJoinCollegeDate = $("input#join-college-date").val();
	isIntroChange = false;
	isInterestChange = false;
	isSexChange = false;
	isBirthChange = false;
	isWebsiteChange = false;
	isNameChange = false;
	isNewPasswordInput = false;
	isFromProvinceChange = false;
	isFromCityChange = false;
	isSeniorChange = false;
	isPresentProvinceChange = false;
	isPresentCityChange = false;
	isCollegeChange = false;
	isCollegeMajorChange = false;
	isJoinCollegeDateChange = false;
	
	$("select").selectpicker();
	
	/* var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0); */
	
	///// profile part /////
	$(".datepicker").datepicker()
					.on("changeDate", function(e) {
						if ($("#birthDate").val() != userBirth)
							isBirthChange = true;
						else
							isBirthChange = false;
						if ($("#join-college-date").val() != userJoinCollegeDate)
							isJoinCollegeDateChange = true;
						else
							isJoinCollegeDateChange = false;
						canSave();
					});
	
	$("#setting-content #intro textarea").keyup(function() {
		if ($(this).val() != userIntro)
			isIntroChange = true;
		else
			isIntroChange = false;
		canSave();
	});
	$("#setting-content #interest textarea").keyup(function() {
		if ($(this).val() != userInterest)
			isInterestChange = true;
		else
			isInterestChange = false;
		canSave();
	});
	$("input[type='radio'][name='sexValue']").change(function() {
		if ($("input[type='radio'][name='sexValue']:checked").val() != userSex)
			isSexChange = true;
		else
			isSexChange = false;
		canSave();
	});
	$("#setting-content #website").keyup(function() {
		if ($(this).val().trim() != userWebsite)
			isWebsiteChange = true;
		else
			isWebsiteChange = false;
		canSave();
	});
	///// username part /////
	$("input#name").keyup(function() {
		if ($(this).val().trim() != userName)
			isNameChange = true;
		else
			isNameChange = false;
		canSave();
	});
	///// user password part /////
	$("input#new-password").keyup(function() {
		if ($(this).val() != "")
			isNewPasswordInput = true;
		else
			isNewPasswordInput = false;
		canSave();
	});
	///// senior info part /////	
	$("button[data-id='from-province']").click(function() {
		if ($("#from-province option").length < 3) {
			$.ajax( {
				url: "../ajax/getAllProvinceList",
				type: "POST",
				dataType: "JSON",
			}).done(function( json ) {
				$.each(json.list, function(i, pr) {
					if (pr.id != ${user.fromProvince})
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
	$("button[data-id='from-city']").click(function() {
		if ($("#from-city option").length < 3 || $(this).val() != 0) {
			$.ajax( {
				url: "../ajax/getCityListByProvinceId",
				type: "POST",
				dataType: "JSON",
				data: {
					provinceId: $("#from-province").val()
				}
			}).done(function( json ) {
				$.each(json.list, function(i, ct) {
					if (ct.id != ${user.fromCity})
						$("#from-city").append("<option value='" + ct.id + "'>" + ct.name + "</option>");
				});
				$("#from-city").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
	});
	$("select#from-province").change(function() {
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
			$("#from-city").selectpicker("refresh");
		}
		if ($(this).val() != userFromProvince)
			isFromProvinceChange = true;
		else {
			isFromProvinceChange = false;
			isFromCityChange = true;
		}
		canSave();
	});
	$("select#from-city").change(function() {
		if ($(this).val() != userFromCity)
			isFromCityChange = true;
		else
			isFromCityChange = false;
		canSave();
	});
	$("input#senior-name").keyup(function() {
		if ($(this).val().trim() != userSenior)
			isSeniorChange = true;
		else
			isSeniorChange = false;
		canSave();
	});
	///// college info part /////
	$("button[data-id='present-province']").click(function() {
		if ($("#present-province option").length < 3) {
			$.ajax( {
				url: "../ajax/getAllProvinceList",
				type: "POST",
				dataType: "JSON",
			}).done(function( json ) {
				$.each(json.list, function(i, pr) {
					// prevent repeat province option
					if (pr.id != ${user.presentProvince})
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
	$("button[data-id='present-city']").click(function() {
		if ($("#present-city option").length < 3) {
			$.ajax( {
				url: "../ajax/getCityListByProvinceId",
				type: "POST",
				dataType: "JSON",
				data: {
					provinceId: $("#present-province").val()
				}
			}).done(function( json ) {
				$.each(json.list, function(i, ct) {
					// prevent repeat & missing city option
					if (ct.id != ${user.presentCity} || $("#present-city option[value='" + ${user.presentCity} + "']").length == 0)
						$("#present-city").append("<option value='" + ct.id + "'>" + ct.name + "</option>");
				});
				$("#present-city").selectpicker("refresh");
			}).fail(function() {
				alert("FAIL");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
	});
	$("button[data-id='present-college']").click(function() {
		if ($("#present-college option").length < 3) {
			if ($("select#present-city").val() != 0) {
				$.ajax( {
					url: "../ajax/getCollegeListByCityId",
					type: "POST",
					dataType: "JSON",
					data: {
						cityId: $("#present-city").val()
					}
				}).done(function( json ) {
					$.each(json.list, function(i, clg) {
						// prevent repeat & missing college option
						if (clg.id != ${user.college} || $("#present-college option[value='" + ${user.college} + "']").length == 0)
							$("#present-college").append("<option value='" + clg.id + "'>" + clg.name + "</option>");
					});
					$("#present-college").selectpicker("refresh");
				}).fail(function() {
					alert("FAIL");
				}).error(function (XMLHttpRequest, textStatus, errorThrown) {
					$("body").append(XMLHttpRequest.responseText);
				});
			}
			else {
				$.ajax( {
					url: "../ajax/getCollegeListByProvinceId",
					type: "POST",
					dataType: "JSON",
					data: {
						provinceId: $("#present-province").val()
					}
				}).done(function( json ) {
					$.each(json.list, function(i, clg) {
						if (clg.id != ${user.college} || $("#present-college option[value='" + ${user.college} + "']").length == 0)
							$("#present-college").append("<option value='" + clg.id + "'>" + clg.name + "</option>");
					});
					$("#present-college").selectpicker("refresh");
				}).fail(function() {
					alert("FAIL");
				}).error(function (XMLHttpRequest, textStatus, errorThrown) {
					$("body").append(XMLHttpRequest.responseText);
				});
			}
		}
	});
	$("select#present-province").change(function() {
		// clear old data in order to reload the new one
		$("#present-city").html("");
		$("#present-city").append("<option value='0'></option>");
		$("#present-city").selectpicker("refresh");
		$("#present-college").html("");
		$("#present-college").append("<option value='0'></option>");
		$("#present-college").selectpicker("refresh");
		
		if ($(this).val() != userPresentProvince) {
			isPresentProvinceChange = true;
			isPresentCityChange = true;
			isCollegeChange = true;
		}
		else
			isPresentProvinceChange = false;
		canSave();
	});
	$("select#present-city").change(function() {
		// clear old data
		$("#present-college").html("");
		$("#present-college").append("<option value='0'></option>");
		$("#present-college").selectpicker("refresh");
		
		if ($(this).val() != userPresentCity) {
			isPresentCityChange = true;
			isCollegeChange = true;
		}
		else
			isPresentCityChange = false;
		canSave();
	});
	$("select#present-college").change(function() {
		if ($(this).val() != userCollege)
			isCollegeChange = true;
		else
			isCollegeChange = false;
		canSave();
	});
	$("input#college-major").keyup(function() {
		if ($(this).val().trim() != userCollegeMajor)
			isCollegeMajorChange = true;
		else
			isCollegeMajorChange = false;
		canSave();
	});
	
	// SAVE THE UPDATE
	$("#setting-content #save").click(function() {
		var canGo = true;
		
		$("#alert-box>div").hide();
		// validate the length of username
		if ($("input#name").val().trim().length < 1 || $("input#name").val().trim().length > 20) {
			$("#bad-name-length").show();
			canGo = false;
		}
		if (!canGo)
			return;
		// validate the username
		if ($("input#name").val().trim() != userName) {
			$.ajax( {
					async: false,
					url: "../ajax/checkUserName",
					type: "POST",
					dataType: "JSON",
					data: { 
						username: $("input#name").val().trim()
					}
			}).done(function( json ) {
				if (json.isExisted) {
					$("#existed-name").show();
					canGo = false;
				}
			}).fail(function() {
				alert("FAIL");
				canGo = false;
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
				canGo = false;
			});
		}
		if (!canGo)
			return;
		// reset password
		if ($("input#new-password").val() != "") {
			if ($("input#original-password").val() == "") {
				$("#empty-original-password").show();
				canGo = false;
			}
			else if ($("input#new-password").val().length < 7) {
				$("#bad-new-password-length").show();
				canGo = false;
			}
			else if ($("input#new-password").val() == "1234567") {
				$("#bad-new-password").show();
				canGo = false;
			}
			else if ($("input#new-password").val() == $("input#original-password").val()) {
				$("#same-password").show();
				canGo = false;
			}
			else if ($("input#repeat-new-password").val() == "") {
				$("#empty-repeat-new-password").show();
				canGo = false;
			}
			else if ($("input#new-password").val() != $("input#repeat-new-password").val()) {
				$("#wrong-repeat-password").show();
				canGo = false;
			}
			else {
				$.ajax( {
					async: false,
					url: "../ajax/validatePassword",
					type: "POST",
					dataType: "JSON",
					data: { 
						username: $("input#name").val().trim(),
						inputPassword: $("input#original-password").val()
					}
				}).done(function( json ) {
					if (!json.isLogin) {
						$("#not-login").show();
						canGo = false;
					}
					else if (!json.isRight) {
						$("#wrong-password").show();
						canGo = false;
					}
					else
						userNewInputPassword = $("input#new-password").val();
				}).fail(function() {
					alert("FAIL");
					canGo = false;
				}).error(function (XMLHttpRequest, textStatus, errorThrown) {
					$("body").append(XMLHttpRequest.responseText);
					canGo = false;
				});
			}
		}
		if (!canGo)
			return;
		if ($("input#senior-name").val().trim().length > 25) {
			$("#bad-senior-name-length").show();
			canGo = false;
		}
		if (!canGo)
			return;
		if ($("input#college-major").val().trim().length > 25) {
			$("#bad-college-major-length").show();
			canGo = false;
		}
		if (!canGo)
			return;
		
		$.ajax( {
			url: "<%=basepath%>/user/setting/save",
			type: "POST",
			dataType: "JSON",
			data: {
				intro: $("#setting-content #intro textarea").val(),
				interest: $("#setting-content #interest textarea").val(),
				sex: $("input[type='radio'][name='sexValue']:checked").val(),
				birth: $("input#birthDate").val(),
				website: $("input#website").val().trim(),
				name: $("input#name").val().trim(),
				newInputPassword: $("input#new-password").val(),
				fromProvince: $("select#from-province").val(),
				fromCity: $("select#from-city").val(),
				senior: $("input#senior-name").val().trim(),
				presentProvince: $("select#present-province").val(),
				presentCity: $("select#present-city").val(),
				college: $("select#present-college").val(),
				collegeMajor: $("input#college-major").val().trim(),
				joinCollegeDate: $("input#join-college-date").val()
			}
		}).done(function( json ) {
			if (json.isDone) {
				// disable the save button
				$("#setting-content #save").attr("disabled", "true");
				// update values
				userIntro = $("#setting-content #intro textarea").val();
				userInterest = $("#setting-content #interest textarea").val();
				userSex = $("input[type='radio'][name='sexValue']:checked").val();
				userBirth = $("input#birthDate").val();
				userWebsite = $("input#website").val().trim();
				userName = $("input#name").val().trim();
				userFromProvince = $("select#from-province").val();
				userFromCity = $("select#from-city").val();
				userSenior = $("input#senior-name").val().trim().trim();
				userPresentProvince = $("select#present-province").val();
				userPresentCity = $("select#present-city").val();
				userCollege = $("select#present-college").val();
				userCollegeMajor = $("input#college-major").val().trim();
				joinCollegeDate = $("input#join-college-date").val();
				
				// refresh username
				$("#user-showcase #user-nickname").html("<b>" + userName + "</b>");
				$("#top-bar #user-title>span #user-name").html(userName);
				canGo = false;
			}
			else {
				alert("保存失败");
			}
		}).fail(function() {
			alert("FAIL");
		}).error(function (XMLHttpRequest, textStatus, errorThrown) {
			$("body").append(XMLHttpRequest.responseText);
		});
	});
	
});

function openSetting(option) {
	$("#ver-navi-bar .list-group").hide().parent().removeClass("active");
	$("#ver-navi-bar #" + option + ">.list-group").show().parent().addClass("active");
	$("#setting-content>div:not(#alert-box)").hide();
	$("#setting-content #" + option).show();
};

// enable save button
function canSave() {
	if (isIntroChange || isInterestChange || isSexChange || isBirthChange || isWebsiteChange ||
			isNameChange ||
			isNewPasswordInput ||
			isFromProvinceChange || isFromCityChange || isSeniorChange ||
			isPresentProvinceChange || isPresentCityChange || isCollegeChange || isCollegeMajorChange || isJoinCollegeDateChange)
		$("#setting-content #save").removeAttr("disabled");
	else
		$("#setting-content #save").attr("disabled", "true");
};
</script>
<title>KickClub - Setting</title>
</head>
<body>
<jsp:include page="../top-float-bar.jsp" flush="true" />
<div id="main">
	<div class="row">
		<div class="col-md-4">
			<div id="ver-navi-bar">
				<div id="user-showcase">
					<div id="user-photo"><img src="<%=basepath%>/${user.photo}" /></div>
					<div id="user-nickname"><b>${user.name}</b></div>
				</div>
				<ul class="nav nav-pills nav-stacked" role="tablist">
					<li id="profile" role="presentation" class="active">
						<a href="javascript: openSetting('profile')">个人资料 </a>
						<ul class="list-group">
							<li class="list-group-item">简介</li>
							<li class="list-group-item">兴趣爱好</li>
							<li class="list-group-item">性别</li>
							<li class="list-group-item">出生日期</li>
						</ul>
					</li>
					<li id="username" role="presentation">
						<a href="javascript: openSetting('username')">改个昵称</a>
						<ul class="list-group">
							<li class="list-group-item">昵称</li>
						</ul>
					</li>
					<li id="password" role="presentation">
						<a href="javascript: openSetting('password')">更换密码</a>
						<ul class="list-group">
							<li class="list-group-item">密码</li>
						</ul>
					</li>
					<li id="senior" role="presentation">
						<a href="javascript: openSetting('senior')">高中信息</a>
						<ul class="list-group">
							<li class="list-group-item">省份</li>
							<li class="list-group-item">城市</li>
							<li class="list-group-item">高中名字</li>
						</ul>
					</li>
					<li id="college" role="presentation">
						<a href="javascript: openSetting('college')">大学状态</a>
						<ul class="list-group">
							<li class="list-group-item">省份</li>
							<li class="list-group-item">城市</li>
							<li class="list-group-item">我的大学</li>
							<li class="list-group-item">专业</li>
							<li class="list-group-item">入学日期</li>
						</ul>
					</li>
					<li id="portrait" role="presentation">
						<a href="javascript: openSetting('portrait')">头像上传</a>
						<ul class="list-group">
							<li class="list-group-item">头像</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="col-md-8">
			<div id="setting-content">
				<div id="profile">
					<div class="panel panel-info" id="intro">
						<div class="panel-heading">
							<h4>简介 </h4>
						</div>
						<div class="panel-body">
							<textarea rows="4">${user.intro}</textarea>
						</div>
					</div>
					<div class="panel panel-info" id="interest">
						<div class="panel-heading">
							<h4>兴趣爱好</h4>
						</div>
						<div class="panel-body">
							<textarea rows="3">${user.interest}</textarea>
						</div>
					</div>
					<div class="btn-group" data-toggle="buttons" id="sex">
						<label class="btn btn-info">
							<input type="radio" name="sexValue" value=1>男
						</label>
						<label class="btn btn-info">
							<input type="radio" name="sexValue" value=2>女
						</label>
						<label class="btn btn-info">
							<input type="radio" name="sexValue" value=0>保密
						</label>
					</div>
					<div class="well" style="margin-top: 20px;">
						<label class="control-label" for="birthDate">出生日期</label>
						<div class="datepicker input-append date" data-date="1990-01-01" data-date-formate="yyyy-mm-dd" data-date-viewmode="years">
							<input id="birthDate" class="span2" size="16" type="text" value="${user.birth}" readonly>
							<span class="add-on">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
						<!-- <label class="control-label" for="birthDate">出生日期</label>
						<input type="text" class="span2" value="02/13/2017" data-date-format="mm-dd'yyyy" id="birthDate"> -->
					</div>
					<div class="well">
						<label class="control-label" for="website">个人网站</label>
						<input id="website" type="text" style="width: 66%; display: block;" value="${user.website}">
					</div>
				</div>
				
				<div id="username">
					<div class="panel panel-primary" id="name">
						<div class="panel-heading">
							<h4>昵称 </h4>
						</div>
						<div class="panel-body">
							<input id="name" type="text" style="width: 50%; height: 34px; padding: 15px; font-size: 18px;" value="${user.name}">
						</div>
					</div>
				</div>
				
				<div id="password">
					<div class="panel panel-warning" id="password">
						<div class="panel-heading">
							<h4>密码 </h4>
						</div>
						<div class="panel-body" id="password-field">
							<div>
								<label class="control-label" for="original-password">原密码</label>
								<input id="original-password" type="password" style="width: 45%; padding: 3px;">
							</div>
							<div style="margin-top: 30px;">
								<label class="control-label" for="new-password">新密码</label>
								<input id="new-password" type="password">
							</div>
							<div>
								<label class="control-label" for="repeat-new-password">重输入新密码</label>
								<input id="repeat-new-password" type="password">
							</div>
						</div>
					</div>
				</div>
				
				<div id="senior">
					<div class="panel panel-info" id="senior-location">
						<div class="panel-heading">
							<h4>地理位置</h4>
						</div>
						<div class="panel-body">
							<h1><small>省份</small></h1>
							<select id="from-province" class="selectpicker" title="高中所在省份" data-style="btn-info" data-live-search="true">
							<c:if test="${user.fromProvince != 0}">
								<option value="0"></option>
							</c:if>
								<option value="${user.fromProvince}" selected="selected">${fromProvinceName}</option>
							</select>
							<h1><small>城市</small></h1>
							<select id="from-city" class="selectpicker" title="高中所在城市" data-live-search="true">
							<c:if test="${user.fromCity != 0}">
								<option value="0"></option>
							</c:if>
								<option value="${user.fromCity}" selected="selected">${fromCityName}</option>
							</select>
						</div>
					</div>
					<div class="panel panel-info" id="senior-name">
						<div class="panel-heading">
							<h4>高中名字</h4>
						</div>
						<div class="panel-body">
							<input id="senior-name" type="text" style="width: 70%; padding: 3px;" value="${user.senior}">
						</div>
					</div>
				</div>
				
				<div id="college">
					<div class="panel panel-primary" id="college-location">
						<div class="panel-heading">
							<h4>地理位置</h4>
						</div>
						<div class="panel-body">
							<h1><small>省份</small></h1>
							<select id="present-province" class="selectpicker" title="大学所在省份" data-style="btn-primary" data-live-search="true">
							<c:if test="${user.presentProvince != 0}">
								<option value="0"></option>
							</c:if>
								<option value="${user.presentProvince}" selected="selected">${presentProvinceName}</option>
							</select>
							<h1><small>城市</small></h1>
							<select id="present-city" class="selectpicker" title="大学所在城市" data-live-search="true">
							<c:if test="${user.presentCity != 0}">
								<option value="0"></option>
							</c:if>
								<option value="${user.presentCity}" selected="selected">${presentCityName}</option>
							</select>
						</div>
					</div>
					<div class="panel panel-primary" id="college-name">
						<div class="panel-heading">
							<h4>我的大学</h4>
						</div>
						<div class="panel-body">
							<select id="present-college" class="selectpicker" title="大学名字" data-style="btn-primary" data-live-search="true">
							<c:if test="${user.college != 0}">
								<option value="0"></option>
							</c:if>
								<option value="${user.college}" selected="selected">${collegeName}</option>
							</select>
						</div>
					</div>
					<div class="panel panel-primary" id="college-detail">
						<div class="panel-heading">
							<h4>其他</h4>
						</div>
						<div class="panel-body">
							<h2><small>专业</small></h2>
							<input id="college-major" type="text" style="width: 50%; padding: 5px;" value="${user.collegeMajor}">
							<h2><small>入学日期</small></h2>
							<div class="datepicker input-append date" data-date="2000-01-01" data-date-formate="yyyy-mm-dd" data-date-viewmode="years">
								<input id="join-college-date" class="span2" size="16" type="text" value="${user.joinCollegeDate}" readonly>
								<span class="add-on">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
				</div>
				
				<div id="portrait">
					<div class="panel panel-primary" id="new-portrait">
						<div class="panel-heading">
							<h4>头像</h4>
						</div>
						<div class="panel-body">
							
						</div>
					</div>
				</div>
				
				<div id="alert-box">
					<div id="not-login" class="alert alert-danger" role="alert">登陆信息已失效，请重新登陆</div>
					<div id="bad-name-length" class="alert alert-warning" role="alert">昵称长度应在1到20字符之间</div>
					<div id="existed-name" class="alert alert-danger" role="alert">该昵称已存在</div>
					<div id="empty-original-password" class="alert alert-warning" role="alert">原密码不得为空</div>
					<div id="bad-new-password-length" class="alert alert-warning" role="alert">密码长度应不小于7</div>
					<div id="bad-new-password" class="alert alert-warning" role="alert">别用1234567当密码哦</div>
					<div id="empty-repeat-new-password" class="alert alert-warning" role="alert">请再输入一次新密码</div>
					<div id="wrong-password" class="alert alert-danger" role="alert">输入的原密码不正确</div>
					<div id="same-password" class="alert alert-warning" role="alert">新密码与旧密码一样</div>
					<div id="wrong-repeat-password" class="alert alert-danger" role="alert">重输入的密码不一致</div>
					<div id="bad-senior-name-length" class="alert alert-warning" role="alert">高中名字不得大于25个字符</div>
					<div id="bad-college-major-length" class="alert alert-warning" role="alert">填写的专业不得大于25个字符</div>
				</div>
							
				<button id="save" type="button" class="btn btn-primary btn-lg" disabled="disabled">保存</button>
				
			</div>
		</div>
	</div>
</div>
</body>
</html>