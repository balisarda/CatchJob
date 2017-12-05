	var mapContainer = document.getElementById('map'),  
	    mapOption = {
	        center: new daum.maps.LatLng(37.57023412331899, 127.00245068753499), 
	        level: 4 
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
	
	var Addr=document.getElementById('road_address').value;
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
	    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
	// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter());
	
	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
	    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	        if (status === daum.maps.services.Status.OK) {               
	        	
	            document.getElementById('road_address').value=result[0].road_address.address_name;
	            document.getElementById('address').value=result[0].address.address_name;
	            var latlng = mouseEvent.latLng;
	            document.getElementById('latitude').value=latlng.getLat();
	            document.getElementById('longitude').value=latlng.getLng();
	               // 마커를 클릭한 위치에 표시합니다 
	            marker.setPosition(mouseEvent.latLng);
	            marker.setMap(map);
	      
	        }   
	    });
	});
	
	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'idle', function() {
	    searchAddrFromCoords(map.getCenter());
	});
	function searchAddrFromCoords(coords, callback) {
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}
	
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
	
	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	
		
	function searchAddr(){	
		var Addr=document.getElementById('road_address').value;
		var geocoder = new daum.maps.services.Geocoder();		
		geocoder.addressSearch(Addr, function(result, status) {

		     if (status === daum.maps.services.Status.OK) {
		    
		        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
		        document.getElementById('road_address').value=result[0].road_address.address_name;
	            document.getElementById('address').value=result[0].address.address_name;
	            document.getElementById('latitude').value=result[0].y;
	            document.getElementById('longitude').value=result[0].x;
		        
		        
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        marker.setPosition(coords);
	            marker.setMap(map);  
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		     }else{
		     	alert("정확한 주소를 입력해 주세요")
		     	}
		});
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
$( function() {
		    $( "#radio-1,#radio-2" ).checkboxradio();
		    
		    $( "#spinner" ).spinner({
		  	  min: 1});
		    
		    $( "#datepicker" ).datepicker({
		  	  minDate: -0, maxDate: "+1M +10D",
		  	  dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		  	  dayNamesShort: [ "일", "월", "화", "수", "목", "금", "토" ],
		  	  monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		  	  dateFormat: "yy년 mm월 dd일 [D]",		  	  	
		  	});
		   
		    $( "#selectjop" ).selectmenu({
		  	  width: 150
		  	});
		    
		    $( function() {
		        $( "#age" ).tooltip();
		    });	
		    
		    $( "#pay" ).tooltip();
		    $('#timepicker1,#timepicker2').timepicker({
				'step': 60, 
				'disableTextInput': true,
				lang:{am: '오전', pm: '오후'},
			});
});	
	function div_OnOff(v,id){	 
				if(v == "1"){
					document.getElementById(id).style.display = ""; 
				}else{
					document.getElementById(id).style.display = "none";
				}
	}
	function callAddr(){		
				document.getElementById('con').style.display = "none";
			
	}
	function chkTxtFld(txtFld, errmsg){
		var name = document.getElementsByName(txtFld);
		for (var i = 0; i < name.length; i++) {
			if(name[i].value==''){
				alert(errmsg);
				name[i].focus();
			
				return false;
			}
		}
		return true;
	}
	function sndFrm(){
		var strArr = ['road_address', 'job_name', 'job_pay', 'job_num', 'job_option', 'job_date', 'job_time_start', 'job_time_end'];
		for (var i = 0; i < strArr.length; i++) {
			if(!chkTxtFld(strArr[i], "필수 항목이 비어있습니다."))
				return false;
		}	
		var con = confirm("주소 ,날짜 및 시급은 수정 불가합니다\n정말로 등록 하시겠습니까?");
		if(con == true){
			return true;
		}
		else if(con == false){
			return false;
		}				
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
