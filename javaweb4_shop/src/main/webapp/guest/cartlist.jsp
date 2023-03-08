<%@page import="pack.product.ProductBean"%>
<%@page import="pack.order.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="pack.product.CartMgr" scope="session"/>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
<h2>** 장바구니 목록 **</h2>
<%@ include file="guest_top.jsp" %>
<table>
	<tr style="background-color: DarkSeaGreen">
		<th>주문상품</th><th>가격(소계)</th><th>수량</th><th>수정 / 삭제</th><th>조회</th>
	</tr>
	<% 
	int totalPrice = 0;
	Hashtable hCart = cartMgr.getCartList();
	if(hCart.size() == 0){
	%>
	<tr><td colspan="5">주문 건수가 없습니다</td></tr>
	<%	
	} else {
		Enumeration enu = hCart.keys();
		while(enu.hasMoreElements()){
			OrderBean order = (OrderBean)hCart.get(enu.nextElement());
			ProductBean product = productMgr.getProduct(order.getProduct_no());
			int price = Integer.parseInt(product.getPrice());
			int quantity = Integer.parseInt(order.getQuantity());
			int subTotal = price * quantity;	// 소계
			totalPrice += subTotal;				// 총계
	%>
	<form action="cartproc.jsp" method="get">
	<input type="hidden" name="flag"/>
	<input type="hidden" name="product_no" value="<%=product.getNo()%>"/>
	<tr style="text-align: center;">
		<td><%=product.getName() %></td>
		<td><%=subTotal %></td>
		<td>
			<input type="number" style="text-align: center; width: 2cm" min="0" name="quantity" value="<%=quantity %>"> 개
		</td>
		<td>
			<input style="background-color: ivory;" type="button" value="수정" onclick="cartUpdate(this.form)"> / 
			<input style="background-color: ivory;" type="button" value="삭제" onclick="cartDelete(this.form)"> 
		</td>
		 <td>
		 <a href="javascript:productDetail_guest('<%=product.getNo()%>')">상세보기</a>
		 </td>
	</tr>
	</form>
<%	
	}
%>
	<tr>
		<td colspan="5">
		<br>
		<b>총 결제 금액 : <%=totalPrice%> 원</b>&nbsp;&nbsp;
		<a href="orderproc.jsp">[주문(결제)하기]</a>
		</td>
	</tr>
<%

}
%>	
</table>
<%@ include file="guest_bottom.jsp" %>
<form action="productdetail_g.jsp" name="detailFrm">
	<input type="hidden" name="no">
</form>
</body>
</html>