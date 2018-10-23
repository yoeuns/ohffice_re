<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../menu/header.jsp"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AdminLTE 2 | Mailbox</title>

<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

</head>
<style>
@media (min-width: 768px)
.modal-dialog {
    width: 600px;
    margin: 30px auto;
}
</style>
<body class="hold-transition skin-blue sidebar-mini">

	<script type="text/javascript">
		var doc = {
			"com_url" : "",
			"doc_id" : "",
			"doc_name" : "",
			"doc_writer" : "",
			"doc_approvers" : "",
			"doc_receivers" : ""
		}
		
		var auth2;
		var DISCOVERY_DOCS = [ "https://www.googleapis.com/discovery/v1/apis/drive/v3/rest" ]
		var SCOPES = [ 'https://www.googleapis.com/auth/drive', 'profile',
				'https://mail.google.com/' ];
		var CLIENT_ID = '587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com';
		var API_KEY = 'AIzaSyBhi9PSQYrFOw0MBWCZusHQFfawVxzU5Vc';
		var token = "";
		var login_info;
		var myUrl = "${sessionScope.loginUser.com_url}"; 
		var masterCopyfile = {
			"일반행사계획서" : "1mnrYjI958jQcCDkNTJwKXD7aqGmVOdiQd5F8S-mcyBc",
			"면접평가서" : "1rNo9Ai4_ut4UnaNJn9m5s24uuxb8ligHY-vUwdzNnyM"

		}

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
		}

		$(document)
				.ready(
						function() {

							info(); // 구글 로그인 정보를 담당한다.

							var today = new Date();
							var dd = today.getDate();
							var mm = today.getMonth() + 1; //January is 0!
							var yyyy = today.getFullYear();

							if (dd < 10) {
								dd = '0' + dd
							}

							if (mm < 10) {
								mm = '0' + mm
							}
							today = yyyy + '' + mm + '' + dd;

							$("a[name='document']")
									.click(
											function() {
												
												var thisvalue = $(this).html();
												var access_token = gapi.auth
														.getToken().access_token;
												var request = gapi.client
														.request({
															'path' : '/drive/v2/files/',
															'method' : 'POST',
															'headers' : {
																'Content-Type' : 'application/json',
																'Authorization' : 'Bearer '
																		+ access_token,
															},
															'body' : {
																"title" : $(
																		this)
																		.html()
																		+ "-"
																		+ login_info['name']
																		+ "-"
																		+ today,
																"mimeType" : "application/vnd.google-apps.folder",
																"parents" : [ {
																	"kind" : "drive#file",
																	"id" : $(
																			this)
																			.attr(
																					"id")
																} ]
															}
														});
												request
														.execute(function(resp) {
															if (!resp.error) {

																console
																		.log("folder create success folder ID : "
																				+ resp.id);
																if (thisvalue == "면접평가서") {

																	var access_token = gapi.auth
																			.getToken().access_token;
																	var request = gapi.client
																			.request({
																				'path' : '/drive/v2/files/'
																						+ masterCopyfile["면접평가서"]
																						+ '/copy',
																				'method' : 'POST',
																				'headers' : {
																					'Content-Type' : 'application/json',
																					'Authorization' : 'Bearer '
																							+ access_token,
																				},
																				'body' : {
																					"title" : thisvalue
																							+ "-"
																							+ login_info['name']
																							+ "-"
																							+ today,
																					"mimeType" : "application/vnd.google-apps.spreadsheet",
																					"parents" : [ {
																						"kind" : "drive#file",
																						"id" : resp.id
																					} ]
																				}
																			})
																	request
																			.execute(function(
																					resp) {
																				if (!resp.error) {
																					console
																							.log("file copy success file ID : "
																									+ resp.id);
																					$("#googledrive").attr("href","https://docs.google.com/spreadsheets/d/"+resp.id);
																					$("iframe").attr("src","https://docs.google.com/spreadsheets/d/"+resp.id);
							
																					$("#title").val(resp.title)
																					$("#myname").html(login_info["name"])
																					$("#myModal").modal('show');
																					doc['doc_id'] = resp.id;
																					doc['doc_writer'] = login_info["email"];
																					
																				} else {

																				}
																			});
																} else if (thisvalue == "일반행사계획서") {
																	var access_token = gapi.auth
																			.getToken().access_token;
																	var request = gapi.client
																			.request({
																				'path' : '/drive/v2/files/'
																						+ masterCopyfile["일반행사계획서"]
																						+ '/copy',
																				'method' : 'POST',
																				'headers' : {
																					'Content-Type' : 'application/json',
																					'Authorization' : 'Bearer '
																							+ access_token,
																				},
																				'body' : {
																					"title" : thisvalue
																							+ "-"
																							+ login_info['name']
																							+ "-"
																							+ today,
																					"mimeType" : "application/vnd.google-apps.spreadsheet",
																					"parents" : [ {
																						"kind" : "drive#file",
																						"id" : resp.id
																					} ]
																				}
																			})
																	request
																			.execute(function(
																					resp) {
																				if (!resp.error) {
																					console
																							.log("file copy success file ID : "
																									+ resp.id);
																					$("#googledrive").attr("href","https://docs.google.com/spreadsheets/d/"+resp.id);
																					$("#title").val(resp.title)
																					$("iframe").attr("src","https://docs.google.com/spreadsheets/d/"+resp.id);
																					$("#myname").html(login_info["name"])
																					$("#myModal").modal('show');
																					doc['doc_id'] = resp.id;
																					doc['doc_writer'] = login_info["email"];
																					
																				} else {

																				}
																			});
																} else {

																}
															} else {
																console
																		.log("Error: "
																				+ resp.error.message);
															}
														});

											});

							$("#approp").click(function() {
								$("#empList :selected").each(function() {
									var split = $(this).html()+"";
									var strarr = split.split(" ");
									doc['doc_receivers'] += strarr[2]+",";
									
 									$("#aproList").append("<li class='select2-selection__choice' name = 'reciver' title="+strarr[2]+">"
 									+ "<span class='select2-selection__choice__remove' role='presentation' onclick='remove(this)'>"
 									+ "x</span>"+strarr[1]+"</li>"
 									)
								})
							});

							$("#confirm").click(function() {
								$("#empList :selected").each(function() {
									
									var split = $(this).html()+"";
									var strarr = split.split(" ");
		
									var num = Number($("div[name='number']").last().html());
									doc['doc_approvers'] += strarr[2]+",";
									num++;
									
									
 									$("#confirmList").append("<li class='list-item' title ="+strarr[2]+"><div class='task-list-wrapper'>"
										+"<div class='task-item flex-row'>"
										+"<div class='flex-column fixed'>"
										+"<div></div>"
										+"</div>"
										+"<div class='flex-column fixed'>"
										+"<div class='task-order writer' name='number'>"+num+"</div>"
										+"</div>"
										+"<div class='flex-column'>"
										+"<span class='full-ellipsis'>"
										+ strarr[1] +"</span>"
										+"</div>"
										+"<span class='icon is-small' onclick='remove1(this)'>x</span>"
									    +"</div>"
								        +"</div></li>"
 									)
									
								});
							})
							dept();
							
							

						});
		function remove(event){
		 	doc['doc_receivers']  = doc['doc_receivers'].replace($(event).parents("li").attr("title")+",","");
			$(event).parents("li").remove();
		}
		
		function remove1(event){
			doc['doc_approvers']  = doc['doc_approvers'].replace($(event).parents("li").attr("title")+",","");
			$(event).parents("li").remove();
		}
		function dept() { //사원을불러오는 ajax
			var deptList = "";
			$.ajax({
				url : "emplist.do",
/* 				type : "post", */
				contentType : "application/json; charset=utf-8",
				async : false,
				success : function(obj) {
					console.log(obj); //object라고 출력함
					//리턴된 객체를 문자열로 변환함.
					var objStr = JSON.stringify(obj);
					//문자열을 json 객체로 바꿈
					var jsonObj = JSON.parse(objStr);
					//문자열 변수 준비
					for ( var i in jsonObj.list) {
						var com_url = jsonObj.list[i].com_url;
						if(myUrl == com_url) { 	
							deptList += "<option>(" + jsonObj.list[i].dept_name + ") "
							+ jsonObj.list[i].emp_name + " "
							+ jsonObj.list[i].emp_email + "</option>"
						}
					}
				},
				/* beforeSend : function() {
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				}, */
				error : function(request, status, errorData) {
					console.log("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
				},
				timeout : 100000

			});
			$('#empList').html(deptList);
		}
		
		function inserDoc(){ //기안 버튼클릭시
			doc['com_url'] = "<c:out value='${sessionScope.loginUser.com_url}'/>"
			doc['doc_name'] = $("#title").val();
			$.ajax({ // 에이작스로 저장된정보들을 보냄
				url : "insertDocument",
				type : "post",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(doc),
				success : function(result) {
					alert(result);
					/* if(result != 'success'){
						location.replace();
					
					} */
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
	<div class="wrapper">

		<!-- Main Header -->

		<!-- Left side column. contains the logo and sidebar -->
		<%@ include file="../menu/aside.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<!-- Modal -->
		<!-- Button trigger modal -->


		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document" style="width: 90%">
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
									<div
										class="dwsu-app-document-event-buttons flex-row gapless is-marginless wrap">
										<div class="flex-column">
											<a class="btn btn-primary" style="width: 187px; height: 50px"><span
												style="vertical-align: middle; font-size: 20px" id="doc_confirm" onclick="inserDoc();">기안 </span></a>
										</div>

										<a class="btn btn-primary" style="width: 187px; height: 50px"><span
											style="vertical-align: middle; font-size: 20px">임시저장 </span></a>

									</div>
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

		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>문서 양식</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">문서양식</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-md-3">
						<a href="compose.html"
							class="btn btn-primary btn-block margin-bottom">자유 양식 기안</a>

						<div class="box box-solid">

						
							<!-- /.box-body -->
						</div>
						<!-- /. box -->
						<a href="#" class="btn btn-block btn-success btn-lg">

							<h4 class="box-title">개인 문서 양식</h4>

						</a>
						<div class="box box-solid">
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
					<div class="col-md-9">
						<div class="box box-primary">

							<!-- /.box-header -->
							<div class="box-body no-padding">

								<div class="table-responsive mailbox-messages">
									<table class="table table-hover table-striped">
										<tbody>

											<c:forEach items="${FolderList}" var="f">
												<c:choose>
													<c:when test="${f.folder_name eq '면접평가서'}">
														<tr>
															<td><input type="checkbox"></td>

															<td><i class="fa fa-file-excel-o fa-2x"></i></td>


															<td class="mailbox-name"><a href="#"
																style="font-size: 13pt;" name="document"
																id="${f.folder_id}">면접평가서</a></td>

															<td class="mailbox-subject"><p>면접에 대한 평가를 위한 문서
																	양식입니다.</p></td>
															<td class="mailbox-attachment"></td>

														</tr>
													</c:when>
													<c:when test="${f.folder_name eq '일반행사계획서'}">
														<tr>
															<td><input type="checkbox"></td>

															<td><i class="fa fa-file-excel-o fa-2x"></i></td>

															<td class="mailbox-name"><a href="#"
																style="font-size: 13pt" name="document"
																id="${f.folder_id}">일반행사계획서</a></td>

															<td class="mailbox-subject"><p>일반적인 행사를 계획하는데
																	사용하는 양식입니다.</p></td>
															<td class="mailbox-attachment"></td>

														</tr>
													</c:when>
												
													<c:otherwise>

													</c:otherwise>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
									<!-- /.table -->
								</div>
								<!-- /.mail-box-messages -->
							</div>
							<!-- /.box-body -->
							<div class="box-footer no-padding"></div>
						</div>
						<!-- /. box -->
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->


		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li><a href="#control-sidebar-home-tab" data-toggle="tab"><i
						class="fa fa-home"></i></a></li>
				<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
						class="fa fa-gears"></i></a></li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript:void(0)"> <i
								class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
						</a></li>
						<li><a href="javascript:void(0)"> <i
								class="menu-icon fa fa-user bg-yellow"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Frodo Updated His
										Profile</h4>

									<p>New phone +1(800)555-1234</p>
								</div>
						</a></li>
						<li><a href="javascript:void(0)"> <i
								class="menu-icon fa fa-envelope-o bg-light-blue"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Nora Joined Mailing
										List</h4>

									<p>nora@example.com</p>
								</div>
						</a></li>
						<li><a href="javascript:void(0)"> <i
								class="menu-icon fa fa-file-code-o bg-green"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Cron Job 254
										Executed</h4>

									<p>Execution time 5 seconds</p>
								</div>
						</a></li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript:void(0)">
								<h4 class="control-sidebar-subheading">
									Custom Template Design <span
										class="label label-danger pull-right">70%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger"
										style="width: 70%"></div>
								</div>
						</a></li>
						<li><a href="javascript:void(0)">
								<h4 class="control-sidebar-subheading">
									Update Resume <span class="label label-success pull-right">95%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-success"
										style="width: 95%"></div>
								</div>
						</a></li>
						<li><a href="javascript:void(0)">
								<h4 class="control-sidebar-subheading">
									Laravel Integration <span
										class="label label-warning pull-right">50%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-warning"
										style="width: 50%"></div>
								</div>
						</a></li>
						<li><a href="javascript:void(0)">
								<h4 class="control-sidebar-subheading">
									Back End Framework <span class="label label-primary pull-right">68%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-primary"
										style="width: 68%"></div>
								</div>
						</a></li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab
					Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Report panel
								usage <input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Allow mail
								redirect <input type="checkbox" class="pull-right" checked>
							</label>

							<p>Other sets of options are available</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Expose author
								name in posts <input type="checkbox" class="pull-right" checked>
							</label>

							<p>Allow the user to show his name in blog posts</p>
						</div>
						<!-- /.form-group -->

						<h3 class="control-sidebar-heading">Chat Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Show me as
								online <input type="checkbox" class="pull-right" checked>
							</label>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Turn off
								notifications <input type="checkbox" class="pull-right">
							</label>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Delete chat
								history <a href="javascript:void(0)" class="text-red pull-right"><i
									class="fa fa-trash-o"></i></a>
							</label>
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


	<!-- Page Script -->
	<script>
		$(function() {
			//Enable iCheck plugin for checkboxes
			//iCheck for checkbox and radio inputs

			//Enable check and uncheck all functionality
			$(".checkbox-toggle").click(
					function() {
						var clicks = $(this).data('clicks');
						if (clicks) {
							//Uncheck all checkboxes
							$(".mailbox-messages input[type='checkbox']")
									.iCheck("uncheck");
							$(".fa", this).removeClass("fa-check-square-o")
									.addClass('fa-square-o');
						} else {
							//Check all checkboxes
							$(".mailbox-messages input[type='checkbox']")
									.iCheck("check");
							$(".fa", this).removeClass("fa-square-o").addClass(
									'fa-check-square-o');
						}
						$(this).data("clicks", !clicks);
					});

			//Handle starring for glyphicon and font awesome
			$(".mailbox-star").click(function(e) {
				e.preventDefault();
				//detect type
				var $this = $(this).find("a > i");
				var glyph = $this.hasClass("glyphicon");
				var fa = $this.hasClass("fa");

				//Switch states
				if (glyph) {
					$this.toggleClass("glyphicon-star");
					$this.toggleClass("glyphicon-star-empty");
				}

				if (fa) {
					$this.toggleClass("fa-star");
					$this.toggleClass("fa-star-o");
				}
			});
		});

		  $(function () {
		    $('#example1').DataTable()
		    $('#example2').DataTable({
		      'paging'      : true,
		      'lengthChange': false,
		      'searching'   : false,
		      'ordering'    : true,
		      'info'        : true,
		      'autoWidth'   : false
		    })
		  })
	</script>

</body>

</html>

