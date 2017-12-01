<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="home" value="/" />

<center>
	<form action="${home }board/noticeupdateProc" method="post">
	<!-- 닉네임 세션 값 받아서 히든으로 숨겨서 넘겨줌 -->
	<input type="hidden" name="member_nickname" value="${sessionMember.nickname}">
	<input type="hidden" name="notice_idx" value="${noticedetail.notice_idx }">
		<table style="width: 650px;">
			<tr>
				<td style="width: 80px; height: 40px;" align="left">제 목
				</td>
				<td style="width: 570px; height: 40px;">
					<input type=text name='notice_title' value="${noticedetail.notice_title }"/><a style="color: red;">${msg }</a>
				</td>
				<td align="right">${noticedetail.notice_idx }</td>
			</tr>
			<tr>
				<td colspan=2 align="right">
				<textarea name="notice_contents"  
				style="width: 650px; height: 300px">${noticedetail.notice_contents }</textarea>
				</td>
			</tr>
			<tr>
				<td align='right' height=40 colspan=2><input type=file
					style="width: 300px;" /></td>
			</tr>
			<tr>
				<td align='center' height=40 colspan=2>
				<input type=submit value='수정하기' style="width: 80px;" /> 
				<input type=reset value='취소' style="width: 80px;" />
				<input type=button value='목록' style="width: 80px;" onclick="location.href='${home }board/noticeBoard'"/></td>
			</tr>
		</table>
	</form>
</center>