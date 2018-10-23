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
 
<!-- 모달 때문에 --> 
<link rel="stylesheet" href="/ohffice/resources/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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
<%@ include file="header.jsp"%>
  <!-- Left side column. contains the logo and sidebar -->
<%@ include file="aside.jsp"%>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Optional description</small>
      </h1>
      <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol> -->
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
          <!-- 다른페이지 할거면 여기부터 수정하기 -->
	      <div class="box box-default" data-toggle="modal" data-target="#companyInfo">
	         <div class="box-header with-border">
	          <i class="fa fa-building"></i>
	          <h3 class="box-title">처음처럼</h3>
	         </div>
	      </div>      
          
          <!-- 회사 소개 모달 -->
          <div class="modal fade" id="companyInfo">
          <div class="modal-dialog modal-dialog-centered"">
            <div class="modal-content">
              <div class="modal-header">                
                <h4 class="modal-title">회사 소개</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              </div>
              <div class="modal-body">
                <p><img src="#">(회사로고)처음처럼</p>
			 	<p>회사 소개 : </p>
			    <p>회사 상세 정보 : </p>
			    <p>회사 주소 : </p>
		        <p>회사 연혁 : </p>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
        
      <div class="row"> 
        <div class="col-md-6">
          <div class="box box-default">
            <div class="box-header with-border">
              <i class="fa fa-file"></i>
              <h3 class="box-title">결재예정문서</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="box-body table-responsive no-padding">
              <table id="waitingDocTbl" class="table table-condensed" style="text-align:center;">
                <tr>
                  <td width="30px"><i class="fa fa-file-o"></i></td>
                  <td style="text-align:left;"><a href="#">사직신청서_오승연_20181001</a></td>
                  <td width="80px">오승연</td>
                  <td width="100px">2018-10-01</td>
                </tr> 
                <tr>
                  <td width="30px"><i class="fa fa-file-o"></i></td>
                  <td style="text-align:left;"><a href="#">사직신청서_오승연_20181001</a></td>
                  <td width="80px">오승연</td>
                  <td width="100px">2018-10-01</td>
                </tr>                
              </table>
              </div>              
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->

        <div class="col-md-6">
          <div class="box box-default">
            <div class="box-header with-border">
              <i class="fa fa-star"></i>
              <h3 class="box-title">공지사항</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="box-body table-responsive no-padding">
              <table id="noticeTbl" class="table table-condensed" style="text-align:center;">
                <tr>
                  <td width="30px"><i class="fa fa-star-o"></i></td>
                  <td style="text-align:left;"><a href="#">첫번째 공지사항</a></td>
                  <td width="70px">오승연</td>
                  <td width="70px"><i class="fa fa-commenting-o"></i> 3</td> <!-- 댓글 수 -->
                  <td width="100px">2018-09-28</td>
                </tr>                
              </table>
              </div>  
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
      
      <div class="row"> 
        <div class="col-md-6">
          <div class="box box-default">
            <div class="box-header with-border">
              <i class="fa fa-file-text"></i>
              <h3 class="box-title">최근 Workflow 문서</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="box-body table-responsive no-padding">
              <table id="recentDocTbl" class="table table-condensed" style="text-align:center;">
                <tr>
                  <td width="30px"><i class="fa fa-file-text-o"></i></td>
                  <td width="30px"><i class="fa fa-spinner"></i></td> <!-- 진행/승인/반려 상황에 따라 -->
                  <td style="text-align:left;"><a href="#">사직신청서_오승연_20181001</a></td>
                  <td width="80px">오승연</td>
                  <td width="100px">2018-10-01</td>
                </tr>                
              </table>
              </div>  
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->

        <div class="col-md-6">
          <div class="box box-default">
            <div class="box-header with-border">
              <i class="fa fa-list"></i>
              <h3 class="box-title">새로운 Post</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <div class="box-body table-responsive no-padding">
              <table id="newPostTbl" class="table table-condensed" style="text-align:center;">
                <tr>
                  <td><span class="label label-default">전사규정</span></td> <!-- 게시판 이름 -->
                  <td style="text-align:left;"><a href="#">ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇ</a></td>
                  <td width="70px">오승연</td>
                  <td width="70px"><i class="fa fa-commenting-o"></i> 3</td> <!-- 댓글 수 -->
                  <td width="100px">2018-09-28</td>
                </tr> 
                                        
              </table>
              </div>  
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
<%@ include file="footer.jsp"%>

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
