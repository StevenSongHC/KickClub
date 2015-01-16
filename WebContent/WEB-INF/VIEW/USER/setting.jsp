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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/user_style/setting-page-style.css">
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-datepicker.css">
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#ver-navi-bar .list-group:first").show();
	
	$("input[type='radio'][name='sexValue'][value=" + ${user.sex} + "]").attr("checked", "checked").parent().addClass("active");
	
	var userIntro = $("#setting-content #intro textarea").val();
	var userInterest = $("#setting-content #interest textarea").val();
	var userSex = $("input[type='radio'][name='sexValue']:checked").val();
	var userBirth = $("#setting-content #birthDate").val();
	var userWebsite = $("#setting-content #website").val();
	isIntroChange = false;
	isInterestChange = false;
	isSexChange = false;
	isBirthChange = false;
	isWebsiteChange = false;
	
	var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
	
	$(".datepicker").datepicker()
					.on("changeDate", function(e) {
						if ($("#birthDate").val() != userBirth)
							isBirthChange = true;
						else
							usBirthChange = false;
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
		if ($(this).val() != userWebsite)
			isWebsiteChange = true;
		else
			isWebsiteChange = false;
		canSave();
	});
	
	// SAVE THE UPDATE
	$("#setting-content #save").click(function() {
		$.ajax( {
			url: "<%=basepath%>/user/setting/save",
			type: "POST",
			dataType: "JSON",
			data: {
				intro: $("#setting-content #intro textarea").val(),
				interest: $("#setting-content #interest textarea").val(),
				sex: $("input[type='radio'][name='sexValue']:checked").val(),
				birth: $("#birthDate").val(),
				website: $("#website").val()
			}
		}).done(function( json ) {
			if (json.isDone) {
				// disable the save button
				$("#setting-content #save").attr("disabled", "true");
				// update values
				userIntro = $("#setting-content #intro textarea").val();
				userInterest = $("#setting-content #interest textarea").val();
				userSex = $("input[type='radio'][name='sexValue']:checked").val();
				userBirth = $("#setting-content #birthDate").val();
				userWebsite = $("#setting-content #website").val();
			}
			else
				alert("保存失败");
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
	
}

// enable save button
function canSave() {
	if (isIntroChange || isInterestChange || isSexChange || isBirthChange || isWebsiteChange)
		$("#setting-content #save").removeAttr("disabled");
	else
		$("#setting-content #save").attr("disabled", "true");
}
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
					<li id="personel-info" role="presentation" class="active">
						<a href="javascript: openSetting('personel-info')">个人资料</a>
						<ul class="list-group">
							<li class="list-group-item">简介</li>
							<li class="list-group-item">兴趣爱好</li>
							<li class="list-group-item">性别</li>
							<li class="list-group-item">出生日期</li>
						</ul>
					</li>
					<li id="email" role="presentation">
						<a href="javascript: openSetting('email')">改个昵称</a>
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
							<li class="list-group-item">大学名字</li>
							<li class="list-group-item">专业</li>
							<li class="list-group-item">入学日期</li>
						</ul>
					</li>
					<li id="avatar" role="presentation">
						<a href="javascript: openSetting('avatar')">头像上传</a>
						<ul class="list-group">
							<li class="list-group-item">头像</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="col-md-8">
			<div id="setting-content">
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
				<button id="save" type="button" class="btn btn-primary btn-lg" disabled="disabled">保存</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>