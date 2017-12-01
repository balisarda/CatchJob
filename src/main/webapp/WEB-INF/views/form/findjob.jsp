<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:url var="home" value="/"/>
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<c:url var="img" value="/resources/img/" />

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<c:forEach var="job" items="${List}" varStatus="status">
		<div style=display:none;>	
			<input type=hidden  id='latitude${status.count}'  value='${job.latitude}'><br/>
			<input type=hidden  id='longitude${status.count}'  value='${job.longitude}'><br/>
			<input type=hidden  id='address${status.count}'  value='${job.address}'><br/>
			<input type=hidden  id='detail_address${status.count}'  value='${job.detail_address}'>
			<input type=hidden  id='road_address${status.count}'  value='${job.road_address}'><br/>
			<input type=hidden  id='member_nickname${status.count}'  value='${job.member_nickname}'><br/>
			<input type=hidden  id='member_phone${status.count}'  value='${job.member_phone}'><br/>
			<input type=hidden  id='job_comment${status.count}'  value='${job.job_comment}'>
			<input type=hidden  id='job_pay${status.count}'  value='${job.job_pay}'><br/>
			<input type=hidden  id='job_name${status.count}'  value='${job.job_name}'><br/>
			<input type=hidden  id='job_num${status.count}'  value='${job.job_num}'><br/>
			<input type=hidden  id='job_option${status.count}'  value='${job.job_option}'>
			<input type=hidden  id='job_date${status.count}'  value='${job.job_date}'><br/>
			<input type=hidden  id='job_time_start${status.count}'  value='${job.job_time_start}'><br/>
			<input type=hidden  id='job_time_end${status.count}'  value='${job.job_time_end}'><br/>
		</div>	
	</c:forEach>	
</head>		
	<input type="hidden" id=listsize value='${Listsize}'> 
	<div id=header></div>
	<div id=container>
		<div id="search">
			    <fieldset>
			      <label for="addr">주소입력</label>
			      <input type=text placeholder="ex)종로5가" name=addr id=addr>
			      <label for="start_time">시작시간</label>
			      <input type="text" name="start_time" id="start_time">
			      <label for="end_time">종료시간</label>
			      <input type="text" name="end_time" id="end_time">
			      <input type=button onclick='search();' value='검색'>		     
			    </fieldset>
		</div>			
		<div id=left_box>
			<div class="map_wrap">
			    <div id="map" style="width:100%;height:500px;position:relative;overflow:hidden;"></div> 			    
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
				            <li id="coffeeMenu" onclick="changeMarker('coffee')">
				                <span class="ico_comm ico_coffee"></span>
				                커피숍
				            </li>
				            <li id="storeMenu" onclick="changeMarker('store')">
				                <span class="ico_comm ico_store"></span>
				                편의점
				            </li>
				            <li id="restaurantMenu" onclick="changeMarker('carpark')">
				                <span class="ico_comm2 ico_restaurant"></span>
				                식   당
				            </li>
				            <li id="deliveryMenu" onclick="changeMarker('carpark')">
				                <span class="ico_comm2 ico_delivery"></span>
				                배   달
				            </li>
				            <li id="etcMenu" onclick="changeMarker('carpark')">
				                <span class="ico_comm2 ico_etc"></span>
				                기   타         
				            </li>				         
				        </ul>
				    </div>
				</div>			
		</div>
		<div id=right_box>			
			<div>
				<b>맥도날드</b><br/>
				2017년 11월 24일<br/>
						
			</div>					
		</div>
	</div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11b5c8e67235051a9e05cc5d09d8f60a&libraries=services,clusterer"></script>
		<link rel="stylesheet" href="${css }form/findjob.css">
		<link rel="stylesheet" href="${css }jquery-ui.css">
		
		<script src="${js }jquery-3.2.1.js"></script>
		<script src="${js }form/findjob.js"></script>
		<script src="${js }jquery-ui.js"></script>
	