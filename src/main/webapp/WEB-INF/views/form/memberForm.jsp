<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:url var="home" value="/"/>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
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
<script type="text/javascript" src="${js }member.js"></script>
<script type="text/javascript">
	var gender = $('input:radio[name=gender]:checked').val();
	'${member.gender}'= gender;
</script>
<div style="width: 700px; height: 700px; margin-left: 300px;"><!-- 큰 틀 -->
	<div>
		${msg }
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
					<label>남</label><input type="radio" name='gender' value="m" checked="checked"/>
					<label>여</label><input type="radio" name='gender' value="w"/>
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

