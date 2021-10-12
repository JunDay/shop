<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/updateEbookAction.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인된 세션이 없거나 관리자가 아니면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		System.out.println("-[Debug] \"CAN NOT FIND Session information\" | /admin/insertCategoryAction.jsp");
		return;
	}
	
	// 1. 입력받은 상품후기 정보를 변수에 대입 및 디버깅
	Ebook ebook = new Ebook();
	
	ebook.setEbookISBN(request.getParameter("ebookISBN"));
	ebook.setCategoryName(request.getParameter("categoryName"));
	ebook.setEbookState(request.getParameter("ebookState"));
	ebook.setEbookTitle(request.getParameter("ebookTitle"));
	ebook.setEbookSummary(request.getParameter("ebookSummary"));
	ebook.setEbookAuthor(request.getParameter("ebookAuthor"));
	ebook.setEbookPageCount(Integer.parseInt(request.getParameter("ebookPageCount")));
	ebook.setEbookCompany(request.getParameter("ebookCompany"));
	ebook.setEbookPrice(Integer.parseInt(request.getParameter("ebookPrice")));
	ebook.setEbookNo(Integer.parseInt(request.getParameter("ebookNo")));
	

	EbookDao ebookDao = new EbookDao();
	
	
	// 3. 상품후기를 DB에 삽입하기 위한 메서드 실행
	ebookDao.updateEbook(ebook);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectEbookList.jsp");
%>