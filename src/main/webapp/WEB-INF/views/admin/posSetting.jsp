<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
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
<script type="text/javascript">
$(function() {
	var myUrl = "${sessionScope.loginUser.com_url}";
	
	(posList = function() {
	$.ajax({
		url: "posList.do",
		data: {com_url: myUrl},
		type: "post",
		dataType: "json",
		success: function (obj) {
			// 리턴된 객체를 문자열로 변환함
			var objStr = JSON.stringify(obj);
			// 문자열을 json 객체로 바꿈
			var jsonObj = JSON.parse(objStr);
			
			var outValues = "";
			
			$("#posTbl").html("");
			for(var i in jsonObj.list) {
				var com_url = jsonObj.list[i].com_url;
				if(myUrl == com_url) { 
					outValues += "<tr><td style='display: none'>" + jsonObj.list[i].pos_num + "</td> " +
								 "<td><input type='text' class='form-control' readonly style='background: white; border: 0; outline: 0;' value='" + jsonObj.list[i].pos_name  + "'></td>" +
								 "<td><button id='modifyBtn' style='background: white; border: 0; outline: 0;' data-toggle='modal' data-target='#modify'><i class='fa fa-edit'></i></button></td> " +
								 "<td><button style='background: white; border: 0; outline: 0;' id='deleteBtn'><i class='fa fa-trash-o'></i></button></td></tr>";
				}				
			}			
			$("#posTbl").html($("#posTbl").html() + outValues); 
		}
	});
	})();
	
	$(document).on("click","#modifyBtn", function() {
		var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var pos_num = td.eq(0).text();
		
		$("#pos_num").attr("value", pos_num);		
	});
	
	$("#modifySave").on("click", function() {
		var pos_num = $("#pos_num").val();
		var pos_name = $("#pos_name").val();
		if(pos_name == "" || $("#pos_name").val() == "") {
			$("#pos_name").attr("style", "background-color: rgba(255, 0, 0, .2);");
		}
		else {
			$("#pos_name").attr("style", "");
			$.ajax({
				url: "modifyPos.do",
				data: {pos_name: pos_name, pos_num: pos_num},
				type: "post",
				success: function(result) {					
					if(result == "ok") {
						location.href = "movePosSetting.do";
					} else {
						alert("직급명 수정을 실패하였습니다.");
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
		var pos_num = td.eq(0).text();
		
		$.ajax({
			url: "deletePos.do",
			data: {pos_num: pos_num},
			type: "post",
			success: function(result) {
				if(result == "ok"){
					posList();
				}
				else
					alert("부서 삭제에 실패했습니다.");
			}
		});
	});
	$(document).on("click","#insertBtn", function(){
		var pos_name = $("#inputPos").val();
		if(pos_name == "" || $("#inputPos").val() == "") {
			$("#inputPos").attr("style", "background-color: rgba(255, 0, 0, .2);");
		}
		else {
			$("#inputPos").attr("style", "");
			$.ajax({
				url: "insertPos.do",
				data: {pos_name: pos_name, com_url: myUrl},
				type: "post",
				success: function(result) {
					if(result == "ok"){
						posList();
					}
					else
						alert("직급 추가에 실패했습니다.");
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

  <!-- Left side column. contains the logo and sidebar -->
<%@ include file="../menu/aside.jsp"%>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        인사 설정
      </h1>
      <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol> -->
    </section>

    <!-- Main content -->
    <!-- 여기에 내용 -->
    <section class="content container-fluid">
    <div class="col-sm-3"></div>
    <div class="col-sm-6">
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">직급 관리</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="box-body table-responsive no-padding">
              <div class="input-group input-group-sm col-sm-12">
				<input id="inputPos" name="inputPos" style="" type="text" class="form-control" placeholder="추가할 직급명을 입력해주세요."> 
				<span class="input-group-btn"> 
				<a id="insertBtn" class="btn btn-info btn-flat">+</a>														
				</span>
			  </div>
			  <br>
              <table id="posTbl" class="table table-condensed" style="text-align:left;">                
                     
              </table>
              </div>              
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->    
          </div>  
      </div>  
	      
	<!-- 부서명 변경 모달 -->
          <div class="modal fade" id="modify">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">직급명 변경</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
              	<input id="pos_num" type="hidden" value="">
                <input id="pos_name" style="" type="text" class="form-control" placeholder="직급명을 입력해주세요."> 
              </div>
              <div class="modal-footer">
             	<a id="modifySave" class="btn btn-info btn-flat">Save</a>	
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
