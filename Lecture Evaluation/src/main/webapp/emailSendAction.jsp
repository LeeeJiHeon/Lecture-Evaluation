<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="util.SHA256"%>
<%@page import="util.Gmail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked == true) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증 된 회원입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		
		return;
	}

	// 사용자에게 보낼 메시지를 기입합니다.
	String host = "http://localhost:8080/Lecture_Evaluation/";
	String from = "dlwlflgs0303@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "강의평가를 위한 이메일 확인 메일입니다.";
	String content = "다음 링크에 접속하여 이메일 확인을 진행하세요.\n" +
			"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";

	

	// SMTP에 접속하기 위한 정보를 기입합니다.

	Properties p = new Properties();

	 // 로그인시 TLS를 사용할 것인지 설정
		p.put("mail.smtp.starttls.enable", "true");
		
		// TLS의 포트번호는 587이며 SSL의 포트번호는 465이다.
		p.put("mail.smtp.port", "587");
	    
		// TLS 버전을 지정, TLS 버전 1.0 이나 1.1은 주요 브라우저에서 지원 중단하였다.
		p.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		// 이메일 발송을 처리해줄 SMTP서버
		p.put("mail.smtp.host", "smtp.gmail.com");
	    
		// SMTP 서버의 인증을 사용한다는 의미
		p.put("mail.smtp.auth", "true");
	 

	try{
	    Authenticator auth = new Gmail();
	    Session ses = Session.getInstance(p, auth);
	    ses.setDebug(true);
	    MimeMessage msg = new MimeMessage(ses); 
	    msg.setSubject(subject);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr);
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	    msg.setContent(content, "text/html;charset=UTF-8");
	    Transport.send(msg);

	} catch(Exception e){
	    e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다..');");
		script.println("history.back();");
		script.println("</script>");
		script.close();		
	    return;
	}
%>

<!doctype html>
<html lang="ko">
<head>
<title>Lecture Evaluation Web</title>
	<%@ include file="link.txt"%>
</head>
<body>
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
				<div class="container">
				    <div class="alert alert-success mt-4" role="alert">
					  이메일 주소 인증 메일이 전송되었습니다. 
					  <br>이메일에 들어가셔서 인증해주세요.
					</div>
			    </div>
		    </div>
	    </div>
	</section>    

	<%@ include file="../footer.jsp"%>
	
	<!-- Jquery 자바스크립트 추가하기 -->		
	<script src="/bootstrap-4.6.0-dist/jquery/jquery-3.5.1.js"></script>
	<!-- Popper 자바스크립트 추가하기 -->
	<script src="./js.popper.js"></script>
	<!-- Bootstrap 자바스크립트 추가하기 -->
	<script src="./js.bootstrap.min.js"></script>
	<script src="/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>

 </body>

</html>