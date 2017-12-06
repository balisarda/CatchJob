<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:url var="css" value="/resources/css/" />
	<c:url var="js" value="/resources/js/" />
	<c:url var="img" value="/resources/img/" />
	<c:url var="home" value="/" />
	<div  id=container>	
		<input type=hidden id=listsize value='${apply_listsize}'>
		<c:forEach var="job" items="${apply_list}" varStatus="status">
		<div style=display:none;>	
			<input type=hidden  id='latitude${status.count}'  value='${job.latitude}'>
			<input type=hidden  id='longitude${status.count}'  value='${job.longitude}'>
			<input type=hidden  id='address${status.count}'  value='${job.address}'>
			<input type=hidden  id='detail_address${status.count}'  value='${job.detail_address}'>
			<input type=hidden  id='road_address${status.count}'  value='${job.road_address}'>
			<input type=hidden  id='member_nickname${status.count}'  value='${job.member_nickname}'>
			<input type=hidden  id='member_phone${status.count}'  value='${job.member_phone}'>
			<input type=hidden  id='job_comment${status.count}'  value='${job.job_comment}'>
			<input type=hidden  id='job_pay${status.count}'  value='${job.job_pay}'>
			<input type=hidden  id='job_name${status.count}'  value='${job.job_name}'>
			<input type=hidden  id='job_num${status.count}'  value='${job.job_num}'>
			<input type=hidden  id='job_option${status.count}'  value='${job.job_option}'>
			<input type=hidden  id='job_date${status.count}'  value='${job.job_date}'>
			<input type=hidden  id='job_time_start${status.count}'  value='${job.job_time_start}'>
			<input type=hidden  id='job_time_end${status.count}'  value='${job.job_time_end}'>
			<input type=hidden  id='no${status.count}'  value='${job.no}'>					
		</div>	
		</c:forEach>			
		<div id=left_box>
			<h1 style="margin:10px auto;">일 지원 내역</h1>				
			<select id="selectjob" style="width:100%;height:30px;">	
				<option id="choice_job" selected="selected" value="" disabled>선택</option>	
				<c:forEach var='getid' items='${apply_list}' varStatus="status" >			
					<option value='${status.index}'>
						[${status.count}] ${getid.job_name} / ${getid.job_date}
					</option>			
				</c:forEach>
			</select>
			<div id="map" style="margin:10px auto;width:90%;height:280px;">			
				<font color="red">등록자가 일을 삭제하면 지원 목록에서 자동 삭제 됩니다.</font>
			</div>
			<font size='5' color='#0174DF' id=apply_num></font><font size='5' color='#FF0040' id="job_num"></font>		
		</div>
		<div id=right_box>
			<div >					
				<form id='frm' method="post">				
					<table style="overflow:hidden;">
				    	<tr><td><br></td></tr>
						<tr>						
							<td align="left" style="width:80px;"><h4>주소</h4></td>
							<td style="width:250px;">
								<div id='road_address'></div>					
							</td>						
						</tr>
						<tr>
							<td align="left"></td>
							<td><div id='detail_address'></div></td>
						</tr>				
						<tr>
							<td colspan=4><hr></td>
						</tr>
						
						<tr>
							<td align="left"><h4>상호명</h4></td>
							<td><div id='job_name'></div></td>
						</tr>
						<tr>
							<td align="left"><h4>전화번호</h4></td>
							<td><div id='member_phone'></div></td>
						</tr>
						<tr>
							<td align="left"><h4>시급</h4></td>
							<td><div id="job_pay"></div></td>				
						</tr>
						<tr>
							<td align="left"><h4>근무형태</h4></td>
							<td>																 		   
							    <div id="job_option"></div>			 								
							</td>					
						</tr>
						
						<tr><td colspan=4><hr></td></tr>
						
						<tr>
							<td align="left"><h4>날 짜</h4></td>
							<td><div id="job_date"></div></td>
						</tr>
						
						<tr>
							<td align="left"><h4>시간</h4></td>
							<td>
								<div id="job_time_start"></div>
								<div id="job_time_end"></div>
							</td>
						</tr>
						<tr>
							<td colspan='4'>
								<div style="height:150px;">
									<textarea id='job_comment' style="width:100%;height:100%;"disabled></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td>
							<div style="display:none;">					
								<div id='address'></div>																							
								<input type="text" name="no" id="no">
								<input type="text">
								<input type="hidden" name='member_nickname' value='${sessionMember.nickname}'>							
							</div>										
							</td>						
						</tr>																					
					</table>			
					<div id=right_bottom_box>												
						<input type='button' onclick="location.href='jobfindForm'" value="계속 지원 하기">	
						<input type='button' onclick="bottonProc('delete_apply');" value="지원취소" id="deleteapply" disabled>																					
					</div>
				</form>							
			</div>	
		</div>								
	</div> 			
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c341eec7decf92e7921dd2100c58e83"></script>	
		<link rel="stylesheet" href="${css }form/job_applyForm.css">
		<link rel="stylesheet" href="${css }jquery-ui.css">	
		<script src="${js }jquery-3.2.1.js"></script>
		<script src="${js }form/job_applyForm.js"></script>
		<script src="${js }jquery-ui.js"></script>