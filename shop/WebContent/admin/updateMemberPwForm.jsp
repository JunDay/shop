<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	
	<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] updateMemberPwForm.jsp | Start");
	
	// 0-1. 로그인된 회원의 세션 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 null 이거나 memberLevel이 1보다 낮으면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
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
	<h1>[관리자] 회원 Pw 수정</h1>
	<form method="post" action="<%=request.getContextPath()%>/admin/updateMemberPwAction.jsp">
		<div>memberNo : </div>
		<div><input type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly></div>
		<div>memberId : </div>
		<div><input type="text" name="memberId" value="<%=member.getMemberId()%>" readonly></div>
		<div>New memberPw : </div>
		<div><input type="password" name="memberPw"></div>
		<div>memberLevel : </div>
		<div><input type="text" name="memberLevel" value="<%=member.getMemberLevel()%>" readonly></div>
		<div>memberName : </div>
		<div><input type="text" name="memberName" value="<%=member.getMemberName()%>" readonly></div>
		<div>memberAge : </div>
		<div><input type="text" name="memberAge" value="<%=member.getMemberAge()%>" readonly></div>
		<div>memberGender : </div>
		<div><input type="text" name="memberGender" value="<%=member.getMemberGender()%>" readonly></div>
		<div>updateDate : </div>
		<div><input type="text" name="updateDate" value="<%=member.getUpdateDate()%>" readonly></div>
		<div>createDate : </div>
		<div><input type="text" name="createDate" value="<%=member.getCreateDate()%>" readonly></div>
		<button type="submit">수정</button>
	</form>
</body>
</html>