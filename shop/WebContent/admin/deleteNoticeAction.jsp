<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/deleteNoticeAction.jsp");
	
	// 1. 삭제할 공지사항의 번호 대입
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	System.out.println(" [Debug] noticeNo : \""+noticeNo+"\" | /admin/deleteNoticeAction.jsp");
	System.out.println(" [Debug] memberPw : \""+memberPw+"\" | /admin/deleteNoticeAction.jsp");
	
	// 2. 공지사항 삭제 메서드 실행
	NoticeDao noticeDao = new NoticeDao();
	if(noticeDao.deleteNoticeAdminCheck(memberId, memberPw) == 1){
		noticeDao.deleteNotice(noticeNo);
	}
	
	
	// 3. 메인 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/index.jsp");
%>