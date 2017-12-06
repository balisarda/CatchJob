function formProc(cmd){
	var frm = document.getElementById('frm');
	frm.action=cmd;
	frm.submit();
}
function goBack() {
    window.history.go(-1);
}
function checkId(){
	var nickname = document.getElementById("nickname").value;
	var oMsg = document.getElementById("idMsg");

	if(nickname==""){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "필수 정보입니다."
		return false;
	}
	var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
	if(!isID.test(nickname)){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."
		return false;
	}
	oMsg.style.display = "none";
}
function checkEmail(){
	var nickname = document.getElementById("nickname").value;
	var email = document.getElementById("email").value;
	var oMsg = document.getElementById("emailMsg");
	
	if(email == ""){
		oMsg.style.display = "none";
		return true;
	}
    var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var isHan = /[ㄱ-ㅎ가-힣]/g;
    if(!isEmail.test(email) || isHan.test(email)){
    	oMsg.style.display = "block";
    	oMsg.innerHTML = "이메일 주소를 다시 확인해주세요.";
    	return false;
    }
    if(true){
    	oMsg.style.display = "none";
    	return true;
    }
    return true;
}
function checkName(){
	var nm = document.getElementById("name").value;
	var oMsg = document.getElementById("nameMsg");
	if(nm==""){
		oMsg.style.display = "block";
		oMsg.innerHTML = "필수 정보입니다.";
		return false;
	}
	var nonchar = /[^가-힣a-zA-Z0-9]/gi;
	if(nonchar.test(nm)){
		oMsg.style.display = "block";
		oMsg.innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
		return false;
	}
	if(true){
		oMsg.style.display = "none";
		return true;
	}
	return true;
}
function checkPw1(){
	var pw = document.getElementById("pw").value;
	var oMsg = document.getElementById("pswd1Msg");
	
	if(pw == ""){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "필수 정보입니다.";
		return false;
	}
	if(isValidPasswd(pw)!=true){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
		return false;
	}
	pwFlag = true;
	oMsg.style.display = "none";
	return true;
	
}
function checkPW1(){
	var pw = document.getElementById("pw").value;
	var oMsg = document.getElementById("pswd1Msg");
	
	if(pw == ""){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "필수 정보입니다.";
		return false;
	}
	if(isValidPasswd(pw)!=true){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
		return false;
	}
	if(encryptSHA512(pw)==data.pw){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "동일한 패스워드는 사용할 수 없습니다.";
		return false;
	}
	pwFlag = true;
	oMsg.style.display = "none";
	return true;
}
function checkPw2(){
	var pswd1 = document.getElementById("pw").value;
	var pswd2 = document.getElementById("pw2").value;
	var oMsg = document.getElementById("pswd2Msg");

	if(pswd2==""){
		oMsg.style.display = "block";
		oMsg.innerHTML = "필수 정보입니다.";
		return false;
	}
	if(pswd1 !=pswd2){
		oMsg.style.display = "block";
		oMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
		return false;
	}else {
		oMsg.style.display = "none";
		return true;
	}
	return true;
}
function isValidPasswd(str){
	if(str==""){
		return false;
	}
	if(str.length<6){
		return false;
	}
	var isPW = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{6,16}$/;
	if(!isPW.test(str)){
		return false;
	}
	return true;
}