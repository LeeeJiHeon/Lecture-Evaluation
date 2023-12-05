<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!doctype html>
<html lang="ko">
<head>
	<%@ include file="link.txt"%>
	<link rel="stylesheet" href="./css/login.css">
	<link rel="stylesheet" href="./css/style.css">
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
		                <h2>Sign in</h2>
		                <form method="post" action="./userLoginAction.jsp" id="login-form">
		                    <input type="text" name="userID" placeholder="UserID">
		                    <input type="password" name="userPassword" placeholder="Password">
		                    <label for="remember-check">
		                        <input type="checkbox" id="remember-check">아이디 저장하기
		                    </label>
		                    <input type="submit" value="Login">
		                </form>
		            </div>
		        </div>
		    </div>
	    </div>
	</section>
	
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/stellar.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="vendors/nice-select/js/jquery.nice-select.min.js"></script>
	<script src="vendors/isotope/imagesloaded.pkgd.min.js"></script>
	<script src="vendors/isotope/isotope-min.js"></script>
	<script src="vendors/owl-carousel/owl.carousel.min.js"></script>
	<script src="js/jquery.ajaxchimp.min.js"></script>
	<script src="js/mail-script.js"></script>
	<!--gmaps Js-->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCjCGmQ0Uq4exrzdcL6rvxywDDOvfAu6eE"></script>
	<script src="js/gmaps.min.js"></script>
	<script src="js/theme.js"></script>
	<%@ include file="footer.jsp"%>
	
</body>
</html>