<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<!-- 회원 관리 : 목록, 수정(등급, PW), 강제탈퇴 -->
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">[회원 관리]</a>
	<!-- 전자책 카테고리 관리 : 목록, 추가, 사용유무 수정-->
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">[전자책 카테고리 관리]</a>
	<!-- 전자책 관리 : 목록, 추가(이미지 추가), 수정, 삭제-->
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">[전자책 관리]</a>
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectOrderListByAdmin.jsp">[주문 관리]</a>
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectOrderCommentListByAdmin.jsp">[상품평 관리]</a>
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectNoticeListByAdmin.jsp">[공지게시판 관리]</a>
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectQnaListByAdmin.jsp">[Q&A 게시판 관리]</a>
</div>