<%@page import="pack.product.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr"/>
<% 
ProductBean bean = productMgr.getProduct(request.getParameter("no"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
<h2>** 상품 상세 보기 **</h2>
<%@ include file="guest_top.jsp" %>
<form action="cartproc.jsp">
<table>
	<tr>
		<td>
			<img src="../upload/<%=bean.getImage()%>" width="150">
		</td>
		<td style="vertical-align: top">
			<table style="width: 100%">
				<tr><td>번호: </td><td><%=bean.getNo() %></td></tr>
				<tr><td>상품: </td><td><%=bean.getName() %></td></tr>
				<tr><td>가격: </td><td><%=bean.getPrice() %></td></tr>
				<tr><td>등록일: </td><td><%=bean.getSdate() %></td></tr>
				<tr><td>재고량: </td><td><%=bean.getStock() %></td></tr>
				<tr>
					<td>주문 수량: </td>
					<td>
						<input type="number" name="quantity" value="1" style="text-align: center; width: 2cm" min="1">
					</td>
				</tr>
			</table>
		</td>
		<td style="vertical-align: top">
			<b>상품 설명</b><p/>
			<%=bean.getDetail() %>
		</td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: center;">
			<br/>
			<input type="hidden" name="product_no" value="<%=bean.getNo()%>">
			<input type="submit" value="장바구니에 담기">
			<input type="button" value="이전으로 이동" onclick="history.back()">
		</td>
	</tr>
</table>
</form>
<%@ include file="guest_bottom.jsp" %>
</body>
</html>