/*---------------------------------------------------------------------------------------------
 @ 파일 이름: join_kr.js
 @ 파일 설명: PC-ko_KR 을 위한 js
 @ 작성자: 김강열
 ---------------------------------------------------------------------------------------------*/

var isCapslock = false;

function toggleLabel(labelId, inputId, mode) {
    var oLabel = document.getElementById(labelId);
    var oInput = document.getElementById(inputId);
    if (mode == "in") {
        oLabel.className = "lbl focus";
    } else {
        if (oInput.value != "") {
            oLabel.className = "lbl focus";
        } else {
            oLabel.className = "lbl";
        }
    }
}

function getXmlHttp() {
    var xmlhttp;
    try {
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            xmlhttp = false;
        }
    }
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
        xmlhttp = new XMLHttpRequest();
    }
    return xmlhttp;
}

var idFlag = false;
var pwFlag = false;

function checkId(event) {
    toggleLabel('idLb', 'id', 'out');

    var id = document.getElementById("id").value;
    var oMsg = document.getElementById("idMsg");
    if (id == "") {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "필수 정보입니다.";

        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_ID_REQUIRED, document.getElementById("token_sjoin").value, true,'');
        lua_do2('join_kr'+document.getElementById("platform").value,'',ERROR_ID_REQUIRED, document.getElementById("token_sjoin").value, true, document.getElementById("id").value);
        return false;
    }

    var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
    if (!isID.test(id)) {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_ID, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    idFlag = false;
    try {
        var xmlhttp = getXmlHttp();
        xmlhttp.open("GET", "/user2/joinAjax.nhn?m=checkId&id=" + id);
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4) {
                var result = xmlhttp.responseText.substr(4, 999);
                if (result == "Y") {
                    if (event == "first") {
                        oMsg.style.display = "block";
                        oMsg.className = "error gm";
                        oMsg.innerHTML = "멋진 아이디네요!";
                    } else {
                        oMsg.style.display = "none";
                    }
                    idFlag = true;
                    return true;
                } else {
                    oMsg.style.display = "block";
                    oMsg.className = "error";
                    oMsg.innerHTML = "이미 사용중이거나 탈퇴한 아이디입니다.";

                    lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_ID, document.getElementById("token_sjoin").value, true,'');
                    return false;
                }
            }
        };
        xmlhttp.send(null);
    } catch (e) {
        if (window.bridgeGotTime) {
            throw e;
        }
    }

    return true;

}

// space 가 있으면 true, 없으면 false
function checkSpace(str) {
    if (str.search(/\s/) != -1) {
        return true;
    } else {
        return false;
    }
}

function isValidPasswd(str) {
    var cnt = 0;
    if (str == "") {
        return false;
    }

	/* check whether input value is included space or not */
    var retVal = checkSpace(str);
    if (retVal) {
        return false;
    }
    if (str.length < 6) {
        return false;
    }
    for (var i = 0; i < str.length; ++i) {
        if (str.charAt(0) == str.substring(i, i + 1))
            ++cnt;
    }
    if (cnt == str.length) {
        return false;
    }

    var isPW = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{6,16}$/;
    if (!isPW.test(str)) {
        return false;
    }

    return true;
}

var isShift = false;
function checkShiftUp(e) {
    if (e.which && e.which == 16) {
        isShift = false;
    }
}

function checkShiftDown(e) {
    if (e.which && e.which == 16) {
        isShift = true;
    }
}

function checkCapslock(e) {
    var myKeyCode = 0;
    var myShiftKey = false;
    if (window.event) { // IE
        myKeyCode = e.keyCode;
        myShiftKey = e.shiftKey;
    } else if (e.which) { // netscape ff opera
        myKeyCode = e.which;
        myShiftKey = isShift;
    }

    var oMsg = document.getElementById("pswd1Msg");

    if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "Caps Lock이 켜져 있습니다.";
    } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "Caps Lock이 켜져 있습니다.";
    } else {
        oMsg.style.display = "none";
    }
}

