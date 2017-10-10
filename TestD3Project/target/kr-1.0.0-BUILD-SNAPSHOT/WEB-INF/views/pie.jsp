<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<!-- request 객체에 저장된 contextpath를 참조하여 경로 명시 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<script src="${ctx}/d3/d3.js" type="text/javascript" charset="utf-8"></script>
<style type="text/css">
div.bar {
	display: inline-block;
	width: 20px;
	height: 75px;
	background-color: teal;
	margin-right: 2px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-- 	<script type="text/javascript"> -->
<%-- var ctx = "${ctx}"; --%>
<!-- 	</script> -->
<title>D3 Page Template</title>
</head>
<body>
<script>
	var dataset = [5, 10, 20, 45, 6, 25];
	
	var pie = d3.pie();
	var color = d3.scaleOrdinal(d3.schemeCategory10);
	
	var w = 300;
	var h = 300;

	var outerRadius = w/2;
	var innerRadius = w/3;

	// path 문서요소 생성
	var arc = d3.arc().innerRadius(innerRadius).outerRadius(outerRadius);

	// svg 문서 요소 지정
	var svg = d3.select("body")
				.append("svg")
				.attr("width", w)
				.attr("height", h);


	// 그룹 지정
	var arcs = svg.selectAll("g.arc") //g에 대한 참조를 지정
			.data(pie(dataset))
			.enter()
			.append("g")
			.attr("class", "arc")
			.attr("transform", "translate("+outerRadius + "," + outerRadius + ")");

	// 호의 경로 그리기
	arcs.append("path")
		.attr("fill", function(d, i){ // path 문서요소의 경로 정보 정의 d, 그 안에 arc 생성 함수 호출
			return color(i);
	})
	.attr("d", arc);  //그룹에 엮인 데이터를 기반으로 호의 경로정보 생성

	// 부채꼴에 텍스트 라벨 생성
	arcs.append("text")
		.attr("transform", function(d){
			return "translate("+arc.centroid(d)+")";
		})
		.attr("text-anchor", "middle")
		.attr("fill","white")
		.text(function(d){
			return d.value;
		})
// 	d3.select("body").append("p").text("new paragraph");
// 	d3.csv("${ctx}/csv/SalesJan2009.csv", function(data){
// 		dataset =data;
// 	});
</script>
</body>
</html>