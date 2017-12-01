<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:url var="home" value="/"/>
<c:url var="css" value="/resources/css/" />
<%
	request.setCharacterEncoding("UTF-8");
%>


<style>
	dl{ 
	width: 400px;
	height: 30px;
	}
	dt {
		float: left;
		padding-left: 20px;
	}
	label {
		font-weight : bold;
	}
	input[type=text] {
    border: 1px solid #666666;
    border-radius: 4px;
    padding:5px;
    align:right;
	}
	input[type=password] {
    border: 1px solid #666666;
    border-radius: 4px;
    padding:5px;
    align:right;
	}
</style>
<link rel="stylesheet" href="${css }buttonst.css">
<link rel="stylesheet" href="${css }sidebarcss.css">
<link rel="stylesheet" href="${css }main.css">
<script type="text/javascript" charset="UTF-8">
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
</script>
<script type="text/javascript">
	var gender = $('input:radio[name=gender]:checked').val();
	'${member.gender}'= gender;
</script>


<div style="width: 700px; height: 700px; margin-left: 300px;"><!-- 큰 틀 -->
	<div>
		${msg } // ${sessionMember }
	</div>
	<form id='frm' action="${home }member/memberProc" method="post">
	<div><!-- 필수입력정보 틀 -->
		<dl><!-- 이름 -->
			<dt>
				<label>이름&nbsp;</label>
				<input type="text" placeholder="이름" id="name" onblur="checkName();" maxlength="30" name='name' value="${member.name }">
			</dt>
			<dd>
				<div id="nameMsg" class="error" style="display: none; float: left; width: 200px;">필수 정보입니다.</div>
			</dd>
		</dl>
		<dl><!-- ID -->
			<dt>
				<label>ID&nbsp;</label>
			</dt>
			<dd>
				<div style="width: 300px;">
				<input type="text" id="nickname" name='nickname' id="nickname" onblur="checkId('first');" placeholder="아이디" style="border: 1;" value="${member.nickname }">
				<!-- ID 중복 확인 버튼 -->
				<input type="button" class="btn-gradient green mini" onclick="formProc('${home}member/chkNickname');" value="ID 중복 확인" />
				</div>
				<div id="idMsg" class="error" style="display: none; float: left; width: 200px;">필수 정보입니다.</div>
			</dd>
		</dl>
		<dl><!-- 비밀번호(스크립트로 복잡성 확인)-->
			<dt>
				<label>비밀번호&nbsp;</label>
			</dt>
			<dd>
				<div>
					<input type="password" id="pw" placeholder="비밀번호" onblur="checkPw1();" name='pw' id="pw" value="${member.pw}">
				</div>
				<div id="pswd1Msg" class="error" style="display: none; float: left; width: 200px;">필수 정보입니다.</div>
			</dd>
		</dl>
		<dl><!-- 비밀번호 확인(비밀번호와 일치여부 확인) -->
			<dt>
				<label>비밀번호 재입력&nbsp;</label>
			</dt>
			<dd>
				<div><input type="password" id="pw2" onblur="checkPw2();" placeholder="비밀번호 확인" /></div>
				<div id="pswd2Msg" class="error" style="display: none; float: left; width: 200px;">필수 정보입니다.</div>
			</dd>
		</dl>
		<dl><!-- 생년월일 -->
			<dt>
				<label>생년월일&nbsp;</label>
			</dt>
			<dd>
				<div>
					<input type="text" placeholder="생년월일 (예 : 800101)" name='age' id="age" value="${member.age}">
				</div>
			</dd>
		</dl>		
		<dl><!-- 성별 (라디오 버튼으로 구현)-->
			<dt>
				<label>성별&nbsp;</label>
			</dt>
			<dd>
				<div>
					<label>남</label><input type="radio" name='gender' onblur="gender();" value="m" checked="checked"/>
					<label>여</label><input type="radio" name='gender' onblur="gender();" value="w"/>
				</div>
			</dd>
		</dl>
		<dl><!-- 이메일(이메일 형식 확인 스크립트) -->
			<dt>
				<label>이메일&nbsp;</label>
			</dt>
			<dd>
				<div style="float: left;">
					<input type="text" placeholder="이메일" onblur="checkEmail();" name='email' id="email" value="${member.email }"/>
					<input type="button" class="btn-gradient green mini" onclick="formProc('${home}member/reqAuthNum');" value="인증번호 전송" />
				</div>
			</dd>
		</dl>
		<dl><!-- 이메일 인증번호 입력칸 -->
			<dt>
				<label>인증번호&nbsp;</label>
			</dt>
			<dd>
				<div style="float: left;">
					<input type="text" placeholder="인증번호" name='authNum' value="${inputAuthNum }"/>
					<input type="button" class="btn-gradient green mini" onclick="formProc('${home}member/chkAuthNum')" value="인증번호 확인" />
				</div>
			</dd>
		</dl>
		<dl><!-- 휴대폰 번호 -->
			<dt>
				<label>휴대폰 번호&nbsp;</label>
			</dt>
			<dd>
				<div style="float: left;">
					<input type="text" placeholder="휴대폰 번호" name='phone' id="phone" value="${member.phone}">
				</div>
			</dd>
		</dl>	
		<div style="clear: both; float: left;"><!-- 회원가입 버튼 -->
			<input type="submit" class="btn-gradient cyan mini" value="회원가입">
		</div>
		<div>
			<input type="reset" onclick="goBack();" class="btn-gradient red mini" value="취소" />
		</div> 
	</div>
	</form>
</div>

