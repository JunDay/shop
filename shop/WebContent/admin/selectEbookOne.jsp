<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | admin/selectEbookOne.jsp");
	
	// 0-1. 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 0-3. 선택한 ebook의 ebookNo 확인
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectEbookOne.jsp</title>
</head>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	<div class="jumbotron">
		<h1>[관리자] 전자책 상세보기</h1>
		<p>선택한 전자책 상세정보 표시</p>
	</div>
	
	<%
		// 1. 선택한 ebook의 상세정보 조회
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>
	<div align="right" style="margin:20px;">
		<a class="btn btn-success" href="">전자책추가</a>
		<a class="btn btn-warning" href="">가격수정</a>
		<a class="btn btn-primary" href="<%=request.getContextPath()%>/admin/updateEbookImgForm.jsp?ebookNo=<%=ebook.getEbookNo()%>">이미지수정</a>
		<a class="btn btn-danger" href="">삭제</a>
	</div>
	
	<table class="table">
		<tr>
			<td colspan="4"><h2><%=ebook.getEbookTitle()%></h2></td>
		</tr>
		<tr>
			<th>ebookNo</th>
			<td><%=ebook.getEbookNo()%></td>
			<td align="center" colspan="2" rowspan="4"><img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>" width="250" height="250"></td>
		</tr>
		<tr>
			<th>ebookISBN</th>
			<td><%=ebook.getEbookISBN()%></td>
		</tr>
		<tr>
			<th>categoryName</th>
			<td><%=ebook.getCategoryName()%></td>
		</tr>
		<tr>
			<th>ebookState</th>
			<td><%=ebook.getEbookState()%></td>
		</tr>
		<tr>
			<th>ebookTitle</th>
			<td><%=ebook.getEbookTitle()%></td>
			<th>ebookSummary</th>
			<td><%=ebook.getEbookSummary()%></td>
		</tr>
		<tr>
			<th>ebookAuthor</th>
			<td><%=ebook.getEbookAuthor()%></td>
			<th>ebookPageCount</th>
			<td><%=ebook.getEbookPageCount()%></td>
		</tr>
		<tr>
			<th>ebookCompany</th>
			<td><%=ebook.getEbookCompany()%></td>
			<th>createDate</th>
			<td><%=ebook.getCreateDate()%></td>
		</tr>
		<tr>
			<th>ebookPrice</th>
			<td><%=ebook.getEbookPrice()%></td>
			<th>updateDate</th>
			<td><%=ebook.getUpdateDate()%></td>
		</tr>
	</table>
	<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">뒤로가기</a>
</div>
</body>
</html>