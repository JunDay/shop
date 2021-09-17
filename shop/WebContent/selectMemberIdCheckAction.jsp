<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>

<%
	System.out.println("**[Debug] selectMemberIdCheckAction.jsp | Start");

	if(request.getParameter("memberIdCheck") == null || request.getParameter("memberIdCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	// memberIdCheck 값이 공백인지 확인, 공백 시 돌려보냄
	String memberIdCheck = request.getParameter("memberIdCheck");

	MemberDao memberDao = new MemberDao();
	String result = memberDao.selectMemberId(memberIdCheck);
	// MemberDao.selectMemberId() 메서드 호출
	
	if(result == null){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheck="+memberIdCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?idCheckResult=This ID alreadt taken");
	}
%>