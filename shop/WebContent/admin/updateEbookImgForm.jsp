<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] selectEbookList.jsp | Start");
	
	// 0-1. 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- adminMenu.jsp Start -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- adminMenu.jsp End -->
	
	<form action="<%=request.getContextPath()%>/admin/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
				<!-- enctype="multipart/form-data" : 액션으로 기계어 코드를 넘길 때 사용 -->
				<!-- enctype="application/x-www-form-urlencoded" : 원래 디폴트로 문자를 넘길 때 사용 -->
		<input type="text" name="ebookNo" value="<%=ebookNo%>" readonly="readonly"> <!-- type="hidden" -->
		<input type="file" name="ebookImg">
		<button type="submit">이미지파일 수정</button>

	</form>
</body>
</html>