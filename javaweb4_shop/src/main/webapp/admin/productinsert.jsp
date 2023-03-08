<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
<%@ include file="admin_top.jsp" %>	
<form action="productproc.jsp?flag=insert" enctype="multipart/form-data" method="post">
<table>
	<tr>
		<td colspan="2">** 상품 등록 **</td>
	</tr>
	<tr>
		<td>상품명 : </td>
		<td><input type="text"name="name" value=""> </td>
	</tr>
	<tr>
		<td>가격 : </td>
		<td><input type="text"name="price"> </td>
	</tr>
	<tr>
		<td>설명 : </td>
		<td>
		<textarea rows="5" cols="60" name="detail"></textarea>
		</td>
	</tr>
	<tr>
		<td>재고량 : </td>
		<td><input type="text"name="stock"> </td>
	</tr>
	<tr>
		<td>이미지 : </td>
		<td><input type="file"name="image"> </td>	<%-- file은 enctype="multipart/form-data" 필수 --%>
	</tr><tr>
		<td colspan="2" style="text-align: center;">
		<input type="submit" value="상품 등록">
		<input type="reset" value="새로 입력">
		</td>
	</tr>
</table>
</form>
<%@ include file="admin_bottom.jsp" %>
</body>
</html>