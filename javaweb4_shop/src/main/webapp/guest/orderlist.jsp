<%@page import="pack.product.ProductBean"%>
<%@page import="pack.order.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.order.OrderMgr"/> 
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
<%@ include file="guest_top.jsp" %>	
** 주문 상품 목록 **
<table>
	<tr>
		<th>주문번호</th><th>상품명</th><th>주문수량</th><th>주문일자</th><th>주문상태</th>
	</tr>
	<% 
	String id = (String)session.getAttribute("idKey");
	ArrayList<OrderBean> list = orderMgr.getOrder(id);	// 해당 id의 주문 상품 목록 보기
	if(list.size() == 0){
	%>
	<tr>
		<td colspan="5">주문한 상품이 없습니다</td>
	</tr>
	<%	
	} else{
		for(OrderBean ord:list){
			ProductBean proBean = productMgr.getProduct(ord.getProduct_no());	// 해당 상품 읽기
	%>		
	<tr style="text-align: center;">
		<td><%=ord.getNo() %></td>
		<td><%=proBean.getName()%></td>
		<td><%=ord.getQuantity() %></td>
		<td><%=ord.getSdate() %></td>
		<td>
		<%
		switch(Integer.parseInt(ord.getState())){
			case 1: out.println("접수"); break;
			case 2: out.println("입금확인"); break;
			case 3: out.println("배송준비"); break;
			case 4: out.println("배송중"); break;
			case 5: out.println("처리완료"); break;
			default: out.println("접수중");
		}		
		%>	
		</td>
	</tr>
	<%		
		}
	}
	%>
</table>
<%@ include file="guest_bottom.jsp" %>
</body>
</html>