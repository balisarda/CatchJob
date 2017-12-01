
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new daum.maps.LatLng(37.57023412331899, 127.00245068753499), // 지도의 중심좌표
    level: 6 // 지도의 확대 레벨                
};
var map = new daum.maps.Map(mapContainer, mapOption);
function setMapType(maptype) { 
    var roadmapControl = document.getElementById('btnRoadmap');
    var skyviewControl = document.getElementById('btnSkyview'); 
    if (maptype === 'roadmap') {
        map.setMapTypeId(daum.maps.MapTypeId.ROADMAP);    
        roadmapControl.className = 'selected_btn';
        skyviewControl.className = 'btn';
    } else {
        map.setMapTypeId(daum.maps.MapTypeId.HYBRID);    
        skyviewControl.className = 'selected_btn';
        roadmapControl.className = 'btn';
    }
}

var clusterer = new daum.maps.MarkerClusterer({
    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
    minLevel: 6, // 클러스터 할 최소 지도 레벨
    disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
});

// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
    map.setLevel(map.getLevel() - 1);
}
// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
    map.setLevel(map.getLevel() + 1);
}

var listsize=document.getElementById("listsize").value;

var coffee_positions=new Array();
var restaurant_positions=new Array();
var etc_positions=new Array();
var store_positions=new Array();
var delivery_positions=new Array();

var coffee_contents=new Array();
var restaurant_contents=new Array();
var etc_contents=new Array();
var delivery_contents=new Array();
var store_contents=new Array();

var latitude_array=[];
var longitude_array=[];
var job_option_array=[];
var address_array=[];
var detail_address_array=[];
var road_address_array=[];
var member_nickname_array=[];
var member_phone_array=[];
var job_comment_array=[];
var job_pay_array=[];
var job_name_array=[];
var job_num_array=[];
var job_date_array=[];
var job_time_start_array=[];
var job_time_end_array=[];

var markers=[];

for(var i=1;i<=listsize;i++){
	var latitude= Number(document.getElementById('latitude'+i).value);
	latitude_array.push(latitude);
	var longitude= Number(document.getElementById('longitude'+i).value);
	longitude_array.push(longitude);
	var job_option= document.getElementById('job_option'+i).value;
	job_option_array.push(job_option);
	var address= document.getElementById('address'+i).value;
	address_array.push(address);
	var detail_address= document.getElementById('detail_address'+i).value;
	detail_address_array.push(detail_address);
	var road_address= document.getElementById('road_address'+i).value;
	road_address_array.push(road_address);
	var member_nickname= document.getElementById('member_nickname'+i).value;
	member_nickname_array.push(member_nickname);
	var member_phone= document.getElementById('member_phone'+i).value;
	member_phone_array.push(member_phone);
	var job_comment= document.getElementById('job_comment'+i).value;
	job_comment_array.push(job_comment);
	var job_pay= document.getElementById('job_pay'+i).value;
	job_pay_array.push(job_pay);
	var job_name= document.getElementById('job_name'+i).value;
	job_name_array.push(job_name);
	var job_num= document.getElementById('job_num'+i).value;
	job_num_array.push(job_num);
	var job_date= document.getElementById('job_date'+i).value;
	job_date_array.push(job_date);
	var job_time_start= document.getElementById('job_time_start'+i).value;
	job_time_start_array.push(job_time_start);
	var job_time_end= document.getElementById('job_time_end'+i).value;
	job_time_end_array.push(job_time_end);
	 
	if(job_option=='카페'){
	coffee_positions.push(new daum.maps.LatLng(latitude,longitude));
	coffee_contents.push('<b>'+job_name+'<br/></b>'+job_date+'<br/>'+job_option);
	}else if(job_option=='기타'){
	etc_positions.push(new daum.maps.LatLng(latitude,longitude));
	etc_contents.push('<b>'+job_name+'<br/></b>'+job_date+'<br/>'+job_option);
	}else if(job_option=='식당'){
	restaurant_positions.push(new daum.maps.LatLng(latitude,longitude));
	restaurant_contents.push('<b>'+job_name+'<br/></b>'+job_date+'<br/>'+job_option);
	}else if(job_option=='배달'){
	delivery_positions.push(new daum.maps.LatLng(latitude,longitude));
	delivery_contents.push('<b>'+job_name+'<br/></b>'+job_date+'<br/>'+job_option);
	}else if(job_option=='편의점'){
	store_positions.push(new daum.maps.LatLng(latitude,longitude));
	store_contents.push('<b>'+job_name+'<br/></b>'+job_date+'<br/>'+job_option);
	}		
}
var imageSrc = '../resources/images/category.png';
var imageSrc2 = '../resources/images/category2.png';// 마커이미지의 주소입니다    
var imageSize = new daum.maps.Size(22, 26),

restaurant_imageOprion = {spriteOrigin: new daum.maps.Point(10, 0),spriteSize: new daum.maps.Size(36, 98)};
etc_imageOprion = {spriteOrigin: new daum.maps.Point(10, 72),spriteSize: new daum.maps.Size(36, 98)};
delivery_imageOprion = {spriteOrigin: new daum.maps.Point(10, 36),spriteSize: new daum.maps.Size(36, 98)};
store_imageOprion = {spriteOrigin: new daum.maps.Point(10, 36),spriteSize: new daum.maps.Size(36, 98)};
coffee_imageOprion = {spriteOrigin: new daum.maps.Point(10, 0),spriteSize: new daum.maps.Size(36, 98)};
// 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

