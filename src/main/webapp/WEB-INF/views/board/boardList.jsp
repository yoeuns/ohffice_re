<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Oh!ffice</title>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 부트스트랩 모달 필요 링크 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- 에디터 필요 요소 불러오기 -->
<script	src="/ohffice/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<link rel="stylesheet" href="/ohffice/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<style>
/* 글쓰기 버튼 */
#tt {
	left: 500px;
	width: 200px;
}
/* 글쓰기 수정 버튼 */	
   #modyBtn{
  width:45px;
  height:25px;
  border:1px solid #D8D8D8;
  background-color: #D8D8D8;
  float:center;
  font-size:12px;
  font-weight:bold;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 0;
} 

   #deleBtn{
  width:45px;
  height:25px;
  border:1px solid #D8D8D8;
  background-color: #D8D8D8;
  float:center;
  font-size:12px;
  font-weight:bold;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 0;
} 

</style>
<script type="text/javascript">
$(function() {
	
    var divisionNum = ${division_num};
	
	var comUrl = "${sessionScope.loginUser.com_url}"; 
	var empEmail =  "${sessionScope.loginUser.emp_email}"; 
	
	if(divisionNum == "0"){
		
		$.ajax({
			url: "boardBasic.do",
			type: "post",
			sync : false,
			data : {com_url: comUrl},
			dataType: "json",
			success: function(obj) {
				
				var objStr = JSON.stringify(obj);
				var jsonObj = JSON.parse(objStr);

				var outValues = "";
							
				for(var i in jsonObj.list) {
					outValues += "<div class='box box-default'><div class='box-header with-border'><h3 class='box-title'>"+
								  jsonObj.list[i].board_title + "</h3><br><small>" + jsonObj.list[i].board_date + "&nbsp&nbsp&nbsp" + jsonObj.list[i].board_email
								  +"</small></div> " +"<div class='box-body'>"
								  + jsonObj.list[i].board_content +"<br><br><br>"
								  +"<table><tr><td style='display: none'><input type='hidden' value='"+ jsonObj.list[i].board_num +"' id='board_num'>" + jsonObj.list[i].board_num + "</td>"
								  +"<td><input type='button' data-toggle='modal' data-target='#modalModify' value='수정' id='modyBtn'></td>"
								  +"<td><input type='button' value='삭제' id='deleBtn'></td></tr></table></div></div>";		
				}
				$("#boardView").html(outValues);
				
			}
		}); 
		
	}else{
	 $.ajax({
		url: "boardList.do",
		type: "post",
		sync : false,
		data : {division_num: divisionNum},
		dataType: "json",
		success: function(obj) {
			
			var objStr = JSON.stringify(obj);
			var jsonObj = JSON.parse(objStr);

			var outValues = "";
						
			for(var i in jsonObj.list) {
				outValues += "<div class='box box-default'><div class='box-header with-border'><h3 class='box-title'>"+
							  jsonObj.list[i].board_title + "</h3><br><small>" + jsonObj.list[i].board_date + "&nbsp&nbsp&nbsp" + jsonObj.list[i].board_email
							  +"</small></div> " +"<div class='box-body'>"
							  + jsonObj.list[i].board_content +"<br><br><br>"
							  +"<table><tr><td style='display: none'><input type='hidden' value='"+ jsonObj.list[i].board_num +"' id='board_num'>" + jsonObj.list[i].board_num + "</td>"
							  +"<td><input type='button' data-toggle='modal' data-target='#modalModify' value='수정' id='modyBtn'></td>"
							  +"<td><input type='button' value='삭제' id='deleBtn'></td></tr></table></div></div>";		
			}
			$("#boardView").html(outValues);
			
		}
	}); 
	}//else끝	 
	 
	 $(document).on("click","#modyBtn",function(){
	    var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var boardNum = td.eq(0).text();
		 
		$("#board_Num").attr("value", boardNum);	 
		
		  $.ajax({
				url: "boardSelect.do",
				data: {board_num: boardNum, division_num: divisionNum, com_url: comUrl},
				type: "post",
				success: function(obj) {
					var objStr = JSON.stringify(obj);
					var jsonObj = JSON.parse(objStr);
					
					var values = "";
					
					for(var i in jsonObj.list) {
					values = "<input type = 'text' id = 'modyTitle' value='"+jsonObj.list[i].board_title+"' placeholder='게시글 제목을 입력하세요!' style='width: 100%; "+
					    "height: 30px; font-size: 14px; line-height: 15px; border: 1px solid #dddddd; padding: 10px; bottom: 20px;'/>"+
						"<br><br>"+
						"<textarea class='modyText' placeholder='게시글 내용을 입력하세요!' "+
						"style='width: 100%; height: 200px; font-size: 12px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;'>"+jsonObj.list[i].board_content+"</textarea>";

					}
					    $("#selectOne").html(values); 
				} 
			}); 
		  }); 

 	 $("#updateButton").click(function(){
 		var boardNum = $("#board_Num").val();
 		var title = $("#modyTitle").val();
		var text = $(".modyText").val();
		
		if(text == "") {
			alert("게시글 내용을 입력해주세요!");
		}else if(title == ""){
			alert("게시글 제목을 입력해주세요!");
		}else{
		 	$.ajax({
				url: "updateBoard.do",
				data: {division_num: divisionNum, board_num: boardNum, board_title: title, board_content: text, com_url: comUrl},
				type: "post",
				success: function(result) {
					if(result == "ok") {
						alert("게시글이 수정 되었습니다.");
						if(divisionNum == "0"){
 							location.href = "moveBoard.do";
 						}else{
 							location.href = "moveBoardList.do?division_num="+divisionNum; 						
 						}
					} else {
						alert("게시글 수정에 실패하였습니다.");
					}					
				},
				error: function(request, status, errorData) {
					alert("error code : " + request.status + "\n" +
						  "message : " + request.responseText + "\n" +
						  "error : " + errorData);				
				}
			}); 		
		}
 	 });
 	 
 	 $(document).on("click","#deleBtn",function(){
 		var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var boardNum = td.eq(0).text();
		
		var retVal = confirm("정말로 삭제 하시겠습니까?");
		
		if(retVal == false){
			location.href = "moveBoardList.do?division_num="+divisionNum;
		}else{
 		 	$.ajax({
 				url: "deleteBoard.do",
 				data: {division_num: divisionNum, board_num: boardNum, com_url: comUrl},
 				type: "post",
 				success: function(result) {
 					if(result == "ok") {
 						alert("게시글이 삭제 되었습니다.");
 						if(divisionNum == "0"){
 							location.href = "moveBoard.do";
 						}else{
 							location.href = "moveBoardList.do?division_num="+divisionNum; 						
 						}
 					} else {
 						alert("게시글 삭제에 실패하였습니다.");
 					}					
 				},
 				error: function(request, status, errorData) {
 					alert("error code : " + request.status + "\n" +
 						  "message : " + request.responseText + "\n" +
 						  "error : " + errorData);				
 				}
 			}); 		
 		} 
  	 });

			 
	 	$("#insertButton").on("click", function() {
	 		var title = $("#title").val();
			var text = $(".textarea").val();
			
			if(text == "") {
				alert("게시글 내용을 입력해주세요!");
			}
			 else {
				$.ajax({
					url: "insertBoard.do",
					data: {division_num: divisionNum, com_url: comUrl,  
						emp_email: empEmail , board_title: title, board_content: text},
					type: "post",
					success: function(result) {
						if(result == "ok") {
							alert("게시글이 등록 되었습니다.");
							if(divisionNum == "0"){
	 							location.href = "moveBoard.do";
	 						}else{
	 							location.href = "moveBoardList.do?division_num="+divisionNum; 						
	 						}
						} else {
							alert("게시글 등록에 실패하였습니다.");
						}					
					},
					error: function(request, status, errorData) {
						alert("error code : " + request.status + "\n" +
							  "message : " + request.responseText + "\n" +
							  "error : " + errorData);				
					}
				});
			} 
		}); 
	  
}); 

