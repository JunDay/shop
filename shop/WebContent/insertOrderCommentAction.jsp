<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | insertOrderCommentAction.jsp");
	
	// 0. 방어코드 : 로그인 상태에서 페이지 접근 불가
	if(session.getAttribute("loginmMmber") != null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 1. 입력받은 상품후기 정보를 변수에 대입 및 디버깅
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int orderScore = Integer.parseInt(request.getParameter("orderScore"));
	String orderCommentContent = request.getParameter("orderCommentContent");
	
	System.out.println(" [Debug] orderNo : \"" + orderNo + "\" | insertOrderCommentAction.jsp FROM insertOrderCommentFrom.jsp");
	System.out.println(" [Debug] ebookNo : \"" + ebookNo + "\" | insertOrderCommentAction.jsp FROM insertOrderCommentFrom.jsp");
	System.out.println(" [Debug] orderScore : \"" + orderScore + "\" | insertOrderCommentAction.jsp FROM insertOrderCommentFrom.jsp");
	System.out.println(" [Debug] orderCommentContent : \"" + orderCommentContent + "\" | insertOrderCommentAction.jsp FROM insertOrderCommentFrom.jsp");
	
	// 2. 입력받은 상품후기 정보를 객체에 삽입
	OrderComment orderComment = new OrderComment();
	orderComment.setOrderNo(orderNo);
	orderComment.setEbookNo(ebookNo);
	orderComment.setOrderScore(orderScore);
	orderComment.setOrderCommentContent(orderCommentContent);
	
	// 3. 상품후기를 DB에 삽입하기 위한 메서드 실행
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	orderCommentDao.insertOrderComment(orderComment);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/selectOrderListByMember.jsp");
%>