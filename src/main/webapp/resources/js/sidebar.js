$(document).ready(function(){
	var on = "sidr on";
	var off = "sidr off";
	document.getElementById("nav_board").addEventListener("mouseover", function() {open('side3');});
	document.getElementById("nav_findjob").addEventListener("mouseover", function() {open('side4');});
	var a = document.getElementById("nav_mypage");
	var b = document.getElementById("nav_login");
	var c = document.getElementById("nav_addjob");
	if(a!=null){
		a.addEventListener("mouseover", function() {open('side1');});
	}else {
		b.addEventListener("mouseover", function() {open('side2');});
	}
	if(c!=null)
		c.addEventListener("mouseover", function() {open('side5');});
	$("body").click(function(e){
		var id = e.target.getAttribute('id');
		document.getElementById("side1").className = off;
		document.getElementById("side2").className = off;
		document.getElementById("side3").className = off;
		document.getElementById("side4").className = off;
		document.getElementById("side5").className = off;
		if(id=="side1" || id=="side2" || id=="side3" || id=="side4" || id=="side5")
			document.getElementById(id).className = on;			
	});
});
function open(cmd){
	document.getElementById(cmd).className = "sidr on";
}