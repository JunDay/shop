<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<ul>
		<!-- 회원 관리 : 목록, 수정(등급, PW), 강제탈퇴 -->
		<li><a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">[회원 관리]</a></li>
		<!-- 전자책 카테고리 관리 : 목록, 추가, 사용유무 수정-->
		<li><a href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">[전자책 카테고리 관리]</a></li>
		<!-- 전자책 관리 : 목록, 추가(이미지 추가), 수정, 삭제-->
		<li><a href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">[전자책 관리]</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/">[주문 관리]</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/">[상품평 관리]</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/">[공지게시판 관리]</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/">[Q&A 게시판 관리]</a></li>
	</ul>
</div>