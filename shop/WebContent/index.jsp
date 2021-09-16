<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>index.jsp</title>

</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand btn btn-secondary" href="./index.jsp">메인</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
		
	<%
		if(session.getAttribute("loginMember") == null) {
	%>
			<!-- 로그인 전  -->
			<div type="button" class="btn"><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
			<div type="button" class="btn"><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div><!-- insertMemberAction.jsp -->
	<%		
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
	%>
			<!-- 로그인 -->
			<div><%=loginMember.getMemberName()%>님 반갑습니다.<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></div>
			<div><a href="<%=request.getContextPath()%>/selectMemberOne.jsp">회원정보</a></div>
	<%
			if(loginMember.getMemberLevel() > 0){ 
	%>
			<div><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a></div>
	<%
			}
		}
	%>
		
	</nav>
	<div class="jumbotron">
		<h1>인덱스 페이지</h1>
		<p>이것저것</p>
	</div>
</div>
</body>
</html>