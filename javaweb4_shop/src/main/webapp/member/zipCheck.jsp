<%@page import="pack.member.ZipcodeDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberMgr" class="pack.member.MemberMgr"/>
<% 
request.setCharacterEncoding("utf-8");

String check = request.getParameter("check");	// 검색 전:y, 검색 후:n
String dongName = request.getParameter("dongName");

ArrayList<ZipcodeDto> list = memberMgr.zipcodeRead(dongName);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>

<script type="text/javascript">
window.onload = function(){

	document.getElementById("btnZipFind").onclick = dongCheck;
	document.getElementById("btnZipClose").onclick = function(){
		window.close();
	};
}

function dongCheck(){
	if(zipForm.dongName.value === ""){
		alert("동 이름을 입력하시오");
		zipForm.dongName.focus();
		return;
	}
	zipForm.submit();
}

function send(zipcode, area1, area2, area3, area4){
	//alert(zipcode + " " + area1);
	opener.document.regForm.zipcode.value = zipcode;
	let addr = area1 + " " + area2 + " " + area3 + " " + area4;
	opener.document.regForm.address.value =addr;
	window.close();
}
</script>
</head>
<body>
<b>**우편번호 찾기**</b><br/>
<form action="zipCheck.jsp"name="zipForm"method="post">
<table>
	<tr>
		<td>
		동 이름 입력: <input type="text" name="dongName"/>
		<input type="button"value="검색"id="btnZipFind">
		<input type="button"value="닫기"id="btnZipClose">
		<input type="hidden"name="check"value="n">
		</td>
	</tr>
</table>
</form>
<% 
if(check.equals("n")){
	if(list.isEmpty()){
%>
	<b>검색 결과가 없습니다</b>
<%		
} else{
%>
	<table>
		<tr>
			<td>검색 결과를 클릭하면 자동으로 주소가 입력됩니다</td>
		</tr>
		<tr>
			<td>
<% 
			for(int i = 0; i < list.size(); i++){
				ZipcodeDto dto = list.get(i);
				String zipcode = dto.getZipcode();
				String area1 = dto.getArea1();
				String area2 = dto.getArea2();
				String area3 = dto.getArea3();
				String area4 = dto.getArea4();
				if(area4 == null) area4 = "";
%>
				<a href="javascript:send('<%=zipcode %>', '<%=area1 %>', '<%=area2 %>', '<%=area3 %>', '<%=area4 %>')">
				<%=zipcode %> <%=area1 %> <%=area2 %> <%=area3 %> <%=area4 %><br/>
				</a>
<%				
			}
%>
			</td>
		</tr>
	</table>
<%	
}	
}
%>
</body>
</html>