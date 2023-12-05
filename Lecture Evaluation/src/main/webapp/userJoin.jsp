<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!doctype html>
<html lang="ko">
<head>
	<%@ include file="link.txt"%>

	<title>Lecture Evaluation Web</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'index.jsp';");
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
									<li class="nav-item"><a class="nav-link" href="userJoin.jsp">Join</a></li>
<%
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
		        <div class="col-lg-4 col-md-6">
		            <div class="login-wrapper">
		                <h2>Sign up</h2>
		                <form method="post" action="./userRegisterAction.jsp" id="login-form">
		                    <input type="text" name="userID" placeholder="UserID" class="form-control">
		                    <input type="password" name="userPassword" placeholder="Password" class="form-control">
		                    <input type="email" name="userEmail" placeholder="E-mail" class="form-control">
		                   
		                    <input type="submit" value="Sign up">
		                </form>
		            </div>
		        </div>
		    </div>
	    </div>
	</section>
	
	
	<!-- <section class="container mt-3" style="max-width: 1000px;">
		<div class="jumbotron">
			<form style="text-align:center">
				<a href="index.jsp" title="홈 바로가기"><img src="img-logo.png" alt="KNU"><br><br></a>
		   	<h1><p class="bottom">회원가입</p></h1>
			</form>
			<form method="post" action="./userRegisterAction.jsp">
				<div class="form-group">
					<input type="text" name="userID" placeholder="아이디" class="form-control">
				</div>
				<div class="form-group">
					<input type="password" name="userPassword" placeholder="비밀번호" class="form-control">
				</div>
				<div class="form-group">
					<input type="email" name="userEmail" placeholder="E-mail (예 : 홍길동@naver.com)" class="form-control">
				</div>
				<button type="submit" class="btn btn-primary">회원가입</button>
			</form>
		</div>
	</section> -->

	<%@ include file="../footer.jsp"%>
	
</body>
</html>