<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<c:url var="home" value="/" />
<link rel="stylesheet" href="${css }buttonst.css" type="text/css">

<form action="${home }board/boardUpdateProc" method="post">
	<input type="hidden" name="member_nickname" value="${sessionMember.nickname}"> <input type="hidden" name="board_idx" value="${boardLst.board_idx }">
	<div>
		<h1 align="center">일 하고 싶어요</h1>
		<hr>
	</div>
	<br>
	<div>
		<a onMouseover="this.style.color='red';">한 줄 소개 제목</a> 
		<input type="text" name="board_title" maxlength="30" size="35" value="${boardLst.board_title }" />
		<a style="color: red;">${msg }</a>
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
			<input type="button" class="btn-gradient red mini" onclick="SearchAddr('${home}form/getmapForm')" value="주소검색" />
			<input type="text" id="reciaddr" name="board_addr" value="${boardLst.board_addr }" />
			<a style="color: red;">${addr }</a>
		</div>
		<br>
	</div>
	<hr>
	<br>
	<!-- 구직 내용 컨텐츠 -->
	<a onMouseover="this.style.color='blue';">각오와 다짐</a> <br>
	<div>
		<textarea rows="5" cols="40" name="board_contents">${boardLst.board_contents }</textarea>
	</div>
	<div align="center">
		<input type="submit" class="btn-gradient orange large" value="수정">
		<input type="reset" class="btn-gradient green large" value="취소">
	</div>
</form>
<script>
	function SearchAddr(map) { var newwin = window.open(map, "blank", "width=530, height=680, scrollbars=yes");	}
</script>
<script src="${js }board/boardChkSelect.js"></script>