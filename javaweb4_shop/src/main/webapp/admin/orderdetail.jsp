<%@page import="pack.product.ProductBean"%>
<%@page import="pack.order.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.order.OrderMgr"/>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr"/>
<%
OrderBean order = orderMgr.getOrderDetail(request.getParameter("no"));
ProductBean product = productMgr.getProduct(order.getProduct_no());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
** 주문 상태 처리 **<br/>
<%@ include file="admin_top.jsp" %>
<form action="orderproc_admin.jsp" name="detailFrm" method="post">
<table border="1">
	<tr>
		<td>고객 아이디 : <%=order.getId() %></td>
		<td>주문번호 : <%=order.getId() %></td>
		<td>상품번호 : <%=product.getNo() %></td>
		<td>상품명 : <%=product.getName() %></td>
	</tr>
	<tr>
		<td>상품가격 : <%=product.getPrice() %></td>
		<td>주문수량 : <%=order.getQuantity() %></td>
		<td>재고수량 : <%=product.getStock() %></td>
		<td>주문일자 : <%=order.getSdate() %></td>
	</tr>
	<tr>
		<td colspan="4"> 총 결제 금액:
			<%=Integer.parseInt(order.getQuantity()) * Integer.parseInt(product.getPrice()) %> 원
		</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
		주문 상태 :
		<select name="state">
			<option value="1">접수</option>
			<option value="2">입금확인</option>
			<option value="3">배송준비</option>
			<option value="4">배송중</option>
			<option value="5">처리완료</option>
		</select>
		 <script type="text/javascript">
		  document.detailFrm.state.value = <%=order.getState() %>
		 </script>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
			<input type="button" value="수정" onclick="orderUpdate(this.form)">
			<input type="button" value="삭제" onclick="orderDelete(this.form)">
			<input type="hidden" name="no" value="<%= order.getNo()%>">
			<input type="hidden" name="flag">
		</td>
	</tr>
</table>
</form>
<%@ include file="admin_bottom.jsp" %>
</body>
</html>