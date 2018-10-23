<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<!-- jquery -->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Oh!ffice</title>

<!-- Bootstrap Core CSS -->
<link
	href="/ohffice/resources/start/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="/ohffice/resources/start/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">
<link
	href="/ohffice/resources/start/vendor/simple-line-icons/css/simple-line-icons.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/ohffice/resources/start/css/stylish-portfolio.min.css"
	rel="stylesheet">

</head>
<style type="text/css">
.info {
    font-size: .7em;
    color: #ff0000;
    display: block;
        text-align: left;
    
}
.wrap-loading { /*화면 전체를 어둡게 합니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000'); /* ie */
}

.wrap-loading div { /*로딩 이미지*/
	position: fixed;
	top: 50%;
	left: 50%;
	margin-left: -21px;
	margin-top: -21px;
}

.display-none { /*감추기*/
	display: none;
}

#current-user img.thumbnail {
	top: 0;
	left: 0;
	width: 2.5rem;
	height: 2.5rem;
	border-radius: 50%;
}

main .container {
	margin-top: 6rem;
	margin-bottom: 6rem;
	transition: transform .6s, opacity .6s;
}

.container {
	position: relative;
	padding: 0 .624rem;
	min-width: 300px;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
	var auth2;
	var SCOPES = [ 'https://www.googleapis.com/auth/drive', 'profile',
			'https://mail.google.com/' ];
	var CLIENT_ID = '587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com';
	var API_KEY = 'AIzaSyBhi9PSQYrFOw0MBWCZusHQFfawVxzU5Vc';
	var token = "";
	// Called when Google Javascript API Javascript is loaded

	$(document).ready(function() {
		$("#about").hide();
		$("#current-user").hide();
		$("#create-comp").hide();
	});
	function handleClientLoad() {
		// Load the API client and auth2 library
		gapi.load('client:auth2', initClient);
	}
	function initClient() {
		gapi.client.init({
			apiKey : API_KEY, //THIS IS OPTIONAL AND WE DONT ACTUALLY NEED THIS, BUT I INCLUDE THIS AS EXAMPLE
			clientId : CLIENT_ID,
			scope : SCOPES.join(' '),
			
		}).then(function() {
			
	
			
			gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
			updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
			
			
		});
	}
	
	function updateSigninStatus(isSignedIn) {
		if (isSignedIn) {
			//로그인 성공 했다면 
			token = gapi.client.getToken().id_token;
			getEmail(); // 해당메소드로 이동
		} else {
			$("#btnLogin").show(100);
			$("#btnLogout").hide();
		}
	}
	function handleAuthClick(event) {
		gapi.auth2.getAuthInstance().signIn();
	}

	function handleSignoutClick(event) {
		if (confirm("로그아웃 하시겠습니까?")) {
			gapi.auth2.getAuthInstance().signOut();
			$("#current-user").hide(2000);
			$("#about").hide(300);
			$("#create-comp").hide();
		}
	}

	function getEmail() {
		// userinfo 메소드를 사용할 수 있도록 oauth2 라이브러리를 로드합니다.
		gapi.client.load('oauth2', 'v2', function() {
			var request = gapi.client.oauth2.userinfo.get();
		
			request.execute(getEmailCallback);
		});
	}
	function getEmailCallback(obj) {// 프로필 정보는 넘겨받은 obj값들중 선택하여 뽑아내면 됨.
		var login_info = {
			'name' : obj.name,
			'email' : obj.email,
			'id' : obj.id,
			'picture' : obj.picture,
			'token' : token
		}; // 보낼정보들을 저장시킨뒤
		
		$.ajax({ // 에이작스로 저장된정보들을 보냄
			url : "login.do",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(login_info),
			success : function(result) { // 이미 권한승인된아이디 (db에 적재된 구글 id라면) 권한을 조회하는 ajax실행 
											//, 아니라면, 조직생성 페이지 띄움
				if(result == "ismember"){
					iscompany(login_info);
				}else if(result == "emailCertification"){
					alert("이메일 인증을 완료해주세요");
				}else{
					 companyResit(login_info);
				}
				
			},
			beforeSend : function() {
				$('.wrap-loading').removeClass('display-none');
			},
			complete : function() {
				$('.wrap-loading').addClass('display-none');
			},
			error : function(request, status, errorData) {
				console.log("error code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + errorData);
			},
			timeout : 100000
		});
		
		
	}
	
	function iscompany(login_info){
		$.ajax({ //회사가 있는지 없는지 조회하는 ajax실행 없다면 회사등록페이지를 띄우고, 있으면 url이동
			url : "iscompany.do",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(login_info),
			success : function(result) { 
			
				if(result != "" || result.length > 0){
					location.href='company?url='+result;					
				}else{
					 companyResit(login_info);
				}
			},
			beforeSend : function() {
				$('.wrap-loading').removeClass('display-none');
			},
			complete : function() {
				$('.wrap-loading').addClass('display-none');
			},
			error : function(request, status, errorData) {
				console.log("error code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + errorData);
			},
			timeout : 100000
		});	
	}
	function companyResit(login_info){
		
		$("#current-user").show();
		$("#user-name").html(login_info['name']);
		$(".thumbnail").attr('src', login_info['picture']);
		$("#btnLogout").css("display", "inline-block", "zoom", "1")
		$("#btnLogin").hide();
		$("#btnLogout").show(100);
		$("#about").show(2000);
		$("#create-comp").show();
		var offset = $("#about").offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
        $('#emp_email').attr('value',login_info['email']);
	}
	
</script>
<div class="wrap-loading display-none">

	<div>
		<img src="/ohffice/resources/start/img/loading.gif" />
	</div>

</div>
<body id="page-top">
	<!-- Navigation -->
		<!-- Header -->
	<header class="masthead d-flex" style="position: initial">
		<div class="container text-center my-auto">
			<h1 class="mb-1">Oh!ffice</h1>
			<h3 class="mb-5">
				<br>
				<button id="btnLogin" onclick="handleAuthClick()"
					class="btn btn-primary">Google Login</button>
				
			</h3>
			<a class="btn btn-primary btn-xl js-scroll-trigger" href="#about" id = "create-comp" style="display: none ">새 조직 만들기</a><br><Br><br>
			<button id="btnLogout" onclick="handleSignoutClick()"
						class="btn btn-primary" style="display: none">Logout</button></a>
		</div>
		<div class="overlay"></div>
	</header>

	<!-- About -->
	<section class="content-section bg-light" id="about"
		style="display: none">
		<div class="container text-center">
			<div class="row">
				<div class="col-lg-10 mx-auto">
					<div class="container">
						<div class="content-section-heading">
							<h2 class="text-primary mb-5">Oh!ffice 조직생성하기</h2>

							<div id="create-desc">
								<span>전사 도입을 원하시면, 개인 계정이 아닌 공용 계정으로 조직 생성을 권장드립니다.</span> <span
									class="email"><br>( 예: admin@mycompany.com )</span><br>
								<span class="middle-desc">데이터는 마스터계정의 구글드라이브에 저장됩니다.</span><br>
								<span class="middle-desc">마스터 계정은 변경이 불가하며, 마스터 계정이 삭제되면
									Oh!ffice를 이용하실 수 없습니다.</span><br> <br> <br>

							</div>
						</div>
						<form id="create-org-form" action="comp.do" method="post"
							novalidate="">
						<input type="hidden" name="emp_email" id="emp_email" value=""/>
							<label for="create-org-name"
								style="text-align: left; display: block; margin-bottom: 0;">조직명<sub>필수입력</sub></label>
							<info class="info">조직명을 입력하세요.</info>
							<center>
								<input name="com_name" id="create-org-name" type="text"
									class="form-control" placeholder="Enter Company">
							</center>

							<br> <label for="create-org-url">접속 URL<sub>필수입력,
									3글자 이상, *URL에 특수문자, 공백은 사용하실 수 없습니다. ( - , _ 제외)</sub></label><br> <label
								custom="create-org-url"><span>http://</span> <span>ohffice.com/?url=<input
									placeholder="URL" name="com_url" id="create-org-url"
									type="text" minlength="3" data-check="isUrl"
									class="valid-check api-use" required="">
							</span></label>
					
					<br>
					<button class="button" id="submit" type="submit">Oh!ffice생성하기</button>
					</form>
					</div>
				</div>
			</div>
		</div>
	
	</section>

	<!-- Map -->
	<section id="contact" class="map">
		<iframe width="100%" height="100%" frameborder="0" scrolling="no"
			marginheight="0" marginwidth="0" 
			src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12661.513516944651!2d127.032909!3d37.498993!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x3565475c3365c5bb!2zS0jsoJXrs7TqtZDsnKHsm5A!5e0!3m2!1sko!2skr!4v1540289742365">
		</iframe>
	</section>

	<!-- Footer -->
	<footer class="footer text-center">
		<div class="container">
			
			<p class="text-muted small mb-0">Copyright &copy; Oh!ffice
				2018</p>
		</div>
	</footer>

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded js-scroll-trigger" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>


	<!-- Bootstrap core JavaScript -->
	<script src="/ohffice/resources/start/vendor/jquery/jquery.min.js"></script>
	<script
		src="/ohffice/resources/start/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script
		src="/ohffice/resources/start/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="/ohffice/resources/start/js/stylish-portfolio.min.js"></script>
	<!-- Google plus Login -->
	<script async defer src="https://apis.google.com/js/api.js"
		onload="this.onload=function(){};handleClientLoad()"
		onreadystatechange="if (this.readyState === 'complete') this.onload()"></script>

</body>

</html>
