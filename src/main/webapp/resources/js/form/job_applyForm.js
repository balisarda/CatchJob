	//각 객체들을 담기 위한 array생성
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
	var no_array=[];
	//리스트 길이를 받음
	var listsize=$('#listsize').val();
		
	//id값으로 가지고온 value값을 list에 담음
for(var i=1;i<=listsize;i++){
	var latitude= Number($(('#latitude')+i).val());
	latitude_array.push(latitude);
	var longitude= Number($(('#longitude')+i).val());
	longitude_array.push(longitude);
	var job_option= $(('#job_option')+i).val();
	job_option_array.push(job_option);
	var address= $(('#address')+i).val();
	address_array.push(address);
	var detail_address= $(('#detail_address')+i).val();
	detail_address_array.push(detail_address);
	var road_address= $(('#road_address')+i).val();
	road_address_array.push(road_address);
	var member_nickname= $(('#member_nickname')+i).val();
	member_nickname_array.push(member_nickname);
	var member_phone= $(('#member_phone')+i).val();
	member_phone_array.push(member_phone);
	var job_comment= $(('#job_comment')+i).val();
	job_comment_array.push(job_comment);
	var job_pay=$(('#job_pay')+i).val();
	job_pay_array.push(job_pay);
	var job_name= $(('#job_name')+i).val();
	job_name_array.push(job_name);
	var job_num= $(('#job_num')+i).val();
	job_num_array.push(job_num);
	var job_date=$(('#job_date')+i).val();
	job_date_array.push(job_date);
	var job_time_start=$(('#job_time_start')+i).val();
	job_time_start_array.push(job_time_start);
	var job_time_end=$(('#job_time_end')+i).val();
	job_time_end_array.push(job_time_end);
	var no=$(('#no')+i).val();
	no_array.push(no);
}

//select 되었을때 실행될 함수 정의
$( function() {
	$( "#selectjob" ).selectmenu({
				width: 300, 	
	  	  //select가 변경 되었을 때 함수
	  	  change: function(event,data){
	  		$("#deleteapply").attr("disabled",false);
	  		//id 값에 각각 ([선택된 번호]=status.idex)의 값을 전달해줌
	  		$("job_option option").each(function(){
	  		    if($(this).val()==job_option_array[data.item.value]){  		    
	  		    }
	  		  }); 
	  		$('#job_option').text(job_option_array[data.item.value]),	  		
	  		$('#job_num').text(job_num_array[data.item.value]+"명 모집"),
	  		$('#job_date').text(job_date_array[data.item.value]),
	  		$('#job_time_start').text(job_time_start_array[data.item.value]+" 부터"),
	  		$('#job_time_end').text(job_time_end_array[data.item.value]+" 까지"),
	  		$('#job_pay').text(job_pay_array[data.item.value]+" 원"),
	  		$('#job_comment').val(job_comment_array[data.item.value]),
	  		$('#job_name').text(job_name_array[data.item.value]),
	  		$('#detail_address').text(detail_address_array[data.item.value]),
	  		$('#road_address').text(road_address_array[data.item.value]),
	  		$('#address').text(address_array[data.item.value]),
	  		$('#member_phone').text(member_phone_array[data.item.value]),
	  		$('#no').val(no_array[data.item.value]); 
	  		$.ajax({
	  	        url:'getapplyNumProc',
	  	        datatype:'text',
	  	        type:'post',
	  	        data:$('#frm').serialize(),
	  	        success:function(data){
	  	        	$("#apply_num").text(data+"명 지원 중 / ");   
	  	        }
	  	    })
	  		
	  		//맵을 담을 container 생성
	  		var mapContainer = document.getElementById('map'),
	  		//맵 option에 ([선택된 번호]=status.idex)의 위도,경도를 담고 center를 지정함 
	  	    mapOption = { 
	  	        center: new daum.maps.LatLng(latitude_array[data.item.value], longitude_array[data.item.value]), // 지도의 중심좌표
	  	        level: 3 
	  	    };
	  		//맵을 생성
		  	var map = new daum.maps.Map(mapContainer, mapOption);
		  	//맵에  [선택된 번호]의 위도,경도에 마커를 생성하기 위한 position 정의	
		  	var markerPosition  = new daum.maps.LatLng(latitude_array[data.item.value], longitude_array[data.item.value]); 	  
		  	var marker = new daum.maps.Marker({
		  	    position: markerPosition
		  	});
		  	//마커를 맵에 보여줌
		  	marker.setMap(map);
	  	  }	  	  
	  	});
});

//jquery-ui에 대한 기능 정의
$( function() {	
    $( "#selectjob").selectmenu({
  	  width: 350
  	});  			    
});	
//form을 전달하기 위한 action 선택 함수
function bottonProc(index){
	var frm=document.getElementById("frm");	
	if(index=='delete_apply'){	
		frm.action="applydeleteProc";
		var content="정말로 지원 취소 하시겠습니까?";
	}
	var con = confirm(content);
	if(con == true){
		frm.submit();		
	}
	else if(con == false){
		return false;
	}
}
