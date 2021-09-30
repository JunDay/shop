<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 이슈 : 이전에 선택된 값들에 다라서 셀렉트 문제


	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | updateQnaForm.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 1. 넘겨받은 qnaNo 값 대입
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(" [Debug] qnaNo : \""+qnaNo +"\" | updateQnaForm.jsp");
	
	// 2. qnaNo을 이용해 Q&A 정보들 조회 후 객체에 대입
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);
	
	// 2. 방어코드 : 작성자만 접근 가능
	if(loginMember.getMemberNo() != qna.getMemberNo()){
		response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
		return;
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>updateQnaForm.jsp</title>
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
		<h1>[회원] Q&A 수정 폼</h1>
		<p>Q&A 수정</p>
	</div>
	<form id="updateQnaForm" method="post" action="<%=request.getContextPath()%>/updateQnaAction.jsp">
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
						<%
							String op1 = qna.getQnaCategory();
							System.out.println(" [Debug] qna.qnaCategory : \""+qna.getQnaCategory()+"\" | updateQnaForm.jsp");
							System.out.println(" [Debug] op1 : \""+op1+"\" | updateQnaForm.jsp");
							if(op1 == "전자책관련"){
						%>
								<option value="">#카테고리 선택</option>
								<option value="전자책관련" selected>  전자책관련</option>
								<option value="개인정보관련">  개인정보관련</option>
								<option value="기타">  기타</option>
						<%
							} else if(qna.getQnaCategory() == "개인정보관련"){
						%>
								<option value="">#카테고리 선택</option>
								<option value="전자책관련">  전자책관련</option>
								<option value="개인정보관련" selected>  개인정보관련</option>
								<option value="기타">  기타</option>
						<%
							} else {
						%>
								<option value="">#카테고리 선택</option>
								<option value="전자책관련">  전자책관련</option>
								<option value="개인정보관련">  개인정보관련</option>
								<option value="기타" selected>  기타</option>
						<%
							}
						%>
					</select>
				</td>
				<th>qnaSecret</th>
				<td>
					<select id="qnaSecret" name="qnaSecret">
						<%
							if(qna.getQnaSecret() == "Y"){
						%>
								<option value="">#비밀글 선택</option>
								<option value="Y" selected>  Y</option>
								<option value="N">  N</option>
						<%
							} else {
						%>
								<option value="">#비밀글 선택</option>
								<option value="Y">  Y</option>
								<option value="N" selected>  N</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>qnaTitle</th>
				<td><input type="text" id="qnaTitle" name="qnaTitle" value="<%=qna.getQnaTitle()%>"></td>
				<th>qnaNo</th>
				<td><input type="hidden" id="qnaNo" name="qnaNo" value="<%=qna.getQnaNo()%>"><%=qna.getQnaNo()%></td>
			</tr>
			<tr>
				<th>qnaContent</th>
				<td colspan="3"><textarea id="qnaContent" name="qnaContent" rows="10" cols="50"><%=qna.getQnaContent()%></textarea></td>
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
			
			$('#updateQnaForm').submit();
		});
	</script>
</div>
</body>
</html>