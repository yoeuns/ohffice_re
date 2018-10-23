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
  <link rel="stylesheet" href="resources/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  
<style type="text/css">
	.nav-tabs-custom {
		float: right;
		width: 70%;
	}
	.main {
		margin-top: 15px;
		margin-left: 30px;
		font-size: 17px;
	}
	.main2 {
		margin-top: 15px;
		margin-left: 30px;
		font-size: 17px;
	}
	input {
	    border: 1px solid #D8D8D8;
	    border-radius: 3px;
	    
	}
	input[type="text"] {
		font-size: 13px;
	}
	#local {
		border : 1px solid transparent;
	}
	.warn {
		font-size: 14px;
		color: red;
	}
	.mainInput {
		height: 30px;
	}
	input::placeholder {
		font-size: 13px;
	}
	#sample6_postcode, #sample6_address, #sample6_address2 {
		padding-left: 10px;
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
	/* $(document).ready(function() {
		$(".main2").hide();
	});
	function event1() {
		$(".main2").hide();
		$(".main").show();
	}
	function event2() {		
		$(".main").hide();
		$(".main2").show();
	} */
	$(document).ready(function() {
		var a = "${ com.com_addr }";
		var b = a.split("|");
		$("#sample6_postcode").val(b[0]);
		$("#sample6_address").val(b[1]);
		$("#sample6_address2").val(b[2]);
		
		var c = "${ com.com_tel }";
		var d = c.split("-");
		var e = d[0]
		$("#inputPhone").val(d[1] + d[2]);
		$("#local").val(e);
		
	});
	
	function button_event() {
		
		var a = $("#sample6_postcode").val();
		var b = $("#sample6_address").val();
		var c = $("#sample6_address2").val();
		var address = a + "|" + b + "|" + c;
		var name = $("#inputName").val();
		var phone1 = $("#local option:selected").val();
		var phone2 = $("#inputPhone").val();
		var phone = phone1 + "-" + phone2;
		var url = "${ com.com_url }";

		$.ajax({
			url : "comChange.do",
			type : "post",
			data : {
				"address" : address,
				"name" : name,
				"phone" : phone,
				"url" : url
			},
			success : function(data) {
				alert("저장 되었습니다.");
			},
			error : function(error) {
				alert("에러!");
			}
			});
	}
</script>

<body class="hold-transition skin-blue sidebar-mini" ondragstart="return false" onselectstart="return false">
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
        조직 관리
      </h1>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
        
       <h1>
          <div class="col-md-9">
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a onclick="event1();" data-toggle="tab" style="font-size: 20px;">조직 설정</a></li>
              <!-- <li><a onclick="event2();" data-toggle="tab" style="font-size: 20px;">소개</a></li> -->
            </ul>
            <div class="tab-content">
              <div class="active tab-pane" id="activity">
                <!-- Post -->
                <div class="main">
					<label>조직명</label><br>
					<input type="text" id="inputName" class="mainInput" style="width: 90%; padding-left: 8px;" value="${ com.com_name }"><br>
					<br><br>
					<label>전화번호</label>
					<div class="input-group">
					<div class="input-group-addon">
					<i class="fa fa-phone"></i>
					<select id="local">
						<option>02</option>
						<option>031</option>
						<option>032</option>
						<option>033</option>
						<option>041</option>
						<option>042</option>
						<option>043</option>
						<option>044</option>
						<option>051</option>
						<option>052</option>
						<option>053</option>
						<option>054</option>
						<option>055</option>
						<option>061</option>
						<option>062</option>
						<option>063</option>
						<option>064</option>
					</select>
					</div>
					<input type="text" id="inputPhone" class="form-control" style="width: 88%;" id="inputPhone" placeholder="전화번호" data-inputmask='"mask": "999-9999"' data-mask>
               	    </div><br>
               	    <br>
               	    <label>주소</label><br>
               	  
                    <input type="text" id="sample6_postcode" class="mainInput" placeholder="우편번호" style="width:20%"><br><br>
					<input type="text" id="sample6_address" class="mainInput" placeholder="주소" style="width:90%"><br><br>
					<input type="text" id="sample6_address2" class="mainInput" placeholder="상세주소" style="width:90%"><br><br>
					<input type="button" id="adBtn" onclick="sample6_execDaumPostcode()" value="주소 찾기" class="btn btn-default">                 	
                 	<br><br><br>
           			<label>URL</label><br>
					<span class="urlText">http://www.${ com.com_url }.ohffice.co.kr</span><br>
					<br><br>
               	    <label>마스터 계정</label><br>
               	    <p>${ com.emp_email }</p><br>
               	    <p class="warn">*마스터계정은 변경이 불가능하며 계정이 삭제되면 oh!ffice를 사용하실 수 없습니다.</p>
               	    <br><br><br>
               	    <div class="box-footer">
               		 <button type="button" class="btn btn-info pull-right" id="saveBtn" onclick="button_event();">저장</button>
             		</div>
                </div>
                <!-- /.post -->
                <!-- <div class="main2">
					<label>슬로건</label><br>
					<input type="text" class="mainInput" style="width: 90%;"><br>
					<br><br>
					<label>URL</label><br>
					<span class="urlText">http://</span>
					<input type="text" class="mainInput" style="width: 65%;">
					<span class="urlText">.ohffice.co.kr</span><br>
					<br><br>
					<label>전화번호</label>
					<div class="input-group">
					<div class="input-group-addon">
					<i class="fa fa-phone"></i>
					<select id="local">
						<option>02</option>
						<option>031</option>
						<option>032</option>
						<option>033</option>
						<option>041</option>
						<option>042</option>
						<option>043</option>
						<option>044</option>
						<option>051</option>
						<option>052</option>
						<option>053</option>
						<option>054</option>
						<option>055</option>
						<option>061</option>
						<option>062</option>
						<option>063</option>
						<option>064</option>
					</select>
					</div>
					<input type="text" class="form-control" style="width: 88%;" id="inputPhone" placeholder="전화번호" data-inputmask='"mask": "999-9999"' data-mask>
               	    </div><br>
               	    <br>
               	    <label>마스터 계정</label><br>
               	    <p>abc@naver.com</p><br>
               	    <p class="warn">*마스터계정은 변경이 불가능하며 계정이 삭제되면 oh!ffice를 사용하실 수 없습니다.</p>
               	    <br><br><br>
               	    <div class="box-footer">
               		 <button type="button" class="btn btn-info pull-right" id="saveBtn" onclick="button_event2();">저장</button>
             		</div>
                </div>
                </div>
                </div>
                </div>
                </div> -->
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
<script src="resources/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
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
<script src="resources/plugins/input-mask/jquery.inputmask.js"></script>
<script src="resources/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="resources/plugins/input-mask/jquery.inputmask.extensions.js"></script>
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
</body>
</html>
