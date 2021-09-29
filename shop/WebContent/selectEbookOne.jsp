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
		%>
		<table border="1">
			<tr>
				<td rowspan="3"><img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg() %>" width="200" height="200"></td>
				<td><%=ebook.getEbookTitle()%></td>
			</tr>
			<tr>
				<td><%=ebook.getEbookAuthor()%></td>
			</tr>
			<tr>
				<td>₩ <%=ebook.getEbookPrice()%></td>
			</tr>
		</table>
	</div>



	<!-- 주문 입력하는 폼 -->
	<div>
		<h2>전자책 주문</h2>
		
		<%			
			// 0-2. 방어 코드 : 로그인한 회원만 접속 가능
			if(loginMember == null){
		%>
			<div>
				로그인 후에 주문이 가능합니다.
				<a href="<%=request.getContextPath()%>/loginForm.jsp">로그인 페이지로 이동</a>
			</div>
		<%
			} else {
		%>
		<form method="post" action="<%=request.getContextPath()%>/insertOrderAction.jsp">
			<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
			<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
			<input type="hidden" name="ebookPrice" value="<%=ebook.getEbookPrice()%>">
			<button type="submit">주문하기</button>
		</form>
		<%
			}
		%>
	</div>
		
	<!-- 이 상품의 별점의 평균, 후기(페이징) -->
	<!-- SELECT AVG(order_score) FROM order_comment WHERE ebook_no=? ORDER BY ebook_no -->
	<!--  SELECT * FROM order_comment WHERE ebook_no=? LIMIT ?, ? -->
	<div>
		<div>
			<%
				OrderCommentDao orderCommentDao = new OrderCommentDao();
				double avgScore = orderCommentDao.selectOrderScoreAvg(ebookNo);
			%>
			별점 평균 : <%=avgScore %>
		</div>
		<div>
			<h2>후기 목록</h2>
				<table>
					<tr>
						<td>GRADE</td>
						<td>COMMENT</td>
						<td>DATE</td>
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
					<a href="<%=request.getContextPath()%>/selectEbookOne?commentPage=<%=startPage-displayPage%>&ebookNo=<%=ebookNo%>">이전</a>
				<%
				}
			
				// 6-7. 페이지 번호 버튼
				for(int i=startPage; i<=endPage; i++) {
					if(i<lastPage){
				%>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?commentPage=<%=i%>&ebookNo=<%=ebookNo%>"><%=i%></a>
				<%
					} else if(endPage>lastPage){
				%>
						<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?commentPage=<%=i%>&ebookNo=<%=ebookNo%>"><%=i%></a>
				<%	
						break;
					}
				}
				
				// 6-8. 다음 버튼
				if(endPage < lastPage){
				%>
					<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?commentPage=<%=startPage+displayPage%>&ebookNo=<%=ebookNo%>">다음</a>
				<%
				}
				%>
		</div>
	</div>
</div>
</body>
</html>