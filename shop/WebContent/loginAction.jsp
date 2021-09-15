<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] loginAction.jsp | Start");
	
	// 1. loginForm.jsp에서 입력받은 Id, Pw 값 변수에 대입 및 디버깅
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	System.out.println("*[Debug] " + memberId + " <-- loginAction.jsp | param : memberId");
	System.out.println("*[Debug] " + memberPw + " <-- loginAction.jsp | param : memberPw");
	
	// 2. DB에 접근하기 위한 MemberDao와 MemberDao의 매개변수에 넣어주기 위해 Member 객체 생성
	MemberDao memberDao = new MemberDao();
	Member paramMember = new Member();
	
	// 2-1. 입력받은 로그인 정보를 객체에 삽입
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 3. memberDao.login 실행
	Member returnMebmer = memberDao.login(paramMember);
	
	// 3-1. 실행 결과 출력
	if(returnMebmer == null) {
		System.out.println("**[Debug] loginAction.jsp | 로그인 실패");
		response.sendRedirect("./loginForm.jsp");
		return;
	} else {
		System.out.println("**[Debug] loginAction.jsp | 로그인 성공");
		// ***입력받은 정보로 loginMember라는 세션 생성
		session.setAttribute("loginMember", returnMebmer);
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}
	
	
%>