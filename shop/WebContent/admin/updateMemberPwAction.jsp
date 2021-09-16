<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] updateMemberPwAction.jsp | Start");
	
	// 0-1. 유효성 검사 : 누락된 memberPw 값 검사
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/selectMemberList.jsp");
		return;
	}
	
	// 1. 입력받은 memberNo, memberPw 값 대입
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPw = request.getParameter("memberPw");
	
	System.out.println("*[Debug] " + memberNo + " <-- updateMemberPwAction.jsp/memberNo");
	System.out.println("*[Debug] " + memberPw + " <-- updateMemberPwAction.jsp/memberPw");
	
	// 2. MemberDao에 있는 updateMemberPwByAdmin() 메서드를 위한 객체 생성
	Member member = new Member();
	
	// 2-1. member 객체에 데이터 삽입
	member.setMemberNo(memberNo);
	member.setMemberPw(memberPw);
	
	// 3. updateMemberPwByAdmin() 실행
	MemberDao memberDao = new MemberDao();
	memberDao.updateMemberPwByAdmin(member);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>