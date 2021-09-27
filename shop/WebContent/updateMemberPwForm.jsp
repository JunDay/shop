<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
// 0. 인코딩 설정
request.setCharacterEncoding("utf-8");
System.out.println("+[Debug] \"Started\" | admin/updateMemberPwForm.jsp");

// 0-1. 로그인된 회원의 세션 정보 가져오기
Member loginMember = (Member)session.getAttribute("loginMember");

// 0-2. 방어 코드 : 로그인 정보가 null 이거나 memberLevel이 1보다 낮으면
if(loginMember == null){
	response.sendRedirect(request.getContextPath()+"/index.jsp");
	return;
}

// 1. 넘겨받은 memberNo 값 대입
int memberNo = Integer.parseInt(request.getParameter("memberNo"));
System.out.println("*[Debug] " + memberNo +" <-- updateMemberForm.jsp/memberNo");

// 2. member의 다른 정보 조회
MemberDao memberDao = new MemberDao();
Member member = memberDao.selectMemberOne(memberNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>[공통] 회원 Pw 수정 | updateMemberPwForm.jsp</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand btn btn-secondary" href="./index.jsp">Main</a>
		<!-- start : submenu include -->
		<div>
		<%
			if(loginMember.getMemberLevel() < 1){
		%>
				<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		<%
			} else {
		%>
				<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<%
			}
		%>
	</div>
	<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<%
			if(loginMember.getMemberLevel() < 1){
		%>
				<h1>[일반회원] 회원 Pw 수정 페이지</h1>
		<%
			} else {
		%>
				<h1>[관리자] 회원 Pw 수정 페이지</h1>
		<%
			}
		%>
		<p>회원 Pw 수정</p>
	</div>
	
	<form method="post" action="<%=request.getContextPath()%>/updateMemberPwAction.jsp">
		<table class="table table-striped">
			<tr>
				<td colspan="2"><h2><%=member.getMemberName()%>님 상세정보</h2></td>
			</tr>
			<tr>
				<td>memberNo</td>
				<td><input type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>memberId</td>
				<td><%=member.getMemberId()%></td>
			</tr>
			<tr>
				<td>newMemberPw</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>memberLevel</td>
				<td><%=member.getMemberLevel()%></td>
			</tr>
			<tr>
				<td>memberName</td>
				<td><%=member.getMemberName()%></td>
			</tr>
			<tr>
				<td>memberAge</td>
				<td><%=member.getMemberAge()%></td>
			</tr>
			<tr>
				<td>memberGender</td>
				<td><%=member.getMemberGender()%></td>
			</tr>
			<tr>
				<td>updateDate</td>
				<td><%=member.getUpdateDate()%></td>
			</tr>
			<tr>
				<td>createDate</td>
				<td><%=member.getCreateDate()%></td>
			</tr>
		</table>
		<a class="btn btn-info" href="<%=request.getContextPath()%>/selectMemberOne.jsp?memberNo=<%=member.getMemberNo()%>">뒤로가기</a>
		<button class="btn btn-success" type="submit">수정</button>
	</form>
</div>
</body>
</html>