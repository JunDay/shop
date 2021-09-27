<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | admin/updateCategoryStateAction.jsp");
	
	// 0-1. 로그인된 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 0-3. 방어코드 : categoryName || cateogryState가 입력되지 않을 경우
	if(request.getParameter("categoryName") == null || request.getParameter("categoryState") == null ){
		response.sendRedirect(request.getContextPath()+"/adim/selectCategoryList.jsp");
		return;
	}
	if(request.getParameter("categoryName").equals("") || request.getParameter("categoryState").equals("")){
		response.sendRedirect(request.getContextPath()+"/adim/selectCategoryList.jsp");
		return;
	}
	
	// 1. 입력받은 카테고리 정보 대입
	String categoryName = request.getParameter("categoryName");
	String updateCategoryName = request.getParameter("updateCategoryName");
	String categoryState = request.getParameter("categoryState");
	System.out.println(" [Debug] cateogryName : \""+categoryName+"\" | updateCategoryAction.jsp | FROM updateCategoryForm.jsp");
	System.out.println(" [Debug] updateCategoryName : \""+updateCategoryName+"\" | updateCategoryAction.jsp | FROM updateCategoryForm.jsp");
	System.out.println(" [Debug] categoryState : \""+categoryState+"\" | updateCategoryAction.jsp | FROM updateCategoryForm.jsp");
	
	// 2. 카테고리 수정 메서드를 위한 객체 생성 및 세팅
	Category category = new Category();
	CategoryDao categoryDao = new CategoryDao();
	
	category.setCategoryName(updateCategoryName);
	category.setCategoryState(categoryState);
	
	// 3. 카테고리 수정 메서드 실행
	categoryDao.updateCategory(category, categoryName);
	
	// 4. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
%>