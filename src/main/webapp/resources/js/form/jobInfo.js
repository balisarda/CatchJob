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
	var listsize=document.getElementById('listsize').value;
		
	//id값으로 가지고온 value값을 list에 담고, 변경가능한 객체를  ChkDisabled 배열에 담음
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
	var no= document.getElementById('no'+i).value;
	no_array.push(no);
}

//select 되었을때 실행될 함수 정의
$( function() {
	$( "#selectjob" ).selectmenu({
	  	  width: 420,
	  	  //select가 변경 되었을 때 함수
	  	  change: function(event,data){
	  		//id 값에 각각 [선택된 번호]=status.idex의 값을 전달해줌
	  		document.getElementById('job_option').value=job_option_array[data.item.value],	  		
	  		document.getElementById('job_num').value=job_num_array[data.item.value],
	  		document.getElementById('job_date').value=job_date_array[data.item.value],
	  		document.getElementById('job_time_start').value=job_time_start_array[data.item.value],
	  		document.getElementById('job_time_end').value=job_time_end_array[data.item.value],
	  		document.getElementById('job_pay').value=job_pay_array[data.item.value],
	  		document.getElementById('job_comment').value=job_comment_array[data.item.value],
	  		document.getElementById('job_name').value=job_name_array[data.item.value],
	  		document.getElementById('detail_address').value=detail_address_array[data.item.value],
	  		document.getElementById('road_address').value=road_address_array[data.item.value],
	  		document.getElementById('address').value=address_array[data.item.value];
	  		document.getElementById('member_phone').value=member_phone_array[data.item.value],
	  		document.getElementById('no').value=no_array[data.item.value];  		
	  		
	  		//맵을 담을 container 생성
	  		var mapContainer = document.getElementById('map'),
	  		//맵 option에 [선택된 번호]=status.idex 의 위도,경도를 담고 center를 지정함 
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
	//radio 버튼 생성
    $( "#radio-1,#radio-2" ).checkboxradio();
    //spinner 생성
    $( "#job_num" ).spinner({
  	  min: 1});
    //datepicker 생성
    $( "#job_date" ).datepicker({
      //날짜를 나타내기위한 최소값, 최대값
  	  minDate: -0, maxDate: "+1M +10D",
  	  dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
  	  dayNamesShort: [ "일", "월", "화", "수", "목", "금", "토" ],
  	  monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
  	  //나타낼 date format 정의
  	  dateFormat: "yy년 mm월 dd일 [D]",		  	  	
  	});
   //select 생성
    $( "#job_option" ).selectmenu({
  	  width: 150
  	});
    //tooltip 생성
    $( function() {
        $( "#age" ).tooltip();
    });	
    
    $( "#job_pay" ).tooltip();  			    
});	
//빈값이 있는지 체크 하기 위한 함수
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
//onsubmit정의, submit되기 전에 chkTxtFld()체크
function sndFrm(){
var strArr = ['job_name','job_num', 'job_option'];
for (var i = 0; i < strArr.length; i++) {
	if(!chkTxtFld(strArr[i], "필수 항목이 비어있습니다."))
		return false;
}
return true;

}
//form을 전달하기 위한 action 선택 함수
function bottonProc(index){
	var frm=document.getElementById("frm");	
	if(index=='delete_job'){	
		frm.action="delete";
		var content="정말로 삭제 하시겠습니까?";
	}
	if(index=='update_job'){			
		frm.action="update";
		var content="정말로 수정 하시겠습니까?";
	}
	var con = confirm(content);
	if(con == true){
		frm.submit();
	}
	else if(con == false){
		return false;
	}					
}
