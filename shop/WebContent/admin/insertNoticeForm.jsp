<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | insertNoticeForm.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인된 회원이 권한 1미만인 경우
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 전달받은 orderNo, ebookNo 대입
	Notice notice = new Notice();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>insertNoticeForm.jsp</title>
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
		<h1>[관리자] 공지사항 입력</h1>
		<p>공지사항을 새로 작성</p>
	</div>
	
	<form id="noticeForm" method="post" action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
		<table class="table table-striped">
			<tr>
				<th>noticeTitle</th>
				<td colspan="3">
					<input id="noticeTitle" type="text" name="noticeTitle">
				</td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td colspan="3">
					<textarea id="noticeContent" name="noticeContent" cols="50" rows="10"></textarea>
				</td>
			</tr>
		</table>
		<a class="btn btn-info" href="<%=request.getContextPath()%>/index.jsp">뒤로가기</a>
		<button id="btn" class="btn btn-success" type="button">등록</button>
	</form>
	<script>
		$('#btn').click(function(){
			if($('#noticeTitle').val() == ''){
				alert('noticeTitle를 입력하세요.');
			}
			if($('#noticeContent').val() == '') {
				alert('noticeContent를 입력하세요.');
			}
			$('#noticeForm').submit();
		});
	</script>
</div>
</body>
</html>