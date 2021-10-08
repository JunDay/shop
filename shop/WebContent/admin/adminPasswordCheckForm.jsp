<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/adminPasswordCheck.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인된 회원이 권한 1미만인 경우
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 전달받은 optionNum 변수에 대입 및 디버깅
	int deleteOptionNum = Integer.parseInt(request.getParameter("deleteOptionNum"));
	System.out.println(" [Debug] deleteOptionNum : \""+deleteOptionNum+"\" | /admin/adminPasswordCheck.jsp");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>deleteNoticeForm.jsp</title>
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
		<h1>[관리자] 비밀번호 확인</h1>
		<p>삭제하기 위해 관리자의 PW 확인</p>
	</div>
	
	<form id="deleteForm" method="post" action="<%=request.getContextPath()%>/admin/adminPasswordCheckAction.jsp?deleteOptionNum=<%=deleteOptionNum%>">
	<%
		// 2. 삭제할 활동의 옵션 확인
		if(deleteOptionNum == 1){ // 2-1. 멤버 삭제
			int memberNo = Integer.parseInt(request.getParameter("memberNo")); // 삭제할 멤버의 memberNo
	%>
			<input type="hidden" name="memberNo" value="<%=memberNo%>">
	<%
		} else if(deleteOptionNum == 2){ // 2-2. 공지사항 삭제
			int noticeNo = Integer.parseInt(request.getParameter("noticeNo")); // 삭제할 멤버의 memberNo
	%>
			<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
	<%
		} else if(deleteOptionNum == 3){ // 2-3. 카테고리 삭제
			String categoryName = request.getParameter("categoryName"); // 삭제할 멤버의 memberNo
	%>
			<input type="hidden" name="categoryName" value="<%=categoryName%>">
	<%
		} else if(deleteOptionNum == 4){ // 2-4. 전자책 삭제
			int ebookNo = Integer.parseInt(request.getParameter("ebookNo")); // 삭제할 멤버의 memberNo
	%>
			<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
	<%
		} else if(deleteOptionNum == 5){ // 2-5. Q&A 삭제
			int qnaNo = Integer.parseInt(request.getParameter("qnaNo")); // 삭제할 멤버의 memberNo
	%>
			<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
	<%
		}
	%>
		<table class="table table-striped">
			<tr>
				<th>memberPw</th>
				<td colspan="3">
					<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
					<input id="memberPw" type="password" name="memberPw">
				</td>
				<th>memberPwCheck</th>
				<td colspan="3">
					<input id="memberPwCheck" type="password" name="memberPwCheck">
				</td>
			</tr>
		</table>
		<a class="btn btn-info" href="<%=request.getContextPath()%>/index.jsp">뒤로가기</a>
		<button id="btn" class="btn btn-danger" type="button">삭제</button>
	</form>
	<script>
		$('#btn').click(function(){
			if($('#memberPw').val() == ''){
				alert('adminPw를 입력하세요.');
				return;
			}
			if($('#memberPwCheck').val() == ''){
				alert('memberPwCheck를 입력하세요.');
				return;
			}
			if($('#memberPw').val() != $('#memberPwCheck').val()){
				alert('memberPw또는 memberPwCheck를 확인하세요.');
				return;
			}
			$('#deleteForm').submit();
		});
	</script>
</div>
</body>
</html>