function checkCapslock2(e) {
    var myKeyCode = 0;
    var myShiftKey = false;
    if (window.event) { // IE
        myKeyCode = e.keyCode;
        myShiftKey = e.shiftKey;
    } else if (e.which) { // netscape ff opera
        myKeyCode = e.which;
        myShiftKey = isShift;
    }

    var oMsg = document.getElementById("pswd2Msg");

    if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "Caps Lock이 켜져 있습니다.";
    } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "Caps Lock이 켜져 있습니다.";
    } else {
        oMsg.style.display = "none";
    }
}


function isValidPasswd(str) {
    var cnt = 0;
    if (str == "") {
        return false;
    }

	/* check whether input value is included space or not */
    var retVal = checkSpace(str);
    if (retVal) {
        return false;
    }
    if (str.length < 6) {
        return false;
    }
    for (var i = 0; i < str.length; ++i) {
        if (str.charAt(0) == str.substring(i, i + 1))
            ++cnt;
    }
    if (cnt == str.length) {
        return false;
    }

    var isPW = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{6,16}$/;
    if (!isPW.test(str)) {
        return false;
    }

    return true;
}

function checkPswd1(event) {
    checkPswd2("check");
    createRsaKey();

    var id = document.getElementById("id").value;
    var pw = document.getElementById("pswd1").value;
    var oMsg = document.getElementById("pswd1Msg");
    var oImg = document.getElementById("pswd1Img");

    if (pw == "") {
        oImg.className = "ps_box int_pass";
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "필수 정보입니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_PSWD1_REQUIRED, document.getElementById("token_sjoin").value, true,'');
        return false;
    }
    if (isValidPasswd(pw) != true) {
        oImg.className = "ps_box int_pass_step1";
        oMsg.style.display = "block";
        oMsg.className = "error e_info";
        oMsg.innerHTML = "6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_PSWD1, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    pwFlag = false;
    try {
        var xmlhttp = getXmlHttp();
        xmlhttp.open("GET", "/user2/joinAjax.nhn?m=checkPswd&id=" + escape(encodeURIComponent(id)) + "&pw=" + escape(encodeURIComponent(pw)));
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4) {
                var result = xmlhttp.responseText.substr(4, 999);
                if (result == 1) {
                    oImg.className = "ps_box int_pass_step1";
                    oMsg.style.display = "block";
                    oMsg.className = "error e_info";
                    oMsg.innerHTML = "6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
                    lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_PSWD1, document.getElementById("token_sjoin").value, true,'');
                    return false;
                } else if (result == 2) {
                    oImg.className = "ps_box int_pass_step2";
                    oMsg.style.display = "block";
                    oMsg.className = "error e_info";
                    oMsg.innerHTML = "6~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
                    lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_PSWD1, document.getElementById("token_sjoin").value, true,'');
                } else if (result == 3) {
                    oImg.className = "ps_box int_pass_step3";
                    oMsg.style.display = "none";
                } else if (result == 4) {
                    oImg.className = "ps_box int_pass_step4";
                    oMsg.style.display = "none";
                } else {
                    oImg.className = "ps_box int_pass";
                    oMsg.style.display = "none";
                }
                pwFlag = true;
                return true;
            }
        };
        xmlhttp.send(null);
    } catch (e) {
        if (window.bridgeGotTime) {
            throw e;
        }
    }

    return true;
}

function checkPswd2(event) {
    var pswd1 = document.getElementById("pswd1").value;
    var pswd2 = document.getElementById("pswd2").value;
    var oMsg = document.getElementById("pswd2Msg");
    var oImg = document.getElementById("pswd2Img");

    if (pswd2 == "") {
        oImg.className = "ps_box int_pass_check";
        oMsg.style.display = "block";
        oMsg.innerHTML = "필수 정보입니다.";
//		lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_PSWD2_REQUIRED, document.getElementById("token_sjoin").value, true,'');
        return false;
    }
    if (pswd1 != pswd2) {
        oImg.className = "ps_box int_pass_check";
        oMsg.style.display = "block";
        oMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
        document.getElementById("pswd2").value = "";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_PSWD2, document.getElementById("token_sjoin").value, true,'');
        return false;
    } else {
        oImg.className = "ps_box int_pass_check2";
        oMsg.style.display = "none";
        return true;
    }

    return true;
}

