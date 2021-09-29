<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<a class="btn btn-dark" href="">전체상품</a> <!-- 메인화면과는 다르게 공지사항 출력 X, 가장 판매량이 높은 순으로 노출 -->
	<a class="btn btn-dark" href="">카테고리</a> <!-- 카테고리를 선택할 수 있는 화면을 출력 -->
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeList.jsp">공지사항</a> <!-- 공지사항의 상세 페이지 목록을 출력 -->
	<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaList.jsp">Q&A</a> <!-- Q&A 페이지 출력 -->
	<a class="btn btn-dark" href="">상품검색</a> <!--  -->
</div>

<!-- 

<div>
	<ul class="list-group list-group-horizontal">
		<li class="list-group-item"><a class="btn btn-dark" href="">Menu1</a></li>
		<li class="list-group-item"><a class="btn btn-dark" href="">Menu2</a></li>
		<li class="list-group-item"><a class="btn btn-dark" href="">Menu3</a></li>
		<li class="list-group-item"><a class="btn btn-dark" href="">Menu4</a></li>
		<li class="list-group-item"><a class="btn btn-dark" href="">Menu5</a></li>
	</ul>
</div>

 -->