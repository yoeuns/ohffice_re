<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Main Header -->
<%@ include file="../menu/header.jsp"%>
<!DOCTYPE>
<html>
<head>
<script type="text/javascript">

var auth2;
var DISCOVERY_DOCS = [ "https://www.googleapis.com/discovery/v1/apis/drive/v3/rest" ]
var SCOPES = [ 'https://www.googleapis.com/auth/drive', 'profile',
		'https://mail.google.com/' ];
var CLIENT_ID = '587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com';
var API_KEY = 'AIzaSyBhi9PSQYrFOw0MBWCZusHQFfawVxzU5Vc';
var token = "";
var login_info;
var order = 0;
function info() {
	gapi
			.load(
					'client:auth2',
					function() {
				
						gapi.client
								.init({
									apiKey : API_KEY, //THIS IS OPTIONAL AND WE DONT ACTUALLY NEED THIS, BUT I INCLUDE THIS AS EXAMPLE
									clientId : CLIENT_ID,
									scope : SCOPES.join(' '),
									discoveryDocs : DISCOVERY_DOCS
								})
								.then(
										function() {

											gapi.auth2
													.getAuthInstance().isSignedIn
													.listen(function() {
														if (isSignedIn) {
															token = gapi.client
																	.getToken().id_token;
															gapi.client
																	.load(
																			'oauth2',
																			'v2',
																			function() {
																				var request = gapi.client.oauth2.userinfo
																						.get();
																				request
																						.execute(getEmailCallback);
																			});
														} else {//로그인이 되어있지 않다면
															alert("로그인이 되어있지 않습니다.");
														}

													});
											updateSigninStatus(gapi.auth2
													.getAuthInstance().isSignedIn
													.get());

										});
					});

};

function getEmailCallback(obj) {// 프로필 정보는 넘겨받은 obj값들중 선택하여 뽑아내면 됨.
	login_info = {
		'name' : obj.name,
		'email' : obj.email,
		'id' : obj.id,
		'picture' : obj.picture,
		'token' : token
	}; // 보낼정보들을 저장시킴
	 order++;
	asyncFunc();
}
function asyncFunc(){
	if(order == 1){
		ajax();
	}
}
$(document)
		.ready(
				function() {
					
					info();
					
					
					
				});
		  
