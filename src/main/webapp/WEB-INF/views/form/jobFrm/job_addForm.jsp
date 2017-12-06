<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:url var="css" value="/resources/css/" />
	<c:url var="js" value="/resources/js/" />
	<c:url var="img" value="/resources/img/" />
	<c:url var="home" value="/" />
	<div  id=container>
	<form action="${var}job/jobaddForm" onsubmit="return sndFrm();" method=post id="frm">
		<div id=left_box>				
			<div class="map_wrap">
			    <div id="map" style="width:100%;height:350px;position:relative;overflow:hidden;"></div> 			    
			    <div class="custom_typecontrol radius_border">
			        <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
			        <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
			    </div>				   
			    <div class="custom_zoomcontrol radius_border"> 
			        <span onclick="zoomIn()"><img src="${img }ico_plus.png" alt="확대"></span>  
			        <span onclick="zoomOut()"><img src="${img }ico_minus.png" alt="축소"></span>
			    </div>
			</div>
				<hr>
			<div id=context>					
				<textarea name='job_comment' placeholder="상세사항을 입력해주세요."></textarea>					
			</div>
		</div>
		<div id=right_box>		
			<div align="left" style="margin:5px 0px 10px 5px;">
				<label for="radio-1"><b>기존 주소</b></label>
			    <input type="radio" value=1 id="radio-1" name="radio-1" onclick="div_OnOff(this.value,'con');">
			    <label for="radio-2"><b>새로운 주소</b></label>	  	
		    	<input type="radio" value=2 id="radio-2" name="radio-1" onclick="div_OnOff(this.value,'con');" checked>
		    </div>
		    <div id="con" style="display:none">
		    	<div align=left>
			    	<div onclick="callAddr();">경기도 안성시 도기동 73-1</div>
			    	<div onclick="callAddr();">서울특별시 강북구 번동 122길 20</div>     	
		    	</div>
		    </div>
		    	<div align="left">					    
				    <table>
				    	<tr><td><br></td></tr>
						<tr>						
							<td align="left" style="width:80px;"><h4>주소</h4></td>
							<td style="width:250px;">
								<input type=text id='road_address' name='road_address' placeholder="주소를 입력해 주세요." style="width:250px;height:30px;">					
							</td>
							<td><input type="button" onclick="return searchAddr();" value="검색"></td>				
						</tr>
						<tr>
							<td align="left"><h4>상세주소</h4></td>
							<td><input type=text id='detail_address' name='detail_address'  placeholder="상세 주소를 입력해 주세요." style="width:250px;height:30px;"></td>
						</tr>
						<tr>
							<td colspan=4 align="center"><h5>지도를 클릭 또는 검색해 주세요.</h5></td>
						</tr>
						<tr>
							<td colspan=4><hr></td>
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td align="left"><h4>상호명</h4></td>
							<td><input type='text' name='job_name' placeholder="ex) 맥도날드 강남점" style="height:30px;"></td>
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td align="left"><h4>시급</h4></td>
							<td><input id="pay_hour" name="job_pay" title="최저임금 6,470원" style="width:60px;height:30px;"><b>원</b></td>				
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td align="left"><h4>인원수</h4></td>
							<td><input type=number id="spinner" name="job_num" style="width:26px;">	</td>		
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr>
							<td align="left"><h4>근무형태</h4></td>
							<td>																 		   
							    <select name="job_option" id="selectjop" style="width:30px;height:30px;">
								    <option value='식당'>식당</option>
								    <option value='배달'>배달</option>
								    <option value='기타' selected="selected">기타</option>
								    <option value='편의점'>편의점</option>										    
								    <option value='카페'>카페</option>
							    </select>		 										
							</td>					
						</tr>
						<tr><td><br></td></tr>
						<tr><td colspan=4><hr></td></tr>
						<tr><td><br></td></tr>
						<tr>
							<td align="left"><h4>날 짜</h4></td>
							<td><input placeholder="날짜를 입력해 주세요." name="job_date" id="datepicker" style="height:30px;"></td>
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td align="left"><h4>시간</h4></td>
							<td>
								<input type="text" id='timepicker1' name="job_time_start" style="width:80px;height:30px;">~
								<input type="text" id='timepicker2' name="job_time_end" style="width:80px;height:30px;">
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td>
							<div style="display:none;">					
								<input type='hidden' id='address' name='address'>							
								<input type='hidden' id='latitude' name='latitude'>
								<input type='hidden' id='longitude' name='longitude'>								
								<input type='hidden' id='phone' name='member_phone' value='010490447982'>							
							</div>
							</td>						
						</tr>
						<tr>
							<td colspan=4>
								<div id=right_bottom_box>
								<input type='hidden' id='name' name='member_nickname' value="${sessionMember.nickname}">
									<input type=reset value=취소>	
									<input type='submit'  value=등록>																		
								</div>
							</td>
						</tr>						
					</table>																		
				</div>
			</div>	
		</form>								
	</div>		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c341eec7decf92e7921dd2100c58e83&libraries=services"></script>	
		<link rel="stylesheet" href="${css}form/job_addForm.css">
		<link rel="stylesheet" href="${css }jquery-ui.css">
		<link rel="stylesheet" href="${css }jquery.timepicker.css">	
		<script src="${js }jquery-3.2.1.js"></script>
		<script src="${js }jquery.timepicker.js"></script>
		<script src="${js }form/job_addFrom.js"></script>
		<script src="${js }jquery-ui.js"></script>