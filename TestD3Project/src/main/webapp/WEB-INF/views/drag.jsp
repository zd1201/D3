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
<style>

html,
body {
  height: 100%;
  margin: 0;
  overflow: hidden;
}

svg {
  position: absolute;
}

</style>
<!-- 	<script type="text/javascript"> -->
<%-- var ctx = "${ctx}"; --%>
<!-- 	</script> -->
<title>D3 Page Template</title>
</head>
<body>
<script>

var width = self.frameElement ? 960 : innerWidth,
    height = self.frameElement ? 500 : innerHeight;

var data = d3.range(20).map(function() { return [Math.random() * width, Math.random() * height]; });

var color = d3.scaleOrdinal(d3.schemeCategory10);

var drag = d3.drag()
    .origin(function(d) { return {x: d[0], y: d[1]}; })
    .on("drag", dragged);

d3.select("body")
    .on("touchstart", nozoom)
    .on("touchmove", nozoom)
  .append("svg")
    .attr("width", width)
    .attr("height", height)
  .selectAll("circle")
    .data(data)
  .enter().append("circle")
    .attr("transform", function(d) { return "translate(" + d + ")"; })
    .attr("r", 32)
    .style("fill", function(d, i) { return color(i); })
    .on("click", clicked)
    .call(drag);

function dragged(d) {
  d[0] = d3.event.x, d[1] = d3.event.y;
  if (this.nextSibling) this.parentNode.appendChild(this);
  d3.select(this).attr("transform", "translate(" + d + ")");
}

function clicked(d, i) {
  if (d3.event.defaultPrevented) return; // dragged

  d3.select(this).transition()
      .style("fill", "black")
      .attr("r", 64)
    .transition()
      .attr("r", 32)
      .style("fill", color(i));
}

function nozoom() {
  d3.event.preventDefault();
}

</script>
</body>
</html>