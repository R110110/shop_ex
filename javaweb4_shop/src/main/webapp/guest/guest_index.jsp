<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
<table>
	<tr>
		<td style="font-size: 20px;">전문 쇼핑몰</td>
	</tr>
</table>
<%@ include file="guest_top.jsp" %>
<table>
<% if(memid != null) {%>
	<tr>
		<td>
			<%=memid %>님의 방문을 환영합니다 <%-- //jsp 액션태그 include로 jsp를 불러왔기 때문에 변수 사용 가능 --%>
			<br/>
			<img src="../images/pic2.gif"/>
		</td>
	</tr>
<%} else {%>
	<tr>
		<td style="font-size: 20px; background-image: url('../images/pic.jpg'); background-size:100%">
			<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
			고객님 어서오세요<br/>
			로그인 후 사용바랍니다<br/><br/><br/><br/>
		</td>
	</tr>
<%} %>
</table>
<%@ include file="guest_bottom.jsp" %>
</body>
</html>