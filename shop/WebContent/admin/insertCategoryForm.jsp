<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | admin/insertCategoryForm.jsp");
	
	// 0-1. 로그인된 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<title>insertCategoryForm.jsp</title>
</head>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<a class="navbar-brand btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
	<!-- start : submenu include -->
	<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[관리자] 카테고리 추가</h1>
		<p>상품 카테고리 추가</p>
	</div>
	
	<h1>카테고리 추가</h1>
	
	<%
		String categoryCheckResult = "";
		if(request.getParameter("categoryCheckResult") != null){
			categoryCheckResult = request.getParameter("categoryCheckResult");
		}
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
</div>
</body>
</html>