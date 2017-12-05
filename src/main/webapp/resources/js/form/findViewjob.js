
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

// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
    map.setLevel(map.getLevel() - 1);
}
// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
    map.setLevel(map.getLevel() + 1);
}

var listsize=document.getElementById("listsize").value;
//각 객체별로 좌표 정보 배열
var coffee_positions=new Array();
var restaurant_positions=new Array();
var etc_positions=new Array();
var store_positions=new Array();
var delivery_positions=new Array();
//각 객체별 마우스 오버 출력 내용 배열
var coffee_contents=new Array();
var restaurant_contents=new Array();
var etc_contents=new Array();
var delivery_contents=new Array();
var store_contents=new Array();

//각 객체별 마커 를 담음
var etc_markers=[];
var restaurant_markers=[];
var delivery_markers=[];
var store_markers=[];
var coffee_markers=[];
//각 객체별 전체정보를 담음
var etc_Info=[];
var restaurant_Info=[];
var delivery_Info=[];
var store_Info=[];
var coffee_Info=[];
var markers=[];

for(var i=1;i<=listsize;i++){
	//각 객체의 정보를 script안에서 관리하기 위한 객체 생성
	var latitude= Number($(('#latitude')+i).val());
	var longitude= Number($(('#longitude')+i).val());
	var job_option= $(('#job_option')+i).val();
	var address= $(('#address')+i).val();
	var detail_address= $(('#detail_address')+i).val();
	var road_address= $(('#road_address')+i).val();
	var member_nickname= $(('#member_nickname')+i).val();
	var member_phone= $(('#member_phone')+i).val();
	var job_comment= $(('#job_comment')+i).val();
	var job_pay=$(('#job_pay')+i).val();
	var job_name= $(('#job_name')+i).val();
	var job_num= $(('#job_num')+i).val();
	var job_date=$(('#job_date')+i).val();
	var job_time_start=$(('#job_time_start')+i).val();
	var job_time_end=$(('#job_time_end')+i).val();
	var no=$(('#no')+i).val();
	
	var windowInofodiv='<div style="width:180px;text-align:center;padding:6px 0;">'+
						'<font size="3" color="#0174DF"><b>'+job_name+'</b></font><br/>'
						     +job_date+'<br/><b>시급 : '
						     +job_pay+' 원</b>'
						"</div>";
	
	 //job_option별로 객체를 관리 하기 위해 각 객체에 정보를 담습니다.
	if(job_option=='카페'){
	coffee_positions.push(new daum.maps.LatLng(latitude,longitude));
	coffee_contents.push(windowInofodiv);
	coffee_Info.push([member_nickname,member_phone,road_address,detail_address,job_name,job_num,job_option,job_pay,job_date,job_time_start,job_time_end,job_comment,no]);
	}else if(job_option=='기타'){
	etc_positions.push(new daum.maps.LatLng(latitude,longitude));
	etc_contents.push(windowInofodiv);
	etc_Info.push([member_nickname,member_phone,road_address,detail_address,job_name,job_num,job_option,job_pay,job_date,job_time_start,job_time_end,job_comment,no]);
	}else if(job_option=='식당'){
	restaurant_positions.push(new daum.maps.LatLng(latitude,longitude));
	restaurant_contents.push(windowInofodiv);
	restaurant_Info.push([member_nickname,member_phone,road_address,detail_address,job_name,job_num,job_option,job_pay,job_date,job_time_start,job_time_end,job_comment,no]);
	}else if(job_option=='배달'){
	delivery_positions.push(new daum.maps.LatLng(latitude,longitude));
	delivery_contents.push(windowInofodiv);
	delivery_Info.push([member_nickname,member_phone,road_address,detail_address,job_name,job_num,job_option,job_pay,job_date,job_time_start,job_time_end,job_comment,no]);
	}else if(job_option=='편의점'){
	store_positions.push(new daum.maps.LatLng(latitude,longitude));
	store_contents.push(windowInofodiv);
	store_Info.push([member_nickname,member_phone,road_address,detail_address,job_name,job_num,job_option,job_pay,job_date,job_time_start,job_time_end,job_comment,no]);
	}		
}
var imageSrc = '../resources/img/category.png';// 마커이미지1의 주소
var imageSrc2 = '../resources/img/category2.png';// 마커이미지2의 주소    
var imageSize = new daum.maps.Size(22, 26),// 마커의 사이즈
//마커이미지의 옵션입니다.
restaurant_imageOprion = {spriteOrigin: new daum.maps.Point(10, 0),spriteSize: new daum.maps.Size(36, 98)};
etc_imageOprion = {spriteOrigin: new daum.maps.Point(10, 72),spriteSize: new daum.maps.Size(36, 98)};
delivery_imageOprion = {spriteOrigin: new daum.maps.Point(10, 36),spriteSize: new daum.maps.Size(36, 98)};
store_imageOprion = {spriteOrigin: new daum.maps.Point(10, 36),spriteSize: new daum.maps.Size(36, 98)};
coffee_imageOprion = {spriteOrigin: new daum.maps.Point(10, 0),spriteSize: new daum.maps.Size(36, 98)};
//마커의 객체 생성입니다.
var restaurant_markerImage = new daum.maps.MarkerImage(imageSrc2, imageSize, restaurant_imageOprion);
var etc_markerImage = new daum.maps.MarkerImage(imageSrc2, imageSize, etc_imageOprion);
var delivery_markerImage = new daum.maps.MarkerImage(imageSrc2, imageSize, delivery_imageOprion);
var store_markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, store_imageOprion);
var coffee_markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, coffee_imageOprion);
//전체 카테고리를 맵에 보여주기 위한 기능
function setEveryMarkers(map) {        
    for (var i = 0; i < markers.length; i++) {  
    	markers[i].setMap(map);
    }        
}
//식당 마커 생성
for (var i = 0; i < restaurant_positions.length; i ++) {  
		//마커를 표시할 위도 경도
		restaurant_marker = new daum.maps.Marker({
        map: map, 
        position: restaurant_positions[i],
        image: restaurant_markerImage,        
    });
		//식당 마커가 mouseover됬을 때 보여줄 infowindow
    var restaurant_infowindow = new daum.maps.InfoWindow({
	    content: restaurant_contents[i]
	});
    //클릭시 #right_box에 보여줄 정보를 담음
    var setRestaurant_Info=restaurant_Info[i]
    restaurant_markers.push(restaurant_marker);
    //식당 마커를 makers에 담음
    markers.push(restaurant_marker);
	daum.maps.event.addListener(restaurant_marker, 'mouseover', makeOverListener(map, restaurant_marker, restaurant_infowindow));
    daum.maps.event.addListener(restaurant_marker, 'mouseout', makeOutListener(restaurant_infowindow));
    daum.maps.event.addListener(restaurant_marker, 'click', clickMarker(setRestaurant_Info,restaurant_marker, map, restaurant_infowindow));
}
//식당카테로리 클릭시 맵에 보여주기 위한 기능
function setRestaurantMarkers(map) {        
    for (var i = 0; i < restaurant_markers.length; i++) {  
    	restaurant_markers[i].setMap(map);
    }        
}
//기타 마커 생성
for (var i = 0; i < etc_positions.length; i ++) {    
		etc_marker = new daum.maps.Marker({
        map: map, 
        position: etc_positions[i],
        image: etc_markerImage     
    });
   var etc_infowindow = new daum.maps.InfoWindow({
	    content: etc_contents[i]
	});
   var setEtc_Info=etc_Info[i]
   etc_markers.push(etc_marker);
   markers.push(etc_marker);
	daum.maps.event.addListener(etc_marker, 'mouseover', makeOverListener(map, etc_marker, etc_infowindow));
    daum.maps.event.addListener(etc_marker, 'mouseout', makeOutListener(etc_infowindow));
    daum.maps.event.addListener(etc_marker, 'click', clickMarker(setEtc_Info,etc_marker, map, etc_infowindow));
}
function setEtcMarkers(map) {        
    for (var i = 0; i < etc_markers.length; i++) {  
    	etc_markers[i].setMap(map);
    }        
}
//배달 마커 생성
for (var i = 0; i < delivery_positions.length; i ++) {   
		delivery_marker = new daum.maps.Marker({
        map: map, 
        position: delivery_positions[i], 
        image: delivery_markerImage  
    });
    var delivery_infowindow = new daum.maps.InfoWindow({
	    content: delivery_contents[i]
	});
    var setDelivery_Info=delivery_Info[i]
    delivery_markers.push(delivery_marker);
    markers.push(delivery_marker);
	daum.maps.event.addListener(delivery_marker, 'mouseover', makeOverListener(map, delivery_marker, delivery_infowindow));
    daum.maps.event.addListener(delivery_marker, 'mouseout', makeOutListener(delivery_infowindow));
    daum.maps.event.addListener(delivery_marker, 'click', clickMarker(setDelivery_Info,delivery_marker, map, delivery_infowindow));
}
function setDeliveryMarkers(map) {        
    for (var i = 0; i < delivery_markers.length; i++) {  
    	delivery_markers[i].setMap(map);
    }        
}
//편의점 마커 생성
for (var i = 0; i < store_positions.length; i ++) {  
		store_marker = new daum.maps.Marker({
        map: map, 
        position: store_positions[i], 
        image: store_markerImage  
    });
    var store_infowindow = new daum.maps.InfoWindow({
	    content: store_contents[i]
	});
    var setStore_Info=store_Info[i]
    store_markers.push(store_marker);
    markers.push(store_marker);
	daum.maps.event.addListener(store_marker, 'mouseover', makeOverListener(map, store_marker, store_infowindow));
    daum.maps.event.addListener(store_marker, 'mouseout', makeOutListener(store_infowindow));
    daum.maps.event.addListener(store_marker, 'click', clickMarker(setStore_Info,store_marker, map, store_infowindow));
}
function setStoreMarkers(map) {        
    for (var i = 0; i < store_markers.length; i++) {  
    	store_markers[i].setMap(map);
    }        
}
//카페 마커 생성 
for (var i = 0; i < coffee_positions.length; i ++) {   
		coffee_marker = new daum.maps.Marker({
        map: map, 
        position: coffee_positions[i],
        image: coffee_markerImage,      
    });
    var coffee_infowindow = new daum.maps.InfoWindow({
	    content: coffee_contents[i]
	});
    var setCoffee_Info=coffee_Info[i]
    coffee_markers.push(coffee_marker);
    markers.push(coffee_marker);  
	daum.maps.event.addListener(coffee_marker, 'mouseover', makeOverListener(map, coffee_marker, coffee_infowindow));
    daum.maps.event.addListener(coffee_marker, 'mouseout', makeOutListener(coffee_infowindow));
    daum.maps.event.addListener(coffee_marker, 'click', clickMarker(setCoffee_Info,coffee_marker, map, coffee_infowindow));
}
function setCoffeeMarkers(map) {        
    for (var i = 0; i < coffee_markers.length; i++) {  
    	coffee_markers[i].setMap(map);
    }        
}

