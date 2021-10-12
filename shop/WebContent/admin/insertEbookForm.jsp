<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/insertEbookForm.jsp");
	
	// 0-1. 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>insertEbookForm.jsp</title>
</head>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[관리자] 전자책 추가 페이지</h1>
		<p>전자책을 추가하기 위한 입력 폼</p>
	</div>
	<form id="insertEbookForm" method="post" action="<%=request.getContextPath()%>/admin/insertEbookAction.jsp">
	<table class="table">
		<tr>
			<th>ebookISBN</th>
			<td><input type="text" name="ebookISBN" id="ebookISBN"></td>
		</tr>
		<tr>
			<th>categoryName</th>
			<td>
				<select name="categoryName" id="categoryName">
				<%
					for(Category c : categoryList){
				%>
						<option value="<%=c.getCategoryName()%>"><%=c.getCategoryName()%></option>
				<%
					}
				%>
				</select>
			</td>
		</tr>
		<tr>
			<th>ebookTitle</th>
			<td><input type="text" name="ebookTitle" id="ebookTitle"></td>
		</tr>
		<tr>
			<th>ebookAuthor</th>
			<td><input type="text" name="ebookAuthor" id="ebookAuthor"></td>
		</tr>
		<tr>
			<th>ebookCompany</th>
			<td><input type="text" name="ebookCompany" id="ebookCompany"></td>
		</tr>
		<tr>
			<th>ebookPageCount</th>
			<td><input type="text" name="ebookPageCount" id="ebookPageCount"></td>
		</tr>
		<tr>
			<th>ebookPrice</th>
			<td><input type="text" name="ebookPrice" id="ebookPrice"></td>
		</tr>
		<tr>
			<th>ebookSummary</th>
			<td><textarea name="ebookSummary" id="ebookSummary"></textarea></td>
		</tr>
		<tr>
			<th>ebookState</th>
			<td>
				<select name="ebookState" id="ebookState">
					<option value="판매중" selected>판매중</option>
					<option value="품절">품절</option>
					<option value="절판">절판</option>
					<option value="구편절판">구편절판</option>
				</select>
			</td>
		</tr>
	</table>
	<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">뒤로가기</a>
	<button type="button" id="btn" class="btn btn-success">추가</button>
	</form>
	<script>
		$('#btn').click(function(){
			if($('#ebookISBN').val() == ''){
				alert('ebookISBN를 입력하세요.');
				return;
			}
			if($('#categoryName').val() == '') {
				alert('categoryName를 입력하세요.');
				return;
			}
			if($('#ebookTitle').val() == '') {
				alert('ebookTitle를 입력하세요.');
				return;
			}
			if($('#ebookAuthor').val() == '') {
				alert('ebookAuthor를 입력하세요.');
				return;
			}
			if($('#ebookCompany').val() == '') {
				alert('ebookCompany를 입력하세요.');
				return;
			}
			if($('#ebookPageCount').val() == '') {
				alert('ebookPageCount를 입력하세요.');
				return;
			}
			if($('#ebookSummary').val() == '') {
				alert('ebookSummary를 입력하세요.');
				return;
			}
			if($('#ebookState').val() == '') {
				alert('ebookState를 입력하세요.');
				return;
			}
			$('#insertEbookForm').submit();
		});
	</script>
</div>
</body>
</html>