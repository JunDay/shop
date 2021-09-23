<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

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
	CategoryDao categoryDao = new CategoryDao();
	
	// 2. 검색어에 따른 
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
<div>
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<div><a href="<%=request.getContextPath()%>/admin/insetCategory.jsp">카테고리추가</a></div>
	<div><a href="<%=request.getContextPath()%>/admin/updateCategoryState.jsp">카테고리수정</a></div>
	<h1>회원 목록</h1>
	<table border="1">
		<thead>
			<tr>
				<td>categoryName</td>
				<td>updateDate</td>
				<td>createDate</td>
				<td>categoryState</td>
				
			</tr>
		</thead>
		<tbody>
			<%
				for(Category category : categoryList){
			%>
					<tr>
						<td><%=category.getCategoryName()%></td>
						<td><%=category.getUpdateDate()%></td>
						<td><%=category.getCreateDate()%></td>
						<td><%=category.getCategoryState()%></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	</div>
</body>
</html>