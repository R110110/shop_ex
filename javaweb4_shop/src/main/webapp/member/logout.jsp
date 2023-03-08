<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//session.invalidate();	// 해당 사용자의 모든 세션을 제거
session.removeAttribute("idKey");	// 해당 사용자의 세션에서 특정 값을 제거
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
alert("로그아웃 성공");
location.href="../guest/guest_index.jsp";
</script>
</body>
</html>