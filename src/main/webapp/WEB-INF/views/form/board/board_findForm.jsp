<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<c:url var="img" value="/resources/img/" />
<c:url var="home" value="/" />
<!-- 구인게시판 / 구직게시판
	- 구인게시판에 필요한 테이블 정보 불러오기
	- 불러온 테이블 정보를 페이징으로 나누어서 보기 
	- 제목을 누르면 게시판의 상세한 정보 보기 
	- 검색을 통해 제목, 내용, 작성자에 대한 검색을 하면 검색결과에 따른 결과물 나오게하기 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link href="${css }jquery.atAccordionOrTabs.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${css }select.css" type="text/css">
<link rel="stylesheet" href="${css }buttonst.css" type="text/css">
<link rel="stylesheet" href="${css }boardstyle.css" type="text/css">
<style>
<!--
.title {
	cursor: pointer;
}
-->
</style>
<script>
<!--
function detailView(no){
	document.getElementById('writeNo').value=no;
	document.getElementById('frm').submit();
}
//-->
</script>

<form id='frm' action="${home }board/detailView">
	<input type="hidden" name="boardNo" id="boardNo">
	<input type="hidden" name="updateNo" id="updateNo">
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
							<c:when test="${fn:length(boardjobLst) > 0}">
								<c:forEach var="boardjobLst" items="${boardjobLst }">
									<tr>
										<td style="width: 30px; height: 40px;" align="center">${boardjobLst.no}</td>
										<td style="width: 330px; height: 40px;" align="center">
											<div class="title" onclick="detailView('${boardjobLst.no}')">${boardjobLst.job_date }</div>
										</td>
										<td style="width: 80px; height: 40px;" align="center">${boardjobLst.member_nickname }</td>
										<td style="width: 120px; height: 40px;" align="center">${boardjobLst.board_date }</td>
										<td style="width: 80px; height: 40px;" align="center">${boardjobLst.job_pay }</td>
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
								<form id="selectFrm" action="${home }board/selectBoard">
									<select name="selectOpt">
										<option value="all">전체</option>
										<option value="title">제목</option>
										<option value="nicname">작성자</option>
									</select> 
									<input type=text name='searchWord' /> 
									<input class="btn-gradient purple small" type="submit" name='searchBtn' value='검색' style="width: 80px;" />
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
											<div class="title" onclick="detailView('${boardLst.board_idx}')">${boardLst.board_title }</div>
										</td>
										<td style="width: 80px; height: 40px;" align="center">${boardLst.member_nickname }</td>
										<td style="width: 120px; height: 40px;" align="center">${boardLst.board_date }</td>
										<td style="width: 80px; height: 40px;" align="center">${boardLst.board_time }</td>
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
								<form id="selectFrm" action="${home }board/selectBoard">
									<select name="selectOpt">
										<option value="all">전체</option>
										<option value="title">제목</option>
										<option value="nicname">작성자</option>
									</select> <input type=text name='searchWord' />
									<button class="btn-gradient purple small">검색</button>
								</form>
							</td>
						</tr>
					</table>
				</div>
			</section>
		</li>
	</ul>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="${js }jquery.bbq.js"></script>
<script src="${js }jquery.atAccordionOrTabs.js"></script>
<script type="text/javascript">
	$('.demo').accordionortabs();
</script>