<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.order.OrderMgr"/>

<%
String flag = request.getParameter("flag");
String no = request.getParameter("no");
String state = request.getParameter("state");

boolean b = false;
if (flag.equals("update")){
	b = orderMgr.updateOrder(no, state);
} else if(flag.equals("delete")){
	b = orderMgr.deleteOrder(no);
} else {
	response.sendRedirect("ordermanager.jsp");
}
if(b){
%>
	<script>
	alert("처리 성공");
	location.href="ordermanager.jsp"
	</script>
<%	
} else {
%>
	<script>
	alert("처리 실패\n관리자에게 문의 바람");
	location.href="ordermanager.jsp"
	</script>
<%	
}
%>