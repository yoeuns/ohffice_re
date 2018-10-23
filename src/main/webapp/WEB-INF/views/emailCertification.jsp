<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oh!ffice</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var result = "${emailResult}"

	if(result == 'ok') {
		$("#emailDiv").html("<h2>인증이 완료되었습니다.</h2><a href='main.do' class='btn btn-info'>Oh!ffice로 이동하기</a>");
	} else {
		$("#emailDiv").html("<h2>인증에 실패하였습니다.</h2><a href='main.do' class='btn btn-info'>Oh!ffice로 이동하기</a>");
	}
});
</script>
</head>
<body>
<div id="emailDiv"></div>
</body>
</html>