<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="bean" class="pack.board.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="boardMgr" class="pack.board.BoardMgr"/>

<% 
bean.setBip(request.getRemoteAddr());	// 작성자의 ip 얻기
bean.setBdata();
int maxNum = boardMgr.currentMaxNum() + 1;
bean.setNum(maxNum);
bean.setGnum(maxNum);
boardMgr.saveData(bean);	// 저장

response.sendRedirect("boardlist.jsp?page=1");	// 저장 후 목록보기
%>