// 마커를 클릭했을 때 동작하는 함수 입니다.
function clickMarker(Info,marker, map, infowindow) {
    return function() {
    	//#left_box의 넓이를 70%로 줄입니다.
    	document.getElementById("left_box").style.width="70%";
    	//#right_box의 display를 보이기로 바꿉니다.
    	document.getElementById("right_box").style.display = "";
    	//#right_box에 표시할 내용
    	document.getElementById("member_nickname").value=Info[0];
    	document.getElementById("member_phone").value=Info[1];
    	document.getElementById("road_address").value=Info[2];
    	document.getElementById("detail_address").value=Info[3];
    	document.getElementById("job_name").value=Info[4];
    	document.getElementById("job_num").value=Info[5];
    	document.getElementById("job_option").value=Info[6];
    	document.getElementById("job_pay").value=Info[7]+'원';
    	document.getElementById("job_date").value=Info[8];
    	document.getElementById("job_time_start").value=Info[9]+' 부터';
    	document.getElementById("job_time_end").value=Info[10]+' 까지';
    	document.getElementById("job_comment").value=Info[11];
    	document.getElementById("no").value=Info[12];
    	//#applyFrm(no,apply_id)를 보내고  getapplyNumProc2을 통해 지원자 수를 가지고 화면에 출력합니다.
    	$.ajax({
  	        url:'getapplyNumProc',
  	        datatype:'text',
  	        type:'post',
  	        data:$('#applyFrm').serialize(),
  	        success:function(data){
  	        	$("#apply_num").val(data);
  	        }
  	    })
  	    //#applyFrm(no,apply_id)를 보내고 chkapplyProc()에서 중복확인을 한 후 결과값을 가지고 옵니다.
  	    $.ajax({
	        url:'chkapplyProc',
	        datatype:'text',
	        type:'post',
	        data:$('#applyFrm').serialize(),
	        success:function(data){
	        	$("#status").val(data);
	        }
	    })  	
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

var clusterer = new daum.maps.MarkerClusterer({
    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
    minLevel: 6, // 클러스터 할 최소 지도 레벨
    disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
});
//첫화면 시 "전체"카테고리가 동작
changeMarker("every");

function changeMarker(type){
    //각 메뉴의 객체를 만듭니다.
    var coffeeMenu = document.getElementById('coffeeMenu');
    var storeMenu = document.getElementById('storeMenu');
    var deliveryMenu = document.getElementById('deliveryMenu');
    var restaurantMenu=document.getElementById('restaurantMenu');
    var etcMenu=document.getElementById('etcMenu');
    var everyMenu=document.getElementById('everyMenu');   
    
    // 커피숍 카테고리가 클릭됐을 때
    if (type === 'coffee') {  
    	//커피숍 카테고리 선택 시 이미지 변화 설정
        coffeeMenu.className = 'menu_selected';    
        storeMenu.className = '';
        deliveryMenu.className = '';
        restaurantMenu.className = '';
        etcMenu.className = '';
        everyMenu.className='';
        //커피숍 카테고리 선택 시 맵에 표시 여부
        setCoffeeMarkers(map);
        setStoreMarkers(null);
        setRestaurantMarkers(null);
        setEtcMarkers(null);
        setDeliveryMarkers(null);
     // 편의점 카테고리가 클릭됐을 때   
    } else if (type === 'store') {
    	coffeeMenu.className = '';    
        storeMenu.className = 'menu_selected';
        deliveryMenu.className = '';
        restaurantMenu.className = '';
        etcMenu.className = '';
        everyMenu.className='';

        setCoffeeMarkers(null);
        setStoreMarkers(map);
        setRestaurantMarkers(null);
        setEtcMarkers(null);
        setDeliveryMarkers(null);
     // 식당 카테고리가 클릭됐을 때  
    } else if (type === 'restaurant') {
    	coffeeMenu.className = '';    
        storeMenu.className = '';
        deliveryMenu.className = '';
        restaurantMenu.className = 'menu_selected';
        etcMenu.className = '';
        everyMenu.className='';

        setCoffeeMarkers(null);
        setStoreMarkers(null);
        setRestaurantMarkers(map);
        setEtcMarkers(null);
        setDeliveryMarkers(null);
    // 기타 카테고리가 클릭됐을 때 
    } else if (type === 'etc') {
		coffeeMenu.className = '';    
	    storeMenu.className = '';
	    deliveryMenu.className = '';
	    restaurantMenu.className = '';
	    etcMenu.className = 'menu_selected';
	    everyMenu.className='';
	  
	    setCoffeeMarkers(null);
	    setStoreMarkers(null);
	    setRestaurantMarkers(null);
	    setEtcMarkers(map);
	    setDeliveryMarkers(null);
	 // 배달 카테고리가 클릭됐을 때
	} else if (type === 'delivery') {  	 
		coffeeMenu.className = '';    
	    storeMenu.className = '';
	    deliveryMenu.className = 'menu_selected';
	    restaurantMenu.className = '';
	    etcMenu.className = '';
	    everyMenu.className='';
	   
	    setCoffeeMarkers(null);
	    setStoreMarkers(null);
	    setRestaurantMarkers(null);
	    setEtcMarkers(null);
	    setDeliveryMarkers(map);
	 // 전체 카테고리가 클릭됐을 때
	} else if (type === 'every') {     
		coffeeMenu.className = '';    
	    storeMenu.className = '';
	    deliveryMenu.className = '';
	    restaurantMenu.className = '';
	    etcMenu.className = '';
	    everyMenu.className='menu_selected';	 
	    setEveryMarkers(map);   
		}        
}
function closeOverlay() {
	overlay.setMap(null);     
	}
	daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

	    // 현재 지도 레벨에서 1레벨 확대한 레벨
	    var level = map.getLevel()-1;

	    // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
	    map.setLevel(level, {anchor: cluster.getCenter()});
	});
