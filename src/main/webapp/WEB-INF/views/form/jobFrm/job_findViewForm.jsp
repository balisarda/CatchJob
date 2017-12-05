<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:url var="css" value="/resources/css/" />
	<c:url var="js" value="/resources/js/" />
	<c:url var="img" value="/resources/img/" />
	<c:url var="home" value="/" />	
	
	<div id=container>
		<div id="search">
			    <fieldset>
			      <font size=5>주소검색</font>
			      <input type=text placeholder="ex)종로5가" id=addr>    
			      <input type=button onclick='search();' value='검색'>  
			    </fieldset>
		</div>			
		<div id=left_box>
			<div class="map_wrap">
			    <div id="map" style="width:70%;height:800px;position:relative;overflow:hidden;"></div> 			    
			    <div class="custom_typecontrol radius_border">
			        <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
			        <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
			    </div>				   
			    <div class="custom_zoomcontrol radius_border"> 
			        <span onclick="zoomIn()"><img src="${img }ico_plus.png" alt="확대"></span>  
			        <span onclick="zoomOut()"><img src="${img }ico_minus.png" alt="축소"></span>
			    </div>
			     <div class="category">
				        <ul>
				            <li id="everyMenu" onclick="changeMarker('every')">
				                <span class="ico_comm ico_All"></span>
				               전   체  
				            </li>				       
				            <li id="coffeeMenu" onclick="changeMarker('coffee')">
				                <span class="ico_comm ico_coffee"></span>
				                커피숍
				            </li>
				            <li id="storeMenu" onclick="changeMarker('store')">
				                <span class="ico_comm ico_store"></span>
				                편의점
				            </li>
				            <li id="restaurantMenu" onclick="changeMarker('restaurant')">
				                <span class="ico_comm2 ico_restaurant"></span>
				                식   당
				            </li>
				            <li id="deliveryMenu" onclick="changeMarker('delivery')">
				                <span class="ico_comm2 ico_delivery"></span>
				                배   달
				            </li>
				            <li id="etcMenu" onclick="changeMarker('etc')">
				                <span class="ico_comm2 ico_etc"></span>
				                기   타         
				            </li>				         
				        </ul>
				    </div>
				</div>				
		</div>
		<div id=right_box >
				<table style="width:100%">
				<tr>
					<td rowspan=3 align="center">
							<img src="${img}applyWindow/userInfo.png">
					</td>	
				</tr>
				<tr>					
					<td><input type=text id="member_nickname" value="${job_list.member_nickname }" style="width:100%;border:none;" disabled></td>
				</tr>
				<tr>		
					<td><input type=text id="member_phone" style="width:100%;border:none;"disabled></td>
				</tr>
				<tr>
					<td rowspan=3 align="center">	
						<img src="${img}applyWindow/address.png">					
					</td>	
				</tr>
				<tr>						
					<td><input type=text id="road_address" style="width:100%;border:none;"disabled></td>
				</tr>
				<tr>
					<td><input type=text id="detail_address" style="width:100%;border:none;"disabled></td>
				</tr>
				<tr>
					<td rowspan=3 align="center">
						<img src="${img}applyWindow/jobInfo.png">						
					</td>	
				</tr>
				<tr>	
					<td><input type=text id="job_name" style="width:100%;border:none;"disabled></td>
					
				</tr>
				<tr>
					<td><input type=text id="job_option" style="width:100%;border:none;"disabled></td>
				</tr>
				<tr>
					<td align="center">
						<img src="${img}applyWindow/pay.png">
					</td>
					<td><input type=text id="job_pay" style="width:100%;border:none;"disabled></td>
				</tr>			
				<tr>
					<td rowspan=4 align="center">
						<img src="${img}applyWindow/date.png">	
					</td>					
				</tr>
				<tr>
					<td><input type=text id="job_date" style="width:100%;border:none;"disabled></td>
				</tr>
				<tr>
					<td><input type=text id="job_time_start" style="width:100%;border:none;"disabled></td>
				</tr>
				<tr>
					<td><input type=text id="job_time_end" style="width:100%;border:none;"disabled></td>
				</tr>
				<tr>
					<td colspan=2>
						<textarea id="job_comment" style="height:200px;"disabled></textarea>
					</td>
				</tr>		
				</table><br/>
				<font size="6" color="#0174DF">	
					지원자<input id="apply_num" style="border:none;width:35px;font-size:20px;"disabled>	
					모집<input id="job_num" style="border:none;width:35px;font-size:20px;"disabled>
				</font>
					<form  id="applyFrm"><br/>
					<input type=hidden name='no' id="no"><input type="hidden" name='member_nickname' id="member" value='${sessionMember.nickname}'>
					<input type=hidden name='apply_contents' id="apply_contents"><input type='hidden' name='apply_status' value="지원 중">							
					</form>	
				<input type='button' id="apply" value="지원하기" style="width:100%;height:30px;">
				<input type="hidden" id="status">
					 						
		</div>
		<div id="dialog_confirm2" title="지원 완료!" style="display:none;">
		  	<p><span style="float:left; margin:12px 12px 20px 0;"></span>등록 완료 되었습니다. 나의 지원 정보 보기로 이동하시겠습니까?</p>
		 </div>
		<div id="dialog_confirm" title="지원 전 확인해주세요." style="display:none;">
			<div class=center>
	  		<table>
	  			<tr>
		  			<td><b>업 체 명:</b></td>
		  			<td><span id="job_name_confirm"></span></td>
	  			</tr>
	  			<tr>
		  			<td><b>시작시간:</b></td>
		  			<td><span id="job_time_start_confirm"></span></td>
	  			</tr>
	  			<tr>
		  			<td><b>종료시간:</b></td>
		  			<td><span id="job_time_end_confirm"></span></td>
	  			</tr>
	  			<tr>
		  			<td><b>시     급:</b></td>
		  			<td><span id="job_pay_confirm"></span><br/></td>		  		
	  			</tr>				
	  		</table>
	  		<font size="2" color="#0174DF">지원 전 한마디.</font>	
	  		<textarea id="contents" style="width:100%;height:100px;"></textarea>	  		
	  		<b>정말로 지원 하시겠습니까?</b>
	  		</div>
		  </div>			  
		</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c341eec7decf92e7921dd2100c58e83&libraries=services,clusterer"></script>
		<link rel="stylesheet" href="${css }form/findjob.css">
		<link rel="stylesheet" href="${css }jquery-ui.css">
		<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
		<script src="${js }jquery-3.2.1.js"></script>
		<script src="${js }form/findViewjob.js"></script>
		<script src="${js }jquery-ui.js"></script>
	