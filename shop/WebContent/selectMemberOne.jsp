<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
// 0. 인코딩 설정
request.setCharacterEncoding("utf-8");
System.out.println("+[Debug] \"Started\" | admin/selectMemberOne.jsp");

// 0-1. 로그인된 회원의 세션 정보 조회
Member loginMember = (Member)session.getAttribute("loginMember");

// 0-2. 방어 코드 : 로그인 정보가 null이면 접속 불가
if(loginMember == null){
	response.sendRedirect(request.getContextPath()+"/index.jsp");
	return;
}

// 1. 넘겨받은 memberNo 값 대입
int memberNo = Integer.parseInt(request.getParameter("memberNo"));
System.out.println(" [Debug] memberNo : \""+memberNo +"\" | admin/selectMemberOne.jsp");

MemberDao memberDao = new MemberDao();

Member member = memberDao.selectMemberOne(memberNo);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>[공통] 회원정보 상세보기 | selectMemberOne.jsp</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<a class="navbar-brand btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
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
				<h1>[일반회원] 회원정보 상세보기</h1>
				<p>회원 Pw 수정, 회원 탈퇴</p>
		<%
			} else {
		%>
				<h1>[관리자] 회원정보 상세보기</h1>
				<p>회원 Pw 강제 수정, 회원 Level 수정, 회원 강제 탈퇴</p>
		<%
			}
		%>
	</div>
	
	<table class="table table-striped">
		<tr>
			<td colspan="2"><h2><%=member.getMemberName()%>님 상세정보</h2></td>
		</tr>
		<tr>
			<td>memberNo</td>
			<td><%=member.getMemberNo()%></td>
		</tr>
		<tr>
			<td>memberId</td>
			<td><%=member.getMemberId()%></td>
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
	<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">뒤로가기</a>
	<a class="btn btn-success" href="<%=request.getContextPath()%>/updateMemberPwForm.jsp?memberNo=<%=member.getMemberNo()%>">Pw 수정</a>
	<%
	if(loginMember.getMemberLevel() < 1){
	%>
		<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=member.getMemberNo()%>">탈퇴</a>
		
	<%
	} else {
	%>
		<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=member.getMemberNo()%>">Level 수정</a>
		<a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberNo=<%=member.getMemberNo()%>">강제 탈퇴</a>
	<%
	}
	%>
	
	
</div>
</body>
</html>