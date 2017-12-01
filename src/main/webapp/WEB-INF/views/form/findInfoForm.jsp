<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:url var="home" value="/"/>
<c:url var="img" value="/resources/img/" />
<c:url var="css" value="/resources/css/" />
<link rel="stylesheet" href="${css }sidebarcss.css">
<link rel="stylesheet" href="${css }buttonst.css">
<link rel="stylesheet" href="${css }main.css">
<div style="width: 650px; height: 1000px; margin-left: 300px;"><!-- 큰 틀 -->
	<div style="border: 1px solid black; width: 500px; height: 100px; margin: 10px;"><!-- ID 찾기 틀 -->
	<form action="${home}member/findId" method="post">
		<div><img src="${img }find_id.png" style="width: 105px; margin-bottom: 10px;"/></div>
		<div style="float: left; width: 150px;">
			<input type="text" placeholder="이름" name='name'>
		</div>
		<div style="float: left; width: 150px;">
			<input type="text" placeholder="이메일" name="email">
		</div>
		<div style="float: right; bottom-padding:10px; width: 150px;">
			<button class="btn-gradient red mini" type="submit">아이디 찾기</button>
		</div>
		<div style="clear: both; margin-top: 10px;"><label>${msg }</label></div>
	</form>
	</div>
	<div style="border: 1px solid black; width: 500px; height: 100px; margin: 10px;"><!-- PW 찾기 틀 -->
	<form action="${home}member/findPw" method="post">
		<div><img src="${img }find_pw.png" width="105px;"/></div>
		<div style="float: left; width: 150px;">
			<input type="text" placeholder="아이디" name='nickname'>
		</div>
		<div style="float: left; width: 150px;">
			<input type="text" placeholder="이메일" name="email">
		</div>
		<div style="float: right; width: 150px; ">
			<button class="btn-gradient orange mini" type="submit">패스워드 새로 받기</button><br/>
		</div>
	</form>
	</div>
</div>
