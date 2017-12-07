<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<c:url var="home" value="/" />

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${css }board/boardTabs.css" type="text/css">
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
function boardDetailProc(board_idx){
	document.getElementById('boardNo').value=board_idx;
	document.getElementById('updateGo').value="no";
	document.getElementById('frm').submit();
}
function jobDetailProc(no){
	document.getElementById('jobNo').value=no;
	document.getElementById('jobfrm').submit();
}
</script>
<form id='frm' action="${home }board/boardDetailProc">
	<input type="hidden" name="boardNo" id="boardNo">
	<input type="hidden" name="updateGo" id="updateGo">
</form>
<form id='jobfrm' action="${home }board/jobDetailProc">
	<input type="hidden" name="jobNo" id="jobNo">
</form>
	<ul class="demo">
		<li><a>구인 게시판</a>
			<section>
				<div align="center">
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
						<c:choose>
							<c:when test="${fn:length(jobLst) > 0}">
								<c:forEach var="jobLst" items="${jobLst }">
									<tr>
										<td style="width: 30px; height: 40px;" align="center">${jobLst.no}</td>
										<td style="width: 330px; height: 40px;" align="center">
											<div class="title" onclick="jobDetailProc('${jobLst.no}')">${jobLst.job_name }</div>
										</td>
										<td style="width: 80px; height: 40px;" align="center">${jobLst.member_nickname }</td>
										<td style="width: 120px; height: 40px;" align="center">${jobLst.board_date }</td>
										<td style="width: 80px; height: 40px;" align="center">${jobLst.job_hits }</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td align="center" colspan="4">조회된 결과가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<table>
						<tr>
							<td class="selectBtn">
								<form id="selectFrm" action="${home }board/boardSelectProc">
									<select name="selectOpt">
										<option value="all">전체</option>
										<option value="job_name">제목</option>
										<option value="member_nickname">작성자</option>
									</select> 
									<input type=text name='jobsearchWord' /> 
									<input class="btn-gradient purple small" type="submit" 
									name='searchBtn' value='검색' style="width: 80px;" />
								</form>
							</td>
						</tr>
					</table>
				</div>
			</section></li>

		<li><a>구직게시판</a>
			<section>
				<div align="center">

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
						<c:choose>
							<c:when test="${fn:length(boardLst) > 0}">
								<c:forEach var="boardLst" items="${boardLst }">
									<tr>
										<td style="width: 30px; height: 40px;" align="center">${boardLst.board_idx}</td>
										<td style="width: 330px; height: 40px;" align="center">
											<div class="title" onclick="boardDetailProc('${boardLst.board_idx}')">${boardLst.board_title }</div>
										</td>
										<td style="width: 80px; height: 40px;" align="center">${boardLst.member_nickname }</td>
										<td style="width: 120px; height: 40px;" align="center">${boardLst.board_date }</td>
										<td style="width: 80px; height: 40px;" align="center">${boardLst.board_hits }</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td align="center" colspan="4">조회된 결과가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<table>
						<tr>
							<td class="selectBtn">
								<form id="selectFrm" action="${home }board/boardSelectProc">
									<select name="selectOpt">
										<option value="all">전체</option>
										<option value="board_title">제목</option>
										<option value="member_nickname">작성자</option>
									</select> <input type=text name='boardsearchWord' />
									<input class="btn-gradient purple small" type="submit" 
									name='searchBtn' value='검색' style="width: 80px;" />
								</form>
							</td>
						</tr>
					</table>
				</div>
			</section>
		</li>
	</ul>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="${js }board/jquery.boardTabs_second.js"></script>
<script src="${js }board/jquery.boardTabs.js"></script>
<script type="text/javascript">
	$('.demo').accordionortabs();
</script>