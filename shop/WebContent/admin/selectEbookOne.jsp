<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] selectEbookOne.jsp | Start");
	
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
	
	<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>
	<div>
		<%=ebook.getEbookNo() %>
	</div>
	<div>
		<img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>">
	</div>
	<div>
		<a href="">삭제</a>
		<a href="">가격수정</a>
		<a href="<%=request.getContextPath()%>/admin/updateEbookImgForm.jsp?ebookNo=<%=ebook.getEbookNo()%>">이미지수정</a>
	</div>
</body>
</html>