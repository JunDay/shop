<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | insertQnaAction.jsp");
	
	// 0-1. 로그인된 세션 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인된 회원만 접근가능
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 입력받은 QnA의 정보들을 객체 안에 대입 및 디버깅
	Qna qna = new Qna();
	
	qna.setQnaCategory(request.getParameter("qnaCategory"));
	qna.setQnaTitle(request.getParameter("qnaTitle"));
	qna.setQnaContent(request.getParameter("qnaContent"));
	qna.setQnaSecret(request.getParameter("qnaSecret"));
	qna.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	
	System.out.println(" [Debug] qnaCategory : \""+qna.getQnaCategory()+"\" | insertQnaAction.jsp");
	System.out.println(" [Debug] qnaTitle : \""+qna.getQnaTitle()+"\" | insertQnaAction.jsp FROM");
	System.out.println(" [Debug] qnaContent : \""+qna.getQnaContent()+"\" | insertQnaAction.jsp FROM");
	System.out.println(" [Debug] qnaSecret : \""+qna.getQnaSecret()+"\" | insertQnaAction.jsp FROM");
	System.out.println(" [Debug] memberNo : \""+qna.getMemberNo()+"\" | insertQnaAction.jsp FROM");
	
	
	// 2. 입력받은 상품후기 정보를 객체에 삽입
	QnaDao qnaDao = new QnaDao();
	qnaDao.insertQna(qna);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
%>