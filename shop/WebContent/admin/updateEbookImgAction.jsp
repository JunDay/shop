<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- request 대신 사용 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 파일 중복을 피할 수 있도록 해줌 -->

<%
	//0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | admin/updateEbookImgAction.jsp");
	
	// 0-1. 세션 정보 조회
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 0-2. 방어 코드 : 로그인 정보가 없거나 관리자가 아니면 접속 불가
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// int ebookNo = Integer.parseInt(request.getParameter("ebookNo")); // multipart/form-data로 넘겨 받아서 사용 불가
	
	// 1. mr객체 생성, cos 라이브러리
	MultipartRequest mr = new MultipartRequest(
			request, // 1-1. 요청
			"C:/Users/leesj/Desktop/eclipse-jee-2020-12-R-win32-x86_64/git-shop/shop/WebContent/image", // 1-2. 파일이 업로드될 경로 지정
			1024*1024*1024, // 1-3. 업로드될 최대 용량 설정 : 약 1GB(KB * MB * GB)
			"utf-8", // 1-4. 인코딩 설정
			new DefaultFileRenamePolicy() // 1-5. 파일의 중복을 피하기 위한 메서드 실행
	);
	
	// 2. 선택된 ebookNo 저장
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	
	// 2-1. 새로운 ebookImg 경로 저장
	String ebookImg = mr.getFilesystemName("ebookImg");
	
	// 3. ebookImg를 변경하기 위한 새로운 Ebook 생성 및 대입
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookImg(ebookImg);
	
	// 4. ebookImg의 새로운 경로 저장
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookImg(ebook);
	
	// 5. 이전 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/admin/selectEbookOne.jsp?ebookNo="+ebookNo);
%>

