<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>;
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/updateEbookForm.jsp");
	
	// 0-1. 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 0-3. 선택한 ebook의 ebookNo 확인
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	System.out.println(" [Debug] ebook : \""+ebook.toString() +"\" | /adminupdateEbookForm.jsp");
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>updateEbookForm.jsp</title>
</head>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[관리자] 전자책 정보수정</h1>
		<p>선택한 전자책의 정보를 수정</p>
	</div>
	
	
	<form id="updateEbookForm" method="post" action="<%=request.getContextPath()%>/admin/updateEbookAction.jsp">
	<table class="table">
		<tr>
			<td colspan="4"><h2><%=ebook.getEbookTitle()%></h2></td>
		</tr>
		<tr>
			<th>ebookNo</th>
			<td><input name="ebookNo" id="ebookNo" type="text" value="<%=ebook.getEbookNo()%>" readonly="readonly"></td>
			<td align="center" colspan="2" rowspan="4"><img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>" width="250" height="250"></td>
		</tr>
		<tr>
			<th>ebookISBN</th>
			<td><input name="ebookISBN" id="ebookISBN" type="text" value="<%=ebook.getEbookISBN()%>"></td>
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
		<tr>
			<th>ebookTitle</th>
			<td><input name="ebookTitle" id="ebookTitle" type="text" value="<%=ebook.getEbookTitle()%>"></td>
			<th>ebookSummary</th>
			<td><input name="ebookSummary" id="ebookSummary" type="text" value="<%=ebook.getEbookSummary()%>"></td>
		</tr>
		<tr>
			<th>ebookAuthor</th>
			<td><input name="ebookAuthor" id="ebookAuthor" type="text" value="<%=ebook.getEbookAuthor()%>"></td>
			<th>ebookPageCount</th>
			<td><input name="ebookPageCount" id="ebookPageCount" type="text" value="<%=ebook.getEbookPageCount()%>"></td>
		</tr>
		<tr>
			<th>ebookCompany</th>
			<td><input name="ebookCompany" id="ebookCompany" type="text" value="<%=ebook.getEbookCompany()%>"></td>
			<th>createDate</th>
			<td><%=ebook.getCreateDate()%></td>
		</tr>
		<tr>
			<th>ebookPrice</th>
			<td><input name="ebookPrice" id="ebookPrice" type="text" value="<%=ebook.getEbookPrice()%>"></td>
			<th>updateDate</th>
			<td><%=ebook.getUpdateDate()%></td>
		</tr>
	</table>
	</form>
	<div style="margin:20px;">
		<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo%>">뒤로가기</a>
		<button type="button" id="btn" class="btn btn-warning">수정완료</button>
	</div>

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
			$('#updateEbookForm').submit();
		});
	</script>
</div>
</body>
</html>