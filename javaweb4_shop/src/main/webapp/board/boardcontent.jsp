<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardMgr" class="pack.board.BoardMgr"/>
<jsp:useBean id="dto" class="pack.board.BoardDto"/>

<% 
String num = request.getParameter("num");
String spage = request.getParameter("page");

boardMgr.updateReadcnt(num);	// 조회수 증가
dto = boardMgr.getData(num);	// 해당 자료 읽기

String name = dto.getName();
String pass = dto.getPass();
String mail = dto.getMail();
String title = dto.getTitle();
String cont = dto.getCont();
String bip = dto.getBip();
String bdate = dto.getBdate();
int cnt = dto.getReadcnt();

String apass = "******";	// 일반인은 비밀번호를 볼 수 없음
String adminOk = (String)session.getAttribute("adminOk");
if(adminOk != null){
	if(adminOk.equals("admin")) apass = pass;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">

</head>
<body>
<table>
	<tr>
		<td><b>비밀번호:<%=apass %></b></td>
		<td style="text-align: right;" colspan="2">
			<a href="reply.jsp?num=<%=num%>&page=<%=spage%>"><img src="../images/reply.gif"></a>
			<a href="edit.jsp?num=<%=num%>&page=<%=spage%>"><img src="../images/edit.gif"></a>
			<a href="delete.jsp?num=<%=num%>&page=<%=spage%>"><img src="../images/del.gif"></a>
			<a href="boardlist.jsp?page=<%=spage%>"><img src="../images/list.gif"></a>
		</td>
	</tr>
	<tr>
		<td>
		작성자: <a href="mailto:<%=mail%>"><%=name %></a>(ip : <%=bip %>)
		</td>
		<td>작성일: <%=bdate %></td>
		<td>조회수: <%=cnt %></td>
	</tr>
	<tr>
		<td colspan="3" style="background-color: cyan">제목: <%=title %></td>
	</tr>
	<tr>
		<td colspan="3">
			<textarea rows="10" style="width: 99%" readonly="readonly"><%=cont %></textarea>
		</td>
	</tr>
</table>
</body>
</html>