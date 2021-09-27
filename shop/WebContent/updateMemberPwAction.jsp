<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | updateMemberPwAction.jsp");
	
	// 0-1. 유효성 검사 : 누락된 memberPw 값 검사
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/selectMemberList.jsp");
		return;
	}
	
	// 1. 입력받은 memberNo, memberPw 값 대입
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPw = request.getParameter("memberPw");
	
	System.out.println(" [Debug] memberNo : \""+memberNo +"\" | updateMemberPwAction.jsp FROM updateMemberPwForm.jsp");
	System.out.println(" [Debug] memberPw : \""+memberPw +"\" | updateMemberPwAction.jsp FROM updateMemberPwForm.jsp");
	
	// 2. MemberDao에 있는 updateMemberPwByAdmin() 메서드를 위한 객체 생성
	Member member = new Member();
	
	// 2-1. member 객체에 데이터 삽입
	member.setMemberNo(memberNo);
	member.setMemberPw(memberPw);
	
	// 3. updateMemberPwByAdmin() 실행
	MemberDao memberDao = new MemberDao();
	memberDao.updateMemberPwByAdmin(member);
	
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 4. 이전 페이지로 이동
	if(loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/selectMemberOne.jsp?memberNo="+memberNo);
		return;
	}
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
	return;
%>