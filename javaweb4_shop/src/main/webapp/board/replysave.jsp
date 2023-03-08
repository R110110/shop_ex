<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>    
<jsp:useBean id="bean" class="pack.board.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="boardMgr" class="pack.board.BoardMgr"/>

<%
String spage = request.getParameter("page");
int num = bean.getNum();
int gnum = bean.getGnum();
int onum = bean.getOnum() + 1;
int nested = bean.getNested() + 1;

// 같은 그룹 내에서 새로운 댓글의 onum보다 크거나 같은 값인 경우 입력 전에 수정하기
boardMgr.updateOnum(gnum, onum);	// onum 갱신 메소드

// 댓글 저장
bean.setOnum(onum);
bean.setNested(nested);
bean.setBip(request.getRemoteAddr());
bean.setBdata();
bean.setNum(boardMgr.currentMaxNum() + 1);
boardMgr.saveReplyData(bean);

response.sendRedirect("boardlist.jsp?page=" + spage);	// 댓글 저장 후 목록보기

%>






