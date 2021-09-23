<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- request 대신 사용 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 파일 중복을 피할 수 있도록 해줌 -->

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("**[Debug] selectEbookList.jsp | Start");
	
	// 0-1. 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// int ebookNo = Integer.parseInt(request.getParameter("ebookNo")); // multipart/form-data로 넘겨 받아서 사용 불가
	
	MultipartRequest mr = new MultipartRequest(
			request, 
			"C:/Users/leesj/Desktop/eclipse-jee-2020-12-R-win32-x86_64/git-shop/shop/WebContent/image", 
			1024*1024*1024, // KB, MB, GB
			"utf-8", 
			new DefaultFileRenamePolicy()
	);
	
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	String ebookImg = mr.getFilesystemName("ebookImg");
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookImg(ebookImg);
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookImg(ebook);
	response.sendRedirect(request.getContextPath()+"/admin/selectEbookOne.jsp?ebookNo="+ebookNo);

%>