function checkName(event) {
    toggleLabel('nmLb', 'nm', 'out');

    var nm = document.getElementById("nm").value;
    var oMsg = document.getElementById("nmMsg");

    if (nm == "") {
        oMsg.style.display = "block";
        oMsg.innerHTML = "필수 정보입니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NAME_REQUIRED, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    var nonchar = /[^가-힣a-zA-Z0-9]/gi;
    if (nonchar.test(nm)) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NAME_FORMAT, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    if (true) {
        oMsg.style.display = "none";
        return true;
    }

    return true;
}

function checkSex(event) {
    var man = document.getElementById("man");
    var woman = document.getElementById("woman");
    var oMsg = document.getElementById("sexMsg");
    //var oDiv = document.getElementById("sexDiv");
    //oDiv.className = "join_row join_sex join_check";

    if (man.checked == false && woman.checked == false) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "필수 정보입니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NO_VALUE_SEX, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    if (man.checked) {
        document.getElementById("manLb").className = "on";
        document.getElementById("womanLb").className = "";
    }
    if (woman.checked) {
        document.getElementById("manLb").className = "";
        document.getElementById("womanLb").className = "on";
    }

    if (true) {
        oMsg.style.display = "none";
        return true;
    }

    return true;
}

function calcAge(birth) {
    var date = new Date();
    var year = date.getFullYear();
    var month = (date.getMonth() + 1);
    var day = date.getDate();
    if (month < 10)
        month = '0' + month;
    if (day < 10)
        day = '0' + day;
    var monthDay = month + '' + day;

    birth = birth.replace('-', '').replace('-', '');
    var birthdayy = birth.substr(0, 4);
    var birthdaymd = birth.substr(4, 4);

    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
    return age;
}

function isValidDate(param) {
    try {
        param = param.replace(/-/g, '');

        // 자리수가 맞지않을때
        if (isNaN(param) || param.length != 8) {
            return false;
        }

        var year = Number(param.substring(0, 4));
        var month = Number(param.substring(4, 6));
        var day = Number(param.substring(6, 8));

        if (month < 1 || month > 12) {
            return false;
        }

        var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
        var maxDay = maxDaysInMonth[month - 1];

        // 윤년 체크
        if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
            maxDay = 29;
        }

        if (day <= 0 || day > maxDay) {
            return false;
        }
        return true;

    } catch (err) {
        return false;
    }
    ;
}

