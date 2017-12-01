<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:url var="home" value="/"/>
<style>
	table { border-collapse:collapse; }  
	table th { text-align: center; }
	table th, table td { border:1px solid black; }
</style>
<script>
$(document).ready(function(){
		$.ajax({
			type:'post', url: "member/loadInfo", dataType: "json", cache: false, 
			success: function(data){
				var jsonStr = data;
				$("#record_tbody").html("");
				$.each(data.recordlist, function(index, recordlist){
					var items = [];
					console.log(recordlist);
					console.log(recordlist.emp);
										
					items.push("<tr><td>"+recordlist.emp+"</td>");
					items.push("<td>"+recordlist.year1+"년 "+recordlist.month1+"월 ~ "+recordlist.year2+"년 "+recordlist.month2+"월"+"</td>");
					items.push("<td>"+recordlist.duty+"</td>");
					items.push("<td>"+recordlist.comment+"</td>");
					$("</tr>", {
						html: items
					}).appendTo("#record_tbody");
				});
			}
		});
	});
</script>
<div style="border: 2px solid black; width: 800px;" align="center"><!-- 큰 틀 -->
	<div><!-- 상세 정보 입력 -->
		<div style="float: left;"><label>해당 정보는 필수입력 사항이 아닙니다.</label></div>
		<div><input type="button" onclick="${home}member/skip" value="skip" width="50px;" height="50px;"></div>
		<div style="margin: 5; margin-top: 20px;"><!-- 아르바이트 경험 -->
			<div>
				<h2><label style="margin-left: -500px;">아르바이트 경력</label></h2>
			</div>
			<form action="${home }member/subMemberProc1" method="post">
			<input type="hidden" name="nickname" value="${sessionMember.nickname }">
			<div>
				<table>
					<thead>
						<tr>
							<th>업종</th>
							<th>기간</th>
							<th>직책</th>
							<th>세부내용</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<select name="emp">
									<option value="">업종 선택</option>
									<option value="매장관리">매장관리</option>
									<option value="사무·회계">사무·회계</option>
									<option value="서빙·주방">서빙·주방</option>
									<option value="서비스·미디어">서비스·미디어</option>
									<option value="생산·기능·운전·배달">생산·기능·운전·배달</option>
									<option value="IT·디자인">IT·디자인</option>
									<option value="고객상담·영업·리서치">고객상담·영업·리서치</option>
									<option value="강사·교육">강사·교육</option>
								</select>
							</td>
							<td>
								<input type="text" placeholder="년" id="" name="year1">
								<input type="text" placeholder="" name="month1">~
								<input type="text" id="" name="year2">
								<input type="text" placeholder="" name="month2">
							</td>
							<td><input type="text" placeholder="예 ) 아르바이트, 점장 등" id="" name="duty"></td>
							<td><input type="text" placeholder="아르바이트에 대한 설명 작성" id="" name="comment"></td>
							<td><input type="submit" value="등록"></td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>			
			<div style="margin-top: 20px;">
				<h2><label style="margin-left: -440px;">등록 아르바이트 목록</label></h2>
			</div>
			<div>
				<table>
					<thead style="vertical-align: middle;">
						<tr>
							<th>업종</th>
							<th>기간</th>
							<th>직책</th>
							<th>세부내용</th>
							<th></th>
						</tr>
					</thead>
					<tbody id="record_tbody">
<!-- 						<tr>	
							<td>서비스</td>
							<td>5개월</td>
							<td>사장</td>
							<td>총괄</td>
							<td>
								<button id="checkJson">수정</button>
								<button>삭제</button>
							</td>
						</tr> -->
					</tbody>
				</table>
			</div>
		</div>
		<hr style="margin-top: 20px;">
		<hr>
		<div style="margin: 5;"><!-- 자격증 등록 -->
			<div>
				<h2><label style="margin-left: -440px;">자격증 및 교육 이수</label></h2>
			</div>
			<div>
			<form action="${home }member/subMemberProc2" method="post">
				<input type="hidden" name="nickname" value="${sessionMember.nickname }">
				<table>
					<thead>
						<tr>
							<th>자격증·교육명</th>
							<th>취득일</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" name="name" placeholder="예 ) 보건증, 건설기초안전교육 등"></td>
							<td><input type="text" name="date" placeholder="예 ) 2017년 7월 취득일 경우 201707"></td>
							<td><input type="submit" value="등록"></td>
						</tr>
					</tbody>
				</table>
			</form>
			</div>
			<div style="margin-top: 20px;">
				<h2><label style="margin-left: -440px;">자격증·교육 이수 목록</label></h2>
			</div>
			<div>
				<table>
					<thead style="vertical-align: middle;">
						<tr>
							<th>자격증·교육명</th>
							<th>취득일</th>
							<th></th>
						</tr>
					</thead>
					<tbody id="license_tbody">
						<tr>
							<td>보건증</td>
							<td>2017.11</td>
							<td>
								<button>수정</button>
								<button>삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<hr style="margin-top: 20px;">
		<hr>
			<div style="margin: 5;"><!-- 업체 정보 등록 -->
				<div>
					<h2><label style="margin-left: -440px;">업체 정보 등록</label></h2>
				</div>
				<div>
				<form action="${home }member/subMemberProc3" method="post">
					<input type="hidden" name="nickname" value="${sessionMember.nickname }">
					<table>
						<thead>
							<tr>
								<th>업체·상호명</th>
								<th>우편번호</th>
								<th>주소</th>
								<th>상세 주소</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" placeholder="예 ) GS25, 카페베네 등" id="" name="emp_name"></td>
								<td><input type="text" placeholder="우편번호" readonly="readonly" onclick="searchPostCode();" id="postcode" name="postcode"></td>
								<td><input type="text" placeholder="주소" readonly="readonly" onclick="searchPostCode();" id="addr1" name="addr1"></td>
								<td><input type="text" placeholder="상세 주소" id="addr2" name="addr2"></td>
								<td><input type="submit" value="등록"></td>
							</tr>
						</tbody>
					</table>
				</form>
				</div>
				<div style="margin-top: 20px;">
					<h2><label style="margin-left: -440px;">등록 업체 목록</label></h2>
				</div>
				<div>
					<table>
						<thead style="vertical-align: middle;">
							<tr>
								<th>업체·상호명</th>
								<th>우편번호</th>
								<th>주소</th>
								<th>상세주소</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="empinfo_tbody">
							<tr>
								<td>GS25</td>
								<td>11111</td>
								<td>주소</td>
								<td>상세주소</td>
								<td>
									<button>수정</button>
									<button>삭제</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
		</div>
	</div>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function searchPostCode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>