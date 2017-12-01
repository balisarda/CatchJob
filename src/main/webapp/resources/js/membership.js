
var idFlag = false;
var pwFlag = false;


function checkId(cmd){
	toggleLabel();
	
	var nickname = document.getElementById("nickname").value;
	var oMsg = document.getElementById("idMsg");
	if(nickname==""){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "필수 정보입니다.";
		
		return false;
	}
	var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
	if(!isID.test(nickname)){
		oMsg.style.display = "block";
		oMsg.className = "error";
		oMsg.innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
		return false;
	}
	idFlag = false;
	try{
		var xmlhttp = getXmlHttp();
		xmlhttp.open("GET", "/member/chkNickname"+"?"+nickname);
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState == 4){
				var result = xmlhttp.responseText;
				if(result =="0"){
					if(cmd=="first"){
						oMsg.style.display = "block";
						oMsg.className = "error gm";
						oMsg.innerHTML = "사용 가능한 아이디입니다.";
					}else{
						oMsg.style.display = "none";
					}
					idFlag=true;
					return true;
				}else {
					oMsg.style.display = "block";
					oMsg.className = "error";
					oMsg.innerHTML = "이미 사용중이거나 탈퇴한 아이디입니다.";
					
					return false;
				}
			}
		};
		xmlhttp.send(null);
	}catch(e){
		if (window.bridgeGotTime){
			throw e;
		}
	}
	return true;	
}
function checkSpace(str){
	if(str.search(/\s/) != -1){
		return true;
	}else {
		return false;
	}
}
function isValidPasswd(str){
	var cnt = 0;
	if(str==""){
		return false;
	}
	var retVal = checkSpace(str);
	if(retVal){
		return false;
	}
	if(str.length<6){
		return false;
	}
	for(var i=0;i<str.length;++i){
		if(str.charAt(0)==str.substring(i,i+1))
			++cnt;
	}
	if(cnt ==str.length){
		return false;
	}
	var isPW = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{6,16}$/;
	if(!isPW.test(str)){
		return false;
	}
	return true;
}

var isShift = false;




















