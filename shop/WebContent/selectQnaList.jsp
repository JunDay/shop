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
<title>selectQnaList.jsp</title>
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
	<div align="right"><a class="btn btn-primary" href="<%=request.getContextPath()%>/insertQnaForm.jsp">Q&A작성</a></div>
	<table class="table table-borderless" width="90%">
		<tr>
			<th>qnaNo</th>
			<th>qnaCategory</th>
			<th>qnaTitle</th>
			<th>memberName</th>
			<th>qnaSecret</th>
			<th>createDate</th>
		<tr>
		<%
			QnaDao qnaDao = new QnaDao();
			ArrayList<Qna> qnaList = qnaDao.selectQnaList(0, 10);
			
			
			int i=0;
			for(Qna q : qnaList){
		%>
			<td><%=q.getQnaNo()%></td>
			<td><%=q.getQnaCategory()%></td>
			<td><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
			<td><%=q.getMemberName() %></td>
			<td><%=q.getQnaSecret() %></td>
			<td><%=q.getCreateDate() %></td>
			<tr></tr>
		<%
			}
		%>
		</tr>
	</table>
	<form action="<%=request.getContextPath()%>/selectQnaList.jsp" method="get">
		<select name="qnaCategory">
			<option value="전자책관련">전자책관련</option>
			<option value="개인정보관련">개인정보관련</option>
			<option value="기타">기타</option>
		</select>
		searchQna : <input type="text" name="searchQna">
		<button class="btn btn-success" type="submit">검색</button>
	</form>
</div>
</body>
</html>