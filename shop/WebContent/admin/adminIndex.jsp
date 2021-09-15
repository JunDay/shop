<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
<%
	System.out.println("**[Debug] adminIndex.jsp | Start");
	// 0. 세션 정보를 가져온다.
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0. 방어 코드 : 로그인 한 상태에서는 들어올 수 없다.
		// 로그인 정보가 null 이거나 memberLevel이 1보다 낮으면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
	<!-- 관리자 메뉴 include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	
	<h1>관리자 페이지</h1>
	<div><%=loginMember.getMemberName() %>님 반갑습니다.</div>
</div>
</body>
</html>