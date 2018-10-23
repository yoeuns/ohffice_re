<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!-- Main Header -->
<%@ include file="../menu/header.jsp"%>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 모달 때문에 -->
<link rel="stylesheet" href="/ohffice/resources/css/bootstrap.min.css">

<style type="text/css">

</style>

<script type="text/javascript">
$(function() {
	// 나의 url 불러오기
	var myUrl = "${sessionScope.loginUser.com_url}"; 
	
	// 게시판 리스트 불러오기

	$.ajax({
		url: "divisionlist.do",
		type: "post",
		dataType: "json",
		success: function(obj) {
			// 리턴된 객체를 문자열로 변환함
			var objStr = JSON.stringify(obj);
			// 문자열을 json 객체로 바꿈
			var jsonObj = JSON.parse(objStr);
			
			var outValues = "";
			
			for(var i in jsonObj.list) {
				var myUrl = "${sessionScope.loginUser.com_url}";
				var com_url = jsonObj.list[i].com_url;
				if(myUrl == com_url) { 
					var visible = jsonObj.list[i].board_visible;
					var visible_str = "";
					if(visible == 'Y') {
						visible_str = "<td><input type='checkbox' id='visible' name='visible' checked></td>";
					}
					else {
						visible_str = "<td><input type='checkbox' id='visible' name='visible'></td>";
					}
					outValues += "<tr><td style='display: none'>" + jsonObj.list[i].division_num + "</td> " +
								 "<td>" + jsonObj.list[i].division_name + "</td> " +
								 visible_str +
								 "<td><input type='button' class='btn btn-block btn-info' data-toggle='modal' data-target='#modifyB' value='수정' id='modifyBtn'></td> " +
								 "<td><input type='button' class='btn btn-block btn-info' value='삭제' id='deleteBtn'></td></tr>";
				 }
			}
			
			$("#boardTbl").html($("#boardTbl").html() + outValues);
		}
	});
	
	//부서 리스트 불러오기
	$.ajax({
		url: "deptlist.do",
		type: "get",
		dataType: "json",
		success: function(obj) {
			// 리턴된 객체를 문자열로 변환함
			var objStr = JSON.stringify(obj);
			// 문자열을 json 객체로 바꿈
			var jsonObj = JSON.parse(objStr);
			
			var outValues = "";
			
			for(var i in jsonObj.list) {
				var com_url = jsonObj.list[i].com_url;
				if(myUrl == com_url) { 
				outValues += "<tr><td style='display: none'>" + jsonObj.list[i].dept_num + "</td> " +
							 "<td>" + jsonObj.list[i].dept_name + "</td>" +
							 "<td><input type='checkbox' id='deptChk' name='deptChk'></tr>";
				}
			}
			
			$("#deptTbl").html($("#deptTbl").html() + outValues); 
		}
	});
	
	$("#insertBoard").on("click", function() {
		var division_name = $("#inputBName").val();
		if(division_name == "" || $("#inputBName").val() == "") {
			$("#inputBName").attr("style", "background-color: rgba(255, 0, 0, .2);");
		}
		else {
			$("#inputBName").attr("style", "");
			$.ajax({
				url: "insertDivision.do",
				data: {division_name: division_name, com_url: myUrl},
				type: "post",
				success: function(result) {
					if(result == "ok") {
						location.href = "moveBoardSetting.do";
					} else {
						alert("게시판 등록에 실패하였습니다.");
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
	
	$(document).on("click","#modifyBtn",function(){
		var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var division_num = td.eq(0).text();
			
		$("#division_num").attr("value", division_num);		
	});
	
	$("#modifyBSave").on("click", function() {
		var division_num = $("#division_num").val();
		var newBName = $("#newBName").val();
		if(newBName == "" || $("#newBName").val() == "") {
			$("#newBName").attr("style", "background-color: rgba(255, 0, 0, .2);");
		}
		else {
			$("#newBName").attr("style", "");
			$.ajax({
				url: "modifyDivision.do",
				data: {newBName: newBName, division_num: division_num},
				type: "post",
				success: function(result) {					
					if(result == "ok") {
						location.href = "moveBoardSetting.do";
					} else {
						alert("게시판명 수정을 실패하였습니다.");
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

	
	$(document).on("click","#deleteBtn", function(){
		var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var division_num = td.eq(0).text();

		$.ajax({
			url: "deleteDivision.do",
			data: {division_num: division_num},
			type: "post",
			success: function(result) {
				if(result == "ok") {
					location.href = "moveBoardSetting.do";
				} else {
					alert("게시판 삭제에 실패하였습니다.");
				}					
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n" +
					  "message : " + request.responseText + "\n" +
					  "error : " + errorData);				
			}
		});
	});
	
	$(document).on("click", "#visible", function() {
		var tdArr = new Array();
		var checkbox = $("input[name=visible]:checked");
		tdArr.push(myUrl);
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			// checkbox.parent() : checkbox의 부모는 <td>이다.
			// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			// 체크된 row의 모든 값을 배열에 담는다.
			/* rowData.push(tr.text()); */
			
			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			var dept_num = td.eq(0).text();
			
			// 가져온 값을 배열에 담는다.
			tdArr.push(dept_num);
		});
		
		 $.ajax({
			url: "boardVisible.do",
			data: JSON.stringify(tdArr),
			type: "post",
			contentType: "application/json; charset=utf-8",
			success: function() {
				location.href = "moveBoardSetting.do";
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n" +
					  "message : " + request.responseText + "\n" +
					  "error : " + errorData);				
			}
		});  		
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



		<!-- Left side column. contains the logo and sidebar -->
		<%@ include file="../menu/aside.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Board Setting <small>Insert, Delete, Modify Board</small>
				</h1>
				<!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol> -->
			</section>

			<!-- Main content -->
			<!-- 여기에 내용 -->
			<section class="content container-fluid">
				<!-- 여기부터 수정하기 -->
		
					<div class="col-md-3">
					</div>
					<div class="col-md-6">
						<div class="box box-default">
							<div class="box-body">
								<div class="box-body no-padding">
									<div class="input-group input-group-sm col-sm-12">
										<input id="inputBName" name="inputBName" style="" type="text" class="form-control" placeholder="추가할 게시판 명을 입력해주세요."> 
										<span class="input-group-btn"> 
										<a id="insertBoard" class="btn btn-info btn-flat">+</a>														
										</span>
									</div>
									<table id="boardTbl" class="table" style="text-align: center;">
										<thead>
										<tr style="text-align: center;">
											<th style="text-align: center; display: none"></th>
											<th style="text-align: center;" class="col-sm-6">게시판 이름</th>
											
											<th style="text-align: center;">게시판 표시</th>
											<th></th>
											<th></th>
										</tr>
										</thead>								
									</table>
								</div>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<div class="col-md-3"></div>

		  <!-- 게시판명 변경 모달 -->
          <div class="modal fade" id="modifyB">
          <div class="modal-dialog modal-dialog-centered"">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">게시판명 변경</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
              	<input id="division_num" type="hidden" value="">
                <input id="newBName" style="" type="text" class="form-control" placeholder="게시판명을 입력해주세요."> 
              </div>
              <div class="modal-footer">
             	<a id="modifyBSave" class="btn btn-info btn-flat">Save</a>	
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
        
        <!-- 게시판 권한 선택 모달 -->
          <div class="modal fade" id="authB">
          <div class="modal-dialog modal-dialog-centered"">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">게시판 권한 선택</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
              	<input id="division_num" type="hidden" value="">
              	<table id="deptTbl" class="table" style="text-align: center;">
              		<thead>
              			<th style="text-align: center; display: none"></th>
						<th style="text-align: center;">부서명</th>
						<th style="text-align: center;"><input type="checkbox" name="selectAll" id="selectAll"></th>											
              		</thead>					
				</table> 			
              </div>
              <div class="modal-footer">
             	<a id="authBSave" class="btn btn-info btn-flat">Save</a>	
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

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
														