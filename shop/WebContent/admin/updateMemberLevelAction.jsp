<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
System.out.println("+[Debug] \"Started\" | updateMemberLevelAction.jsp");
	
	// 0-1. 유효성 검사 : 입력된 memberLevel 값 검사
	if(request.getParameter("memberLevel") == null || request.getParameter("memberLevel").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
		return;
	}
	
	// 1. 입력받은 memberNo, memberPw 대입
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	
	System.out.println(" [Debug] memberNo : \""+memberNo +"\" | updateMemberLevelAction.jsp FROM updateMemberLevelForm.jsp");
	System.out.println(" [Debug] memberLevel : \""+memberLevel +"\" | updateMemberLevelAction.jsp FROM updateMemberLevelForm.jsp");
	
	// 2. MemberDao에 있는 updateMemberLevelByAdmin() 메서드를 위한 객체 생성
	Member member = new Member();
	
	// 2-1. member 객체에 데이터 삽입
	member.setMemberNo(memberNo);
	member.setMemberLevel(memberLevel);
	
	// 3. updateMemberLevelByAdmin() 실행
	MemberDao memberDao = new MemberDao();
	memberDao.updateMemberLevelByAdmin(member);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/selectMemberOne.jsp?memberNo="+memberNo);
%>