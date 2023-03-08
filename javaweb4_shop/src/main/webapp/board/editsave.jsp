<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="bean" class="pack.board.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="boardMgr" class="pack.board.BoardMgr"/>

<%
String spage = request.getParameter("page");

boolean b = boardMgr.checkPass(bean.getNum(), bean.getPass());	// 비밀번호 비교

if(b){
	boardMgr.saveEdit(bean);
	response.sendRedirect("boardlist.jsp?page=" + spage);
} else {
%>
	<script type="text/javascript">
		alert("비밀번호 불일치");
		history.back();
	</script>
<% 
}
%>	