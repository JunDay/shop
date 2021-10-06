<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/insertCategoryAction.jsp");
	
	// 0-1. 로그인된 회원의 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인된 세션이 없거나 관리자가 아니면
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		System.out.println("-[Debug] \"CAN NOT FIND Session information\" | /admin/insertCategoryAction.jsp");
		return;
	}
	
	// 1. 입력받은 상품후기 정보를 변수에 대입 및 디버깅
	Category category = new Category();
	category.setCategoryName(request.getParameter("categoryName"));
	category.setCategoryState(request.getParameter("categoryState"));
	
	System.out.println(" [Debug] category : \"" + category.toString() + "\" | /admin/insertCategoryAction.jsp");
	
	
	// 2. 입력받은 상품후기 정보를 객체에 삽입
	
	// 3. 상품후기를 DB에 삽입하기 위한 메서드 실행
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
%>