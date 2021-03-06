<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:url var="home" value="/" />
<c:url var="css" value="/resources/css/" />

<link rel="stylesheet" href="${css }board/boardviewForm.css" />
<script>

function noticeDetailProc(noticeNo) {
	document.getElementById('noticeNo').value = noticeNo;
	document.getElementById('updateGo').value = "noticeUp";
	document.getElementById('frm').submit();	
	}
function noticeDeleteProc(deleteNo) {
	document.getElementById('deleteNo').value = deleteNo;
	document.getElementById('delete').submit();
	}
</script>

</head>
<form id='delete' action="${home }board/noticeDeleteProc">
	<input type="hidden" name="deleteNo" id="deleteNo">
</form>
<form id='frm' action="${home }board/noticeDetailProc">
	<input type="hidden" name="noticeNo" id="noticeNo"> 
	<input type="hidden" name="updateGo" id="updateGo">
</form>
<body>
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
						<th class="subject">${noticeLst.notice_title }</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="infocell"><b>등록일 </b>${noticedetail.notice_date }
							<b>작성자 </b>${noticeLst.member_nickname }</td>
					</tr>
					<tr>
						<td class="contents" align="center">
							${noticeLst.notice_contents }</td>
					</tr>
				</tbody>

				<c:set var="nickname" value="${sessionMember.nickname }" />
				<tr>
					<c:choose>
						<c:when test="${nickname eq 'CatchJob'}">
							<td colspan=2 align="center"><input type="button" value='수정'
								onclick="noticeDetailProc('${noticeLst.notice_idx}')" /> <input
								type="button" value='삭제'
								onclick="noticeDeleteProc('${noticeLst.notice_idx}')" /> <input
								type="button" value='목록'
								onclick="location.href='${home }board/noticeSelectProc'" /></td>
						</c:when>
						<c:otherwise>
							<td colspan=2 align="center"><input type="button" value='목록'
								onclick="location.href='${home }board/noticeSelectProc'" /></td>
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
