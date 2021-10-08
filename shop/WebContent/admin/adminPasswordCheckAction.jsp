<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>

<%
	// 0. 인코딩 설정
	request.setCharacterEncoding("utf-8");
	System.out.println("+[Debug] \"Started\" | /admin/adminPasswordCheckAction.jsp");
	
	// 1. 전달받은 memberId, memberPw 초시화
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	System.out.println(" [Debug] memberId : \""+memberId+"\" | /admin/adminPasswordCheckAction.jsp");
	
	// 2. 전달받은 수행삭제 동작의 번호(deleteOptionNum)
	int deleteOptionNum = Integer.parseInt(request.getParameter("deleteOptionNum"));
	
	// 3. 사용자가 입력한 비밀번호의 유효성을 검사하는 메서드를 실행하기 위한 객체 생성
	MemberDao memberDao = new MemberDao();
	
	// 4. deleteOptionNum에 따른 삭제 작업 수행
	if(deleteOptionNum == 1){ // 4-1. 사용자 강제 삭제
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		
		if(memberDao.adminPwCheck(memberId, memberPw) == 1){
			memberDao.deleteMemberByAdmin(memberNo);
			response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
			return;
		}
	} else if (deleteOptionNum == 2){ // 4-2. 공지사항 삭제
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		
		NoticeDao noticeDao = new NoticeDao();
		
		if(memberDao.adminPwCheck(memberId, memberPw) == 1){
			noticeDao.deleteNotice(noticeNo);
			response.sendRedirect(request.getContextPath()+"/selectNoticeList.jsp");
			return;
		}
	} else if (deleteOptionNum == 3){ // 4-3. 카테고리 삭제
		String categoryName = request.getParameter("categoryName");
		
		CategoryDao categoryDao = new CategoryDao();
		
		if(memberDao.adminPwCheck(memberId, memberPw) == 1){
			categoryDao.deleteCategory(categoryName);
			response.sendRedirect(request.getContextPath()+"/admin/selectCategoryList.jsp");
			return;
		}
	} else if (deleteOptionNum == 4){ // 4-4. 전자책 삭제
		int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		
		EbookDao ebookDao = new EbookDao();
		
		if(memberDao.adminPwCheck(memberId, memberPw) == 1){
			ebookDao.deleteEbook(ebookNo);
			response.sendRedirect(request.getContextPath()+"/admin/selectEbookList.jsp");
			return;
		}
	} else if (deleteOptionNum == 5){ // 4-5. Q&A 삭제
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		
		QnaDao qnaDao = new QnaDao();
		
		if(memberDao.adminPwCheck(memberId, memberPw) == 1){
			qnaDao.deleteQna(qnaNo);
			response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");
			return;
		}
	}
	
	
	// 3. 메인 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/index.jsp");
%>