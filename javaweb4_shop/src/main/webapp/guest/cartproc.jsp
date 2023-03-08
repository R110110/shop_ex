<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="pack.product.CartMgr" scope="session"/> <% //세션이 살아있는 동안만 cartMgr이 유효 %>
<jsp:useBean id="order" class="pack.order.OrderBean"/>
<jsp:setProperty property="*" name="order"/>
<%
String flag = request.getParameter("flag");	//구매목록, 수정, 삭제 판단용
String id = (String)session.getAttribute("idKey");
//out.print(order.getQuantity());

if(id == null){
	response.sendRedirect("../member/login.jsp");
} else {
	if(flag == null){	// Cart에 주문 상품 담기
		order.setId(id);	// 로그인한 유저의 아이디
		cartMgr.addCart(order);	// Cart에 주문 상품 담기(DB x) : id(주문자) product_no(상품) qauntity(수량)
%>
	<script>
	alert("장바구니에 담았습니다");
	location.href="cartlist.jsp";
	</script>
<%		
	} else if(flag.equals("update")){
		order.setId(id);
		cartMgr.updateCart(order);
%>
	<script>
	alert("장바구니의 내용을 수정했습니다");
	location.href="cartlist.jsp";
	</script>
<%		
	} else if(flag.equals("delete")){
		cartMgr.deleteCart(order);
%>
	<script>
	alert("해당 상품의 주문을 삭제했습니다");
	location.href="cartlist.jsp";
	</script>
<%		
	}
}

%>