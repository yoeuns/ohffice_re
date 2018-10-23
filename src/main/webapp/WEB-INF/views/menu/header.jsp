<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery 3 -->
<script src="/ohffice/resources/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/ohffice/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/ohffice/resources/dist/js/adminlte.min.js"></script>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="/ohffice/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/ohffice/resources/bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="/ohffice/resources/bower_components/Ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/ohffice/resources/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect. -->
  <link rel="stylesheet" href="/ohffice/resources/dist/css/skins/skin-blue.min.css">
   <!-- Google Font -->
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<title>Oh!ffice</title>
</head>
<style type="text/css">
.wrap-loading { /*화면 전체를 가립니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: #ffffff; /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000'); /* ie */
}

.loadingimage {
    position: fixed;
    top: 21%;
    left: 36%;
    }
.navbar-nav>.user-menu>.dropdown-menu>li.user-header {
	height: 65px;
}
div.col-xs-4.text-center {
	margin-left: 20px;
}
</style>
<body>

<div class="wrap-loading display-none" id="loading" style="display: none;">

	<div>
		<img class="loadingimage" src="https://ubisafe.org/images/gif-transparent-adventure-time-5.gif" />
	</div>

</div>
<script type="text/javascript">
var auth2;
var SCOPES = [ 'https://www.googleapis.com/auth/drive', 'profile',
		'https://mail.google.com/' ];
var CLIENT_ID = '587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com';
var API_KEY = 'AIzaSyBhi9PSQYrFOw0MBWCZusHQFfawVxzU5Vc';
var token = "";


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
		token = gapi.client.getToken().id_token;
		getEmail(); // 해당메소드로 이동
	} else {//로그인이 되어있지 않다면
		location.replace("main.do");
		/* $("#btnLogin").show(100);
		$("#btnLogout").hide(); */
	}
}
function handleSignoutClick(event) {
	if (confirm("로그아웃 하시겠습니까?")) {
		gapi.auth2.getAuthInstance().signOut();
		location.replace("main.do");
	/* 	$("#current-user").hide(2000);
		$("#about").hide(300);
		$("#create-comp").hide(); */
	}
}

function getEmail() {
	// userinfo 메소드를 사용할 수 있도록 oauth2 라이브러리를 로드합니다.
	gapi.client.load('oauth2', 'v2', function() {
		var request = gapi.client.oauth2.userinfo.get();
	
		request.execute(getEmailCallback);
	});
}
function getEmailCallback(obj) {
	var login_info = {
			'name' : obj.name,
			'email' : obj.email,
			'id' : obj.id,
			'picture' : obj.picture,
			'token' : token,
			'url' : "<c:out value='${param.url}'/>"
		}; // 보낼정보들을 저장시킨다
		$.ajax({ // 에이작스로 저장된정보들을 보냄
			url : "confirmURL",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(login_info),
			success : function(result) { //아이디의 url 값을 조회하여 맞지 않다면, 맞지 않는 url을 조회하여 이동, url이 없는경우에는 초기페이지로 이동.
			
				/* if(result != 'success'){
					location.replace("main.do");
				}  */
			},
			beforeSend : function() {
			//	$('.wrap-loading').removeClass('display-none');
			},
			complete : function() {
			// 	$('.wrap-loading').addClass('display-none');
			},
			error : function(request, status, errorData) {
				console.log("error code : " + request.status + "\n"
						+ "message : " + request.responseText + "\n"
						+ "error : " + errorData);
			},
			timeout : 100000
		});

}
</script>
<header class="main-header">

    <!-- Logo -->
    <a href="menu.do" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>Oh!</b></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Oh!ffice</b></span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <!-- The user image in the navbar-->
            
              <!-- hidden-xs hides the username on small devices so only the image appears. -->
              <span class="hidden-xs">${ sessionScope.loginUser.emp_name }</span>
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              <li class="user-header">
                <p class="emailp">
                <i class="fa fa-fw fa-envelope-o"></i>
                <span class="user-email">${ sessionScope.loginUser.emp_email }</span>
                </p>
              </li>
              <!-- Menu Body -->
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-center">
                    <a class="btn btn-app" href=""><i class="fa fa-edit"></i>기안문서</a>
                  </div>               
                  <div class="col-xs-4 text-center">
                    <a class="btn btn-app" href=""><i class="fa fa-edit"></i>수신문서</a>
                  </div>
                </div>
                <!-- /.row -->
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="myInfo.do" class="btn btn-default btn-flat">나의정보</a>
                </div>
                <div class="pull-right">
                  <a href="javascript:handleSignoutClick();" class="btn btn-default btn-flat">로그아웃</a>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>
</body>
	<!-- Google plus Login -->
	<script async defer src="https://apis.google.com/js/api.js"
		onload="this.onload=function(){};handleClientLoad()"
		onreadystatechange="if (this.readyState === 'complete') this.onload()"></script>
</html>