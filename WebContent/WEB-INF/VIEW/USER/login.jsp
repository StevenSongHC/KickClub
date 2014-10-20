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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-dialog.css">
<style type="text/css">
#alert-box div {
	display: none;
	margin: auto;
	width: 50%;
}
</style>
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript"	src="<%=basepath%>/js/jquery.form.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#login-form").submit(function() {
		var options = {
				url: "login/do",
				beforeSubmit: function() {
					$("#alert-box>div").hide();
					if ($("#login-form #email").val() == "") {
						$("#empty-email").show();
						$("#login-form #email").focus();
						return false;
					}
					else if ($("#login-form #password").val() == "") {
						$("#empty-password").show();
						$("#login-form #password").focus();
						return false;
					}
					return true;
				},
				success: function( json ) {
					switch(json.statusCode) {
						case -1 :
							$("#wrong-password").show();
							$("#login-form #password").val("").focus();
							break;
						case 0:
							$("#non-exist-user").show();
							$("#login-form #email").focus();
							break;
						case 1:
							console.log(document.referrer);
							window.location.href = document.referrer;
							break;
						default:
							$("#error").show();
					}
				}
			};
		$("#login-form").ajaxSubmit(options);
		return false;
	});
	
});
</script>
</head>
<body>
<div style="width: 50%;margin: auto;margin-top: 20px">
	<form id="login-form" class="form-horizontal">
		<div class="form-group">
			<label for="email" class="col-sm-2 control-label">账号</label>
			<div class="col-sm-10">
				<input type="text" id="email" name="email" class="form-control" placeholder="请输入邮箱">
			</div>
		</div>
		<div class="form-group">
			<label for="password" class="col-sm-2 control-label">密码</label>
			<div class="col-sm-10">
				<input type="password" id="password" name="password" class="form-control" placeholder="请输入密码">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<div class="checkbox">
					<label>
						<input name="rememberme" type="checkbox">记住我
					</label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button class="btn btn-primary">登陆</button>
			</div>
		</div>
	</form>
</div>
<div id="alert-box">
	<div id="empty-email" class="alert alert-warning" role="alert">账号不能为空</div>
	<div id="empty-password" class="alert alert-warning" role="alert">密码不能为空</div>
	<div id="non-exist-user" class="alert alert-warning" role="alert">该用户不存在</div>
	<div id="wrong-password" class="alert alert-warning" role="alert">密码错误</div>
	<div id="error" class="alert alert-danger" role="alert">未知错误</div>
</div>
</body>
</html>