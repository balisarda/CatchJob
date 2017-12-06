<%@page import="java.security.MessageDigest"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:url var="home" value="/"/>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<%
	request.setCharacterEncoding("UTF-8");
	session.setAttribute("memberInfo", "memberinfo");
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
<script type="text/javascript" src="${js }member.js"></script>
<%!
	private String encryptSHA512(String pw){
		try{
			MessageDigest sha = MessageDigest.getInstance("SHA-512");
			sha.update(pw.getBytes());
			StringBuffer sb = new StringBuffer();
			for(byte b : sha.digest()){
				sb.append(Integer.toHexString(0xff & b));
			}
			return sb.toString();
		}catch (NoSuchAlgorithmException e){
			e.printStackTrace();
			return null;
		}
	}
%>
<script type="text/javascript" charset="UTF-8">
$(document).ready(function(){
	$.ajax({
		type:'post', url: "memberInfo_JSON", dataType: "json", cache: false,
		success: function(data){
			var jsonStr = data;

			document.getElementById("name").value = data.name;
			document.getElementById("nickname").value = data.nickname;
			document.getElementById("email").value = data.email;
			document.getElementById("phone").value = data.phone;
			//document.getElementById("oldpw").value = data.pw;
			document.getElementById("oldemail").value = data.email;
			document.getElementById("oldphone").value = data.phone;
		}
	});
});
</script>
<div style="width: 700px; height: 700px; margin-left: 300px;"><!-- 큰 틀 -->
	<div>
		${msg } // ${sessionMember}
	</div>
	<form id='frm' action="${home }member/memberInfo_modi" method="post">
<!-- 	<input type="hidden" id="oldpw" name="oldpw"> -->
	<input type="hidden" id="oldemail" name="oldemail">
	<input type="hidden" id="oldphone" name="oldphone">
	<div><!-- 필수입력정보 틀 -->
		<dl><!-- 이름 -->
			<dt>
				<label>이름&nbsp;</label>
				<input type="text" placeholder="이름" id="name" readonly="readonly" maxlength="30" name='name'>
			</dt>
		</dl>
		<dl><!-- ID -->
			<dt>
				<label>ID&nbsp;</label>
			</dt>
			<dd>
				<div style="width: 300px;">
					<input type="text" id="nickname" name='nickname' id="nickname" readonly="readonly" placeholder="아이디" style="border: 1;">
				</div>
			</dd>
		</dl>
		<dl><!-- 비밀번호(스크립트로 복잡성 확인)-->
			<dt>
				<label>비밀번호&nbsp;</label>
			</dt>
			<dd>
				<div>
					<input type="password" id="pw" placeholder="비밀번호" onblur="checkPW1();" name='pw' id="pw">
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
		<dl><!-- 이메일(이메일 형식 확인 스크립트) -->
			<dt>
				<label>이메일&nbsp;</label>
			</dt>
			<dd>
				<div style="float: left;">
					<input type="text" placeholder="이메일" onblur="checkEmail();" name='email' id="email"/>
					<input type="button" class="btn-gradient green mini" onclick="formProc('${home}member/reqAuthNum');" value="인증번호 전송" />
					<div id="emailMsg" class="error" style="display: none; float: left; width: 200px;">필수 정보입니다.</div>
				</div>
			</dd>
		</dl>
		<dl><!-- 이메일 인증번호 입력칸 -->
			<dt>
				<label>인증번호&nbsp;</label>
			</dt>
			<dd>
				<div style="float: left;">
					<input type="text" placeholder="인증번호" name='authNum' id="inputAuthNum" value="${inputAuthNum }"/>
					<input type="button" class="btn-gradient green mini" onclick="formProc('${home}member/chkAuthNum');" value="인증번호 확인" />
				</div>
			</dd>
		</dl>
		<dl><!-- 휴대폰 번호 -->
			<dt>
				<label>휴대폰 번호&nbsp;</label>
			</dt>
			<dd>
				<div style="float: left;">
					<input type="text" placeholder="휴대폰 번호" name='phone' id="phone">
				</div>
			</dd>
		</dl>	
		<div style="clear: both; float: left;"><!-- 회원가입 버튼 -->
			<input type="submit" class="btn-gradient cyan mini" value="확인">
		</div>
		<div>
			<input type="reset" onclick="goBack();" class="btn-gradient red mini" value="취소" />
		</div> 
	</div>
	</form>
</div>

