<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:url var="home" value="/" />
<c:url var="css" value="/resources/css/" />
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>게시글 페이지</title>

<link rel="stylesheet" href="${css }viewboard.css" />
<script>
<!--
	function detailView(board_idx) {
		document.getElementById('boardNo').value = board_idx;
		document.getElementById('updateNo').value = "update";
		document.getElementById('frm').submit();
	}
	function boardDeleteProc(deleteNo) {
		document.getElementById('deleteNo').value = deleteNo;
		document.getElementById('delete').submit();
	}
//-->
</script>

</head>
<form id='delete' action="${home }board/boardDeleteProc">
	<input type="hidden" name="deleteNo" id="deleteNo">
</form>
<form id='frm' action="${home }board/detailView">
	<input type="hidden" name="boardNo" id="boardNo"> <input
		type="hidden" name="updateNo" id="updateNo">
</form>
	<div id="sub_wrap">
		<div class="container">
			<table class="table table-view">
				<colgroup>
					<col width="7%">
					<!-- 글 번호 -->
					<col width="20%">
					<!--  제목   -->
					<col width="10%">
					<!-- 작성자 -->
					<col width="10%">
					<!-- 작성일 -->
					<col width="7%">
					<!-- 조회수 -->
				</colgroup>
				<thead>
					<tr>
						<th class="subject">${detailView.board_title }</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="infocell"
							style="border: 1px solid #444444; padding: 10px;">
							<b>등록일</b>${detailView.board_date }<br>
							<b>작성자</b>${detailView.member_nickname }<br> 
							<b>나이</b>${detailView.member_age }<br>
							<b>성별</b> <c:set var="age" value="${detailView.member_gender }" />
							<c:choose>
								<c:when test="${age eq 'm'}">
									<b>남자</b>
								</c:when>
								<c:otherwise>
									<b>여자</b>
								</c:otherwise>
							</c:choose> <br> 
							<br>
						</td>
					</tr>
					<tr>
						<td><b>전화번호</b></td>
						<td class="contents" align="center">${detailView.member_phone }</td>
					</tr>
					<tr>
					<tr>
						<td><b>원하는 알바유형</b></td>
						<td class="contents" align="center">${detailView.board_type }</td>
					</tr>
					<tr>
						<td><b>원하는 알바 시간대</b></td>
						<td class="contents" align="center">${detailView.board_time }</td>
					</tr>
					<tr>
						<td><b>원하는 알바급여</b></td>
						<td class="contents" align="center">${detailView.board_pay }</td>
					</tr>
					<tr>
						<td><b>장소</b></td>
						<td class="contents" align="center">${detailView.board_addr }</td>
					</tr>
					<tr>
						<td><b>기타 사항</b></td>
						<td class="contents" align="center"><textarea rows="20"
								cols="30">${detailView.board_contents }</textarea></td>
					</tr>
				</tbody>

				<c:set var="nickname" value="${sessionMember.nickname }" />
				<c:set var="nick" value="${detailView.member_nickname }" />
				<tr>
					<c:choose>
						<c:when test="${nickname eq nick}">
							<td colspan=2 align="center" class="contents"><input
								type="button" value='수정'
								onclick="detailView('${detailView.board_idx}')" /> <input
								type="button" value='삭제'
								onclick="boardDeleteProc('${detailView.board_idx}')" /> <input
								type="button" value='목록'
								onclick="location.href='${home }board/selectBoard'" /></td>
						</c:when>
						<c:otherwise>
							<td colspan=2 class="contents" align="center"><input
								type="button" value='목록'
								onclick="location.href='${home }board/selectBoard'" /></td>
						</c:otherwise>
					</c:choose>
				</tr>




				<!-- 이전글 & 다음글  
					<c:choose>
						<c:when test="${fn:length(list) == 2 and tb_write.idx == list[0].idx }">  내가클릭한 게시물이 list[0]번째 글이면 최신글이다.  
						<tr>
							<td><span class="prev">이전</span>이전글이 없습니다.</td>  최신글보다 더 최신글이 없다는 의미이다. 
						</tr>
						<tr>
							<td><span class="next">다음</span><a href="/View?idx=${list[1].idx}">${list[1].title}</a></td> 
						</tr>
						</c:when>
						
						<c:when test="${fn:length(list) == 2 and tb_write.idx < list[0].idx }">  내가 클릭한 게시물이 list[0]번째 글(최신글)보다 이전에 만들어 졌으면 
						<tr>									 
							<td><span class="prev">이전</span><a href="/View?idx=${list[0].idx}">${list[0].title}</a></td>  list[0]번쨰 글이 나온다. 
						</tr>																			 내가 클릭한 글은 무조건 list[1]번째 글이다. a
						<tr>
							<td><span class="next">다음</span>다음글이 없습니다.</td>
						</tr>
						</c:when>
						<c:when test="${fn:length(list) == 3 and tb_write.idx < list[0].idx}">  내가 클릭한 게시물이 [l  
						<tr>
							<td><span class="prev">이전</span><a href="/View?idx=${list[0].idx}">${list[0].title}</a></td>
						</tr>
						<tr>
							<td><span class="next">다음</span><a href="/View?idx=${list[2].idx}">${list[2].title}</a></td>
						</tr>
						</c:when>
					</c:choose> -->
			</table>
		</div>
	</div>

	<!-- 0 : ${list[0].title} 
	1 : ${list[1].title}
	2 : ${list[2].title}-->
 