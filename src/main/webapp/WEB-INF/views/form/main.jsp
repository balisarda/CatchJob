<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<c:url var="img" value="/resources/img/" />
<c:url var="css" value="/resources/css/" />
<script>
$(document).ready(function(){
	$.ajax({
		type:'post', url: "board/mainBoard", dataType: "json", cache: false,
		success: function(data){
			var jsonStr = data;
			console.log(data);
			$("#notice_table").html("");
			$.each(data.noticelist, function(index, noticelist){
				$("<li><a href='javascript:noticeDetailProc("+noticelist.num+");' onclick='noticeDetailView(noticelist.num);'>"+noticelist.nickname+" "+noticelist.title+"</a></li>").appendTo("#notice_table");
			});
			$("#board_table").html("");
			$.each(data.boardlist, function(index, boardlist){
				$("<li><a href='javascript:boardDetailProc("+boardlist.num+");' onclick='detailView(boardlist.num);'>"+boardlist.nickname+" "+boardlist.title+"</a></li>").appendTo("#board_table");
			});
			$("#job_table").html("");
			$.each(data.joblist, function(index, joblist){
				$("<li><a>"+joblist.nickname+" "+joblist.title+"</a></li>").appendTo("#job_table");
			});
		}
	});
});
function boardDetailProc(board_idx) {
	document.getElementById('boardNo').value = board_idx;
	document.getElementById('updateNo').value = "noup";
	document.getElementById('boardfrm').submit();
}
function noticeDetailProc(notice_idx) {
	document.getElementById('noticeNo').value = notice_idx;
	document.getElementById('updateNo').value = "noup";
	document.getElementById('noticefrm').submit();
}
</script>
<form id='boardfrm' action="${home }board/boardDetailProc">
	<input type="hidden" name="boardNo" id="boardNo"> 
	<input type="hidden" name="updateGo" id="updateGo">
</form>
<form id='noticefrm' action="${home }board/noticeDetailProc">
	<input type="hidden" name="noticeNo" id="noticeNo"> 
	<input type="hidden" name="updateGo" id="updateGo">
</form>

<link rel="stylesheet" href="${css }main.css" >
<!-- 페이드인 효과 포함한 메인이미지 -->
		<div class="fade">
			<div style="align:center; margin-left:50px; margin-right: 0px;">
			<img alt="메인" src="${img }mainpage.png" width="90%" height="394px">
			</div>
		</div>
		<!-- 큰틀 -->
		<div style="height: 500px; padding: 5px, 17px, 13px, 0px; margin-top: 100px; margin-left: 100px;">
			<div align="left" style="background-color: #e71d36; color: #FFFFFF; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;" >
				<ul class="list" id="notice_table">
				</ul>
			</div>
			<div align="left" style="background-color: #2ec4b6; color: #FFFFFF; display: block; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;">
				<ul class="list2" id="board_table">
				</ul>
			</div>
			<div align="left" style="background-color: #011627;  display: block; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;">
				<ul class="list3" id="job_table">
				</ul>
			</div>
		</div>