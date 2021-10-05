<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>adminIndex.jsp | 관리자 메인화면</title>
</head>
<body>
<div>
<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | adminIndex.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0. 방어 코드 : 로그인 한 상태에서는 들어올 수 없다.
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	<div class="jumbotron">
		<h1>관리자 페이지</h1>
		<p><%=loginMember.getMemberName() %>님 반갑습니다.</p>
	</div>
	
	<!-- 공지사항 -->
	<h2>공지사항</h2>
	<table class="table table-borderless" width="90%">
		<tr>
		<%
			NoticeDao noticeDao = new NoticeDao();
			ArrayList<Notice> noticeList = noticeDao.selectNoticeList(0, 5);
			
			
			int pi=0;
			for(Notice n : noticeList){
		%>
			<td width="10%" align="center">[공지]</td>
			<td width="5%" align="center"><%=n.getNoticeNo()%></td>
			<td width="50%"><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></th>
			<td width="15%" align="center"><%=n.getMemberName()%></td>
			<td width="20%" align="center"><%=n.getCreateDate()%></td>
			<tr></tr>
		<%
			}
		%>
		</tr>
	</table>
</div>
</div>
</body>
</html>