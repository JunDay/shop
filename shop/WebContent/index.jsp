<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>shop index.jsp | 메인화면</title>

</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand btn btn-secondary" href="./index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
		<div>
	<%
		// 0. 인코딩 설정
		request.setCharacterEncoding("utf-8");
		System.out.println("+[Debug] \"Started\" | index.jsp");
		
		// 0. 로그인된 세션 확인
		if(session.getAttribute("loginMember") == null) {
	%>
			<!-- 0-1. 로그인 전 화면 출력(로그인, 회원가입 버튼)  -->
			<div>
				<a class="btn btn-info" href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a>
				<a class="btn btn-info" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
			</div>
	<%		
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
	%>
			<!-- 0-2. 로그인 후 화면 출력(로그아웃, 회원정보 버튼, ...)-->
			<div>
				<p class="text-white"><%=loginMember.getMemberName()%>님 반갑습니다.</p>
				<a class="btn btn-info" href="<%=request.getContextPath()%>/selectMemberOne.jsp?memberNo=<%=loginMember.getMemberNo()%>">회원정보</a>
				<a class="btn btn-info" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">나의 주문</a>
	<%
			// 1. 관리자 로그인 확인
			if(loginMember.getMemberLevel() > 0){ 
	%>
			<!-- 1-1. 관리자인 경우 관리자 페이지 이동 버튼 출력 -->
				<a class="btn btn-success" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a>
	<%
			}
	%>
			<a class="btn btn-danger" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
			</div>
	<%
		}
	%>
		</div>
	</nav>
	<div class="jumbotron">
		<h1>인덱스 페이지</h1>
		<p>이것저것</p>
	</div>
	<!-- 상품 목록 -->
	<%
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
		
		// 2. 전체 상품 목록 조회 메서드 실행
		EbookDao ebookDao = new EbookDao();
		ArrayList<Ebook> ebookList = ebookDao.selectEbookList(currentPage, ROW_PER_PAGE);
		
		// 3. 인기 상품 목록 조회
		ArrayList<Ebook> popularEbokList = ebookDao.selectPopularEbookList();
		
		// 4. 신상품 목록 조회
		ArrayList<Ebook> newEbookList = ebookDao.selectNewEbookList();
	%>
	<h2>신상품 목록</h2>
	<table border="1">
		<tr>
		<%
			int pi=0;
			for(Ebook e : newEbookList){
		%>
			<td>
					<div><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg() %>" width="200" height="200"></div>
					<div><%=e.getEbookTitle()%></div>
					<div>₩ <%=e.getEbookPrice()%></div>
			</td>
		<%
			}
		%>
		</tr>
	</table>
	<h2>인기 상품 목록</h2>
	<table border="1">
		<tr>
		<%
			pi=0;
			for(Ebook e : popularEbokList){
		%>
			<td>
					<div>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
							<img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg() %>" width="200" height="200">
						</a>
					</div>
					<div><%=e.getEbookTitle()%></div>
					<div>₩ <%=e.getEbookPrice()%></div>
			</td>
		<%
			}
		%>
		</tr>
	</table>
	
	<h2>전체 상품 목록</h2>
	<table border="1">
		<tr>
		<%
			pi=0;
			for(Ebook e : ebookList){
		%>
			<td>
					<div><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg() %>" width="200" height="200"></div>
					<div><%=e.getEbookTitle()%></div>
					<div>₩ <%=e.getEbookPrice()%></div>
			</td>
		<%
				pi+=1;
				if(pi%5 == 0){
		%>
					<tr></tr><!-- 줄바꿈 -->
		<%
				}
			}
		%>
		</tr>
	</table>
	<%
	// 6-1. 총 ebook의 수
	int totalCount = ebookDao.totalEbookCount(ebookCategory);
	System.out.println(" [Debug] totalCount : \""+totalCount +"\" | index.jsp | RETRUNED BY ebookDao.totalEbookCount()");
	
	// 6-2. 마지막 페이지 수
	int lastPage = totalCount / ROW_PER_PAGE;
	if(totalCount % ROW_PER_PAGE != 0) {
		lastPage+=1;
	}
	System.out.println(" [Debug] lastPage : \""+lastPage +"\" | index.jsp");
	
	// 6-3. 화면에 보여질 페이지 번호의 갯수
	int displayPage = 10;
	
	// 6-4. 화면에 보여질 시작 페이지 번호
	int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
	System.out.println(" [Debug] startPage : \""+startPage +"\" | index.jsp");
	
	// 6-5. 화면에 보여질 마지막 페이지 번호
	int endPage = startPage + displayPage - 1;
	System.out.println(" [Debug] endPage : \""+endPage +"\" | index.jsp");
	
	
	// 6-6. 이전 버튼 출력
	if(startPage > displayPage){
	%>
		<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=startPage-displayPage%>">이전</a>
	<%
	}

	// 6-7. 페이지 번호 버튼
	for(int i=startPage; i<=endPage; i++) {
		if(i<lastPage){
	%>
			<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>"><%=i%></a>
	<%
		} else if(endPage>lastPage){
	%>
			<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>"><%=i%></a>
	<%	
			break;
		}
	}
	
	// 6-8. 다음 버튼
	if(endPage < lastPage){
	%>
		<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=startPage+displayPage%>">다음</a>
	<%
	}
	%>
</div>
</body>
</html>