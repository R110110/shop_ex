<%@page import="pack.member.MemberMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="memberBean" class="pack.member.MemberBean"/>
<jsp:setProperty property="*" name="memberBean"/>
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr"/>

<%
boolean b =memberMgr.memberInsert(memberBean);

if(b){
	out.println("<b>회원가입을 축하합니다</b>");
	out.println("<a href='login.jsp'>로그인</a>");
} else{
	out.println("<b>회원가입에 실패했습니다</b>");
	out.println("<a href='register.jsp'>가입 재시도</a>");
}
%>