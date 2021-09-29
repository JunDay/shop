<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/updateNoticeAction.jsp");
	
	// 0-1. 로그인된 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 입력받은 카테고리 정보 대입
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	System.out.println(" [Debug] noticeNo : \""+noticeNo+"\" | /admin/updateNoticeAction.jsp | FROM /admin/updateNoticeForm.jsp");
	System.out.println(" [Debug] noticeTitle : \""+noticeTitle+"\" | /admin/updateNoticeAction.jsp | FROM /admin/updateNoticeForm.jsp");
	System.out.println(" [Debug] noticeContent : \""+noticeContent+"\" | /admin/updateNoticeAction.jsp | FROM /admin/updateNoticeForm.jsp");
	System.out.println(" [Debug] memberNo : \""+memberNo+"\" | /admin/updateNoticeAction.jsp | FROM /admin/updateNoticeForm.jsp");
	
	// 2. 카테고리 수정 메서드를 위한 객체 생성 및 세팅
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setMemberNo(memberNo);
	
	// 3. 카테고리 수정 메서드 실행
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.updateNotice(notice);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/selectNoticeOne.jsp?noticeNo="+noticeNo);
%>