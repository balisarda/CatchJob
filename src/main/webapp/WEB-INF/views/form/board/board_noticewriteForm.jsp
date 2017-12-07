<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="home" value="/" />

<center>
	<form action="${home }board/noticeInsertProc" method="post">
	<!-- 닉네임 세션 값 받아서 히든으로 숨겨서 넘겨줌 -->
	<input type="hidden" name="member_nickname" value="${sessionMember.nickname}">
		<table style="width: 650px;">
			<tr>
				<td style="width: 80px; height: 40px;" align="right">제 목</td>
				<td>
					<input type=text name='notice_title' /> <a style="color: red;">${msg }</a>
				</td>
			</tr>
			<tr>
				<td colspan=2 align="right">
					<textarea name="notice_contents" style="width: 650px; height: 300px"></textarea>
				</td>
			</tr>
			<tr>
				<td align='right' height=40 colspan=2><input type=file style="width: 300px;" /></td>
			</tr>
			<tr>
				<td align='center' height=40 colspan=2><input type=submit value='글쓰기' style="width: 120px;" />
					<input type=reset value='취소' style="width: 120px;" />
				</td>
			</tr>
		</table>
	</form>
</center>