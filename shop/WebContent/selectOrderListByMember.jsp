<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | selectOrderListByMember.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인한 회원만 접속 가능
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(loginMember.getMemberNo());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectOrderListByMember.jsp</title>
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
		<h1>[회원&관리자] 주문한 상품 조회</h1>
		<p>상품의 상세내역 조회, 상품 후기 작성 가능</p>
	</div>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>orderNo</th>
				<th>ebookTitle</th>
				<th>orderPrice</th>
				<th>createDate</th>
				<th>memberId</th>
				<th>상세주문내역</th>
				<th>ebook후기</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderEbookMember oem : list) {
			%>
					<tr>
						<td><%=oem.getOrder().getOrderNo()%></td>
						<td><%=oem.getEbook().getEbookTitle()%></td>
						<td><%=oem.getOrder().getOrderPrice()%></td>
						<td><%=oem.getOrder().getOrderDate()%></td>
						<td><%=oem.getMember().getMemberId()%></td>
						<td><a href="">상세주문내역</a>
						<td><a href="<%=request.getContextPath()%>/insertOrderCommentFrom.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>">ebook후기</a>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</div>
</body>
</html>