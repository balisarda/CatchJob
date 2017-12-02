<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<c:url var="img" value="/resources/img/" />
<c:url var="js" value="/resources/js/" />
<c:url var="home" value="/" />
<script	src="${js }jquery-3.2.1.js"></script>
<style>
.sidr.on {
	left: 0px;
}

.sidr.off {
	left: -300px;
	right: auto;
}

.sidr {
	display: block;
	position: absolute;
	top: 0px;
	height: 100%;
	z-index: 999999;
	width: 260px;
	overflow-x: auto;
	overflow-y: auto;
	background: #333;
	font-size: 22px;
	font-color: #FFFFFF;
}

ul li.hide {
	font-size: large;
	}
ul{
   list-style:none;
   }

</style>
<div style="top:500px">
<div id="side1" class="sidr off" style="transition: left 0.2s ease;">
	<ul class="hide" style="display: block;">
		<li><a href="${home }member/logOut">로그아웃</a></li>
		<li><a href="${home }member/memberInfo">개인정보 수정</a></li>
		<li><a href="${home }job/confirm_add">일 등록 정보 보기</a></li>
	</ul>
</div>
<div id="side2" class="sidr off" style="transition: left 0.2s ease;">
	<ul class="hide" style="display: block;">
		<li><a href="${home }login">로그인</a></li>
		<li><a href="${home }memberForm">회원가입</a></li>
		<li><a href="${home }findInfoForm">ID/PW찾기</a></li>
	</ul>
</div>
<div id="side3" class="sidr off" style="transition: left 0.2s ease;">
	<ul class="hide" style="display: block;">
		<li><a href="${home }board/selectBoard">구인/구직 게시판</a></li>
		<li><a href="${home }board/noticeBoard">공지사항</a></li>
	</ul>
</div>
<div id="side4" class="sidr off" style="transition: left 0.2s ease;">
	<ul class="hide" style="display: block;">
		<li><a href="${home }job/find">일자리 찾기</a></li>
	</ul>
</div>
<div id="side5" class="sidr off" style="transition: left 0.2s ease;">
	<ul class="hide" style="display: block;">
		<li><a href="${home }board_writeForm">알바 등록</a></li>
		<li><a href="${home }addjob">일등록</a></li>
	</ul>
</div>
<div class="sidebar" id=navibar style="position: fixed;">
	<ul class="main_menu">
		<li class="menu"><c:choose>
				<c:when test="${sessionMember.nickname ne null }">
					<a style="cursor: pointer;"> <img id="nav_mypage" alt="MyPage" src="${img }logo.png" /></a>
				</c:when>
				<c:when test="${sessionMember.nickname eq null }">
					<a style="cursor: pointer;"> <img id="nav_login" alt="로그인" src="${img }sidebar/01.png" /></a>
				</c:when>
			</c:choose></li>
		<li class="menu">
			<a style="cursor: pointer;"><img id="nav_board" alt="게시판" src="${img }sidebar/02.png" /></a>
		</li>
		<li class="menu">
			<a style="cursor: pointer;"><img id="nav_findjob" alt="일 찾기" src="${img }sidebar/03.png" /></a>
		</li>
		<c:if test="${sessionMember.nickname ne null}">
		<li class="menu">
			<a style="cursor: pointer;"><img id="nav_addjob" alt="일 등록" src="${img }sidebar/addjob.JPG" /></a>
		</li>
		</c:if>
	</ul>
</div>
</div>
<script>
$(document).ready(function(){
	var on = "sidr on";
	var off = "sidr off";
	document.getElementById("nav_board").addEventListener("mouseover", function() {opensidebar('side3');});
	document.getElementById("nav_findjob").addEventListener("mouseover", function() {opensidebar('side4');});
	var a = document.getElementById("nav_mypage");
	var b = document.getElementById("nav_login");
	var c = document.getElementById("nav_addjob");
	if(a!=null){
		a.addEventListener("mouseover", function() {opensidebar('side1');});
	}else {
		b.addEventListener("mouseover", function() {opensidebar('side2');});
	}
	if(c!=null)
		c.addEventListener("mouseover", function() {opensidebar('side5');});
	$("body").click(function(e){
		var id = e.target.getAttribute('id');
		document.getElementById("side1").className = off;
		document.getElementById("side2").className = off;
		document.getElementById("side3").className = off;
		document.getElementById("side4").className = off;
		document.getElementById("side5").className = off;
		if(id=="side1" || id=="side2" || id=="side3" || id=="side4" || id=="side5")
			document.getElementById(id).className = on;			
	});
});
function opensidebar(cmd){
	document.getElementById(cmd).className = "sidr on";
}
</script>
