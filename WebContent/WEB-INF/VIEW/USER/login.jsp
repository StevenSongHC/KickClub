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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-select.min.css">
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
	function doLogin() {
		$.ajax( {
			url: "login/do",
			type: "POST",
			dataType: "JSON",
			data: {
				email: $("#login-email").val(),
				password: $("#login-password").val()
			}
		}).done(function( json ) {
			BootstrapDialog.show({
				type: BootstrapDialog.TYPE_PRIMARY,
				title: "Yes",
				message: "Done"
			});
		}).fail(function() {
			BootstrapDialog.show({
				type: BootstrapDialog.TYPE_DANGER,
				title: "出错",
				message: "请重试"
			});
		}).error(function (XMLHttpRequest, textStatus, errorThrown) {
			$("body").append(XMLHttpRequest.responseText);
		});
	}
</script>
</head>
<body>
<div style="width: 50%;margin: auto;margin-top: 20px">
	<form class="form-horizontal" role="form">
		<div class="form-group">
			<label for="login-email" class="col-sm-2 control-label">账号</label>
			<div class="col-sm-10">
				<input type="text" id="login-email" class="form-control" placeholder="请输入邮箱">
			</div>
		</div>
		<div class="form-group">
			<label for="login-password" class="col-sm-2 control-label">密码</label>
			<div class="col-sm-10">
				<input type="password" id="login-password" class="form-control" placeholder="请输入密码">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<div class="checkbox">
					<label>
						<input type="checkbox">记住我
					</label>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button class="btn btn-primary" onclick="doLogin()">登陆</button>
			</div>
		</div>
	</form>
</div>
</body>
</html>