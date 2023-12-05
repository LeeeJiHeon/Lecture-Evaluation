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

	request.setCharacterEncoding("UTF-8");
	String reportTitle = null;
	String reportContent = null;
	if(request.getParameter("reportTitle") != null) {
		reportTitle = request.getParameter("reportTitle");
	}
	if(request.getParameter("reportContent") != null) {
		reportContent = request.getParameter("reportContent");
	}
	if(reportTitle == null || reportContent == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();		
	    return;
		
	}
	
	// 사용자에게 보낼 메시지를 기입합니다.
	String host = "http://localhost:8080/Lecture_Evaluation/";
	String from = "dlwlflgs0303@gmail.com";
	String to = "dlwlflgjs@naver.com";
	String subject = "강의평가 사이트에서 접수된 신고 메일입니다.";
	String content = "신고자 : " + userID +
					"<br>제목 : " + reportTitle +
					"<br>내용 : " + reportContent;
	

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
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('정상적으로 신고되었습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();		
    return;
%>