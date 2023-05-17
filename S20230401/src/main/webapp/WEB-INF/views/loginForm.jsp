<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 ▒ ShareGo</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/initializer.js"></script>
<script type="text/javascript">
	$(() => {
		$('#username').focus();
	});
</script>
<link href="https://unpkg.com/sanitize.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/preference.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/presets.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/loginForm.css">
</head>
<body>
	<div class="container">
		<div id="loginBox">
			<form action="/loginProc" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" id="redirectLink" name="redirectLink" value="${redirect }">
				<div class="form-group">
					<div id="logo-div" class="full-height" style="display: flex; justify-content: center; align-items: center; padding: 0 10px;">
						<a id="logo" class="full-height" href="${pageContext.request.contextPath}/">
							<div style="width: auto; display: flex; flex-direction: column; justify-content: center; align-items: flex-end;">
								<img src="${pageContext.request.contextPath}/image/ShareGo_Img.png" style="height: 30px;">
								<span style="font-size: 24px; font-weight: 900; margin: -5px 0 0 0;">ShareGo</span>
							</div>
						</a>
					</div>
					<div class="input-box">
						<input type="text" id="username" name="username" required>
						<label for="username">아이디</label>
					</div>
					<div class="input-box">
						<input type="password" id="password" name="password" required>
						<label for="password">비밀번호</label>
						<br>
						<span id="loginErrorMessage">${message }</span>
					</div>
					<button id="login-button" class="subtheme-button adv-hover" type="submit">로그인</button>
					<button id="join-button" class="theme-button adv-hover" type="button" onclick="location.href = '${pageContext.request.contextPath}/join';">회원가입</button>
					<div id="login-forgot">
						로그인 정보를 잊어버렸나요? <a href="${pageContext.request.contextPath }/id/search">아이디 찾기</a> / <a href="${pageContext.request.contextPath }/password/reset">비밀번호 재설정</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>