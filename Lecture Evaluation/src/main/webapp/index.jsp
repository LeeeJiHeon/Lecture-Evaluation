<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>

<!doctype html>
<html lang="ko">
<head>
	<%@ include file="link.txt"%>
	<link href="./css/style.css" rel="stylesheet" />
	<title>Lecture Evaluation Web</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("lectureDivide") != null) {
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}

	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}

	if(request.getParameter("pageNumber") != null) {
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	}

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
	
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
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
									<li class="nav-item"><a class="nav-link" href="userLogin.jsp">Sign in</a></li>
									<li class="nav-item"><a class="nav-link" href="userJoin.jsp">Sign up</a></li>
<%
	} else {
%>
									<li class="nav-item"><a class="nav-link" href="userLogout.jsp">Sign out</a></li>
								</ul>
							</li>
<%
}
%>					
						</ul>
						
					</div>
					<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0 ml-3">
	                       <input name="search" class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
	                       <button class="btn genric-btn info radius my-2 my-sm-0" type="submit">검색</button>
                   </form>
                   
				</div>
			</nav>
		</div>
	</header>

	 
	<section class="about_area section_gap">
	<div class="banner_inner">
		<div class="container">
		    <div class="row justify-content-center">
				<form method="get" action="./index.jsp" class="form-inline mt-3">
					<select name="LectureDivide" class="form-control mx-1 mt-2">
						<option value="전체">전체</option>
						<option value="전공" <%if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
						<option value="교양" <%if(lectureDivide.equals("교양")) out.println("selected"); %>>교양</option>
						<option value="기타" <%if(lectureDivide.equals("기타")) out.println("selected"); %>>기타</option>					
					</select>
					<select name="searchType" class="form-control mx-1 mt-2">
						<option value="최신순">최신순</option>
						<option value="추천순" <%if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>				
					</select>
					<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="Search">
					<button type="submit" class="btn btn genric-btn info radius mx-1 mt-2">검색</button>
					<a class="btn genric-btn success radius mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
					<a class="btn genric-btn danger radius mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
				</form>
		
<%		
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList != null)
	for(int i = 0; i < evaluationList.size(); i++) {
		if(i == 5) break;
		EvaluationDTO evaluation = evaluationList.get(i);	
		
%>
		
				<div class="card bg-light mt-3">
					<div class="card-header bg-light">
						<div class="row">
							 <div class="col-8 text-left"><%=evaluation.getLectureName()%>&nbsp;<small><%=evaluation.getProfessorName()%></small></div>
							<div class="col-4 text-right">
							종합 <span style="color: red;"><%= evaluation.getTotalScore() %></span>
							</div>
						</div>
					</div>
					<div class="card-body">
						<h5 class="card-title">
						<%=evaluation.getEvaluationTitle()%>&nbsp;<small>(<%=evaluation.getLectureYear()%>년 <%=evaluation.getSemesterDivide()%>)</small>
						</h5>
						<p class="card-text"><%= evaluation.getEvaluationContent() %></p>
						<div class="row">
							<div class="col-9 text-left">
								작성자&nbsp;<small style="color: blue;"><%= evaluation.getUserID() %></small>
							</div>
						</div>
						<div class="row">
							<div class="col-9 text-left">	
								성적<span style="color: red;"> <%= evaluation.getCreditScore() %></span>
								개꿀<span style="color: red;"> <%= evaluation.getComfortableScore() %></span>
								강의<span style="color: red;"> <%= evaluation.getLectureScore() %></span>
								<span style="color: green"> (추천: <%= evaluation.getLikeCount() %>)</span>
							</div>
							<div class="col-3 text-right">
								<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">추천</a>
								<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">삭제</a>
							</div>
						</div>
					</div>
				</div>
<%
		}
%>
			</div>
		</div>
		<br>
		<ul class="pagination justify-content-center mt3">
			<li class="page-item">
			<%
				if(pageNumber <= 0) {
			%>
				<a class="page-link disabled">이전</a>
			<%
				} else {
			%>
						<a class="page-link" href="./index.jsp
						?lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
						&searchType= <%= URLEncoder.encode(searchType,"UTF-8") %>
						&search=<%= URLEncoder.encode(search,"UTF-8") %>
						&pageNumber=<%= pageNumber - 1 %>">이전</a>
		
			<%
				}
			%>	
			</li>
			<li class="page-item">
			<%
				if(evaluationList != null && evaluationList.size() < 6) {
			%>
				<a class="page-link disabled">다음</a>
			<%
				} else {
			%>
				<a class="page-link" href="./index.jsp?
				lectureDivide=<%= URLEncoder.encode(lectureDivide,"UTF-8") %>
				&searchType=<%= URLEncoder.encode(searchType,"UTF-8") %>
				&search=<%= URLEncoder.encode(search,"UTF-8") %>
				&pageNumber=<%= pageNumber +1 %>">다음</a>
		
			<%
				}
			%>
		    </li>
		</ul>
		</div>
	</section>
	
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label>
								<input type="text" name="lectureName" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label>
								<input type="text" name="professorName" class="form-control" maxlength="20">
							</div>
						</div>	
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강 연도</label>
								<select name="lectureYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023" selected>2023</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>수강 학기</label>
								<select name="semesterDivide" class="form-control">
									<option value="1학기" selected>1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label>
								<select name="lectureDivide" class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">							
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>						
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B" >B</option>
									<option value="C" >C</option>
									<option value="D" >D</option>
									<option value="F" >F</option>
								</select>
							</div>	
							<div class="form-group col-sm-3">
								<label>성적</label>
								<select name="creditScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B" >B</option>
									<option value="C" >C</option>
									<option value="D" >D</option>
									<option value="F" >F</option>
								</select>
							</div>	
							<div class="form-group col-sm-3">
								<label>개꿀</label>
								<select name="comfortableScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B" >B</option>
									<option value="C" >C</option>
									<option value="D" >D</option>
									<option value="F" >F</option>
								</select>
							</div>	
							<div class="form-group col-sm-3">
								<label>강의</label>
								<select name="lectureScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B" >B</option>
									<option value="C" >C</option>
									<option value="D" >D</option>
									<option value="F" >F</option>
								</select>
							</div>	
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form>
				
				</div>
			</div>	
		</div>
	</div>
	
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						
	
						<div class="form-group">
							<label>신고 제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">							
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>						
						</div>
						
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				
				</div>
			</div>	
		</div>
	</div>
	
	
	<!-- Jquery 자바스크립트 추가하기 -->		
	<script src="./bootstrap-4.6.0-dist/jquery/jquery-3.5.1.js"></script>>
	<script src="./bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Popper 자바스크립트 추가하기 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<%@ include file="footer.jsp"%>
	
</body>
</html>