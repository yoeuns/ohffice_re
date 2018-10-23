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
  <!-- bootstrap datepicker -->
  <link rel="stylesheet" href="resources/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  
<style type="text/css">
	label {
		font-size: 14px;
	}
	.col-md-6 {
		float-left: 20px;
	}
	.col-sm-10 {
		font-size: 14px;
	}
	#adBtn {
		float-left: 20%;
	}
</style>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function button_event() {
		if (confirm("취소 하시겠습니까?") == true) {
			location.href="menu.do";
		} else {
			return;
		}
	}
	
	function button_event2() {
		
		var a = $("#sample6_postcode").val();
		var b = $("#sample6_address").val();
		var c = $("#sample6_address2").val();
		var email = "${ sessionScope.loginUser.emp_email }";
		var produce = $("#inputProduce").val();
		var address = a + "|" + b + "|" + c;
		var phone = $("#inputPhone").val();
		var birth = $("#datepicker").val();
		var gender = $("#selectGender option:selected").val();
		var marriaged = $("#selectMarriaged option:selected").val();
		var army = $("#selectArmy option:selected").val();

		$.ajax({
			url : "mChange.do",
			type : "post",
			data : {
				"email" : email,
				"produce" : produce,
				"address" : address,
				"phone" : phone,
				"birth" : birth,
				"gender" : gender,
				"marriaged" : marriaged,
				"army" : army
			},
			success : function(data) {
				alert("저장 되었습니다.");
			},
			error : function(error) {
				alert("에러!");
			}
			});
	}
	
	$(document).ready(function(){
		
		var i = "${ emp.emp_addr }";
		var j = i.split("|");
		$("#sample6_postcode").val(j[0]);
		$("#sample6_address").val(j[1]);
		$("#sample6_address2").val(j[2]);
		
		var op = "${ emp.emp_gender }".trim();
		if(op == "여") {
			$("#selectGender").val("여").attr("selected", "selected");
		} else if(op == "남") {
			$("#selectGender").val("남").attr("selected", "selected");
		} else {
			$("#selectGender").val("choose").attr("selected", "selected");
		}
		
		var op1 = "${ emp.emp_marriaged }";
		if(op1 == "미혼") {
			$("#selectMarriaged").val("미혼").attr("selected", "selected");
		} else if(op1 == "기혼") {
			$("#selectMarriaged").val("기혼").attr("selected", "selected");
		} else {
			$("#selectMarriaged").val("choose").attr("selected", "selected");
		}
		
		var op2 = "${ emp.emp_army }";
		if(op2 == "필") {
			$("#selectArmy").val("필").attr("selected", "selected");
		} else if(op2 == "미필") {
			$("#selectArmy").val("미필").attr("selected", "selected");
		} else if(op2 == "면제") {
			$("#selectArmy").val("면제").attr("selected", "selected");
		} else if(op2 == "여성"){
			$("#selectArmy").val("여성").attr("selected", "selected");
		} else {
			$("#selectArmy").val("choose").attr("selected", "selected");
		}
	});
</script>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
<%@ include file="/WEB-INF/views/menu/header.jsp"%>

  <!-- Left side column. contains the logo and sidebar -->
<%@ include file="/WEB-INF/views/menu/aside.jsp"%>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        나의 정보
      </h1>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
       ${ emp.emp_name }님의 정보
       <h1>
       <!-- Horizontal Form -->
          <div class="box box-info">
            <!-- /.box-header -->
            <!-- form start -->
            <form class="form-horizontal" action="mChange.do" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="inputSelf" class="col-sm-2 control-label">자기소개</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputProduce" value="${ emp.emp_produce }" placeholder="자기소개" style="width:80%">
                  </div>
                </div>
                <div class="form-group">
                  <label for="inputAddress" class="col-sm-2 control-label">주소(우편번호)</label>
                  <div class="col-sm-10">
                    <%-- <input type="text" class="form-control" id="inputAddress" value="${ emp.emp_addr }" placeholder="주소" style="width:80%"> --%>
                    <input type="text" id="sample6_postcode" placeholder="우편번호" class="form-control" style="width:15%"><br>
					<input type="text" id="sample6_address" placeholder="주소" style="width:80%" class="form-control"><br>
					<input type="text" id="sample6_address2" placeholder="상세주소" style="width:80%" class="form-control"><br>
					<input type="button" id="adBtn" onclick="sample6_execDaumPostcode()" value="주소 찾기" class="btn btn-default">
                  </div>
                </div>
                <hr>
                <div class="form-group">
                    <%-- <label for="inputPhone" class="col-sm-2 control-label">전화번호</label>             
                    <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPhone" value="${ emp.emp_tel }" placeholder="전화번호" style="width:30%"> --%>
					<label for="inputPhone" class="col-sm-2 control-label">전화번호</label>
             		<div class="input-group">
					<div class="input-group-addon">
					<i class="fa fa-phone"></i>
					</div>
					<input type="text" class="form-control" id="inputPhone" style="width:25%" value="${ emp.emp_tel }" placeholder="전화번호" data-inputmask='"mask": "(010)-9999-9999"' data-mask>
					</div>
                </div>
               <div class="form-group">
                <label for="inputPhone" class="col-sm-2 control-label">생년월일</label>       
                <%-- <div class="col-sm-10">
                 <input type="text" class="form-control" id="datepicker" value="${ emp.emp_birth }" placeholder="생년월일" style="width:30%">
                </div> --%>
                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                  </div>
                  <input type="text" class="form-control" style="width:25%" id="datepicker" value="${ emp.emp_birth }" placeholder="생년월일">
                </div>
              </div>
              <hr>
              <div class="form-group">
                <label for="inputGender" class="col-sm-2 control-label">성별</label>
                <select id="selectGender" class="form-control" style="width: 23%;">
                  <option value="choose">선택</option>
                  <option value="남">남성</option>
                  <option value="여">여성</option> 
                </select>
              </div>
              <div class="form-group">
                <label for="inputMarrige" class="col-sm-2 control-label">혼인여부</label>
                <select class="form-control" id="selectMarriaged" style="width: 23%;">
                  <option value="choose">선택</option>
                  <option value="미혼">미혼</option>
                  <option value="기혼">기혼</option>
                </select>
              </div>
              <div class="form-group">
                <label for="inputArmy" class="col-sm-2 control-label">병역</label>
                <select class="form-control" id="selectArmy" style="width: 23%;">
                  <option value="choose">선택</option>
                  <option value="필">필</option>
                  <option value="미필">미필</option>
                  <option value="면제">면제</option>
                  <option value="여성">여성</option>
                </select>
              </div>
              </div>
   
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="button" class="btn btn-default" onclick="button_event();">취소</button>
                <button type="button" class="btn btn-info pull-right" id="saveBtn" onclick="button_event2();">저장</button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
          </h1>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
<%@ include file="/WEB-INF/views/menu/footer.jsp"%>

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
     
<!-- bootstrap datepicker -->
<script src="resources/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<!-- Page script -->
<script>
  $(function () {
   
    //Date picker
    $('#datepicker').datepicker({
      autoclose: true
    })
    
    //Money Euro
    $('[data-mask]').inputmask()

  })
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
<!-- InputMask -->
<script src="resources/plugins/input-mask/jquery.inputmask.js"></script>
<script src="resources/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="resources/plugins/input-mask/jquery.inputmask.extensions.js"></script>
</body>
</html>
