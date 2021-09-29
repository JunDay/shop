<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
<div>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<%
	// 0. 방어 코드 : 로그인된 세션이 있는 경우 접근 불가
	System.out.println("**[Debug] insertMemberForm.jsp | Start");
	if(session.getAttribute("loginmMmber") != null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	%>
	<h1>회원가입</h1>
	
	<%
		String memberIdCheck = "";
		if(request.getParameter("memberIdCheck") != null){
			memberIdCheck = request.getParameter("memberIdCheck");
		}
	%>
	<div><%=request.getParameter("idCheckResult") %></div>
	<!-- memberId가 사용가능한지 확인 폼 -->
	<form action="<%=request.getContextPath()%>/selectMemberIdCheckAction.jsp" method="post">
		<div>
			회원 아이디 : <input type="text" name="memberIdCheck">
			<button type="submit">아이디 중복 검사</button>
		</div>
	</form>
	
	<!-- 회원가입 폼 -->
	<form id="joinForm" method="post" action="<%=request.getContextPath()%>/insertMemberAction.jsp">
		<div>memberId : </div>
		<div><input type="text" id="memberId" name="memberId" readonly="readonly" value="<%=memberIdCheck%>"></div>
		<div>memberPw : </div>
		<div><input type="password" id="memberPw" name="memberPw"></div>
		<div>memberName : </div>
		<div><input type="text" id="memberName" name="memberName"></div>
		<div>memberAge : </div>
		<div><input type="text" id="memberAge" name="memberAge"></div>
		<div>memberGender : </div>
		<div>
			<input type="radio" class="memberGender" name="memberGender" value="남">남
			<input type="radio" class="memberGender" name="memberGender" value="여">여
		</div>
		<button id="btn" type="button">회원가입</button>
	</form>
	
	<script>
		// 버튼을 클릭헀을 때
		$('#btn').click(function(){
			if($('#memberId').val() == ''){
				alert('ID를 입력하세요.');
			}
			if($('#memberPw').val() == '') {
				alert('PW를 입력하세요.');
			}
			if($('#memberName').val() == '') {
				alert('Name를 입력하세요.');
			}
			if($('#memberAge').val() == '') {
				alert('Age를 입력하세요.');
			}
			
			let memberGender = $('.memberGender:checked'); // 클래스타입으로 받아오면 무조건 배열이다.
			if(memberGender.length == 0){
				alert('Gender를 입력하세요.');
			}
			$('#joinForm').submit();
		});
	</script>
</div>
</body>
</html>