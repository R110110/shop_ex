<%@page import="pack.product.ProductMgr"%>
<%@page import="pack.product.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr"/>
<% 
String no = request.getParameter("no");
ProductBean bean = productMgr.getProduct(no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
** 상품 상세보기 **
<%@ include file="admin_top.jsp" %>	
<table>
	<tr>
		<td>
			<img src="../upload/<%=bean.getImage()%>" width="150"/>
		</td>
		<td>
			<table style="width: 100%">
				<tr><td>번호: </td><td><%=bean.getNo() %></td></tr>
				<tr><td>상품명: </td><td><%=bean.getName() %></td></tr>
				<tr><td>가격: </td><td><%=bean.getPrice() %></td></tr>
				<tr><td>등록일: </td><td><%=bean.getSdate() %></td></tr>
				<tr><td>재고량: </td><td><%=bean.getStock() %></td></tr>
			</table>
		</td>
		<td style="vertical-align: top">
			* 상품 설명 *<br/>
			<%=bean.getDetail() %>
		</td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: center;">
		<a href="javascript:productUpdate('<%=bean.getNo() %>')">수정하기</a>
		<a href="javascript:productDelete('<%=bean.getNo() %>')">삭제하기</a>
		</td>
	</tr>
</table>
<%@ include file="admin_bottom.jsp" %>

<form action="productupdate.jsp"name="updateForm">
	<input type="hidden" name="no">
</form>

<form action="productproc.jsp?flag=delete"name="delForm" method="post"><%--get방식에서는 flag가 넘어가지 않음 --%>
	<input type="hidden" name="no">
</form>
</body>
</html>