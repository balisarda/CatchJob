	function chkBox_jop() {
		var chkBoxjop = document.getElementsByName("board_type");
		var ok = "";
		for (var i = 0; i < chkBoxjop.length; i++) {
			if (chkBoxjop[i].checked == true) {
				ok += chkBoxjop[i].value + " ";
			}
		}
	}
	function chkBox_time() {
		var chkBoxtime = document.getElementsByName("board_time");
		for (var i = 0; i < chkBoxtime.length; i++) {
			if (chkBoxtime[i].checked)
				chkBoxtime[i].value + " ";
		}
	function selectBox_pay() {
			var Urgency = document.getElementsById("board_pay");
			var val1 = board_pay.options[board_pay.selectedIndex].value;

			var Salary = document.getElementsById("board_pay");
			var val2 = board_pay.options[board_pay.selectedIndex].value;
	}
	}	