<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<c:url var="img" value="/resources/img/" />
<c:url var="home" value="/" />
<!-- 개인정보 수정 창에서 할 듯 -->
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>알바 등록 하기</title>

<link rel="stylesheet" href="${css }buttonst.css" type="text/css">

<script type="text/javascript">
function chkBox_jop(){
	var chkBoxjop = document.getElementsByName("board_type");
	var ok="";
	for(var i=0;i<chkBoxjop.length;i++){
		if(chkBoxjop[i].checked == true){
			ok += chkBoxjop[i].value+" ";
		}
	}
}
function chkBox_time(){
	var chkBoxtime = document.getElementsByName("board_time");
	for(var i=0;i<chkBoxtime.length;i++){
		if(chkBoxtime[i].checked)
			chkBoxtime[i].value+" ";
}
function selectBox_pay(){
	var Urgency = document.getElementsById("board_pay");
	var val1 = board_pay.options[board_pay.selectedIndex].value;
	
	var Salary = document.getElementsById("board_pay");
	var val2 = board_pay.options[board_pay.selectedIndex].value;
	}
}

</script>

</head>
<form action="${home }board/boardupdateProc" method="post">
	<!-- 히든으로 닉네임 세션으로 받아서 폼안에서 값 보내기 -->
	<input type="hidden" name="member_nickname"
		value="${sessionMember.nickname}">
		<input type="hidden" name="board_idx" value="${detailView.board_idx }">
	<div>
		<h1 align="center">일 하고 싶어요</h1>
		<hr>
	</div>
	<br>
	<div>
		<a onMouseover="this.style.color='red';">한 줄 소개 제목</a> <input
			type="text" name="board_title" maxlength="30" size="35"
			value="${detailView.board_title }" /> <a style="color: red;">${msg }</a>
	</div>
	<br>
	<hr>
	<div>
		<!-- 하고 싶은 알바 유형 -->
		<br> <a onMouseover="this.style.color='blue';">하고 싶은 알바 유형</a> <br>
		<br> <input type="checkbox" name="board_type" value="편의점"><label>편의점</label>
		<input type="checkbox" name="board_type" value="피시방"><label>피시방</label>
		<input type="checkbox" name="board_type" value="서빙"><label>서빙</label>
		<input type="checkbox" name="board_type" value="카운터"><label>카운터</label>
		<input type="checkbox" name="board_type" value="상관없다"><label>상관없다</label>
		<br> <br>
		<hr>
	</div>
	<br>
	<div>
		<!-- 알바가 가능한, 하고싶은 시간대 -->
		<a onMouseover="this.style.color='blue';">근무 하고싶은 시간대</a> <br> <br>
		<div>
			<a onMouseover="this.style.color='blue';">평일</a> <input
				type="checkbox" name="board_time" value="평일 오전">평일 오전 <input
				type="checkbox" name="board_time" value="평일 오후">평일 오후 <input
				type="checkbox" name="board_time" value="평일 밤">평일 밤 오후 <br>
		</div>
		<div>
			<a onMouseover="this.style.color='blue';">주말</a> <input
				type="checkbox" name="board_time" value="주말 오전">주말 오전 <input
				type="checkbox" name="board_time" value="주말 오후">주말 오후 <input
				type="checkbox" name="board_time" value="주말 밤">주말 밤
		</div>
		<hr>
		<br>
	</div>

	<div>
		<!-- 원하는 알바비  -->
		<a onMouseover="this.style.color='blue';">원하는 시급</a>
		<ul>
			<li class="Urgency" value="시급"><select title="Urgency"
				name="board_pay" id="board_pay">
					<option>최저 시급 ~ 8000원</option>
					<option>8000원 ~ 10000원</option>
					<option>10000원 ~ 15000원</option>
					<option>15000원 ~ 20000원</option>
					<option>추후 협의</option>
					<option>상관없다</option>
			</select> <br></li>
			<li class="Salary" value="월급"><select title="Salary"
				name="board_pay" id="board_pay">
					<option>100만원 ~ 200만원</option>
					<option>200만원 ~ 300만원</option>
					<option>300만원 ~ 400만원</option>
					<option>400만원 ~ 500만원</option>
					<option>추후 협의</option>
					<option>상관없다</option>
			</select></li>
		</ul>
	</div>
	<br>
	<hr>
	<br>
	<div>
		<!-- 알바를 하고 싶은 장소 -->
		<a onMouseover="this.style.color='blue';">알바를 하고 싶은 장소</a><br>
		<div>
			<input type="button" onclick="SearchAddr('${home}form/getmapForm')"
				value="주소검색" /> <input type="text" id="reciaddr" name="board_addr"
				value="${detailView.board_addr }" />
		</div>
		<br>

	</div>
	<hr>
	<br>
	<!-- 구직 내용 컨텐츠 -->
	<a onMouseover="this.style.color='blue';">각오와 다짐</a> <br>
	<div>
		<textarea rows="5" cols="40" name="board_contents">${detailView.board_contents }</textarea>
	</div>

	<div align="center">
		<input type="submit" class="btn-gradient orange large" value="수정">
		<input type="reset" class="btn-gradient green large" value="취소">
	</div>


</form>


<script>
function SearchAddr(map){
	var newwin = window.open(map, "blank", "width=530, height=680, scrollbars=yes");
}

</script>
</html>