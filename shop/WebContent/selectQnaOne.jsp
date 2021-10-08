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
	
	// 0-2. 방어 코드 : 로그인한 회원만 접속 가능
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		System.out.println("-[Debug] \"CAN NOT FIND Session information\" | selectQnaOne.jsp");
		return;
	}
	
	// 1. 넘겨받은 qnaNo 값 대입
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(" [Debug] qnaNo : \""+qnaNo +"\" | selectQnaOne.jsp");
	
	// 2. qnaNo을 이용해 Q&A 정보들 조회 후 객체에 대입
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);
	
	
	// 2. 방어코드 : 비밀글은 관리자나 작성자만 접근 가능
	if(loginMember.getMemberLevel() < 1 && loginMember.getMemberNo() != qna.getMemberNo()){
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
		return;
	}
	
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
		<%
			if(loginMember.getMemberLevel() >= 1){
		%>
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/insertQnaCommentForm.jsp?qnaNo=<%=qna.getQnaNo()%>">답글작성</a>
				<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/adminPasswordCheckForm.jsp?qnaNo=<%=qna.getQnaNo()%>&deleteOptionNum=5">강제삭제</a>
		<%
			} else {
		%>
				<a class="btn btn-success" href="<%=request.getContextPath()%>/insertQnaForm.jsp">Q&A작성</a>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/updateQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>">수정</a>
				<a class="btn btn-danger" href="<%=request.getContextPath()%>/deleteQna.jsp?qnaNo=<%=qna.getQnaNo()%>">삭제</a>
		<%
			}
		%>
	</div>
	
	<!-- Q&A 질문 부분 -->
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
	<%
		QnaCommentDao qnaCommentDao = new QnaCommentDao();
		QnaComment qnaComment = qnaCommentDao.selectQnaComment(qnaNo);
	%>
	<!-- Q&A 답변 부분 -->
	<form>
		<table class="table table-striped">
			<tr>
				<td colspan="4"><h3>답변</h3></td>
			</tr>
			<tr>
				<td><input type="text" name="memberName" value="<%=qnaComment.getMemberName()%>" readonly></td>
				<td width="50%"><input type="text" name="memberName" value="<%=qnaComment.getQnaCommentContent()%>" readonly></td>
				<td><input type="text" name="createDate" value="<%=qnaComment.getUpdateDate()%>" readonly></td>
				<td>
				<%
					if(loginMember.getMemberLevel() > 1 && qnaComment.getMemberNo() != 0){
				%>
						<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/updateQnaCommentForm.jsp?qnaNo=<%=qna.getQnaNo()%>">수정</a>
				<%
					}
				%>
				</td>
			</tr>
		</table>
		<a class="btn btn-info" href="<%=request.getContextPath()%>/selectQnaList.jsp">뒤로가기</a>
	</form>
</div>
</body>
</html>