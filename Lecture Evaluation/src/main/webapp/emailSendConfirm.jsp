<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!doctype html>
<html lang="ko">
<head>
	<%@ include file="link.txt"%>
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

<!--================ Start Header Area =================-->
	<header class="header_area">
		<div class="main_menu">
			<nav class="navbar navbar-expand-lg navbar-light">
				<div class="container">
					<!-- Brand and toggle get grouped for better mobile display -->
					<a class="navbar-brand logo_h" href="home.jsp"><img src="img/logo.png" alt=""></a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse offset" id="navbarSupportedContent">
						<ul class="nav navbar-nav menu_nav justify-content-end">
							<li class="nav-item active"><a class="nav-link" href="home.jsp">Home</a></li>
							<li class="nav-item"><a class="nav-link" href="index.jsp">Main</a></li>
							<li class="nav-item"><a class="nav-link" href="https://www.notion.so/6af7766e979542d1bb41190accc88735?pvs=4">Portfolio</a></li>
							<li class="nav-item submenu dropdown">
<%
	if(userID == null) {
%>
								<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
								 aria-expanded="false">User Page</a>
								<ul class="dropdown-menu">
									<li class="nav-item"><a class="nav-link" href="userLogin.jsp">Login</a></li>
									<li class="nav-item"><a class="nav-link" href="userJoin.jsp">Join</a></li><%
	} else {
%>
									<li class="nav-item"><a class="nav-link" href="userLogout.jsp">Logout</a></li>
								</ul>
							</li>
<%
}
%>
						</ul>
						
					</div>
					<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0 ml-3">
                        <input name="search" class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
				</div>
			</nav>
		</div>
	</header>
	
	
	<section class="about_area section_gap">
		<div class="container">
		    <div class="row justify-content-center">
				<div class="container">
				    <div class="alert alert-success mt-4" role="alert">
					  이메일 주소 인증을 하셔야 이용 가능합니다. 인증 메일을 받지 못하셨나요?
						<br><a href="emailSendAction.jsp" class="btn btn-primary">인증 메일 다시 받기</a>
					</div>
			    </div>
		    </div>
	    </div>
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