<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | selectQnaList.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectNoticeOne.jsp</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<a class="navbar-brand btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	
	</nav>
	
	<div class="jumbotron">
		<h1>[공통] Q&A 목록 출력</h1>
		<p>Q&A 목록 출력</p>
	</div>
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
</body>
</html>