<%@page import="pack.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memberMgr" class="pack.member.MemberMgr" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자-회원관리</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
<h2>** 관리자 - 전체 회원관리 **</h2>
<div style="text-align: center;">
<%@ include file="admin_top.jsp" %>	<%-- 로그인 여부 확인 후 관리자 메뉴로 이동 --%>
</div>

<table style="width: 90%">
  <tr style="background-color: cyan">
  	<th>아이디</th><th>회원명</th><th>이메일</th><th>전화</th><th>수정</th>
  </tr>
  <%
  ArrayList<MemberBean> list = memberMgr.getMemberAll(); 
  for(MemberBean m:list){
  %>
  <tr style="text-align: center;">
  	<td><%=m.getId() %></td>
  	<td><%=m.getName() %></td>
  	<td style="text-align: left;"><%=m.getEmail() %></td>
  	<td><%=m.getPhone() %></td>
  	<td><a href="javascript:memUpdate('<%=m.getId()%>')">수정하기</a></td>
  </tr>
  <%	  
  }
  %>
</table>

<%@ include file="admin_bottom.jsp" %>

<form action="memberupdate_admin.jsp" name="updateFrm" method="post">
<input type="hidden" name="id">
</form>
</body>
</html>






