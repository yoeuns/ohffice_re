<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
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
	// 나의 url 불러오기
	var myUrl = "${sessionScope.loginUser.com_url}"; 

	
	$.ajax({
		url: "comName.do",
		data: {com_url: myUrl},
		type: "get",
		success: function(result) {			
			$('#com_name').attr("value", result);	
		}
	}); 
	
	
	//부서 리스트 불러오기
	(deptlist = function() {
	$.ajax({
		url: "deptlist.do",
		type: "get",
		dataType: "json",
		success: function (obj) {
			// 리턴된 객체를 문자열로 변환함
			var objStr = JSON.stringify(obj);
			// 문자열을 json 객체로 바꿈
			var jsonObj = JSON.parse(objStr);
			
			var outValues = "";

			$("#deptTbl").html("");
			$('#dept_select').html("");
			$('#dept_select').append("<option value='0'>--선택--</option>");
			$('#dept_select1').html("");
			$('#dept_select1').append("<option value='0'>--선택--</option>");
			for(var i in jsonObj.list) {
				var com_url = jsonObj.list[i].com_url;
				if(myUrl == com_url) { 
					outValues += "<tr><td style='display: none'>" + jsonObj.list[i].dept_num + "</td> " +
								 "<td><button id='dept' style='background: white; border: 0; outline: 0;'>" + jsonObj.list[i].dept_name + "</button></td>" +
								 "<td><button data-toggle='modal' data-target='#modifyD' id='modifyBtn' style='background: white; border: 0; outline: 0;'><i class='fa fa-edit'></i></button></td> " +
								 "<td><button style='background: white; border: 0; outline: 0;' id='deleteBtn'><i class='fa fa-trash-o'></i></button></td></tr>";
					$('#dept_select').append("<option value='" + jsonObj.list[i].dept_num + "'>" + jsonObj.list[i].dept_name + "</option>");
					$('#dept_select1').append("<option value='" + jsonObj.list[i].dept_num + "'>" + jsonObj.list[i].dept_name + "</option>");
				}				
			}
			
			$("#deptTbl").html($("#deptTbl").html() + outValues); 
		}
	});
	})();
	//권한 리스트 불러오기
	$.ajax({
		url: "authlist.do",
		type: "get",
		dataType: "json",
		success: function(obj) {
			// 리턴된 객체를 문자열로 변환함
			var objStr = JSON.stringify(obj);
			// 문자열을 json 객체로 바꿈
			var jsonObj = JSON.parse(objStr);
			
			for(var i in jsonObj.list) {
				if(jsonObj.list[i].auth_num > '1')
					$('#auth_select').append("<option value='" + jsonObj.list[i].auth_num + "'>" + jsonObj.list[i].auth_name + "</option>");				
			}
		}
	});
	
	//조직원 리스트 불러오기
	(emplist = function(value) {	
	$.ajax({
		url: "emplist.do",
		type: "get",
		dataType: "json",
		success: function(obj) {
			// 리턴된 객체를 문자열로 변환함
			var objStr = JSON.stringify(obj);
			// 문자열을 json 객체로 바꿈
			var jsonObj = JSON.parse(objStr);
			
			var outValues = "";
			
			 
			$("#empDiv").html(""); 
			for(var i in jsonObj.list) {
				var com_url = jsonObj.list[i].com_url;
				if(myUrl == com_url) { 		
					var dept_name = jsonObj.list[i].dept_name;
					if(jsonObj.list[i].dept_name == null) {
						dept_name = $('#com_name').val();
					}
					var emp_tel = jsonObj.list[i].emp_tel;
					if(jsonObj.list[i].emp_tel == null) {
						emp_tel = " - ";
					}
					if(value == null) {
						
						outValues += "<div class='col-sm-6'>" +
							         "<div class='box box-default'>" + 
							         "<div class='box-header with-border'>" +
							         "<h3 class='box-title'><table><tr><td style='display: none;'>" + jsonObj.list[i].emp_email + "</td>" +
							         "<td style='display: none;'>" + jsonObj.list[i].auth_num + "</td>" +
							         "<td><input type='radio' id='empBtn' name='empBtn' value='" + jsonObj.list[i].emp_email + "'>&nbsp;&nbsp;" + jsonObj.list[i].emp_name + "</td></tr></table></h3>" +
							         "</div>" +
							         "<div class='box-body'>" +
							         "<div class='box-body table-responsive no-padding'>" +
							         "<span class='label label-info'>" + jsonObj.list[i].auth_name + "</span>&nbsp;" +
							         "<span>" + dept_name + "</span><br><br>" +
							         "<span><i class='fa fa-fw fa-phone'></i>" + emp_tel + "</span><br>" +
							         "<span><i class='fa fa-fw fa-envelope-o'></i> <a style='cursor: default;'>" + jsonObj.list[i].emp_email + "</a></span>" +
							         "</div>" + 
							         "</div>" +
							         "</div>" +	
							         "</div>";
					}
					else {
						if(jsonObj.list[i].dept_num == value) {
							outValues += "<div class='col-sm-6'>" +
					         "<div class='box box-default'>" + 
					         "<div class='box-header with-border'>" +
					         "<h3 class='box-title'><table><tr><td style='display: none;'>" + jsonObj.list[i].emp_email + "</td>" +
					         "<td style='display: none;'>" + jsonObj.list[i].auth_num + "</td>" +
					         "<td><input type='radio' id='empBtn' name='empBtn' value='" + jsonObj.list[i].emp_email + "'>&nbsp;&nbsp;" + jsonObj.list[i].emp_name + "</td></tr></table></h3>" +
					         "</div>" +
					         "<div class='box-body'>" +
					         "<div class='box-body table-responsive no-padding'>" +
					         "<span class='label label-info'>" + jsonObj.list[i].auth_name + "</span>&nbsp;" +
					         "<span>" + dept_name + "</span><br><br>" +
					         "<span><i class='fa fa-fw fa-phone'></i>" + emp_tel + "</span><br>" +
					         "<span><i class='fa fa-fw fa-envelope-o'></i> <a style='cursor: default;'>" + jsonObj.list[i].emp_email + "</a></span>" +
					         "</div>" + 
					         "</div>" +
					         "</div>" +	
					         "</div>";
		
					}
					}
				}				
			}			
			$("#empDiv").html($("#empDiv").html() + outValues); 			
		}
	}); 
	})();
	$(document).on("click","#empBtn", function(){
		var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var emp_email = td.eq(0).text();
		var auth_num = td.eq(1).text();
		
		$("#updateEmp").attr("style", "visibility: visible;");
		$("#deleteEmp").attr("style", "visibility: visible;");
		$("#empEmail").attr("value", emp_email);
		$("#empAuthNum").attr("value", auth_num);
	});
	
	$(document).on("click","#deleteEmp", function(){		
		if($("#empAuthNum").val() == '1') {
			$("#deleteMent").html("마스터 계정 조직원은 삭제할 수 없습니다.");
			$("#deleteOk").attr("style", "visibility: hidden;");
		} else if($("#empEmail").val() == "${sessionScope.loginUser.emp_email}") {
			$("#deleteMent").html("자기 자신은 삭제할 수 없습니다.");
			$("#deleteOk").attr("style", "visibility: hidden;");
		}
		else {
			$("#deleteMent").html("조직원을 삭제 시 해당 조직원의 정보는 삭제되며 더 이상 이 조직을 이용할 수 없습니다.");
			$("#deleteOk").attr("style", "visibility: visible;");
		}
	});
	
	$(document).on("click","#deleteOk", function(){		
		var emp_email = $("#empEmail").val();
		$.ajax({
			url: "deleteEmp.do",
			data: {emp_email: emp_email},
			type: "post",
			success: function(result) {
				if(result == "ok")
					location.href = "moveDeptSetting.do";
			} 
		});
		emplist();
	});
	
	$(document).on("click","#dept", function(){
		var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var clickdept = td.eq(0).text();
		$("#clickDept").attr("value", "clickdept");
		emplist(clickdept);
	});
	
	$(document).on("click","#com_name", function(){
		emplist();
	}); 
	
	$("#insertDept").on("click", function() {
		var dept_name = $("#inputDept").val();
		if(dept_name == "" || $("#inputDept").val() == "") {
			$("#inputDept").attr("style", "background-color: rgba(255, 0, 0, .2);");
		}
		else {
			$("#inputDept").attr("style", "");
			$.ajax({
				url: "insertDept.do",
				data: {dept_name: dept_name, com_url: myUrl},
				type: "post",
				success: function(result) {
					if(result == "ok") {
						deptlist();
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
		var dept_num = td.eq(0).text();
			
		$("#dept_num").attr("value", dept_num);		
	});
	
	$(document).on("click","#updateEmpDeptSave",function(){
		var dept_num = $("#dept_select1").val();
		var emp_email = $("#empEmail").val();

		$.ajax({
			url: "updateEmpDept.do",
			data: {emp_email: emp_email, dept_num: dept_num},
			type: "post",
			success: function(result) {	
				if(result == "ok") {
					location.href = "moveDeptSetting.do";
				} else {
					alert("부서 이동에 실패하였습니다.");
				}
							
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n" +
					  "message : " + request.responseText + "\n" +
					  "error : " + errorData);				
			}
		});
	});
	
	$("#modifyDSave").on("click", function() {
		var dept_num = $("#dept_num").val();
		var newDName = $("#newDName").val();
		if(newDName == "" || $("#newDName").val() == "") {
			$("#newDName").attr("style", "background-color: rgba(255, 0, 0, .2);");
		}
		else {
			$("#newDName").attr("style", "");
			$.ajax({
				url: "modifyDept.do",
				data: {newDName: newDName, dept_num: dept_num},
				type: "post",
				success: function(result) {					
					if(result == "ok") {
						location.href = "moveDeptSetting.do";
					} else {
						alert("부서명 수정을 실패하였습니다.");
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
	
	$(document).on("click","#deleteBtn",function(){
		var checkBtn = $(this); 
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		var dept_num = td.eq(0).text();

		$.ajax({
			url: "deleteDept.do",
			data: {dept_num: dept_num},
			type: "post",
			success: function(result) {
				if(result == "ok") {
					deptlist();
				} else {
					alert("부서 삭제에 실패하였습니다.");
				}					
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n" +
					  "message : " + request.responseText + "\n" +
					  "error : " + errorData);				
			}
		});
	});
		
	$("#insertEmpSave").on("click", function() {
		var emp_name = $("#emp_name").val();
		var emp_email = $("#emp_email").val();
		var dept_num = $("#dept_select").val();
		var pos_num = $("#pos_select").val();
		var emp_date = $("#emp_date").val();
		var auth_num = $("#auth_select").val();
		var com_url = myUrl;		
		
		$.ajax({
			url: "mailSender.do",
			data: {emp_name: emp_name, emp_email: emp_email, dept_num: dept_num, pos_num: pos_num, emp_date: emp_date, auth_num: auth_num, com_url: com_url},
			type: "post",
			success: function(result) {
				if(result == "ok") {
				      var auth2;
				      var DISCOVERY_DOCS = [ "https://www.googleapis.com/discovery/v1/apis/drive/v3/rest" ]
				      var SCOPES = [ 'https://www.googleapis.com/auth/drive', 'profile',
				            'https://mail.google.com/' ];
				      var CLIENT_ID = '587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com';
				      var API_KEY = 'AIzaSyBhi9PSQYrFOw0MBWCZusHQFfawVxzU5Vc';
				      var token = "";
				      var login_info;


				      function info() {
				         gapi.load(
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
	
				      
				      var access_token = gapi.auth.getToken().access_token;
				        var request = gapi.client.request({
				                 'path' : '/drive/v3/files/'
				                       + drive()
				                       + '/permissions',
				                 'method' : 'POST',
				                 'headers' : {
				                    'Content-Type' : 'application/json',
				                    'Authorization' : 'Bearer '
				                          + access_token,
				                 },
				                 'body' : {
				                    "role" : "writer",
				                    "type" : "user",
				                    "emailAddress" : emp_email,
				                    "deleted" : "false",
				                    "kind" : "drive#permission",
				                 }
				              })
				              request.execute(function(resp) {
				                 if (!resp.error) {
				                    console.log("file copy success file ID : "
				                                + resp.id);            
				                 }   		      
				   				 else {
				     				console.log("Error: "+ resp.error.message);
				  				 }
							  });
					location.href = "moveDeptSetting.do";			
				} else if(result == "inputerror") {
					alert("필수항목을 다 입력해주세요.");
				} else if(result == "mailerror") {
					alert("gmail 계정의 메일을 입력해주세요.");
				} else if(result == "already") {
					alert("이미 추가된 조직원입니다.");
				} else {
					alert("조직원 등록이 되지 않았습니다.");
				}				
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n" +
					  "message : " + request.responseText + "\n" +
					  "error : " + errorData);				
			}
		}); 
	});
	
	function drive() {
		var id = "";
		$.ajax({
			url: "sharedDrive.do",
			data: {com_url: myUrl},
			method: "post",
			async: false,
			success: function (obj) {
				id = obj;
			},
			error: function(request, status, errorData) {
				alert("error code : " + request.status + "\n" +
					  "message : " + request.responseText + "\n" +
					  "error : " + errorData);				
			}
		});	
		return id;
	};
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
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        조직도/조직원 관리
      </h1>
      <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol> -->
    </section>
	
    <!-- Main content -->
    <!-- 여기에 내용 -->
    <section class="content container-fluid">
	<div class="col-sm-1"></div>
	 <div class="row col-sm-10"> 
        <div class="col-sm-3">
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">조직도</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="box-body table-responsive no-padding">
              <div class="input-group input-group-sm col-sm-12">
				<input id="inputDept" name="inputDept" style="" type="text" class="form-control" placeholder="추가할 부서명을 입력해주세요."> 
				<span class="input-group-btn"> 
				<a id="insertDept" class="btn btn-info btn-flat">+</a>														
				</span>
			  </div>
			  <br>
              <table class="table table-condensed" style="text-align:center;">    
              	<input type="hidden" value="" id="clickDept">                
                <tr><td colspan="4"><input type="button" style='background: white; border: 0; outline: 0;' id="com_name" value=""></td></tr>           
              </table>
              <table id="deptTbl" class="table table-condensed" style="text-align:center;">                    
                <tr><td colspan="4"><input type="button" style='background: white; border: 0; outline: 0;' id="com_name" value=""></td></tr>           
              </table>
              </div>              
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->

        <div class="col-sm-9 no-padding">
          <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title pull-right">
              <input type="button" class="btn btn-info" id="updateEmp" style="visibility: hidden;" data-toggle='modal' data-target='#updateE' value="부서 이동">
              <input type="button" class="btn btn-info" id="deleteEmp" style="visibility: hidden;" data-toggle='modal' data-target='#deleteE' value="조직원 삭제">
              <input type="button" class="btn btn-info" id="insertEmp" name="insertEmp" data-toggle='modal' data-target='#insertE' value="조직원 추가">
              <input type="hidden" id="empEmail" value="">
              <input type="hidden" id="empAuthNum" value="">
              </h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="box-body table-responsive no-padding" id="empDiv">
              		
			        
		
     
              </div>  
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        
      </div>  


    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  		<!-- 부서명 변경 모달 -->
          <div class="modal fade" id="modifyD">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">부서명 변경</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
              	<input id="dept_num" type="hidden" value="">
                <input id="newDName" style="" type="text" class="form-control" placeholder="부서명을 입력해주세요."> 
              </div>
              <div class="modal-footer">
             	<a id="modifyDSave" class="btn btn-info btn-flat">Save</a>	
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
        <!-- 부서 이동 모달 -->
          <div class="modal fade" id="updateE">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">부서 이동</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
              <select class="form-control" id="dept_select1">
                  <option value="0">--선택--</option>
              </select>
              </div>
              <div class="modal-footer">              
              	<a id="updateEmpDeptSave" class="btn btn-info btn-flat">Save</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
        
        <!-- 조직원 삭제 모달 -->
          <div class="modal fade" id="deleteE">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">조직원 삭제</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
              <p id="deleteMent"></p>
              </div>
              <div class="modal-footer">
             	<input type="button" id="deleteOk" style="visibility: hidden;" class="btn btn-info btn-flat" value="Ok">	
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
        
        
       <!-- 조직원 추가 모달 -->
          <div class="modal fade" id="insertE">
          <div class="modal-dialog modal-dialog-centered"">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">조직원 추가하기</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
                <div class="form-group">
                  <label for="emp_name"><font style="color: red;">*</font> 이름</label>
                  <input type="text" class="form-control" style="" id="emp_name" value="" placeholder="이름을 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="emp_email"><font style="color: red;">*</font> 이메일</label>
                  <input type="email" class="form-control" id="emp_email" value="" placeholder="example@gmail.com">
                </div>
				<div class="form-group">
                  <label for="dept_select">부서</label>
                  <select class="form-control" id="dept_select">
                  <option value="0">--선택--</option>
                  </select>
                </div>
                <div class="form-group">
                  <label for="pos_select">직위/직책</label>
                  <select class="form-control" id="pos_select">
                  <option value="">--선택--</option>
                  </select>
                </div>
                <div class="form-group">
                  <label for="emp_date">입사일</label>
                  <input type="date" class="form-control" id="emp_date">
                </div>
                <div class="form-group">
                  <label for="auth_select"><font style="color: red;">*</font> 권한</label>
                  <select class="form-control" id="auth_select">
                  <option value="0">--선택--</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
             	<button id="insertEmpSave"  class="btn btn-info btn-flat">Save</button>	
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
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
