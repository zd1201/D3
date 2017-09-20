<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!-- request 객체에 저장된 contextpath를 참조하여 경로 명시 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<script src="${ctx}/d3/d3.js" type="text/javascript" charset="utf-8"></script>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<script type="text/javascript">
	var ctx = "${ctx}";
	alert(ctx);
	</script>
	<title>D3 Page Template</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<script type="text/javascript">
	d3.select("body").append("p").text("new paragraph");
</script>
</body>
</html>
