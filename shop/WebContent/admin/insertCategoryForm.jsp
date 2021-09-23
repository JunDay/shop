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
	
	<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] selectCategoryList.jsp | Start");
	
	// 0-1. 세션 정보를 가져온다.
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
		// 로그인 정보가 null 이거나 memberLevel이 1보다 낮으면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	%>
	<h1>회원가입</h1>
	
	<%
		String categoryNameCheck = "";
		if(request.getParameter("categoryNameCheck") != null){
			categoryNameCheck = request.getParameter("categoryNameCheck");
		}
	%>
	<div><%=request.getParameter("categoryCheckResult") %></div>
	<!-- memberId가 사용가능한지 확인 폼 -->
	<form action="<%=request.getContextPath()%>/selectCategoryNameCheckAction.jsp" method="post">
		<div>
			회원 아이디 : <input type="text" name="categoryIdCheck">
			<button type="submit">카테고리 중복 검사</button>
		</div>
	</form>
	
	<!-- 회원가입 폼 -->
	<form method="post" action="<%=request.getContextPath()%>/insertCategoryAction.jsp">
		<div>memberId : </div>
		<div><input type="text" name="memberId" readonly="readonly" value="<%=categoryNameCheck%>"></div>
		<div>memberPw : </div>
		<div><input type="password" name="memberPw"></div>
		<div>memberName : </div>
		<div><input type="text" name="memberName"></div>
		<div>memberAge : </div>
		<div><input type="text" name="memberAge"></div>
		<div>memberGender : </div>
		<div>
			<input type="radio" name="memberGender" value="남">남
			<input type="radio" name="memberGender" value="여">여
		</div>
		<button type="submit">회원가입</button>
	</form>

</body>
</html>