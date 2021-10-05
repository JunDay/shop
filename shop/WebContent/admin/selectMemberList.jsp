<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | selectMemberList.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 한 상태에서는 들어올 수 없다.
		// 로그인 정보가 null 이거나 memberLevel이 1보다 낮으면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 검색어 설정
	String searchMemberId = "";
	if(request.getParameter("searchMemberId") != null){
		searchMemberId = request.getParameter("searchMemberId");
	}
	System.out.println("*[Debug] " + searchMemberId +" <-- selectMemberList.jsp/searchMemberId");
	
	// 2. 현재 페이지 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("*[Debug] " + currentPage +" <-- selectMemberList.jsp/currentPage");
	
	// 1-2. 한 페이지당 보여줄 값 설정(상수)
	final int ROW_PER_PAGE = 10; // 상수 <- 스네이크 표현식으로
	// 1-3. 보여줄 시작 페이지 번호 설정
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	MemberDao memberDao = new MemberDao();
	
	// 2. 검색어에 따른 
	ArrayList<Member> memberList = null;
	
	if(searchMemberId.equals("") == true){ // 검색어가 없는 경우
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
	} else { // 검색어가 있는 경우
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, searchMemberId);
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectMemerList.jsp</title>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[관리자] 회원목록 출력</h1>
		<p>회원관리하기 위해 회원목록 출력하는 페이지</p>
	</div>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<td>memberNo</td>
				<td>memberId</td>
				<td>memberLevel</td>
				<td>memberName</td>
				<td>memberGender</td>
				<td>updateDate</td>
				<td>createDate</td>
				
			</tr>
		</thead>
		<tbody>
			<%
				for(Member m : memberList){
			%>
					<tr>
						<td><a href="<%=request.getContextPath()%>/selectMemberOne.jsp?memberNo=<%=m.getMemberNo()%>"><%=m.getMemberNo()%></a></td>
						<td><%=m.getMemberId()%></td>
						<td>
							<%=m.getMemberLevel()%>
							<%
								if(m.getMemberLevel() == 0){
							%>
									<span>일반회원</span>
							<%
								} else if(m.getMemberLevel() == 1){
							%>
									<span>관리자</span>
							<%
								}
							%>
						</td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getMemberGender()%></td>
						<td><%=m.getUpdateDate()%></td>
						<td><%=m.getCreateDate()%></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<div align="center" style="margin:30px;">
<%
	// 1. 총 회원의 수
	int totalCount = memberDao.totalMemberCount(searchMemberId);
	System.out.println(" [Debug] totalCount : \""+totalCount +"\" | selectMemberList.jsp | RETRUNED BY memberDao.totalMemberCount()");

	// 4. 마지막 페이지 수
	int lastPage = totalCount / ROW_PER_PAGE;
	if(totalCount % ROW_PER_PAGE != 0) {
		lastPage+=1;
	}
	System.out.println(" [Debug] lastPage : \""+lastPage +"\" | selectMemberList.jsp");
	
	// 5. 화면에 보여질 페이지 번호의 갯수
	int displayPage = 10;
	
	// 6. 화면에 보여질 시작 페이지 번호
	int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
	System.out.println(" [Debug] startPage : \""+startPage +"\" | selectMemberList.jsp");
	
	// 7. 화면에 보여질 마지막 페이지 번호
	int endPage = startPage + displayPage - 1;
	System.out.println(" [Debug] endPage : \""+endPage +"\" | selectMemberList.jsp");
	
	
	// 8. 이전 버튼 출력
	if(startPage > displayPage){
%>
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=startPage-displayPage%>&serchMemberId=<%=searchMemberId%>">이전</a>
<%
	}

	// 9. 페이지 번호 버튼
	for(int i=startPage; i<=endPage; i++) { // 1, 10 | 10<7 -> F | 10>7
		if(i<lastPage){
	%>
		<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>&serchMemberId=<%=searchMemberId%>"><%=i%></a>
<%
		} else if(endPage>lastPage){
%>
		<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>&serchMemberId=<%=searchMemberId%>"><%=i%></a>
<%	
			break;
		}
	}
	
	// 10. 다음 버튼
	if(endPage < lastPage){
%>
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=startPage+displayPage%>&serchMemberId=<%=searchMemberId%>">다음</a>
<%
	}
%>
	</div>
	<!--  -->
	<div align="center" style="margin:30px;">
	<form action="<%=request.getContextPath()%>/admin/selectMemberList.jsp" method="get">
		memberId : 
		<input type="text" name="searchMemberId">
		<button class="btn btn-success" type="submit">검색</button>
	</form>
	</div>
</div>
</body>
</html>