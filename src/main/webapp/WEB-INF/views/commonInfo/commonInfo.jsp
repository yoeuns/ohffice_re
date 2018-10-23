<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Oh!ffice</title>
  
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
		<link rel="stylesheet" href="/ohffice/resources/css/bootstrap.min.css">
		
  
  <style type="text/css">
  	.total {
             border: 0.5px solid #a1a1a1;
            box-shadow: 0px 0px 0.1px 0.1px #a1a1a1;
            margin: 5%;
            background-color:white;
        }

        .total_up_1 {
            display: inline-block;
            padding: 15px;
        }

        .total_up_2 {
            display: inline-block;
            float:right;
            padding: 15px;
        }
        .modal {
        	text-align: center;
		}
        .btn btn-outline-info{
        	border: 0px;
        }
        .modal-body_total{
			display:inline-block;
			width:85%;
		}
		.modal-body_label{
			display:inline-block;
			
		}
        .modal-body_field{
 			display:inline-block; 	
 			float: right;
        }
        .control{
        	display:inline-block;
        	width:500px;
        	padding:5px;
        }
        
        input[type=text]{
        	width:100%;
        	border:2px solid #aaa;
        	border-radius:4px;
        	margin:8px 0;
        	outline:none;
        	padding:8px;
        	box-sizing:border-box;
        	transition:.3s;
        	margin-top:5px;
        	margin-left:10px;
        }
        input[type=email]{
        	width:100%;
        	border:2px solid #aaa;
        	border-radius:4px;
        	margin:8px 0;
        	outline:none;
        	padding:8px;
        	box-sizing:border-box;
        	transition:.3s;
        	margin-top:5px;
        	margin-left:10px;
        }
        input[type=tel]{
        	width:100%;
        	border:2px solid #aaa;
        	border-radius:4px;
        	margin:8px 0;
        	outline:none;
        	padding:8px;
        	box-sizing:border-box;
        	transition:.3s;
        	margin-top:5px;
        	margin-left:10px;
        }
		
        .modal-header{
        	background-color: #ececec;
        }
        .modal-body_info{
        	padding:30px;
        	text-align:center;
        }
    
		.modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
		}
		
		
        .total_view {
            text-align: center;
        }

        .contactInfo {
            border-top: 1px solid #a1a1a1;
            box-shadow: 0px 0px 0.3px 0.3px #a1a1a1;
            margin: 5%;
        	background-color:white;
        }
  </style>
  
  <script type="text/javascript">
  
  $(document).on("click", ".empName", function() {
	  var name = $(this).attr("value");
	  
	  $.ajax({
		  url : "getInfo.do",
		  type: "post",
	  	  data : {"abc" : name},
	  	  success : function() {
	  		  alert("제발요");
	  	  }
	  	  
	  });
  })

  </script>

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

  <!-- Main Header -->
<%@ include file="../menu/header.jsp"%>

  <!-- Left side column. contains the logo and sidebar -->
<%@ include file="../menu/aside.jsp"%>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header ${ selectOne.emp_name }
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
      
      <!-- ********************************* -->
      
       <div class="total">
            <div class="total_up">
                <div class="total_up_1">
                    <button class="btn btn-primary" type="submit">그룹관리</button>
                </div>
            </div>
            <hr>
            <div class="total_view">
                <a href="#" class="total_view_list">전체보기</a>
            </div>
        </div>
        <div class="contactInfo">
            <table class="table">
                <thead class="thead-light">
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">이름</th>
                        <th scope="col">직위/직책</th>
                        <th scope="col">조직명</th>
                        <th scope="col">이메일</th>
                        <th scope="col">전화번호</th>
                    </tr>
                </thead>

	                <tbody>
						
	                	<c:forEach var="list" items="${list}">
	                    <tr>
	                        <th scope="row">
	                        	<!-- <div class="custom-control custom-checkbox">
								  <input type="checkbox" class="custom-control-input" id="customCheck1">
								  <label class="custom-control-label" for="customCheck1"></label>
								</div>  -->
	                        </th>
	                        <td><a onclick="getInfo();" class="empName" data-toggle="modal" data-target="#exampleModalCenter" value="${list.emp_name }">${list.emp_name }</a></td>
	                        <td>${list.pos_name }<!-- 처음 --></td>
	                        <td>${list.dept_name }<!-- 처음처럼 --></td>
	                        <td>${list.emp_email }<!-- ilkinli@nate.com --></td>
	                        <td>${list.emp_tel }<!-- 010-4911-5867 --></td>
	                    </tr>
	                    </c:forEach>
					
					
	                </tbody>

            </table>
        </div>
        
				
				<!-- Modal -->
				<div class="modal fade bd-example-modal-lg" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-lg" role="document">
				    <div class="modal-content">
				      <div class="modal-body">
				      	<div class="modal-body_info">
					       	<!-- <div class="modal-body_total">그룹  </div> -->
					       	<div class="modal-body_total">
					       		<div class="modal-body_label">
					       			<h5>이름</h5>
					       		</div> 
					       		<div class="modal-body_field">
					       			<div class="control">
					       				<input type="text" placeholder="이름" value="${selectOne.emp_name }">
					       			</div>
					       		</div>
					       	</div>
					       	<div class="modal-body_total">
					       		<div class="modal-body_label">
					       			<h5>조직명</h5>
					       		</div>
					       		<div class="modal-body_field">
					       			<div class="control">
					       				<input type="text" placeholder="조직명" value="$">
					       			</div>
					       		</div>
					       	</div>
					       	<div class="modal-body_total">
					       		<div class="modal-body_label">
					       			<h5>직위/직책</h5>
					       		</div> 
					       		<div class="modal-body_field">
					       			<div class="control">
					       				<input type="text" placeholder="직위/직책" value="">
					       			</div>
					       		</div>
					       	</div>
					       	<div class="modal-body_total">
					       		<div class="modal-body_label">
					       			<h5>이메일</h5>
					       		</div> 
					       		<div class="modal-body_field">
					       			<div class="control">
					       				<input type="email" placeholder="이메일" value="">
					       			</div>
					       		</div>
					       	</div>
					       	<div class="modal-body_total">
					       		<div class="modal-body_label">
					       			<h5>전화번호</h5>
					       		</div>
					       		<div class="modal-body_field">
					       			<div class="control">
					       				<input type="tel" placeholder="전화번호" value="">
					       			</div>
					       		</div>
					       	</div>
				      	</div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				      </div>
				    </div>
				  </div>
				</div>
        
		        
 
    </body>
      
      
      
      
      
      
      <!-- *********************************** -->
       

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
