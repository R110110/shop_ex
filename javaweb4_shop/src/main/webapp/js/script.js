function zipCheck(){
	url = "zipCheck.jsp?check=y";
	window.open(url, "post", "toolbar=no,width=500,height=350,top=200,left=300,status=yes,scrollbars=yes,menubar=no,modal=yes");
}

function idCheck(){
	if(regForm.id.value === ""){
		alert("id를 입력하시오");
		regForm.id.focus();
	} else {
		url="idcheck.jsp?id=" + regForm.id.value;
		window.open(url, "id", "width=300,height=200,left=150,top=200");
	}
}

function inputCheck(){
	if(regForm.id.value === ""){
		alert("id를 입력하시오");
		regForm.id.focus();
		return;
	}
	
	if(regForm.passwd.value !== regForm.repasswd.value){
	alert("비밀번호 불일치");
	regForm.passwd.focus();
	return;
	}
	// 정규표현식 사용을 권장
	// 아이디 중복확인 생략
	
	document.regForm.submit();
	
}

//쇼핑몰 로그인 후 자신의 정보 수정 시 사용
function memberUpdateOk(){ 
	//입력자료 오류검사 생략
	document.updateForm.submit();
}
function memberUpdateCancel(){
	location.href="../guest/guest_index.jsp";
}
function memberDelete(){
	alert("회원탈퇴는 곧 죽음!!!");
}

//관리자 관련 
function funcAdminLogin(){
	if(adminLoginform.adminid.value === ""){
		alert("id 를 입력하시오");
		adminLoginform.adminid.focus();
		return;
	}
	if(adminLoginform.adminpasswd.value === ""){
		alert("password를 입력하시오");
		adminLoginform.adminpasswd.focus();
		return;
	}
	adminLoginform.submit();
}
function funcAdminHome(){
	location.href = "../guest/guest_index.jsp";
}

//관리자 입장에서 각 회원 수정
function memUpdate(id) {
	//alert(id);
	document.updateFrm.id.value = id;
	document.updateFrm.submit();
}

function memberUpdateAdmin(){
	document.updateFormAdmin.submit();
}
function memberUpdateCancelAdmin(){
	location.href = "membermanager.jsp";
}

//관리자에서 상품처리
function productDetail(no){
	document.detailForm.no.value = no;
	document.detailForm.submit();
}
function productUpdate(no){
	if(confirm("정말 수정할까요?")){
		document.updateForm.no.value = no;
		document.updateForm.submit();
	}
}
function productDelete(no){
	if(confirm("정말 삭제할까요?")){
		document.delForm.no.value = no;
		document.delForm.submit();		
	}
}

//사용자에서 상품 처리
function productDetail_guest(no){ 
	document.detailFrm.no.value = no;
	document.detailFrm.submit();
}

//카트 처리용
function cartUpdate(form){
	form.flag.value = "update";
	form.submit();
}
function cartDelete(form){
	form.flag.value = "delete";
	form.submit();
}

//관리자에서 주문 처리
function orderDetail(no){
	document.detailFrm.no.value = no;
	document.detailFrm.submit();
}

function orderUpdate(form){
	document.detailFrm.flag.value = "update";
	form.submit();
}

function orderDelete(form){
	document.detailFrm.flag.value = "delete";
	form.submit();
}


