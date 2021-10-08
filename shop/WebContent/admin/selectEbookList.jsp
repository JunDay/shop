<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/selectEbookList.jsp");
	
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
	
	// 2. 카테고리 목록 조회
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectEbookList.jsp</title>
</head>
<div class="container">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<a class="navbar-brand btn btn-primary" href="<%=request.getContextPath()%>/index.jsp">Main</a>
		<!-- start : submenu include -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		<!-- end : submenu include -->
	</nav>
	
	<div class="jumbotron">
		<h1>[관리자] 전자책 목록</h1>
		<p>전자책 목록 표시</p>
	</div>
	
	<!-- 3. 카테고리 목록 출력, 카레고리 선택 후 검색 버튼 클릭 시 해당 카테고리 선택 -->
	<form method="get" action="<%=request.getContextPath()%>/admin/selectEbookList.jsp">
		<select name="ebookCategory">
			<option value="">전체목록</option>
			<%
				for(Category c : categoryList) {
			%>
				<option value="<%=c.getCategoryName()%>"><%=c.getCategoryName()%></option>
			<%
				}
			%>
		</select>
		<button type="submit" class="btn btn-success">검색</button>
	
	<!-- 4. ebook 목록 조회 -->
	<%
		EbookDao ebookDao = new EbookDao();
		ArrayList<Ebook> ebookList = null;
		
		
		if(ebookCategory.equals("") == true) { // 선택된 카테고리가 없을 시
			ebookList = ebookDao.selectEbookList(currentPage, 10);
		} else { // 선택된 카테고리가 있을 시
			ebookList = ebookDao.selectEbookListByPage(currentPage, 10, ebookCategory);
		}
	%>
	
	<!-- 5. ebook 목록 출력 -->
	<table class="table table-striped">
		<thead>
			<tr>
				<th>ebookNo</th>
				<th>categoryName</th>
				<th>ebookTitle</th>
				<th>ebookState</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Ebook e : ebookList) {
		%>
				<tr>
					<td><%=e.getEbookNo()%></td>
					<td><%=e.getCategoryName()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></td>
					<td><%=e.getEbookState()%></td>
				</tr>
		<%		
			}
		%>
		</tbody>
	</table>
	</form>
	<!-- 6. 페이징 출력 -->
	<div align="center" style="margin:30px;">
	<%
	// 6-1. 총 ebook의 수
	int totalCount = ebookDao.totalEbookCount(ebookCategory);
	System.out.println(" [Debug] totalCount : \""+totalCount +"\" | selectEbookList.jsp | RETRUNED BY ebookDao.totalEbookCount()");
	
	// 6-2. 마지막 페이지 수
	int lastPage = totalCount / ROW_PER_PAGE;
	if(totalCount % ROW_PER_PAGE != 0) {
		lastPage+=1;
	}
	System.out.println(" [Debug] lastPage : \""+lastPage +"\" | selectEbookList.jsp");
	
	// 6-3. 화면에 보여질 페이지 번호의 갯수
	int displayPage = 10;
	
	// 6-4. 화면에 보여질 시작 페이지 번호
	int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
	System.out.println(" [Debug] startPage : \""+startPage +"\" | selectEbookList.jsp");
	
	// 6-5. 화면에 보여질 마지막 페이지 번호
	int endPage = startPage + displayPage - 1;
	System.out.println(" [Debug] endPage : \""+endPage +"\" | selectEbookList.jsp");
	
	
	// 6-6. 이전 버튼 출력
	if(startPage > displayPage){
	%>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=startPage-displayPage%>&ebookCategory=<%=ebookCategory%>">이전</a>
	<%
	}

	// 6-7. 페이지 번호 버튼
	for(int i=startPage; i<=endPage; i++) {
		if(i<lastPage){
	%>
			<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&ebookCategory=<%=ebookCategory%>"><%=i%></a>
	<%
		} else if(endPage>lastPage){
	%>
			<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&ebookCategory=<%=ebookCategory%>"><%=i%></a>
	<%	
			break;
		}
	}
	
	// 6-8. 다음 버튼
	if(endPage < lastPage){
	%>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=startPage+displayPage%>&ebookCategory=<%=ebookCategory%>">다음</a>
	<%
	}
	%>
	</div>
</div>
</body>
</html>