</script>
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
		<!-- Main Header -->
		<%@ include file="../menu/header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@ include file="../menu/aside.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Modal HTML embedded directly into document -->
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					게시글
				</h1>
				<input type='button' id="tt" class='btn btn-block btn-info'
					data-toggle="modal" data-target="#modalInsert" value='글쓰기'>
			</section>
			<!-- Modal -->
			<div class="modal fade" id="modalInsert" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">게시글 작성</h4>
						</div>
						<div class="modal-body">
							<!-- 모달 내용 -->
							<section class="content">
								<div class="row">
									<div class="col-md-12">
										<div class="box">
											<div class="box-header">
												<h3 class="box-title">${sessionScope.loginUser.emp_name}</h3>
												<!-- tools box -->
												<div class="pull-right box-tools">
													<button type="button" class="btn btn-default btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
														<i class="fa fa-minus"></i>
													</button>
												</div>
												<!-- /. tools -->
											</div>
											<!-- /.box-header -->
											<div class="box-body pad">
												<form method="post">
												    <input type = "text" id = "title" placeholder="게시글 제목을 입력하세요!" style="width: 100%; 
												    height: 30px; font-size: 14px; line-height: 15px; border: 1px solid #dddddd; padding: 10px; bottom: 20px;"/>
													<br><br>
													<textarea class="textarea" placeholder="게시글 내용을 입력하세요!"
														style="width: 100%; height: 200px; font-size: 12px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
														<center><button type="button" id="insertButton" class="btn btn-default" style= "margin-top:20px;">Save</button></center>
												</form>
											</div>
										</div>
									</div>
									<!-- /.col-->
								</div>
								<!-- ./row -->
							</section>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div><!-- 공지사항 입력 모달 끝 -->
			
			<!-- update Modal -->
			<div class="modal fade" id="modalModify" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">게시글 수정</h4>
						</div>
						<div class="modal-body">
							<!-- 모달 내용 -->
							<section class="content">
								<div class="row">
									<div class="col-md-12">
										<div class="box">
											<div class="box-header">
												<h3 class="box-title">${sessionScope.loginUser.emp_name}</h3>
												<!-- tools box -->
												<div class="pull-right box-tools">
													<button type="button" class="btn btn-default btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
														<i class="fa fa-minus"></i>
													</button>
												</div>
												<!-- /. tools -->
											</div>
											<!-- /.box-header -->
											<div class="box-body pad">
												<form action = 'boardSelect.do' method="post" id="selectOne">						
												</form>
												<input id='board_Num' type='hidden' value=''>
												<center><button type='button' id='updateButton' class='btn btn-default' style= 'margin-top:20px;'>Save</button></center>
											 </div>
										</div>
									</div>
									<!-- /.col-->
								</div>
								<!-- ./row -->
							</section>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div><!-- 공지사항 수정 모달 끝 -->
			

			<!-- Main content -->
			<!-- 공지사항 내용 출력 -->
			<section id="boardView" class="content container-fluid">
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
				<li class="active"><a href="#control-sidebar-home-tab"
					data-toggle="tab"><i class="fa fa-home"></i></a></li>
				<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
						class="fa fa-gears"></i></a></li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript:;"> <i
								class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
						</a></li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design <span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger"
										style="width: 70%"></div>
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