function checkBirthday(event) {
    toggleLabel('yyLb', 'yy', 'out');
    toggleLabel('ddLb', 'dd', 'out');

    var birthday = "";
    var yy = document.getElementById("yy").value;
    var s = document.getElementById('mm');
    var mm = s.options[s.selectedIndex].value;
    var dd = document.getElementById("dd").value;
    var oMsg = document.getElementById("birthdayMsg");

    if (yy == "" && mm == "" && dd == "") {
        oMsg.style.display = "block";
        oMsg.innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
        return false;
    }

    if (mm.length == 1) {
        mm = "0" + mm;
    }
    if (dd.length == 1) {
        dd = "0" + dd;
    }

    if(yy == "") {
        oMsg.style.display = "block";
        oMsg.innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NO_VALUE_YEAR, document.getElementById("token_sjoin").value, true,'');
        return false;
    }
    if(yy.length != 4 || yy.indexOf('e') != -1 || yy.indexOf('E') != -1) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_YEAR, document.getElementById("token_sjoin").value, true,'');
        return false;
    }
    if(mm == "") {
        oMsg.style.display = "block";
        oMsg.innerHTML = "태어난 월을 선택하세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NO_VALUE_MONTH, document.getElementById("token_sjoin").value, true,'');
        return false;
    }
    if(dd == "") {
        oMsg.style.display = "block";
        oMsg.innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NO_VALUE_DAY, document.getElementById("token_sjoin").value, true,'');
        return false;
    }
    if(dd.length != 2 || dd.indexOf('e') != -1 || dd.indexOf('E') != -1) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_DAY, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    birthday = yy + mm + dd;

    if (!isValidDate(birthday)) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "생년월일을 다시 확인해주세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_DATE, document.getElementById("token_sjoin").value, true,'');
        return false;
    }
    document.getElementById("birthday").value = birthday;

    var age = calcAge(birthday);
    if (age < 0) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "미래에서 오셨군요. ^^";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_DATE, document.getElementById("token_sjoin").value, true,'');
        return false;
    } else if (age >= 100) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "정말이세요?";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_DATE, document.getElementById("token_sjoin").value, true,'');
        return false;
    } else if (age < 14) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "만 14세 미만의 어린이는 보호자 동의가 필요합니다.";

        if (document.getElementById("joinMode").value == "unreal") {
            viewJuniverMobileTab();
        }
        return true;
    } else {
        oMsg.style.display = "none";

        viewUnrealMobileTab();
        return true;
    }

    return true;
}

function checkEmail(event) {
    toggleLabel('emailLb', 'email', 'out');
    
    var id = document.getElementById("id").value;
    var email = document.getElementById("email").value;
    var oMsg = document.getElementById("emailMsg");

    if (email == "") {
        oMsg.style.display = "none";
        return true;
    }

    var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var isHan = /[ㄱ-ㅎ가-힣]/g;
    if (!isEmail.test(email) || isHan.test(email)) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "이메일 주소를 다시 확인해주세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_EMAIL, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    if (email == id + "@naver.com") {
        oMsg.style.display = "block";
        oMsg.innerHTML = "가입중인 아이디는 사용하실 수 없습니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_EMAIL, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    if (true) {
        oMsg.style.display = "none";
        return true;
    }
    return true;
}

function checkMobno(event) {
    toggleLabel('mobnoLb', 'mobno', 'out');

    var mobno = document.getElementById("mobno").value;
    var oMsg = document.getElementById("mobnoMsg");
    var old_mobno = document.getElementById("old_mobno").value;

    if (mobno == "") {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "필수 정보입니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NO_VALUE_PHONENO, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    if( old_mobno != "" && old_mobno != mobno) {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "인증을 다시 수행해 주세요.";

        document.getElementById("authno").value = "";
        document.getElementById("old_mobno").value = "";
        document.getElementById("old_authno").value = "";
        document.getElementById("authFlag").value = "N";

        toggleLabel('authnoLb','authno','out');
        checkAuthno('check');
        return false;
    }


    if (true) {
        oMsg.style.display = "none";
        return true;
    }

    return true;
}

function checkAuthno(event) {
    toggleLabel('authnoLb','authno','out');

    var authno = document.getElementById("authno").value;
    var oMsg = document.getElementById("authnoMsg");
    var old_authno = document.getElementById("old_authno").value;

    if (authno == "" || document.getElementById("authFlag").value != "Y") {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "인증이 필요합니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_NO_VALUE_AUTHNO, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    if( old_authno != "" && document.getElementById("authFlag").value == "Y" ) {
        oMsg.style.display = "block";
        oMsg.className = "error gm";
        oMsg.innerHTML = "인증된 상태입니다.";
        return true;
    }

    if (true) {
        oMsg.style.display = "none";
        return true;
    }

    return true;
}

var mvnoFlag = "OFF";

