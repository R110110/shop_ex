<%@page import="pack.board.BoardDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="boardMgr" class="pack.board.BoardMgr"/>
<jsp:useBean id="dto" class="pack.board.BoardDto"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
int pageBlock, start, end;
int pageSu, spage = 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script type="text/javascript">
window.onload = function() {
	document.querySelector("#btnSearch").onclick = function() {
		if(frm.sword.value === "") {
			frm.sword.focus();
			//alert("검색어를 입력하세요");
			frm.sword.placeholder = "검색어를 입력하세요";
			return;
		}		
		frm.submit();
	}
}
</script>
</head>
<body>
<table>
	<tr>
		<td>
		[<a href="../guest/guest_index.jsp">메인으로</a>]&nbsp;
		[<a href="boardlist.jsp?page=1">최근목록</a>]&nbsp;
		[<a href="boardwrite.jsp">새글작성</a>]&nbsp;
		[<a href="#" onclick="window.open('../admin/admin_index.jsp',' ','width=300,height=150,top=200,left=300')">관리자용</a>]
		<br/><br/>
			<table style="width: 100%" border="1">
				<tr style="background-color: cyan">
					<th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회</th>
				</tr>
				<%
				request.setCharacterEncoding("utf-8");
				
				try{
					spage = Integer.parseInt(request.getParameter("page"));
				}catch(Exception e){
					spage = 1;
				}
				
				if(spage <= 0) spage = 1;
				
				// 검색 관련 ------------------
				String stype = request.getParameter("stype");
				String sword = request.getParameter("sword");
				//out.print(stype + " " + sword);
				// ----------------------------
				
				boardMgr.totalList(); // 전체 레코드 수 처리
				pageSu = boardMgr.getPageSu(); // 전체 페이지 수 얻기
				//out.print("전체 페이지 수 : " + pageSu);
				ArrayList<BoardDto> list =boardMgr.getDataAll(spage, stype, sword);
				
				for(int i=0; i < list.size(); i++) {
					dto = (BoardDto)list.get(i);
					// 댓글 들여쓰기 준비=======
					int nst = dto.getNested();
					String tab = "";
					String icon = "";
					for(int k = 0; k < nst; k++){
						tab += "&nbsp;&nbsp;";
						icon = "<img src='../images/re.gif'/>";
					}
					//======================
				%>
				<tr>
					<td><%=dto.getNum() %></td>
					<td>
						<%=tab %><%=icon %>
						<a href="boardcontent.jsp?num=<%=dto.getNum() %>&page=<%=spage%>"><%=dto.getTitle() %></a>
					</td>
					<td><%=dto.getName() %></td>
					<td><%=dto.getBdate() %></td>
					<td><%=dto.getReadcnt() %></td>
				</tr>
				<%
				}
				%>
			</table>
		<table>
			<tr>
				<td style="text-align: center;">
				<%
				for(int i=1; i <= pageSu; i++) {
					if(i == spage){
	                     out.print("<b style='font-size:12pt;color:red'>[" + i + "]</b>");
	                  }else{
	                     out.print("<a href='boardlist.jsp?page=" + i + "'>[" + i + "]</a>");
	                  }
				}
				%>
				<br/><br/>
				<form action="boardlist.jsp" name="frm" method="get">
				<select name="stype">
					<option value="title" selected="selected">글제목</option>
					<option value="name">작성자</option>
				</select>
				<input type="text" name="sword">
				<input type="button" value="검색" id="btnSearch" />
				</form>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>