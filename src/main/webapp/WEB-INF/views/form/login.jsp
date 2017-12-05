<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<c:url var="img" value="/resources/img/" />
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<c:url var="home" value="/"/>
<div align="center">
	<section class="container">
	    <article class="half">
	        <h1>Catch Your Job!</h1>
	        <div class="content">
	            <div class="signin-cont cont">
                <form action="${home }member/loginProc" method="post">
                <input type="text" name='nickname' id="id" class="inpt" required="required" placeholder="ID" value="${member.nickname }">
                <input type="password" name='pw' id="password" class="inpt" required="required" placeholder="PW">
			    <div>
					<input type="submit" value="로그인" class="submit">
				</div>
				<div style="float: center; margin-left: 10px; width: 90%; padding-top: 0px; z-index:1;"><!-- 카카오 로그인 버튼 -->
					<a id="custom-login-btn" href="javascript:loginWithKakao()">
					<img src="${img }kakao_account_login_btn_large_wide.png" width="270px; "/></a>
					<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
					<script type='text/javascript'>
						//<![CDATA[
						// 사용할 앱의 JavaScript 키를 설정해 주세요.
						Kakao.init('e925fd239ed6fbfe4c7fd0e9e37d5d45');
						function loginWithKakao() {
							// 로그인 창을 띄웁니다.
							Kakao.Auth.login({
								success: function(authObj) {
									Kakao.API.request({
										url: '/v1/user/me',
										success: function(res){
											//document.getElementById("sns_nickname").value = res.properties.nickname;
											//document.getElementById("sns_email").value = res.properties.kaccount_email;
											//document.getElementById("sns_profile").value = res.properties.profile;
											//document.getElementById("sns_token").value = res.properties.access_token;
											//document.getElementById("kakaoLogin").submit();
											alert(res.properties.nickname+'님 환영합니다.');
											alert(JSON.stringify(res));
											location.href="./main?name="+res.properties.nickname;
										},
										fail: function(error){
											alert(JSON.stringify(error));
										}
									});
									alert(JSON.stringify(authObj));
									document.getElementById("sns_token").value = authObj.properties.access_token;
								},
								fail: function(err) {
									alert(JSON.stringify(err));
								}
							});
						};
						//]]>
					</script>
					<div class="submit-wrap">
						<table border="0">
							<tr>
								<td><a href="${home }findInfoForm" class="more">ID/PW 찾기</a></td>
								<td><a href="${home }memberForm" class="more">회원가입</a></td>
							</tr>
						</table>
					</div>
				</div>     
		        </form>
		        </div>
	        </div>
	    </article>
	</section>
</div>
<script	src="${js }jquery-3.2.1.js"></script>
<script type="text/javascript">
$('.tabs .tab').click(function(){
    if ($(this).hasClass('signin')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signin-cont').show();
    } 
    if ($(this).hasClass('signup')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signup-cont').show();
    }
});
$('.container .bg').mousemove(function(e){
    var amountMovedX = (e.pageX * -1 / 30);
    var amountMovedY = (e.pageY * -1 / 9);
    $(this).css('background-position', amountMovedX + 'px ' + amountMovedY + 'px');
});
</script>