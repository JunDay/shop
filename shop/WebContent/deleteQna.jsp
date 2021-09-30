<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /deleteQna.jsp");
	
	// 1. 삭제할 공지사항의 번호 대입
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(" [Debug] qnaNo : \""+qnaNo+"\" | /deleteQna.jsp");
	
	// 2. 공지사항 삭제 메서드 실행
	QnaDao qnaDao = new QnaDao();
	qnaDao.deleteQna(qnaNo);
	
	
	// 3. 메인 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>