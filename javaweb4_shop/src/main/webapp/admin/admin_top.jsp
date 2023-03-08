<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String adminid = (String)session.getAttribute("adminKey");
if(adminid == null){	//로그인을 해야 볼 수 있도록 조건 설정
	response.sendRedirect("adminlogin.jsp");	
}
%>
<table>
  <tr>
	<td><a href="../guest/guest_index.jsp">홈페이지</a></td>
	<td><a href="adminlogout.jsp">로그아웃</a></td>
	<td><a href="membermanager.jsp">회원관리</a></td>
	<td><a href="productmanager.jsp">상품관리</a></td>
	<td><a href="ordermanager.jsp">주문관리</a></td>
  </tr>
</table>
