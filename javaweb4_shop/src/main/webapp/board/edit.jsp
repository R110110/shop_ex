<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardMgr" class="pack.board.BoardMgr"/>
<jsp:useBean id="dto" class="pack.board.BoardDto"/>

<% 
String num = request.getParameter("num");
String spage = request.getParameter("page");
dto = boardMgr.getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script type="text/javascript">
function check(){
	if(frm.pass.value === ""){
		frm.pass.focus();
		alert("비밀번호를 입력하세요");
		return;
	}
	
	if(confirm("정말 수정할까요?")){
		frm.submit();
	}
}
</script>
</head>
<body>
<h2>** 글 수정 **</h2>
<form action="editsave.jsp"name="frm"method="post">
	<input type="hidden"name="num"value="<%=num%>"/>
	<input type="hidden"name="page"value="<%=spage%>"/>
	<table border="1">
		<tr>
			<td colspan="2"><h2>*** 글 수정 ***</h2></td>
		</tr>
		<tr>
			<td align="center" width="100">이 름</td>
			<td width="430"><input name="name" size="15" value="<%=dto.getName()%>"></td>
		</tr>
		<tr>
			<td align="center">암 호</td>
			<td><input type="password" name="pass" size="15"></td>
		</tr>
		<tr>
			<td align="center">메 일</td>
			<td><input name="mail" size="25"value="<%=dto.getMail()%>"></td>
		</tr>
		<tr>
			<td align="center">제 목</td>
			<td><input name="title" size="50" value="<%=dto.getTitle()%>"></td>
		</tr>
		<tr>
			<td align="center">내 용</td>
			<td><textarea name="cont" cols="50" rows="10"><%=dto.getCont()%></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center" height="30">
			    <input type="button"
				 value="메  인" onClick="location.href='../main.html'">&nbsp;
				<input type="button" value="수정완료" onClick="check()">&nbsp;
				<input type="button" value="목  록"
				  onClick="location.href='boardlist.jsp?page=<%=spage%>'"></td>
		</tr>
	</table>
</form>
</body>
</html>