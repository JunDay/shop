<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | insertOrderCommentFrom.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인한 회원만 접속 가능
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 전달받은 orderNo, ebookNo 대입
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	System.out.println(" [Debug] orderNo : \""+orderNo +"\" | insertOrderCommentFrom.jsp FROM selectOrderListByMember.jsp");
	System.out.println(" [Debug] ebookNo : \""+ebookNo +"\" | insertOrderCommentFrom.jsp FROM selectOrderListByMember.jsp");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>insertOrderCommentFrom.jsp</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<a class="navbar-brand btn btn-secondary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
	<!-- start : submenu include -->
	<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[회원&관리자] 상품후기 입력 페이지</h1>
		<p>상품에 대한 후기 등록</p>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/insertOrderCommentAction.jsp">
		<table class="table table-striped">
			<tr>
				<td colspan="2"><h2>상품후기 입력</h2></td>
			</tr>
			<tr>
				<td>orderNo</td>
				<td><input type="text" name="orderNo" readonly="readonly" value="<%=orderNo%>"></td>
			</tr>
			<tr>
				<td>ebookNo</td>
				<td><input type="text" name="ebookNo" readonly="readonly" value="<%=ebookNo%>"></td>
			</tr>
			<tr>
				<td>orderScore</td>
				<td>
					<input type="radio" name="orderScore" value="1">1
					<input type="radio" name="orderScore" value="2">2
					<input type="radio" name="orderScore" value="3">3
					<input type="radio" name="orderScore" value="4">4
					<input type="radio" name="orderScore" value="5">5
				</td>
			</tr>
			<tr>
				<td>상품 후기</td>
				<td><textarea rows="3" cols="35" name="orderCommentContent" placeholder="상품후기 입력"></textarea></td>
			</tr>
		</table>
		<a class="btn btn-info" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">뒤로가기</a>
		<button class="btn btn-success" type="submit">후기 입력</button>
	</form>
</div>
</body>
</html>