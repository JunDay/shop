<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] insertMemberAction.jsp | Start");
	
//로그인 상태에서 페이지 접근 불가
	if(session.getAttribute("loginmMmber") != null){
		// 다시 브라우저에게 다른 곳을 요청하도록 하는 메서드, 어디로 보내는 것이 아니다
		response.sendRedirect("./index.jsp");
		return;
	}

	// 회원가입 입력값 유효성 검사
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null || request.getParameter("memberAge") == null || request.getParameter("memberGender") == null){
		// 다시 브라우저에게 다른 곳을 요청하도록 하는 메서드, 어디로 보내는 것이 아니다
		response.sendRedirect("./insertMemberForm.jsp");
		return;
	}

	// 회원가입 입력값 유효성 검사
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("") || request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("")){
		// 다시 브라우저에게 다른 곳을 요청하도록 하는 메서드, 어디로 보내는 것이 아니다
		response.sendRedirect("./insertMemberForm.jsp");
		return;
	}

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
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	
	MemberDao memberDao = new MemberDao();
	memberDao.insertMember(member);
%>