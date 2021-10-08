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
	
	// 0-2. 방어 코드 : 로그인된 세션이 없거나 관리자가 아니면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		System.out.println("-[Debug] \"CAN NOT FIND Session information\" | insertQnaCommentForm.jsp");
		return;
	}
	
	// 1. 넘겨받은 qnaNo 값 대입
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(" [Debug] qnaNo : \""+qnaNo +"\" | insertQnaCommentForm.jsp");
	
	// 2. qnaNo을 이용해 Q&A 정보들 조회 후 객체에 대입
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);
	
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	QnaComment qnaComment = qnaCommentDao.selectQnaComment(qnaNo);
	
	if(qnaComment.getQnaCommentContent() != null){
		response.sendRedirect(request.getContextPath()+"/selectQnaOne.jsp?qnaNo="+qnaNo);
		System.out.println("-[Debug] \"Already registered QnaComment\" | insertQnaCommentForm.jsp");
		return;
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>insertQnaCommentForm.jsp</title>
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
		<h1>[관리자] Q&A 답변하기</h1>
		<p>관리자가 Q&A에 대한답변 작성</p>
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
	
	<!-- Q&A 답변 부분 -->
	<form id="insertQnaCommentForm"action="<%=request.getContextPath()%>/admin/insertQnaCommentAction.jsp">
		<table class="table table-striped">
			<tr>
				<td colspan="4"><h3>답변</h3></td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>" readonly>
					<input type="hidden" name="qnaNo" value="<%=qna.getQnaNo()%>" readonly>
					<input type="text" name="memberName" value="<%=loginMember.getMemberName()%>" readonly>
				</td>
				<td width="50%"><input type="text" id="qnaCommentContent" name="qnaCommentContent"></td>
				<td><input type="text" name="createDate" placeholder="작성일" readonly></td>
				<td><button id="btn" type=button class="btn btn-primary">입력</button></td>
			</tr>
		</table>
		<a class="btn btn-info" href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=qna.getQnaNo()%>">뒤로가기</a>
	</form>
	
	<script>
		// 버튼을 클릭헀을 때
		$('#btn').click(function(){
			if($('#qnaCommentContent').val() == ''){
				alert('qnaCommentContent를 입력하세요.');
				return;
			}
			$('#insertQnaCommentForm').submit();
		});
	</script>
</div>
</body>
</html>