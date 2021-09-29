<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | insertNoticAction.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인된 회원이 권한 1미만인 경우
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 입력받은 상품후기 정보를 변수에 대입 및 디버깅
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int memberNo = loginMember.getMemberNo();
	
	System.out.println(" [Debug] orderNo : \"" + noticeTitle + "\" | insertNoticAction.jsp FROM insertNoticeFrom.jsp");
	System.out.println(" [Debug] ebookNo : \"" + noticeContent + "\" | insertNoticAction.jsp FROM insertNoticeFrom.jsp");
	System.out.println(" [Debug] memberNo : \"" + memberNo + "\" | insertOrderCommentAction.jsp");
	
	// 2. 입력받은 상품후기 정보를 객체에 삽입
	Notice notice = new Notice();
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setMemberNo(memberNo);
	
	
	// 3. 상품후기를 DB에 삽입하기 위한 메서드 실행
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.insertNotice(notice);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/index.jsp");
%>