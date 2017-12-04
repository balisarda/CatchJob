<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<c:url var="home" value="/" />
<c:url var="css" value="/resources/css/" />
<c:url var="js" value="/resources/js/" />
<c:url var="img" value="/resources/img/" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
	<meta http-equiv="Context-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${css }sidebarcss.css" >
	<link rel="stylesheet" href="${css }main.css">
	<link rel="stylesheet" href="${css }/form/logincss.css">
<title>Project main page</title>
</head>

<body style="overflow-x: hidden; overflow-y: auto;">

	<div id=main>
		<div>
			<div>
				<c:import url="/top" />
			</div>
			<div>
				<c:import url="/sidebar" />
			</div>
			<div class="content" id=content>
				<c:import url="/form/${formPath }" />
			</div>
		</div>
	</div>
</body>
</html>