var restaurant_markerImage = new daum.maps.MarkerImage(imageSrc2, imageSize, restaurant_imageOprion);
var etc_markerImage = new daum.maps.MarkerImage(imageSrc2, imageSize, etc_imageOprion);
var delivery_markerImage = new daum.maps.MarkerImage(imageSrc2, imageSize, delivery_imageOprion);
var store_markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, store_imageOprion);
var coffee_markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, coffee_imageOprion);
//식당 마커 생성

for (var i = 0; i < restaurant_positions.length; i ++) {  
    var restaurant_marker = new daum.maps.Marker({
        map: map, 
        position: restaurant_positions[i],
        image: restaurant_markerImage,        
    });
    var restaurant_infowindow = new daum.maps.InfoWindow({
	    content: restaurant_contents[i]
	});
    markers.push(restaurant_marker);
	daum.maps.event.addListener(restaurant_marker, 'mouseover', makeOverListener(map, restaurant_marker, restaurant_infowindow));
    daum.maps.event.addListener(restaurant_marker, 'mouseout', makeOutListener(restaurant_infowindow));
    daum.maps.event.addListener(restaurant_marker, 'click', clickMarker(restaurant_marker, map, restaurant_infowindow));
}
//기타 마커 생성
for (var i = 0; i < etc_positions.length; i ++) {    
   var etc_marker = new daum.maps.Marker({
        map: map, 
        position: etc_positions[i],
        image: etc_markerImage     
    });
   var etc_infowindow = new daum.maps.InfoWindow({
	    content: etc_contents[i]
	});
   markers.push(etc_marker);
	daum.maps.event.addListener(etc_marker, 'mouseover', makeOverListener(map, etc_marker, etc_infowindow));
    daum.maps.event.addListener(etc_marker, 'mouseout', makeOutListener(etc_infowindow));
    daum.maps.event.addListener(etc_marker, 'click', clickMarker(etc_marker, map, etc_infowindow));
}
//배달 마커 생성
for (var i = 0; i < delivery_positions.length; i ++) {   
    var delivery_marker = new daum.maps.Marker({
        map: map, 
        position: delivery_positions[i], 
        image: delivery_markerImage  
    });
    var delivery_infowindow = new daum.maps.InfoWindow({
	    content: delivery_contents[i]
	});
    markers.push(delivery_marker);
	daum.maps.event.addListener(delivery_marker, 'mouseover', makeOverListener(map, delivery_marker, delivery_infowindow));
    daum.maps.event.addListener(delivery_marker, 'mouseout', makeOutListener(delivery_infowindow));
    daum.maps.event.addListener(delivery_marker, 'click', clickMarker(delivery_marker, map, delivery_infowindow));
}
//편의점 마커 생성
for (var i = 0; i < store_positions.length; i ++) {  
    var store_marker = new daum.maps.Marker({
        map: map, 
        position: store_positions[i], 
        image: store_markerImage  
    });
    var store_infowindow = new daum.maps.InfoWindow({
	    content: store_contents[i]
	});
    markers.push(store_marker);
	daum.maps.event.addListener(store_marker, 'mouseover', makeOverListener(map, store_marker, store_infowindow));
    daum.maps.event.addListener(store_marker, 'mouseout', makeOutListener(store_infowindow));
    daum.maps.event.addListener(store_marker, 'click', clickMarker(store_marker, map, store_infowindow));
}
//카페 마커 생성 
for (var i = 0; i < coffee_positions.length; i ++) {   
    var coffee_marker = new daum.maps.Marker({
        map: map, 
        position: coffee_positions[i],
        image: coffee_markerImage       
    });
    var coffee_infowindow = new daum.maps.InfoWindow({
	    content: coffee_contents[i]
	});	
    markers.push(coffee_marker);  
	daum.maps.event.addListener(coffee_marker, 'mouseover', makeOverListener(map, coffee_marker, coffee_infowindow));
    daum.maps.event.addListener(coffee_marker, 'mouseout', makeOutListener(coffee_infowindow));
    daum.maps.event.addListener(coffee_marker, 'click', clickMarker(coffee_marker, map, coffee_infowindow));
}
clusterer.addMarkers(markers);
// 마커를 클릭했을 때 동작하는 함수 입니다.	
function clickMarker(marker, map, infowindow) {
    return function() {   	
    	infowindow.close();
    	
    	
};
}
// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}
// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();               
    };
}
//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
overlay.setMap(null);     
}
daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

    // 현재 지도 레벨에서 1레벨 확대한 레벨
    var level = map.getLevel()-1;

    // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
    map.setLevel(level, {anchor: cluster.getCenter()});
});
//주소를 입력하고 그 위치로 중심좌표를 이동하는 함수 입니다.
function search(){
	
	var geocoder = new daum.maps.services.Geocoder();
	 Addr=document.getElementById('addr').value;
geocoder.addressSearch(Addr, function(result, status) {	
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
        map.setLevel(5);
        map.setCenter(coords);
    }else{
    	alert("정확한 주소를 입력해 주세요")
    	}
});
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////