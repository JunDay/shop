<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("##[Debug] deleteMember.jsp | Start");
	
	// 1. loginForm.jsp에서 입력받은 Id, Pw 값 변수에 대입 및 디버깅
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));

	System.out.println("*[Debug] " + memberNo + " <-- deleteMember.jsp | param : memberNo");
	
	// 2. DB에 접근하기 위한 MemberDao와 MemberDao의 매개변수에 넣어주기 위해 Member 객체 생성
	MemberDao memberDao = new MemberDao();
	
	// 3. delteMemberByAdmin() 실행
	memberDao.deleteMemberByAdmin(memberNo);
	
	// 4. selectMemberList.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>