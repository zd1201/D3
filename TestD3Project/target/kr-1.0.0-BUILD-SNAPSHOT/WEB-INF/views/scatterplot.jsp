<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!-- request 객체에 저장된 contextpath를 참조하여 경로 명시 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<script src="${ctx}/d3/d3.js" type="text/javascript" charset="utf-8"></script>
	<style type="text/css">
		div.bar{
		display: inline-block;
		width: 20px;
		height: 75px;
		background-color: teal;
		margin-right: 2px;
		}
		
		.axis path,
		.axis line{
			fill: none;
			stroke: black;
			shape-rendering: crispEdges;
		}
		
		.axis text{
			font-family: sans-serif;
			font-size: 11px;
		}
		
		text{
			fill: olive;
		}
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
<!-- 	<script type="text/javascript"> -->
<%-- var ctx = "${ctx}"; --%>
<!-- 	</script> -->
	<title>D3 Page Template</title>
</head>
<body>
<h1>
	Hello D3!  
</h1>

	<p>Click on this text to update the chart with new data values as many times as you like!</p>
	
		<script type="text/javascript">
		
			//Width and height
			var w = 500;
			var h = 300;
			var padding = 30;
			
			//Dynamic, random dataset
			var dataset = [];											
			var numDataPoints = 50;										
			var xRange = Math.random() * 1000;
			var yRange = Math.random() * 1000;
			
			for (var i = 0; i < numDataPoints; i++) {					
				var newNumber1 = Math.floor(Math.random() * xRange);	
				var newNumber2 = Math.floor(Math.random() * yRange);	
				dataset.push([newNumber1, newNumber2]);					
			}
			
			var svg = d3.select("body")
						.append("svg")
						.attr("width",w)
						.attr("height",h);

			//x축 생성하는 척도 함수 정의
			var xScale = d3.scaleLinear()
								.domain([0, d3.max(dataset, function(d){// 정의역의 아래쪽 경계값 0으로 지정, 위쪽 경계값은 dataset의 최댓값 지정
									return d[0];
								})])
								.range([padding, w - padding * 2]);// 치역 0부터 svg 넓이인 w로 설정
			
			//y축 생성하는 척도 함수 정의
			var yScale = d3.scaleLinear()
								.domain([0, d3.max(dataset, function(d){
									return d[1];
								})])
								.range([h - padding, padding]);
								
			// 반지름 전용 척도 함수
			var rScale = d3.scaleLinear()
							.domain([0, d3.max(dataset, function(d){
								return d[1];
							})])
							.range([2, 5]);
								
			// x축 생성하는 축 함수 정의
			// 축은 어떤 척도를 다뤄야 하는지 반드리 알려줘야 함
			// 축을 나타내는 선을 기준으로 라벨의 위치 지정. 기본값은 bottom, 라벨이 선 아래쪽에 표시 됨
			var xAxis = d3.axisBottom()
							.scale(xScale)
							.ticks(5);
			// x축 생성
			svg.append("g")
				.attr("class", "axis")
				.attr("transform", "translate(0,"+(h - padding)+")")
				.call(xAxis);
			
			
			var yAxis = d3.axisLeft()
			.scale(yScale)
			.ticks(5);
			
			
			// y축 생성
			svg.append("g")
			.attr("class", "axis")
			.attr("transform", "translate("+ padding +",0)")
			.call(yAxis);
			
			// 산포도 생성
			svg.selectAll("circle")
				.data(dataset)
				.enter()
				.append("circle")
				.attr("cx", function(d){
					return xScale(d[0]);
				})
				.attr("cy", function(d){
					return yScale(d[1]);
				})
				.attr("r", function(d){
					return rScale(d[1]);
				});
			
// 			// 라벨 생성
// 			svg.selectAll("text")
// 				.data(dataset)
// 				.enter()
// 				.append("text")
// 				.text(function(d){
// 					return d[0] + "," +d[1];
// 				})
// 				.attr("x", function(d){
// 					return xScale(d[0]);
// 				})
// 				.attr("y", function(d){
// 					return yScale(d[1]);
// 				})
// 				.attr("font-family", "sans-serif")
// 				.attr("font-size", "11px")
// 				.attr("fill", "red");
			
			//클릭 이벤트
			d3.select("p")
				.on("click", function(){
					
			
			
			// x축 갱신
			svg.select(".x.axis")
				.transition()
				.duration(1000)
				.call(xAxis);
			
			// y축 갱신
			svg.select(".y.axis")
				.transition()
				.duration(1000)
				.call(yAxis);
			
			//모든 점을 갱신
			svg.selectAll("circle")
				.data(dataset)
				.transition()
				.duration(1000)
				.on("start", function(){ // 트랜지션 시작 시 실행
					d3.select(this)
						.attr("fill", "magneta")
						.attr("r", 7);
				})
				.attr("cx", function(d){
					return xScale(d[0]);
				})
				.attr("cy", function(d){
					return yScale(d[1]);
				})
				.on("end", function(){ // 트랜지션 종료 시 실행
					d3.select(this)
						.attr("fill", "black")
						.attr("r", 2);
				});
			
			// 라벨 생성
// 			svg.selectAll("text")
// 				.data(dataset)
// 				.enter()
// 				.append("text")
// 				.text(function(d){
// 					return d[0] + "," +d[1];
// 				})
// 				.attr("x", function(d){
// 					return xScale(d[0]);
// 				})
// 				.attr("y", function(d){
// 					return yScale(d[1]);
// 				})
// 				.attr("font-family", "sans-serif")
// 				.attr("font-size", "11px")
// 				.attr("fill", "red");
			});
			
			
			var formatAsPercentage = d3.format(".1%");
			
			xAxis.tickFormat(formatAsPercentage);
			
		</script>
</body>
</html>
