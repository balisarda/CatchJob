<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="css" value="/resources/css/" />
<c:url var="home" value="/" />

<link rel="stylesheet" href="${css }board/boardselectForm.css" type="text/css">
<link rel="stylesheet" href="${css }buttonst.css" type="text/css">
<link rel="stylesheet" href="${css }board/boardstyle.css" type="text/css">
<style>
<!--
.title {
	cursor: pointer;
}
-->
</style>
<script>
function noticeDetailView(notice_title){
	document.getElementById('noticeNo').value=notice_title;
	document.getElementById('updateNo').value="notice";
	document.getElementById('frm').submit();
}
function writeFrm(home){
	document.getElementById('frm').action=home+"board_noticewriteForm";
	document.getElementById('frm').submit();
}
</script>

<!-- 게시글 세부사항 보기 -->
<form id='frm' action="${home }board/noticeDetailView">
	<input type="hidden" name="noticeNo" id="noticeNo">
	<input type="hidden" name="updateNo" id="updateNo">
</form>
<div align="center">
	<h2 >공지사항</h2><br><br>
</div>
<table>
	<thead>
		<tr>
			<th width="50">번호</th>
			<th width="250">제목</th>
			<th width="100">작성자</th>
			<th width="150">작성일</th>
			<th width="50">조회</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(noticeLst) > 0}">
				<c:forEach var="notice" items="${noticeLst }">
					<tr>
						<td style="width: 40px; height: 40px;" align="center">${notice.notice_idx}</td>
						<td style="width: 330px; height: 40px;" align="center">
							<div class="title"
								onclick="noticeDetailView('${notice.notice_idx}')">${notice.notice_title }</div>
						</td>
						<td style="width: 80px; height: 40px;" align="center">${notice.member_nickname }</td>
						<td style="width: 120px; height: 40px;" align="center">${notice.notice_date }</td>
						<td style="width: 80px; height: 40px;" align="center">${notice.notice_hits }</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td align="center" colspan="4">조회된 결과가 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
		<!-- 글쓰기는 관리자인지 세션값으로 확인 -->
		<c:set var="nickname" value="${sessionMember.nickname }" />
		<c:choose>
			<c:when test="${nickname eq 'CatchJob'}">
				<tr>
					<td align="right"><input style="" type="button"
						onclick="writeFrm('${home }')" value='글쓰기' /></td>
				</tr>
			</c:when>
			<c:otherwise>

			</c:otherwise>
		</c:choose>
	</tbody>
</table>

<table>
	<tr>
		<td class="selectBtn">
			<form id="selectFrm" action="${home }board/noticeBoard">
				<select name="selectOpt">
					<option value="all">전체</option>
					<option value="notice_title">제목</option>
					<option value="member_nickname">작성자</option>
				</select> <input type=text name='noticesearchWord' /> 
				<input class="btn-gradient purple small" type="submit" name='searchBtn'
					value='검색' style="width: 80px;" />
			</form>
		</td>
	</tr>
</table>