function ajax(){

	 $.ajax({ // 에이작스로 저장된정보들을 보냄
			url : "draftList.do",
			type : "get",
			data :  {'email1' : login_info['email']},
			contentType : "application/json; charset=utf-8",
			success : function(obj) { //아이디의 url 값을 조회하여 맞지 않다면, 맞지 않는 url을 조회하여 이동, url이 없는경우에는 초기페이지로 이동.
				console.log(obj); //object라고 출력함
				//리턴된 객체를 문자열로 변환함.
				var objStr = JSON.stringify(obj);
				//문자열을 json 객체로 바꿈
				var jsonObj = JSON.parse(objStr);
				//문자열 변수 준비
				for ( var i in jsonObj.list) {
					$("#data").append(""
							+"<tr onclick = 'openModal(this);' id="+jsonObj.list[i].doc_num+">"
							+"<td>"+jsonObj.list[i].doc_num+"</td>"
							+"<td>"+jsonObj.list[i].doc_con+"</td>"
							+"<td>"+jsonObj.list[i].doc_name+"</td>"
							+"<td>"+jsonObj.list[i].doc_writer+"</td>"
							+"<td>"+jsonObj.list[i].doc_date+"</td>"
		             	+"</tr>")
				}
				   $('#example2').DataTable({
					      'paging'      : true,
					      'lengthChange': true,
					      'searching'   : true,
					      'ordering'    : true,
					      'info'        : true,
					      'autoWidth'   : true
					    })
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
function openModal(event){

	 $.ajax({ // 에이작스로 저장된정보들을 보냄
			url : "selectDocument.do",
			type : "get",
			data :  {'doc_num' : $(event).attr('id')},
			contentType : "application/json; charset=utf-8",
			success : function(obj) { //아이디의 url 값을 조회하여 맞지 않다면, 맞지 않는 url을 조회하여 이동, url이 없는경우에는 초기페이지로 이동.
				console.log(obj); //object라고 출력함
				//리턴된 객체를 문자열로 변환함.
				var objStr = JSON.stringify(obj);
				//문자열을 json 객체로 바꿈
				var jsonObj = JSON.parse(objStr);
				//문자열 변수 준비
				for ( var i in jsonObj.list) {
				/* 	$("#data").append(""
							+"<tr onclick = 'openModal(this);' id="+jsonObj.list[i].doc_num+">"
							+"<td>"+jsonObj.list[i].doc_num+"</td>"
							+"<td>"+jsonObj.list[i].doc_con+"</td>"
							+"<td>"+jsonObj.list[i].doc_name+"</td>"
							+"<td>"+jsonObj.list[i].doc_writer+"</td>"
							+"<td>"+jsonObj.list[i].doc_date+"</td>"
		             	+"</tr>")
				}
				   $('#example2').DataTable({
					      'paging'      : true,
					      'lengthChange': true,
					      'searching'   : true,
					      'ordering'    : true,
					      'info'        : true,
					      'autoWidth'   : true
					    }) */
			}
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
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Oh!ffice</title>
  

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<iframe
							src=""
							width="100%" height="800px" id="spreadsheat"></iframe>
						<div id="dwsu-app-document-editor-rightmenu" class="opened">
							<div class="toggle-button left-button">
								<span class="icon is-medium"><i aria-hidden="true"
									class="fa fa-angle-right"></i></span>
							</div>
							<div class="menu-body">
								<div class="menu-header-section">
							
									<br>
									<div class="dwsu-app-draft-title-section">

										<section class="dwsu-app-draft-section">
											<div class="flex-row">
												<div class="flex-column title-desc">
													<input type="text" class="input" id="title">
												</div>
											</div>
										</section>
										<hr>
									</div>
									<div class="">
										<section
											class="dwsu-app-draft-section dwsu-app-draft-label-section">

										</section>
									</div>
									<!---->
									<section
										class="dwsu-app-draft-section dwsu-app-draft-process-setting-section">
										<a class="button is-primary is-fullwidth"
											href="javascript:process();"><span class="icon"><i
												class="fa fa-cog  fa-3x"></i></span> <span style="font-size: 20px;">
												&nbsp; 프로세스 설정 </span></a>
									</section>
									<section id="proSection"
										class="dwsu-app-draft-section dwsu-app-draft-process-setting-section">

										<div class='form-group'>
											<div class='flex-column' style='width: 374px; height: 100px'>
												<select multiple class='form-control' id="empList">

												</select>
											</div>
										</div>
										<div
											class='dwsu-app-document-event-buttons flex-row gapless is-marginless wrap'>
											<div class='button' id='confirm'
												style='flex-direction: column; align-items: center; justify-content: center; width: 187px;'>
												<span class='icon'><i aria-hidden='true'
													class='fa  fa-check fa-2x'></i> </span>&nbsp; 승인자 <span
													class='dwsu-app-counter-tag tag is-rounded is-small is-dark'
													style='display: none;'><span> </span> <!----></span>
											</div>
											<div class='button' id='approp'
												style='flex-direction: column; align-items: center; justify-content: center; width: 187px;'>
												<span class='icon'> <i aria-hidden='true'
													class='fa fa-eye fa-2x'></i>
												</span>&nbsp; 수신자<span
													class='dwsu-app-counter-tag tag is-rounded is-small is-dark'
													style='display: none;'> <span>0</span> <!----></span>
											</div>
										</div>
									</section>

									<div class="bottom-buttons">
										<span class="dwsu-tooltip"><span class="trigger"><a
												onclick="ga('send', 'event', 'App_create doc', 'ButtonClick', '구글 드라이브에서 편리하게 편집하기')"
												href=""
												target="_blank" class="button bottom-button circled" id = "googledrive"><span
													class="icon is-small"><img
														src="https://icon-icons.com/icons2/478/PNG/32/google-drive_47008.png"
														class="docImage"></span></a></span>
											<div style="display: none;"></div></span>
										<!---->

									</div>
								</div>
								<div
									class="dwsu-pretty-scroll dwsu-app-draft-process ps ps--theme_dwsu"
									data-ps-id="0a6eff75-aa2b-1613-5601-7bb3438f0a67"
									style="max-width: 100%; max-height: 100%; height: 100%;">
									<div class="dwsu-pretty-scroll-wrapper"
										style="position: relative;">
										<div class="dwsu-app-remote-contents">
											<!---->
											<!---->
											<div class="dwsu-app-document-editor-process">
												<div class="dwsu-app-document-editor-tasks">
													<div class="dwsu-app-draft-contents-title flex-row">
														<div class="flex-column left">
															<span class="full-ellipsis"> 프로세스 (결재순서) </span>
														</div>
														<div class="flex-column right fixed"></div>
													</div>
													<section>
														<div class="dwsu-app-task-list">
															<ul class="list-group" id= "confirmList">
																<li class="list-item"><div
																		class="task-list-wrapper">
																		<div class="task-item flex-row">
																			<div class="flex-column fixed">
																				<div></div>
																			</div>
																			<div class="flex-column fixed">
																				<div class="task-order writer" name="number">1</div>
																			</div>
																			<div class="flex-column">
																				<span class="full-ellipsis" id="myname"></span>
																				<!---->
																			</div>
																			<div class="flex-column right fixed">
																				<span class="icon is-small"><i
																					class="fa fa-pencil"></i></span>
																			</div>
																			<!---->
																			<!---->
																		</div>
																	</div></li>
															</ul>
														</div>
													</section>
												</div>
												<div class="dwsu-app-document-editor-">
													<div class="dwsu-app-draft-contents-title flex-row">
														<div class="flex-column left">
															<span class="full-ellipsis">수신자</span>
														</div>
														<div class="flex-column right fixed"></div>
													</div>
													<section>
														<div class="dwsu-app-receiver-list">
															<div class="flex-row wrap gapless"></div>
															<div class="form-group">
																<span
																	class="select2 select2-container select2-container--default select2-container--below"
																	dir="ltr" style="width: 100%;"><span
																	class="selection"><span
																		class="select2-selection select2-selection--multiple"
																		role="combobox" aria-haspopup="true"
																		aria-expanded="false" tabindex="-1"><ul
																				class="select2-selection__rendered" id ="aproList">
																				
																				
																				
																			</ul></span></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>
															</div>
														</div>
													</section>
												</div>
												<hr>
												<div
													class="dwsu-app-document-event-buttons flex-row gapless is-marginless wrap">

													<div class="button"
														style="flex-direction: column; align-items: center; justify-content: center; width: 187px;">
														<span class="icon"><i aria-hidden="true"
															class="fa fa-commenting-o"></i></span>&nbsp;+Comment <span
															class="dwsu-app-counter-tag tag is-rounded is-small is-dark"
															style="display: none;"><span></span> <!----></span>
													</div>
													<div class="button"
														style="flex-direction: column; align-items: center; justify-content: center; width: 187px;">
														<span class="icon"><i aria-hidden="true"
															class="fa fa-paperclip"></i></span>&nbsp; +File<span
															class="dwsu-app-counter-tag tag is-rounded is-small is-dark"
															style="display: none;"><span>0</span> <!----></span>
													</div>
													<!---->
												</div>
											</div>
										</div>
										<object
											style="display: block; position: absolute; top: 0; left: 0; height: 100%; width: 100%; overflow: hidden; pointer-events: none; z-index: -1;"
											type="text/html" data="about:blank"></object>
									</div>
									<div class="ps__scrollbar-x-rail"
										style="left: 0px; bottom: 0px;">
										<div class="ps__scrollbar-x" tabindex="0"
											style="left: 0px; width: 0px;"></div>
									</div>
									<div class="ps__scrollbar-y-rail" style="top: 0px; right: 0px;">
										<div class="ps__scrollbar-y" tabindex="0"
											style="top: 0px; height: 0px;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save
							changes</button>
					</div>
				</div>
			</div>
		</div>
  <!-- Left side column. contains the logo and sidebar -->
<%@ include file="../menu/aside.jsp"%>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
            <div class="box">
            <div class="box-header">
              <h3 class="box-title">기안문서</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example2" class="table table-bordered table-hover">
                <thead>
                <tr>
                <th>문서번호</th>
                  <th>상태</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일자</th>
                </tr>
                </thead>
                <tbody id= "data">
          
                </tbody>
                <tfoot>
                <tr>
                </tr>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

    </section>

    <!-- Main content -->
    <section class="content container-fluid">
        
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
<%@ include file="../menu/footer.jsp"%>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->



<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>

</html>
