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
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
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
		<h1>[관리자] 전자책 주문 상세보기</h1>
		<p>선택한 전자책 주문 상세정보</p>
	</div>
	
	<%
		// 1. 선택한 ebook의 상세정보 조회
		OrderDao orderDao = new OrderDao();
		OrderEbookMember oem = orderDao.selectOrderOneByAdmin(orderNo);
		System.out.println(oem.toString());
	%>
	
	<table class="table">
		<tr>
			<td colspan="4"><h2>주문정보(<%=oem.getOrder().getOrderNo()%>)</h2></td>
		</tr>
		<tr>
			<th>orderNo</th>
			<td><%=oem.getOrder().getOrderNo()%></td>
			<th>orderPrice</th>
			<td><%=oem.getOrder().getOrderPrice()%></td>
		</tr>
		<tr>
			<th>orderDate</th>
			<td><%=oem.getOrder().getOrderDate()%></td>
			<th>updateDate</th>
			<td><%=oem.getOrder().getUpdateDate()%></td>
		</tr>
		<tr>
			<td colspan="4"><h2>회원정보(<%=oem.getMember().getMemberNo()%>)</h2></td>
		</tr>
		<tr>
			<th>memberNo</th>
			<td><%=oem.getMember().getMemberNo()%></td>
			<th>memberId</th>
			<td><%=oem.getMember().getMemberId()%></td>
		</tr>
		<tr>
			<th>memberName</th>
			<td><%=oem.getMember().getMemberName()%></td>
			<th>memberLevel</th>
			<td><%=oem.getMember().getMemberLevel()%></td>
		</tr>
		<tr>
			<th>memberAge</th>
			<td><%=oem.getMember().getMemberAge()%></td>
			<th>memberGender</th>
			<td><%=oem.getMember().getMemberGender()%></td>
		</tr>
		<tr>
			<td colspan="4"><h2>전자책정보(<%=oem.getOrder().getEbookNo()%>)</h2></td>
		</tr>
		<tr>
			<th>ebookNo</th>
			<td><%=oem.getOrder().getEbookNo()%></td>
			<td align="center" colspan="2" rowspan="4"><img src="<%=request.getContextPath()%>/image/<%=oem.getEbook().getEbookImg()%>" width="250" height="250"></td>
		</tr>
		<tr>
			<th>categoryName</th>
			<td><%=oem.getEbook().getCategoryName()%></td>
		</tr>
		<tr>
			<th>ebookTitle</th>
			<td><%=oem.getEbook().getEbookTitle()%></td>
		</tr>
		<tr>
			<th>ebookState</th>
			<td><%=oem.getEbook().getEbookState()%></td>
		</tr>
		<tr>
			<th>ebookAuthor</th>
			<td><%=oem.getEbook().getEbookAuthor()%></td>
			<th>ebookCompany</th>
			<td><%=oem.getEbook().getEbookCompany()%></td>
		</tr>
	</table>
	<a class="btn btn-info" href="<%=request.getContextPath()%>/admin/selectOrderListByAdmin.jsp">뒤로가기</a>
</div>
</body>
</html>