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
				$("<li><a>"+noticelist.nickname+" "+noticelist.title+"</a></li>").appendTo("#notice_table");
			});
			$("#board_table").html("");
			$.each(data.boardlist, function(index, boardlist){
				$("<li><a>"+boardlist.nickname+" "+boardlist.title+"</a></li>").appendTo("#board_table");
			});
		}
	});
});
</script>
<link rel="stylesheet" href="${css }main.css" >
		<div class="fade">
			<div style="align:center; margin-left:300px; margin-right: 0px;">
			<img alt="메인" src="${img }mainpage.png" width="90%" height="394px">
			</div>
		</div>
		<div style="height: 500px; padding: 5px, 17px, 13px, 0px; margin-top: 100px; margin-left: 300px;">
			<div style="background-color: #e71d36; color: #FFFFFF; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;" >
				<ul class="list" id="notice_table">
				</ul>
			</div>
			<div style="background-color: #2ec4b6; color: #FFFFFF; display: block; width: 350px; float: left; margin-top: 2px; margin-right: 15px; margin-bottom: 2px; margin-left: 0px;">
				<ul class="list2" id="board_table">
				</ul>
			</div>
		</div>