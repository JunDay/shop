<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | selectQnaOne.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 1. 넘겨받은 memberNo 값 대입
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(" [Debug] qnaNo : \""+qnaNo +"\" | selectQnaOne.jsp");
	
	QnaDao qnaDao = new QnaDao();
	
	Qna qna = qnaDao.selectQnaOne(qnaNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectQnaOne.jsp</title>
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
		<h1>[공통] Q&A 상세보기</h1>
		<p>Q&A 상세정보 출력</p>
	</div>
	<div align="right">
		<a class="btn btn-success" href="<%=request.getContextPath()%>/insertQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>">Q&A작성</a>
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/updateQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>">수정</a>
		<a class="btn btn-danger" href="<%=request.getContextPath()%>/deleteQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>">삭제</a>
		<%
			if(loginMember == null){
			}
			else if(loginMember.getMemberLevel() >= 1){
				%>
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/insertQnaCommentForm.jsp?=<%=qna.getQnaNo()%>">답글작성</a>
				<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteForcedQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>">강제삭제</a>
				<%
			}
		%>
	</div>
	<table class="table table-striped">
		<tr>
			<td colspan="5"><h2><%=qna.getQnaTitle()%></h2></td>
		</tr>
		<tr>
			<th>qnaNo</th>
			<td><%=qna.getQnaNo()%></td>
			<th>memberName</th>
			<td><%=qna.getMemberName()%></td>
		</tr>
		<tr>
			<th>qnaCategory</th>
			<td><%=qna.getQnaCategory()%></td>
			<th>qnaSecret</th>
			<td><%=qna.getQnaSecret()%></td>
		</tr>
		<tr>
			<th>createDate</th>
			<td><%=qna.getCreateDate()%></td>
			<th>updateDate</th>
			<td><%=qna.getUpdateDate()%></td>
		</tr>
		<tr>
			<th>qnaTitle</th>
			<td colspan="3"><%=qna.getQnaTitle()%></td>
		</tr>
		<tr>
			<th>qnaContent</th>
			<td colspan="3"><%=qna.getQnaContent()%></td>
		</tr>
	</table>
	<a class="btn btn-info" href="<%=request.getContextPath()%>/selectQnaList.jsp">뒤로가기</a>
	
</div>
</body>
</html>