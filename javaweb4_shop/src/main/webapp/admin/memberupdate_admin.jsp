<%@page import="pack.member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />

<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
//out.print(id);

MemberBean bean = memberMgr.getMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 회원 수정</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnUpdateOkAdmin").onclick=memberUpdateAdmin;
	document.getElementById("btnUpdateCancelAdmin").onclick=memberUpdateCancelAdmin;
}
</script>
</head>
<body>
<form action="memberupdateproc_admin.jsp" name="updateFormAdmin" method="post">
<table>
  <tr style="background-color: blue;">
  	<td colspan="2" style="color: white">
  		<b><%=bean.getName() %></b> 회원님의 정보 수정(관리자) 
  	</td>
  </tr>
  <tr>
  	<td>아이디</td>
  	<td>
  		<%=bean.getId() %>
  		<input type="hidden" name="id" value="<%=bean.getId()%>">
  	</td>
  </tr>
  <tr>
  	<td>비밀번호</td>
  	<td>
  		<input type="password" name="passwd" 
  			value="<%=bean.getPasswd()%>">
  	</td>
  </tr>
  <tr>
  	<td>회원명</td>
  	<td>
  		<input type="text" name="name" value="<%=bean.getName()%>">
  	</td>
  </tr>
  <tr>
  	<td>이메일</td>
  	<td>
  		<input type="text" name="email" value="<%=bean.getEmail()%>">
  	</td>
  </tr>
  <tr>
  	<td>전화번호</td>
  	<td>
  		<input type="text" name="phone" value="<%=bean.getPhone()%>">
  	</td>
  </tr>
  <tr>
  	<td>우편번호</td>
  	<td>
  		<input type="text" name="zipcode" value="<%=bean.getZipcode()%>">
  	</td>
  </tr>
  <tr>
  	<td>주소</td>
  	<td>
  		<input type="text" name="address" 
  			value="<%=bean.getAddress()%>" size="50">
  	</td>
  </tr>
  <tr>
  	<td>직업</td>
  	<td>
  		<select name="job">
  			<option value="<%=bean.getJob()%>"><%=bean.getJob()%></option>
  			<option value="회사원">회사원</option>
  			<option value="학생">학생</option>
  			<option value="자영업">자영업</option>
  			<option value="기타">기타</option>
  		</select>

  	</td>
  </tr>
  <tr>
  	<td colspan="2" style="text-align: center;">
  		<input type="button" value="수정완료" id="btnUpdateOkAdmin">
  		<input type="button" value="수정취소" id="btnUpdateCancelAdmin">
  	</td>
  </tr>
</table>
</form>
</body>
</html>
