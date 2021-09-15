<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
		response.sendRedirect("./index.jsp");
		return;
	}
	%>
	<h1>회원가입</h1>
	<form method="post" action="./insertMemberAction.jsp">
		<div>memberId : </div>
		<div><input type="text" name="memberId"></div>
		<div>memberPw : </div>
		<div><input type="password" name="memberPw"></div>
		<div>memberName : </div>
		<div><input type="text" name="memberName"></div>
		<div>memberAge : </div>
		<div><input type="text" name="memberAge"></div>
		<div>memberGender : </div>
		<div>
			<input type="radio" name="memberGender" value="남">남
			<input type="radio" name="memberGender" value="여">여
		</div>
		<button type="submit">회원가입</button>
	</form>
</div>
</body>
</html>