<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="commons.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] selectMemberList.jsp | Start");
	
	// 0-1. 세션 정보를 가져온다.
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 한 상태에서는 들어올 수 없다.
		// 로그인 정보가 null 이거나 memberLevel이 1보다 낮으면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 현재 페이지 설정
	int currentPage = 1;
	
	// 1-1. 현재 페이지 값 가져오기
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 1-2. 한 페이지당 보여줄 값 설정(상수)
	final int ROW_PER_PAGE = 10; // 상수 <- 스네이크 표현식으로
	// 1-3. 보여줄 시작 페이지 번호 설정
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
<div>
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<h1>회원 목록</h1>
	<table border="1">
		<thead>
			<tr>
				<td>memberNo</td>
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
						<td><%=m.getMemberNo()%></td>
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
<%
	// 1. 전체 행의 수
	int totalCount = 0;
	
	// 2. DB 연결
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	// 3. 전체 데이터의 개수를 알아내는 쿼리 작성 및 실행
	PreparedStatement stmt = conn.prepareStatement("SELECT count(*) FROM member");
	ResultSet rs = stmt.executeQuery();
	
	// 3-1. totalCount 대입
	if(rs.next()) {
		totalCount = rs.getInt("COUNT(*)");
	}
	System.out.println("*[Debug] " + totalCount +" <-- selectMemberList.jsp/totalCount");
	
	// 4. 마지막 페이지 수
	int lastPage = totalCount / ROW_PER_PAGE;
	if(totalCount % ROW_PER_PAGE != 0) {
		lastPage+=1;
	}
	System.out.println("*[Debug] " + lastPage +" <-- selectMemberList.jsp/lastPage");
	
	// 5. 화면에 보여질 페이지 번호의 갯수
	int displayPage = 10;
	
	// 6. 화면에 보여질 시작 페이지 번호
	int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
	System.out.println("*[Debug] " + startPage +" <-- selectMemberList.jsp/startPage");
	
	// 7. 화면에 보여질 마지막 페이지 번호
	int endPage = startPage + displayPage - 1;
	System.out.println("*[Debug] " + endPage +" <-- selectMemberList.jsp/endPage");
	
	
	// 8. 이전 버튼 출력
	if(startPage > displayPage){
%>
	<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=startPage-displayPage%>">이전</a>
<%
	}

	// 9. 페이지 번호 버튼
	for(int i=startPage; i<=endPage; i++) {
		if(endPage<lastPage){
	%>
		<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>"><%=i%></a>
<%
		} else if(endPage>lastPage){
%>
		<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>"><%=i%></a>
<%	
			break;
		}
	}
	
	// 10. 다음 버튼
	if(endPage < lastPage){
%>
	<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=startPage+displayPage%>">다음</a>
<%
	}
%>
</div>
</body>
</html>