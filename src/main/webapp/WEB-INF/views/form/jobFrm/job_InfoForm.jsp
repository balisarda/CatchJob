<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:url var="css" value="/resources/css/" />
	<c:url var="js" value="/resources/js/" />
	<c:url var="img" value="/resources/img/" />
	<c:url var="home" value="/" />
	<div  id=container>	
		<input type=hidden id=listsize value='${add_listsize}'>
		<c:forEach var="job" items="${add_list}" varStatus="status">
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
			<h1 style="margin:10px auto;">일 등록 내역</h1>				
			<select id="selectjob" style="width:100%;height:30px;">	
				<option id="choice_job" selected="selected" value="" disabled>선택</option>	
				<c:forEach var='getid' items='${add_list}' varStatus="status" >			
					<option value='${status.index}'>
						[${status.count}] ${getid.job_name} / ${getid.job_date}
					</option>			
				</c:forEach>
			</select>
			<div id="map" style="margin:10px auto;width:90%;height:280px;"></div>
			<div>	
			<h3><span id=apply_num></span>
			<button id="create-user" style="display:none;">지원자 보기</button>
			</h3>
			</div>
			<div id="dialog-form" >
			  <form>
			    <fieldset>
			      <label for="name">이름</label>
			      <input type="text" name="name" id="name" value="이두현" style="width:100px;" >
			      <label for="email">성별</label>
			      <input type="text" name="email" id="email" value="남자" style="width:100px;" >
			      <label for="password">나이</label>
			      <input type="text" name="password" id="password" value="31" style="width:100px;">
			      <input type="submit" style="position:absolute; top:-1000px">
			    </fieldset>
			  </form>
			</div>	
		</div>
		<div id=right_box>
			<div align="left">					
				<form id='frm' method="post">
				  <div id="jobinfo-contain">				
					<table style="overflow:hidden;">
				    	<tr><td><br></td></tr>
						<tr>						
							<td align="left" style="width:80px;"><h4>주소</h4></td>
							<td style="width:250px;">
								<input type=text id='road_address' name='road_address' style="width:250px;height:30px;" disabled>					
							</td>						
						</tr>
						<tr>
							<td align="left"></td>
							<td><input type=text id='detail_address' name='detail_address'  style="width:250px;height:30px;" disabled></td>
						</tr>				
						<tr>
							<td colspan=4><hr></td>
						</tr>
						
						<tr>
							<td align="left"><h4>상호명</h4></td>
							<td><input type='text' name='job_name' id='job_name' style="height:30px;"></td>
						</tr>
						
						<tr>
							<td align="left"><h4>시급</h4></td>
							<td><input id="job_pay" name="job_pay" title="최저임금 6,470원" style="width:60px;height:30px;" disabled><b>원</b></td>				
						</tr>
						
						<tr>
							<td align="left"><h4>인원수</h4></td>
							<td><input id="job_num" name="job_num"  style="width:26px;">	</td>		
						</tr>
						<tr>
							<td align="left"><h4>근무형태</h4></td>
							<td>																 		   
							    <select name="job_option" id="job_option" style="width:30px;height:30px;">
								    <option value='식당'>식당</option>
								    <option value='배달'>배달</option>
								    <option value='기타'>기타</option>
								    <option value='편의점'>편의점</option>										    
								    <option value='카페'>카페</option>
							    </select>		 										
							</td>					
						</tr>
						
						<tr><td colspan=4><hr></td></tr>
						
						<tr>
							<td align="left"><h4>날 짜</h4></td>
							<td><input type="text" name="job_date" id="job_date" style="height:30px;" disabled></td>
						</tr>
						
						<tr>
							<td align="left"><h4>시간</h4></td>
							<td>
								<input type="text" name="job_time_start" id="job_time_start" style="width:80px;height:30px;" disabled>~
								<input type="text" name="job_time_end" id="job_time_end" style="width:80px;height:30px;" disabled>
							</td>
						</tr>
						<tr>
							<td colspan='4'>
								<div style="height:150px;">
									<textarea name='job_comment' id='job_comment' style="width:100%;height:100%;"></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td>
							<div style="display:none;">					
								<input type='hidden' id='address' name='address' >															
								<input type='hidden' id='member_phone' name='member_phone' value='010490447982'>
								<input type="hidden" name='no' id="no">									
							</div>															
							</td>						
						</tr>																					
					</table>			
					<div id=right_bottom_box>												
						<input type='button' id="update_btn" onclick="bottonProc('update_job');" value="수정" disabled>	
						<input type='button' id="delete_btn" onclick="bottonProc('delete_job');" value="삭제" disabled>																					
					</div>
				  </div>	
				</form>
				<div id="users-contain" style="display:none;">
				  <h3>지원자 선택</h3>
				  <table id="users">
				    <thead>
				      <tr class="ui-widget-header ">
				        <th style="width:100px;">이름</th>
				        <th style="width:100px;">성별</th>
				        <th style="width:100px;">나이</th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>				        
				      </tr>
				    </tbody>
				  </table>				
				</div>							
			</div>	
		</div>								
	</div> 			
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c341eec7decf92e7921dd2100c58e83"></script>	
		<link rel="stylesheet" href="${css }form/job_InfoForm.css">
		<link rel="stylesheet" href="${css }jquery-ui.css">	
		<script src="${js }jquery-3.2.1.js"></script>
		<script src="${js }form/job_InfoForm.js"></script>
		<script src="${js }jquery-ui.js"></script>