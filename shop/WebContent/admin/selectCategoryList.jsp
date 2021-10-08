<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | admin/selectCategoryList.jsp");
	
	// 0-1. 로그인된 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 2. 검색어에 따른 목록 출력
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectCategoryList.jsp</title>
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
		<h1>[관리자] 카테고리 목록 출력</h1>
		<p>카테고리를 관리하기 위해 카테고리 목록을 촐력하는 페이지</p>
	</div>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>categoryState</th>
				<th>updateDate</th>
				<th>createDate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Category category : categoryList){
			%>
					<tr>
						<td><input type="text" name="categoryName" value="<%=category.getCategoryName()%>" readonly="readonly"></td>
						<td><input type="text" name="categoryState" value="<%=category.getCategoryState()%>" readonly="readonly"></td>
						<td><%=category.getUpdateDate()%></td>
						<td><%=category.getCreateDate()%></td>
						<td><a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryName=<%=category.getCategoryName()%>&categoryState=<%=category.getCategoryState()%>">수정</a></td>
						<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/adminPasswordCheckForm.jsp?categoryName=<%=category.getCategoryName()%>&deleteOptionNum=3">삭제</a></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">뒤로가기</a>
	<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리추가</a>
</div>
</body>
</html>