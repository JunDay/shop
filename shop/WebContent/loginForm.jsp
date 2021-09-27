<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("+[Debug] \"Started\" | loginForm.jsp");

	// 0. 인증 방어 코드 : 로그인된 세션을 가지고 있는 경우 접근 불가
	if(session.getAttribute("loginMember") != null) {
		System.out.println("-[Debug] \"FAILED - Already logged in\" | loginForm.jsp");
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>shop loginForm.jsp | 로그인 화면</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand btn btn-secondary" href="./index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	<h1 style="font-size:50px;">Login</h1>
	<div style="width:30%;">
	<form method="post" action="./loginAction.jsp">
	<div class="form-group">
		<div style="font-size:larger;">memberId</div>
		<div><input class="form-control" type="text" name="memberId"></div>
	</div>
	<div class="form-group">
		<div style="font-size:larger;">memberPw</div>
		<div><input class="form-control" type="password" name="memberPw"></div>
	</div>
		<div><button class="btn btn-info" type="submit">로그인</button></div>
	</form>
	</div>
</div>
</body>
</html>