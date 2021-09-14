<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 방어 코드
	// 로그인 한 상태에서는 들어올 수 없다.
	System.out.println("**[Debug] insertMemberForm.jsp | Start");
	if(session.getAttribute("loginmMmber") != null){
		// 다시 브라우저에게 다른 곳을 요청하도록 하는 메서드, 어디로 보내는 것이 아니다
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
</body>
</html>