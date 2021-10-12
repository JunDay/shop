<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | selectNoticeOne.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 1. 넘겨받은 memberNo 값 대입
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(" [Debug] noticeNo : \""+noticeNo +"\" | selectNoticeOne.jsp");
	
	NoticeDao noticeDao = new NoticeDao();
	
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
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
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[공통] 공지사항 상세보기</h1>
		<p>공지사항 확인</p>
	</div>
	
	<div align="right">
		<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">새 공지작성</a>
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>">수정</a>
		<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/adminPasswordCheckForm.jsp?noticeNo=<%=notice.getNoticeNo()%>&deleteOptionNum=2">삭제</a>
	</div>
	
	<table class="table table-striped">
		<tr>
			<td colspan="5"><h2><%=notice.getNoticeTitle()%></h2></td>
		</tr>
		<tr>
			<th>noticeNo</th>
			<td><%=notice.getNoticeNo()%></td>
			<th>memberName</th>
			<td><%=notice.getMemberName()%></td>
		</tr>
		<tr>
			<th>createDate</th>
			<td><%=notice.getCreateDate()%></td>
			<th>updateDate</th>
			<td><%=notice.getUpdateDate()%></td>
		</tr>
		<tr>
			<th>noticeTitle</th>
			<td colspan="3"><%=notice.getNoticeTitle()%></td>
		</tr>S
		<tr>
			<th>noticeContent</th>
			<td colspan="3"><%=notice.getNoticeContent()%></td>
		</tr>
	</table>
	<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/selectNoticeListByAdmin.jsp">뒤로가기</a>
</div>
</body>
</html>