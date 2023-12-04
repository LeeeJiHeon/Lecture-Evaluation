<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!doctype html>
<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="./bootstrap-4.6.0-dist/css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가 -->
	<link rel="stylesheet" href="./css/custom.css">
	
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
			
		<div id="navbar" class ="collapse navbar-collapse justify-content-between">
			<ul class="navbar-nav">
				<li class ="dropdown-content nav-item dropdown active">
					<a class="nav-link" href="main.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
<%
	if(userID == null) {
%>
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원관리</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item active" href="userJoin.jsp">회원가입</a>
<%
	} else {
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
}
%>
					</div>	
				</li>
			</ul>
			<form action = "./index.jsp" method="get" class="d-flex">
				<input name="search" class="form-control mr-2" type="text" placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div>
	</nav>
	
	<section class="container mt-3" style="max-width: 560px;">
		<div class="alter alter-warning mt-4" role="alter">
		이메일 주소 인증을 하셔야 이용 가능합니다. 인증 메일을 받지 못하셨나요?
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">인증 메일 다시 받기</a>
	</section>
	
	<%@ include file="../footer.jsp"%>
	
	<!-- Jquery 자바스크립트 추가하기 -->		
	<script src="/bootstrap-4.6.0-dist/jquery/jquery-3.5.1.js"></script>
	<!-- Popper 자바스크립트 추가하기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<!-- Bootstrap 자바스크립트 추가하기 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>
	
	
</body>
</html>