//#addr의 값을 가지고 와 주소 검색을 합니다.
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
//#right_box에서 마우스가 떠났을때 기능 구현
$('#right_box').mouseleave(function() {
	document.getElementById("left_box").style.width="100%";
	document.getElementById("right_box").style.display="none";
	});

//지원하기 버튼 click 기능입니다.
$('#apply').click(function(){
	var addUser=document.getElementById("member_nickname").value;
	var User=document.getElementById("member").value;
	var status=document.getElementById("status").value;
	//#dialog_confirm 다이어로그에 표시 할  객체입니다. 
	$("#job_name_confirm").text(document.getElementById("job_name").value);
	$("#job_time_end_confirm").text(document.getElementById("job_time_end").value);
	$("#job_time_start_confirm").text(document.getElementById("job_time_start").value);
	$("#job_pay_confirm").text(document.getElementById("job_pay").value);
	//세션id가 null이면 등록 을 막습니다.
	if(User==""){
		alert("비회원은 이용할수 없습니다. 로그인해주세요.");
		return false;
	//등록자id와 세션 id가 같으면 등록을 막습니다.	
	}else if(addUser==User){
		alert("내가 등록한 일감에는 지원할수 없습니다.");
		return false;
	//status가 "impossible"이면 지원을 막습니다.
	}else if(status=="impossible"){
		alert("이미 지원 하였습니다.\n중복지원할수 없습니다.");
		return false;		
	}else{
		 //지원 전 확인창 띄움니다.
		 $("#dialog_confirm").dialog({
  	      resizable: false,
	      height: "auto",
	      width: 400,
	      modal: true,
	      buttons: {
	        "예": function() {
	          $( this ).dialog( "close" );
	          //#dialog_confirm의 #contents를 #applyFrm으로 보냅니다.
	          var apply_contents=document.getElementById("contents").value;   
	          document.getElementById("apply_contents").value=apply_contents;	          
	          //#applyFrm의 내용을  addapplyProc()에서 apply(DTO)에 insert하는 기능입니다.
	          $.ajax({
			        url:'addapplyProc',
			        datatype:'String',
			        type:'post',
			        data:$('#applyFrm').serialize(),
			        success:function(data){
			        	 //#dialog_confirm의 value를 ""로 초기화 합니다.
			        	 document.getElementById("contents").value="";  
			        	 //성공 하면 계속 일 등록 or일 등록 정보로 이동 선택 창	 띄움니다.
			        	 $("#dialog_confirm2").dialog({
			        	      resizable: false,
			        	      height: "auto",
			        	      width: 400,
			        	      modal: true,
			        	      buttons: {
			        	        예: function() {
			        	         location.href="jobapplyForm";
			        	        },
			        	        아니요: function() {
			        	          $( this ).dialog( "close" );
			        	        }
			        	      }
			        	    });
			        }
			    })
	        },
	        아니요: function() {
	          $( this ).dialog( "close" );
	          return false;
	        }
	      }
	    });		
 } 
})
