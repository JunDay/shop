<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] insertMemberAction.jsp | Start");
	
	// 방어코드 : 로그인 상태에서 페이지 접근 불가
	if(session.getAttribute("loginmMmber") != null){
		response.sendRedirect("./index.jsp");
		return;
	}
	
	// 유효성 검사 : 누락된 사항 검사
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null || request.getParameter("memberAge") == null || request.getParameter("memberGender") == null){
		response.sendRedirect("./insertMemberForm.jsp");
		return;
	}

	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("") || request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("")){
		response.sendRedirect("./insertMemberForm.jsp");
		return;
	}
	
	// 입력받은 값을 변수에 대입
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	
	System.out.println("*[Debug] " + memberId + " <-- insertMemberAction.jsp/memberId");
	System.out.println("*[Debug] " + memberPw + " <-- insertMemberAction.jsp/memberPw");
	System.out.println("*[Debug] " + memberName + " <-- insertMemberAction.jsp/memberName");
	System.out.println("*[Debug] " + memberAge + " <-- insertMemberAction.jsp/memberAge");
	System.out.println("*[Debug] " + memberGender + " <-- insertMemberAction.jsp/memberGender");
	
	// MemberDao에 있는 insertMember() 메서드를 위한 객체 생성
	Member member = new Member();
	
	// member 객체에 데이터 삽입
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	
	// insertMemberDao() 실행
	MemberDao memberDao = new MemberDao();
	memberDao.insertMember(member);
	
	// 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/index.jsp");
%>