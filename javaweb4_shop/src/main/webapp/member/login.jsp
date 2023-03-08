<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 로그인</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.querySelector("#btnLogin").onclick = funcLogin;
	document.querySelector("#btnHome").addEventListener("click", funcHome);
}

function funcLogin(){
	if(loginForm.id.value === ""){
		alert("아이디 입력");
		loginForm.id.focus();
	} else if (loginForm.passwd.value === ""){
		alert("비밀번호 입력");
		loginForm.passwd.focus();
	} else {
		loginForm.method = "post";
		loginForm.action = "loginproc.jsp";	// 아이디 비밀번호 확인 후 loginproc.jsp에서 세션 생성
		loginForm.submit();
	}
}

function funcHome(){
	location.href="../guest/guest_index.jsp";
}

</script>
</head>
<body style="margin-top: 20px;">
	<form name="loginForm">
	<table>
		<tr>
			<td colspan="2">*로그인*</td>
		</tr>
		<tr>
			<td>아이디 : </td>
			<td><input type="text" name="id"/></td>
		</tr>
		<tr>
			<td>비밀번호 : </td>
			<td><input type="text" name="passwd"/></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="로그인" id="btnLogin"/>
				<input type="button" value="홈페이지" id="btnHome"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>