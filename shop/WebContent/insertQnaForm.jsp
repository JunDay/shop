<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | insertQnaForm.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인한 회원만 접속 가능
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>insertQnaForm.jsp</title>
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
		<h1>[회원] Q&A 작성 폼</h1>
		<p>Q&A 작성</p>
	</div>
	<form id="insertQnaForm" method="post" action="<%=request.getContextPath()%>/insertQnaAction.jsp">
		<table class="table table-striped">
			<tr>
				<th>memberNo</th>
				<td><input type="hidden" id="memberNo" name="memberNo" value="<%=loginMember.getMemberNo()%>"><%=loginMember.getMemberNo()%></td>
				<th>memberName</th>
				<td><%=loginMember.getMemberName()%>님</td>
			</tr>
			<tr>
				<th>qnaCategory</th>
				<td>
					<select id="qnaCategory" name="qnaCategory">
						<option value="" selected>#카테고리 선택</option>
						<option value="전자책관련">  전자책관련</option>
						<option value="개인정보관련">  개인정보관련</option>
						<option value="기타">  기타</option>
					</select>
				</td>
				<th>qnaSecret</th>
				<td>
					<select id="qnaSecret" name="qnaSecret">
						<option value="" selected>#비밀글 선택</option>
						<option value="Y">  Y</option>
						<option value="N">  N</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>qnaTitle</th>
				<td colspan="3"><input type="text" id="qnaTitle" name="qnaTitle"></td>
			</tr>
			<tr>
				<th>qnaContent</th>
				<td colspan="3"><textarea id="qnaContent" name="qnaContent" rows="10" cols="50"></textarea></td>
			</tr>
		</table>
		<a class="btn btn-info" href="<%=request.getContextPath()%>/selectQnaList.jsp">뒤로가기</a>
		<button id="btn" type="button" class="btn btn-success">입력</button>
	</form>
	
	<script>
		// 버튼을 클릭헀을 때
		$('#btn').click(function(){
			if($('#qnaCategory').val() == ''){
				alert('qnaCategory를 입력하세요.');
				return;
			}
			if($('#qnaSecret').val() == '') {
				alert('qnaSecret를 입력하세요.');
				return;
			}
			if($('#qnaTitle').val() == '') {
				alert('qnaTitle를 입력하세요.');
				return;
			}
			if($('#qnaContent').val() == '') {
				alert('qnaContent를 입력하세요.');
				return;
			}
			
			$('#insertQnaForm').submit();
		});
	</script>
</div>
</body>
</html>