function mainSubmit(cnt) {
    submitClose();

    var res = true;
    var mode = document.getElementById("platform").value;
    var agentType = document.getElementById("agentType").value;

    cnt++;
    if (cnt > 10) {
        submitOpen();
        return false;
    }

    if (cnt == 1) {
        if (checkId('join') != true) {
            res = false;
        }
        if (checkPswd1('check') != true) {
            res = false;
        }
        if (checkPswd2('check') != true) {
            res = false;
        }
        if (checkName('check') != true) {
            res = false;
        }
        if(agentType != "iOS_App") {
            if (checkSex('check') != true) {
                res = false;
            }
            if (checkBirthday('check') != true) {
                res = false;
            }
        }

        if (checkEmail('check') != true) {
            res = false;
        }

        var joinMode = document.getElementById("joinMode").value;

        if (joinMode == "unreal") {
            viewUnrealMobileTab();
            if (checkMobno('check') != true) {
                res = false;
            }
            if (checkAuthno('check') != true) {
                res = false;
            }
        }
        if (joinMode == "juniverMobile") {
            viewJuniverMobileTab();
            if (checkPrtsAgree('check') != true) {
                res = false;
            }
            if (checkPrtsName('check') != true) {
                res = false;
            }
            if (checkPrtsSex('check') != true) {
                res = false;
            }
            if (checkPrtsBirthday('check') != true) {
                res = false;
            }
            if (checkPrtsTelecom() != true) {
                res = false;
            }
            if (checkPrtsMobno('check') != true) {
                res = false;
            }
            if (checkPrtsAuthno('check') != true) {
                res = false;
            }
        }
        if (joinMode == "juniverIpin") {
            viewJuniverIpinTab();

            if (checkIpinAgree('check') != true) {
                res = false;
            }
            if (mode != "M") {
                if (checkIpinAuth('check') != true) {
                    res = false;
                }
            } else {
                if (checkIpinAuthM('check') != true) {
                    res = false;
                }
            }

            if (checkIpinMobno('check') != true) {
                res = false;
            }
            if (checkIpinAuthno('check') != true) {
                res = false;
            }
        }
    }

    var oMsg = document.getElementById("joinMsg");
    if (res == false) {
        oMsg.style.display = "block";
        oMsg.innerHTML = "입력하신 정보를 다시 확인해주세요.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_JOIN_SUBMIT, document.getElementById("token_sjoin").value, true, document.getElementById("id").value);

        submitOpen();
        return false;
    }
    if (res == true) {
        if (idFlag != true || pwFlag != true) {
            setTimeout("mainSubmit(" + cnt + ")", 300);
            return false;
        } else
        {
            oMsg.style.display = "none";
            document.getElementById("pswd1").value = "";
            document.getElementById("pswd2").value = "";

            if (cnt > 1) {

                lua_do('join_kr'+document.getElementById("platform").value,'',SUCCESS_JOIN_SUBMIT, document.getElementById("token_sjoin").value, true, document.getElementById("id").value);
                lua_do2('join_kr'+document.getElementById("platform").value,'',SUCCESS_JOIN_SUBMIT, document.getElementById("token_sjoin").value, true, document.getElementById("id").value);
                document.getElementById("nid_kb2").value = desk.f();

                document.getElementById('join_form').submit();
            } else {
                return true;
            }
        }
        ;
    }
    ;

};

function submitClose() {
    document.getElementById("btnSubmit").disabled = true;
}

function submitOpen() {
    document.getElementById("btnSubmit").disabled = false;
}

function checkShiftDownJoin(e) {
    if (e.which && e.which==16){
        isshift = true;
    }

    var oMsg = document.getElementById("pswd1Msg");
    if (e.which && e.which==20){
        if(!isCapslock) {
            isCapslock = true;
            oMsg.style.display = "block";
            oMsg.className = "error";
            oMsg.innerHTML = "Caps Lock이 켜져 있습니다.";
        } else {
            isCapslock = false;
            oMsg.style.display = "none";
        }
    }
    focuswhere=0;

}
