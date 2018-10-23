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
  
<style type="text/css">
	.mainA {
		font-size: 15px;
		color: #3c8dbc;
	}
	.mainB {
		font-size: 15px;
		color: #6E6E6E;
	}
	.sub {
		font-size: 15px;
		margin-left: 33px;
		color: #6E6E6E;
		padding-right: 200px;
		padding-left: 10px;
		padding-top: 5px;
		padding-bottom: 5px;
		cursor: default;
	}
	#abc {
		margin-top: 15px;
	}
	.nav-tabs-custom{
		width: 50%;
	}
	.namediv {
		margin-top: 10px;
		margin-left: 10px;
		margin-bottom: 15px;
	}
	.name {
		font-size: 17px;
		color: #6E6E6E;
		cursor: default;
	}
	.cnamediv {
		margin-left: 10px;
		margin-bottom: 10px;
	}
	.cname {
		font-size: 14px;
		color: #6E6E6E;
		margin-right: 10px;
	}
	.description {
		float: right;
	}
	.description a {
		color: #A4A4A4;
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
	$(document).ready(function() {
		//$("#abc").html("<c:forEach items='${ emp }' var='a' begin= '0'><a class='sub' id='bus' value='${ a.dept_name }'>${ a.dept_name }</a><br><br></c:forEach>");
		$("#abc").hide();
		$("#def").html("<c:forEach items='${ emp }' var='a'><c:if test='${ !empty a.emp_name }'><div class='nav-tabs-custom'><div class='tab-content'><div class='user-block'><div class='namediv'><a class='name'>${ a.emp_name }</a></div><div class='cnamediv'><span class='cname'>${ a.com_name }</span><span class='cname'>${ a.dept_name }</span></div><div class='description1'><span class='description'><i class='fa fa-fw fa-phone'></i> ${ a.emp_tel }</span></div><div class='description1'><span class='description'><i class='fa fa-fw fa-envelope-o'></i> <a style='cursor: default;''>${ a.emp_email }</a></span></div></div></div></div></c:if></c:forEach>");
	});
	
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

			for(var i in jsonObj.list) {
				var com_url = jsonObj.list[i].com_url;
				var myUrl = "${sessionScope.loginUser.com_url}";  
				if(myUrl == com_url) { 
					outValues += "<a class='sub' id='bus' value='" + jsonObj.list[i].dept_name + "'>" + jsonObj.list[i].dept_name + "</a><br><br>"
			
				}
			}
			
			$("#abc").html(outValues); 
		}
	});
	
	function changeIcon() {
		var icon = $(".mainA").find("i");
		
		if(icon.hasClass("fa fa-fw fa-arrow-right")) {
			icon.removeClass("fa fa-fw fa-arrow-right").addClass("fa fa-fw fa-arrow-down");
			$("#abc").show();
		} else {
			icon.removeClass("fa fa-fw fa-arrow-down").addClass("fa fa-fw fa-arrow-right");
			$("#abc").hide();
		}
	}
	
	$(document).on("click", ".sub", function() {
		$("#def").html("");
		var a = $(this).attr("value");
		$.ajax({
			url : "selectDept.do",
			type : "post",
			dataType : "json",
			data : {"dname" : a},
			success : function(obj) {
				
				var objStr = JSON.stringify(obj);
				var jsonObj = JSON.parse(objStr);
				var outValues = $("#def").html();
				
				for(var i in jsonObj.list) {
					outValues += "<div class='nav-tabs-custom'><div class='tab-content'><div class='user-block'><div class='namediv'><a class='name'>" + decodeURIComponent(jsonObj.list[i].ename) + "</a></div><div class='cnamediv'><span class='cname'>" + decodeURIComponent(jsonObj.list[i].cname) + "</span><span class='cname'>" + decodeURIComponent(jsonObj.list[i].dname) + "</span></div><div class='description1'><span class='description'><i class='fa fa-fw fa-phone'></i>" +
					jsonObj.list[i].phone + "</span></div><div class='description1'><span class='description'><i class='fa fa-fw fa-envelope-o'></i> <a style='cursor: default;''>" + jsonObj.list[i].email + "</a></span></div></div></div></div>";
				}
				
				$("#def").html(outValues);
			}			
		});
	});
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
        조직원 정보
      </h1>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
        
       <h1>
      <div class="row">
        <div class="col-md-3">

          <!-- Profile Image -->
          <div class="box box-primary">
          <div class="box-body box-profile">
            <h4>조직도</h4>
            <hr>
            <a class="mainA" onclick="changeIcon();"><i class="fa fa-fw fa-arrow-right"></i></a>
            <a class="mainB" href="empInfo.do"> 
           	<c:forEach items="${ emp }" var="a" begin="0" end= "0">${ a.com_name }</c:forEach>
           	</a>
          </div>
          <div id="abc">
          
          </div>
            <!-- /.box-body -->
          <br>
          </div>
          <!-- /.box -->
          </div>
          <!-- col-md-3 -->
          
         <div class="col-md-9" id="def">
         <%-- <c:forEach items="${ emp }" var="a">
          <c:if test="${ !empty a.emp_name }">
          <div class="nav-tabs-custom">
          <div class="tab-content">             
          <div class="user-block">
          <div class="namediv">
          <a class="name">${ a.emp_name }</a>
          </div>
          <div class="cnamediv">
          <span class="cname">${ a.com_name }</span>
          <span class="cname">${ a.dept_name }</span>
          </div>
          <div class="description1">
          <span class="description"><i class="fa fa-fw fa-phone"></i> ${ a.emp_tel }</span>
          </div>
          <div class="description1">
          <span class="description"><i class="fa fa-fw fa-envelope-o"></i> <a style="cursor: default;">${ a.emp_email }</a></span>
          </div>
       	  </div>
          </div>
          </div>
           </c:if>
         </c:forEach> --%>
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
</body>
</html>
