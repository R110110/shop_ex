<%@page import="pack.order.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="pack.product.CartMgr" scope="session"/>
<jsp:useBean id="orderMgr" class="pack.order.OrderMgr"/>
<jsp:useBean id="productMgr" class="pack.product.ProductMgr"/>

<%
Hashtable hCart = cartMgr.getCartList();

Enumeration enu = hCart.keys();
if(hCart.size() == 0 ){
%>
	<script>
	alert("주문 내역이 없습니다");
	location.href = "orderlist.jsp";
	</script>
<%	
} else {
	while(enu.hasMoreElements()){
		OrderBean orderBean = (OrderBean)hCart.get(enu.nextElement());
		orderMgr.insertOrder(orderBean);	// 주문 상품 shop_order에 저장
		productMgr.reduceProduct(orderBean);	// 주문 수만큼 상품 재고량 빼기
		cartMgr.deleteCart(orderBean);		// 결제 종료 후 Cart의 주문상품 제거
	}
%>
	<script>
	alert("주문처리가 완료되었습니다");
	location.href="orderlist.jsp"
	</script>
<%
}
%>