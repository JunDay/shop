<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | selectQnaList.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	QnaDao qnaDao = new QnaDao();
	
	// fc 페이지번호 확인
	int currentNCPage = 0;
	if(request.getParameter("currentNCPage") != null) { 
		currentNCPage = Integer.parseInt(request.getParameter("currentNCPage"));
	}
	// 한 페이지당 보여줄 값 설정(상수)
	final int NC_ROW_PER_PAGE = 5;
	// 보여줄 시작 페이지 번호 설정
	int beginNCRow = (currentNCPage-1)*NC_ROW_PER_PAGE;
	
	// nc 페이지번호 확인
	int currentFCPage = 0;
	if(request.getParameter("currentFCPage") != null) { 
		currentFCPage = Integer.parseInt(request.getParameter("currentFCPage"));
	}
	// 한 페이지당 보여줄 값 설정(상수)
	final int FC_ROW_PER_PAGE = 5;
	// 보여줄 시작 페이지 번호 설정
	int beginFCRow = (currentFCPage-1)*FC_ROW_PER_PAGE;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectQnaList.jsp</title>
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
		<h1>[관리자] Q&A 목록 출력, 답변 유무</h1>
		<p>Q&A 목록 출력</p>
	</div>
	<h2>답변이 필요한 Q&A</h2>
	<table class="table table-borderless" width="90%">
		<tr>
			<th>qnaNo</th>
			<th>qnaCategory</th>
			<th>qnaTitle</th>
			<th>memberName</th>
			<th>qnaSecret</th>
			<th>createDate</th>
		<tr>
		<%
			ArrayList<Qna> qnaNeedCommentList = qnaDao.selectQnaListNeedComment(currentNCPage, NC_ROW_PER_PAGE);
			
			
			int i=0;
			for(Qna q : qnaNeedCommentList){
		%>
			<td><%=q.getQnaNo()%></td>
			<td><%=q.getQnaCategory()%></td>
			<td><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
			<td><%=q.getMemberName() %></td>
			<td><%=q.getQnaSecret() %></td>
			<td><%=q.getCreateDate() %></td>
			<tr></tr>
		<%
			}
		%>
		</tr>
	</table>
		<!-- 6. 페이징 출력 -->
	<div align="center" style="margin:30px;">
	<%
	// 6-1. 총 ebook의 수
	int totalNCCount = qnaDao.totalQnaNeedCommentCount();
	System.out.println(" [Debug] totalNCCount : \""+totalNCCount +"\" | selectQnaListByAdmin.jsp");
	
	// 6-2. 마지막 페이지 수
	int lastNCPage = totalNCCount / NC_ROW_PER_PAGE;
	if(totalNCCount % NC_ROW_PER_PAGE != 0) {
		lastNCPage+=1;
	}
	System.out.println(" [Debug] lastNCPage : \""+lastNCPage +"\" | selectQnaListByAdmin.jsp");
	
	// 6-3. 화면에 보여질 페이지 번호의 갯수
	int displayNCPage = 10;
	
	// 6-4. 화면에 보여질 시작 페이지 번호
	int startNCPage = ((currentNCPage - 1) / displayNCPage) * displayNCPage + 1;
	System.out.println(" [Debug] startNCPage : \""+startNCPage +"\" | selectQnaListByAdmin.jsp");
	
	// 6-5. 화면에 보여질 마지막 페이지 번호
	int endNCPage = startNCPage + displayNCPage - 1;
	System.out.println(" [Debug] endNCPage : \""+endNCPage +"\" | selectQnaListByAdmin.jsp");
	
	
	// 6-6. 이전 버튼 출력
	if(startNCPage > displayNCPage){
	%>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectQnaListByAdmin.jsp?currentNCPage=<%=startNCPage-displayNCPage%>&currentFCPage=<%=currentFCPage%>">이전</a>
	<%
	}

	// 6-7. 페이지 번호 버튼
	for(int j=startNCPage; j<=endNCPage; j++) {
		if(j<lastNCPage){
	%>
			<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectQnaListByAdmin.jsp?currentNCPage=<%=j%>&currentFCPage=<%=currentFCPage%>"><%=j%></a>
	<%
		} else if(endNCPage>lastNCPage){
	%>
			<a class="btn btn-secondary" href="<%=request.getContextPath()%>/admin/selectQnaListByAdmin.jsp?currentNCPage=<%=j%>&currentFCPage=<%=currentFCPage%>"><%=j%></a>
	<%	
			break;
		}
	}
	
	// 6-8. 다음 버튼
	if(endNCPage < lastNCPage){
	%>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectQnaListByAdmin.jsp?currentNCPage=<%=startNCPage+displayNCPage%>&currentFCPage=<%=currentFCPage%>">다음</a>
	<%
	}
	%>
	</div>
	<h2>답변 완료한 Q&A</h2>
	<table class="table table-borderless" width="90%">
		<tr>
			<th>qnaNo</th>
			<th>qnaCategory</th>
			<th>qnaTitle</th>
			<th>memberName</th>
			<th>qnaSecret</th>
			<th>createDate</th>
		<tr>
		<%
			ArrayList<Qna> qnaFinishedCommentList = qnaDao.selectQnaListFinishedComment(currentFCPage, FC_ROW_PER_PAGE);
			
			
			i=0;
			for(Qna q : qnaFinishedCommentList){
		%>
			<td><%=q.getQnaNo()%></td>
			<td><%=q.getQnaCategory()%></td>
			<td><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
			<td><%=q.getMemberName() %></td>
			<td><%=q.getQnaSecret() %></td>
			<td><%=q.getCreateDate() %></td>
			<tr></tr>
		<%
			}
		%>
		</tr>
	</table>
</div>
</body>
</html>