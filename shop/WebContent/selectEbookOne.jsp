<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | selectEbookOne.jsp");
	
	// 1. 넘겨받은 값 확인
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 2. 현재 페이지 설정
	int commentPage = 1;
	if(request.getParameter("commentPage") != null){
		commentPage = Integer.parseInt(request.getParameter("commentPage"));
	}
	System.out.println(" [Debug] commentPage : \""+commentPage +"\" | selectEbookOne.jsp");
	
	// 1-2. 한 페이지당 보여줄 값 설정(상수)
	final int ROW_PER_PAGE = 5; // 상수 <- 스네이크 표현식으로
	// 1-3. 보여줄 시작 페이지 번호 설정
	int beginRow = (commentPage-1)*ROW_PER_PAGE;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectEbookOne.jsp</title>
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
		<h1>[공통] 선택 상품 상세조회</h1>
		<p></p>
	</div>
	
	<!-- 상품정보 상세출력 -->
	<div>
		<h2>상품 정보</h2>
		<%
			EbookDao ebookDao = new EbookDao();
			Ebook ebook = ebookDao.selectEbookOne(ebookNo);
			
			OrderCommentDao orderCommentDao = new OrderCommentDao();
			double avgScore = orderCommentDao.selectOrderScoreAvg(ebookNo);
		%>
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
			<th>평균 별점</th>
			<td><%=avgScore%></td>
		</tr>
	</table>
	</div>

	<!-- 주문 입력하는 폼 -->
	<div>		
		<%			
			// 0-2. 방어 코드 : 로그인한 회원만 접속 가능
			if(loginMember == null){
		%>
			<div style="margin:20px;">
				로그인 후에 주문이 가능합니다.<br>
				<a class="btn btn-info" href="<%=request.getContextPath()%>/loginForm.jsp">로그인 페이지로 이동</a>
			</div>
		<%
			} else {
		%>
		<form method="post" action="<%=request.getContextPath()%>/insertOrderAction.jsp">
			<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
			<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
			<input type="hidden" name="ebookPrice" value="<%=ebook.getEbookPrice()%>">
			<button style="margin:20px;" class="btn btn-primary" type="submit">주문하기</button>
		</form>
		<%
			}
		%>
	</div>
		
	<!-- 이 상품의 별점의 평균, 후기(페이징) -->
	<!-- SELECT AVG(order_score) FROM order_comment WHERE ebook_no=? ORDER BY ebook_no -->
	<!--  SELECT * FROM order_comment WHERE ebook_no=? LIMIT ?, ? -->
	<div>
		<h2>후기 목록</h2>
			<table class="table table-striped">
				<tr>
					<th>order_score</th>
					<th>order_comment_content</th>
					<th>create_date</th>
				</tr>
				<%
					ArrayList<OrderComment> commentList = new ArrayList<OrderComment>();
					commentList = orderCommentDao.selectCommentList(beginRow, ROW_PER_PAGE, ebookNo);
					
					for(OrderComment c : commentList) {
				%>
						<tr>
							<td><%=c.getOrderScore()%></td>
							<td><%=c.getOrderCommentContent()%></td>
							<td><%=c.getCreateDate()%></td>
						</tr>
				<%
					}
				%>
			</table>
			
			<div align="center" style="margin:30px;">
				<%
				// 6-1. 총 ebook의 수
				int totalCount = orderCommentDao.totalCommentCount();
				System.out.println(" [Debug] totalCount : \""+totalCount +"\" | selectEbookOne.jsp | RETRUNED BY orderCommentDao.totalCommentCount()");
				
				// 6-2. 마지막 페이지 수
				int lastPage = totalCount / ROW_PER_PAGE;
				if(totalCount % ROW_PER_PAGE != 0) {
					lastPage+=1;
				}
				System.out.println(" [Debug] lastPage : \""+lastPage +"\" | selectEbookOne.jsp");
				
				// 6-3. 화면에 보여질 페이지 번호의 갯수
				int displayPage = 10;
				
				// 6-4. 화면에 보여질 시작 페이지 번호
				int startPage = ((commentPage - 1) / displayPage) * displayPage + 1;
				System.out.println(" [Debug] startPage : \""+startPage +"\" | selectEbookOne.jsp");
				
				// 6-5. 화면에 보여질 마지막 페이지 번호
				int endPage = startPage + displayPage - 1;
				System.out.println(" [Debug] endPage : \""+endPage +"\" | selectEbookOne.jsp");
				
				
				// 6-6. 이전 버튼 출력
				if(startPage > displayPage){
				%>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectEbookOne?commentPage=<%=startPage-displayPage%>&ebookNo=<%=ebookNo%>">이전</a>
				<%
				}
			
				// 6-7. 페이지 번호 버튼
				for(int i=startPage; i<=endPage; i++) {
					if(i<lastPage){
				%>
						<a class="btn btn-secondary" href="<%=request.getContextPath()%>/selectEbookOne.jsp?commentPage=<%=i%>&ebookNo=<%=ebookNo%>"><%=i%></a>
				<%
					} else if(endPage>lastPage){
				%>
						<a class="btn btn-secondary" href="<%=request.getContextPath()%>/selectEbookOne.jsp?commentPage=<%=i%>&ebookNo=<%=ebookNo%>"><%=i%></a>
				<%	
						break;
					}
				}
				
				// 6-8. 다음 버튼
				if(endPage < lastPage){
				%>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectEbookOne.jsp?commentPage=<%=startPage+displayPage%>&ebookNo=<%=ebookNo%>">다음</a>
				<%
				}
				%>
		</div>
	</div>
</div>
</body>
</html>