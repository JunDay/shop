<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | admin/selectOrderlist.jsp");
	
	// 0-1. 로그인된 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 0-3. 페이지 번호 확인
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) { 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 0-4. 선택된 ebook 카테고리 확인
	String ebookCategory = "";
	if(request.getParameter("ebookCategory") != null) {
		ebookCategory = request.getParameter("ebookCategory");
	}
	
	// 1-1. 한 페이지당 보여줄 값 설정(상수)
	final int ROW_PER_PAGE = 10;
	// 1-2. 보여줄 시작 페이지 번호 설정
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	// 2. 주문 목록을 조회 및 반환받을 객체 생성
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = new ArrayList<OrderEbookMember>();
	
	list = orderDao.selectOrderList(currentPage, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectOrderList.jsp</title>
</head>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[관리자] 회원 주문 목록 출력</h1>
		<p>회원들의 전자책 주문 목록 표시</p>
	</div>
	
	<h1>주문 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>orderNo</th>
				<th>ebookTitle</th>
				<th>orderPrice</th>
				<th>orderDate</th>
				<th>memberId</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderEbookMember oem : list){
			%>
					<tr>
						<td><a href="<%=request.getContextPath()%>/admin/selectOrderOneByAdmin.jsp?orerNo=<%=oem.getOrder().getOrderNo() %>"><%=oem.getOrder().getOrderNo() %></a></td>
						<td><%=oem.getEbook().getEbookTitle() %></td>
						<td><%=oem.getOrder().getOrderPrice() %></td>
						<td><%=oem.getOrder().getOrderDate() %></td>
						<td><%=oem.getMember().getMemberId() %></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<!-- 6. 페이징 출력 -->
	<%
	// 6-1. 총 ebook의 수
	int totalCount = orderDao.totalOrderCount();
	System.out.println(" [Debug] totalCount : \""+totalCount +"\" | selectOrderList.jsp | RETRUNED BY orderDao.totalOrderCount()");
	
	// 6-2. 마지막 페이지 수
	int lastPage = totalCount / ROW_PER_PAGE;
	if(totalCount % ROW_PER_PAGE != 0) {
		lastPage+=1;
	}
	System.out.println(" [Debug] lastPage : \""+lastPage +"\" | selectOrderList.jsp");
	
	// 6-3. 화면에 보여질 페이지 번호의 갯수
	int displayPage = 10;
	
	// 6-4. 화면에 보여질 시작 페이지 번호
	int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
	System.out.println(" [Debug] startPage : \""+startPage +"\" | selectOrderList.jsp");
	
	// 6-5. 화면에 보여질 마지막 페이지 번호
	int endPage = startPage + displayPage - 1;
	System.out.println(" [Debug] endPage : \""+endPage +"\" | selectOrderList.jsp");
	
	
	// 6-6. 이전 버튼 출력
	if(startPage > displayPage){
	%>
		<a href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=startPage-displayPage%>">이전</a>
	<%
	}

	// 6-7. 페이지 번호 버튼
	for(int i=startPage; i<=endPage; i++) {
		if(i<lastPage){
	%>
			<a href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=i%>"><%=i%></a>
	<%
		} else if(endPage>lastPage){
	%>
			<a href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=i%>"><%=i%></a>
	<%	
			break;
		}
	}
	
	// 6-8. 다음 버튼
	if(endPage < lastPage){
	%>
		<a href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=startPage+displayPage%>">다음</a>
	<%
	}
	%>
</div>
</body>
</html>