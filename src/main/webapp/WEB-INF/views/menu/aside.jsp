<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Oh!ffice</title>

<script type="text/javascript">
$(function() {
$.ajax({
		url: "divisionlist.do",
		type: "post", 
		sync : true,
		dataType: "json",
		success: function(obj) {
			console.log(obj); // object 라고 출력함
			// 리턴된 객체를 문자열로 변환함
			var objStr = JSON.stringify(obj);
			// 문자열을 json 객체로 바꿈
			var jsonObj = JSON.parse(objStr);
			
			var outValues = "";
			
			for(var i in jsonObj.list) {
				var myUrl = "${sessionScope.loginUser.com_url}"; 
				var com_url = jsonObj.list[i].com_url;
				var empEmail = "${sessionScope.loginUser.emp_email}"; 
					 
				if(myUrl == com_url) {
					
					var visible = jsonObj.list[i].board_visible;
					var visible_str = "";
					

					if(visible == 'Y') {
						outValues +=  "<li><a href='moveBoardList.do?division_num="+ jsonObj.list[i].division_num +
								"'>" +  jsonObj.list[i].division_name + "</a></li>"; 
					}
					
					
				} // url 비교
			}//for문 끝
			$("#boardMenu").html($("#boardMenu").html() +outValues );
		}
	});

});
</script>
</head>
<body>
<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">Documents</li>
        <!-- Optionally, you can add icons to the links -->
<c:if test="${sessionScope.loginUser.auth_num ne '3'}">
        <li class="treeview">
          <a href="#"><i class="fa fa-cog"></i> <span>관리자</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="comManage.do">조직 관리</a></li>
            <li class="treeview">
	            <a href="#"><span>인사 관리</span>
	            <span class="pull-right-container">
	                <i class="fa fa-angle-left pull-right"></i>
	            </span>
	         	</a>
	         	<ul class="treeview-menu">
	         		<li><a href="#">인사 설정</a></li>
	         		<li><a href="moveDeptSetting.do">조직도/조직원 관리</a></li>
	         	</ul>
         	</li>     
            <li><a href="moveBoardSetting.do">게시판 관리</a></li>
          </ul>
        </li>
</c:if>
        <li class="treeview">
          <a href="#"><i class="fa fa-upload"></i> <span>문서 기안</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="#">최근 승인 문서</a></li>
            <li><a href="documentForm.do">문서 양식</a></li>
          </ul>
        </li>
        <li><a href="#"><i class="fa fa-check"></i> <span>문서 결재</span> </a></li>
        <li class="treeview">
          <a href="#"><i class="fa fa-file-text"></i> <span>워크플로우 문서</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="draftDoc.do">기안문서</a></li>
            <li><a href="#">결재완료문서</a></li>
            <li><a href="#">수신문서</a></li>
          </ul>
        </li>
        <li><a href="#"><i class="fa fa-link"></i> <span>워크플로우 데이터</span></a></li> 
		<br>
        <li class="header">Info</li>        
        <li><a href="myInfo.do"><i class="fa fa-user"></i> <span>나의 정보</span></a></li>
        <li class="treeview">
          <a href="#"><i class="fa fa-list"></i> <span>게시판</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul id="boardMenu"class="treeview-menu">
          <li><a href='moveBoard.do'>공지사항</a></li>
          </ul> <!-- 여기는 게시판 종류 쓰여지는 곳 -->
        </li>
        <li><a href="empInfo.do"><i class="fa fa-users"></i> <span>조직원 정보</span></a></li>
        <li><a href="commonInfo.do"><i class="fa fa-phone-square"></i> <span>공통 연락처</span></a></li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
</body>
</html>