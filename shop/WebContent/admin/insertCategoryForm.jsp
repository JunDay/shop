<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/insertCategoryForm.jsp");
	
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>insertCategoryList.jsp</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[관리자] 카테고리 추가</h1>
		<p>카테고리를 추가하기 위한 페이지</p>
	</div>
	<form id="insertCategoryForm" method="post" action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp">
	<table class="table table-striped">
		<thead>
			<tr>
				<td>categoryName</td>
				<td>categoryState</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input id="categoryName" name="categoryName" type="text"></td>
				<td>
					<select id="categoryState" name="categoryState">
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
	<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">뒤로가기</a>
	<button id="btn" class="btn btn-success" type="button">카테고리추가</button>
	</form>
	<script>
		$('#btn').click(function(){
			if($('#categoryName').val() == ''){
				alert('categoryName를 입력하세요.');
				return;
			}
			if($('#categoryState').val() == '') {
				alert('categoryState를 선택하세요.');
				return;
			}
			$('#insertCategoryForm').submit();
		});
	</script>
</div>
</body>
</html>