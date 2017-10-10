<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<%@ include file="/WEB-INF/views/taglibs.jsp"%>
<%@ page session="false"%>

<!-- request 객체에 저장된 contextpath를 참조하여 경로 명시 -->
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html ng-app="ojtD3">
<head>
<script src="${ctx}/d3/d3.js" type="text/javascript" charset="utf-8"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script src="${ctx}/scripts/controller/bar_ctrl.js" type="text/javascript" charset="utf-8"></script>

<title>D3 Page Template</title>
</head>
<body ng-controller="barCtrl">
<!-- 	<div> -->
<!-- 		<p id="add">판매수량 (단위: 천개)</p> -->
<!-- 		 날짜 입력 : <input type="date" id="date"> -->
<!-- 		 판매수량 입력 : <input type="number" id="quantity"> -->
<!-- 	</div> -->
<!-- 	<p id="remove">Remove a data value</p> -->
	
	<span id="dpTime">오후 01:44:40</span>
	<script>
			
			// 날짜 형식
// 		 	var  time_format = d3.timeFormat("%H:%M:%S");
// 	 		var dataset = [];
// 	 		var interval;

// 	 		var numDataPoints = 12; // 데이터 개수	
// 	 		var minValue = 5; // 최소 값
// 	 		var maxRange = 30; // 최대 값
// 	 		var svgWidth = 700;
// 	 		var svgHeight = 340;
// 	 		var barPadding = 1;
// 	 		var padding = 30;
	 		
// 				 	var dataset = [{time: "2016-08-02", value: 9},
// 						               {time: "2016-08-03", value: 7},
// 						               {time: "2016-08-04", value: 23},
// 						               {time: "2016-08-05", value: 27},
// 						               {time: "2016-08-06", value: 31},
// 						               {time: "2016-08-07", value: 13},
// 						               {time: "2016-08-08", value: 3},
// 						               {time: "2016-08-09", value: 9},
// 						               {time: "2016-08-10", value: 9},
// 						               {time: "2016-08-11", value: 9},
// 						               {time: "2016-08-12", value: 9},
// 						               {time: "2016-08-13", value: 9}];
													
		
// 			var svg2 = d3.select("body")
// 							.append("svg")
// 							.attr("width", svgWidth)
// 							.attr("height", svgHeight);


// 			var xScale = d3.scaleBand()
// 							.domain(d3.range(dataset.length)) // 정의역
// 							.rangeRound([ padding , svgWidth - padding * 2]) // 치역 padding 부터 
// 							.paddingInner(0.05);

// 			var yScale = d3.scaleLinear()
// 							.domain([ 0, d3.max(dataset, function(d) {
// 								return d.value;
// 							})])
// 							.range([ svgHeight - padding, padding]);
			
// 			//.range([h - padding, padding]);
// 			var x_domain = d3.extent(dataset, function(d) { 
// 								return new Date(d.time); 
// 							});
		
// 			var axisXScale = d3.scaleTime()
// 								.domain(x_domain)
// 								.rangeRound([padding, svgWidth - padding * 2]);
			
// 			var barYScale = d3.scaleLinear()
// 								.domain([ 0, d3.max(dataset, function(d) {
// 									return d.value;
// 								})])
// 								.range([ 0, svgHeight - padding]);
			
			
// 			// x축 생성하는 축 함수 정의
// 			// 축은 어떤 척도를 다뤄야 하는지 반드리 알려줘야 함
// 			// 축을 나타내는 선을 기준으로 라벨의 위치 지정. 기본값은 bottom, 라벨이 선 아래쪽에 표시 됨
// //	 		var xAxis = d3.axisBottom()
// //	 						.scale(xScale)
// //	 						.tickFormat(time_format);
			
// 			var xAxis = d3.axisBottom()
// 							.scale(axisXScale)
// 							.tickFormat(time_format);
// 			// x축 생성
// 			svg2.append("g")
// 				.attr("class", "axis x")
// 				.attr("transform", "translate(0,"+(svgHeight - padding)+")")
// 				.call(xAxis);
			
// 			var yAxis = d3.axisLeft()
// 							.scale(yScale)
// 							.ticks(5);
			
			
// 			// y축 생성
// 			svg2.append("g")
// 				.attr("class", "axis y")
// 				.attr("transform", "translate("+ padding+",0)")
// 				.call(yAxis);

// 			var time = function(d) {
// 				return d.time;
// 			}

// 			svg2.selectAll("rect")
// 				.data(dataset, time)
// 				.enter()
// 				.append("rect")
// 				.attr("x", function(d, i) {
// 						return xScale(i);
// 					})
// 				.attr("y", function(d) {
// 						return svgHeight - padding - barYScale(d.value);
// 					})
// 				.attr("width", xScale.bandwidth())
// 				.attr("height", function(d) {
// 						return barYScale(d.value);
// 					})
// 				.attr("fill", function(d) {
// 						return "rgb(0, 0, " + (d.value * 10) + ")";
// 					})
// 				.on("mouseout",function(d) {
// 					d3.select(this)
// 						.transition()
// 						.duration(250)
// 						.attr("fill","rgb(0, 0, " + (d.value * 10) + ")");
// 					})
// 				.append("title")
// 				.text(function(d){
// 					return "This value is " + d.value;
// 				});

// 			svg2.selectAll("text").data(dataset, time).enter().append("text")
// 					.text(function(d) {
// 						return d.value;
// 					})
// 					.attr("x", function(d, i) {
// 						return xScale(i) + xScale.bandwidth() / 2;
// 					})
// 					.attr("y", function(d) {
// 						return svgHeight - barYScale(d.value);
// 					})
// 					.attr("font-family", "sans-serif").attr("font-size", "8px")
// 					.attr("fill", "white").attr("text-anchor", "middle");

// 			// 값 문서요소 추가하기
// 			d3.selectAll("p")
// 					.on("click", function() {

// 								var paragraphID = d3.select(this).attr("id");

// 								if (paragraphID == "add") {
// 									// 신규 값 추가
// 									var maxValue = 25;
// 									var minValue = 2;

// 									// 사용자 추가 데이터
// 									//var newNumber = Math.floor(Math.random() * maxValue) + minValue;
// 									//var lasttimeValue = dataset[dataset.length -1].time;

// 									var newNumber = Number(document.getElementById("quantity").value);
// 									var lasttimeValue = document.getElementById("time").value;

// 									dataset.push({
// 										// key: lasttimeValue + 1,
// 										time : lasttimeValue,
// 										value : newNumber
// 									});
// 								} else {
// 									// dataset에서 값 하나 제거
// 									dataset.shift();
// 								}

// 								// 추가되는 막대를 위한 공간 확보를 위해 x축의 척도 조절
// 								xScale.domain(d3.range(dataset.length));
								
// 								yScale.domain([ 0, d3.max(dataset, function(d) {
// 												return d.value;
// 											})]);
									
// 								barYScale.domain([ 0, d3.max(dataset, function(d) {
// 									return d.value;
// 								}) ]);
								
// 									x_domain = d3.extent(dataset, function(d) {
// 										return new Date(d.time); 
// 									});
									
								
// 									axisXScale.domain(x_domain)
									
// 									xAxis.scale(axisXScale);
// 									yAxis.scale(yScale);
									
									
// 								// 데이터가 갱신된 선택물 저장
// 								var bars = svg2.selectAll("rect")
// 												.data(dataset,time);
// 								// 모자란 선택물 추출
// 								bars.enter()
// 									.append("rect")
// 									.attr("x", svgWidth - padding * 2) // 새로운 rect의 가로위치를 svg 오른쪽 모서리를 바깥쪽 위치로 설정
// 									.attr("y", function(d) {
// 											return svgHeight - padding - barYScale(d.value);
// 										})
// 									.attr("width", xScale.bandwidth())
// 									.attr("height",	function(d) {
// 											return barYScale(d.value);
// 									})
// 									.attr("fill",function(d) {
// 											return "rgb(0,0, " + Math.round(d.value * 10) + ")";
// 									})
// 									.merge(bars) // 막대 갱신
// 									.transition()
// 									.duration(500)
// 									.attr("x",function(d, i) {
// 												console.log("i", i)
// 												console.log("bar xScale(i)",xScale(i));
// 												return xScale(i);
// 									})
// 									.attr("y", function(d) {
// 											return svgHeight - padding - barYScale(d.value);
// 										})
// 									.attr("width", xScale.bandwidth())
// 									.attr("height", function(d) {
// 											return barYScale(d.value);
// 									});

// 								bars.exit()
// 									.transition()
// 									.duration(500)
// 									.attr("x",-xScale.bandwidth()) 
// 								// 왼쪽으로 제거
// 								// 이전 트랜지션이 완전히 끝나기를 기다렸다가 dom에서 문서요소 삭제
// 								.remove();

// 								// 라벨 선택
// 								var labels = svg2.selectAll("text")
// 												.data(dataset,time);

// 								//라벨 갱신
// 								labels.enter()
// 									.append("text")
// 									.text(function(d) {
// 										return d.value;
// 								})
// 								.attr("x", svgWidth - padding * 2)
// 								.attr("y", function(d) {
// 									return svgHeight - barYScale(d.value);
// 								})
// 								.attr("font-family", "sans-serif")
// 								.attr("font-size", "8px")
// 								.attr("fill", "white")
// 								.attr("text-anchor", "middle")
// 								.merge(labels) //Update…
// 								.transition()
// 								.duration(500)
// 								.attr("x", function(d, i) {
// 											return xScale(i) + xScale.bandwidth() / 2;
// 								});

// 								labels.exit()
// 										.transition()
// 										.duration(500)
// 										.attr("x",-xScale.bandwidth())
// 										.remove();
					
				
				
// 				// x축 
// 				svg2.selectAll("g.axis.x")
// 					.call(xAxis);
				
				
// 				// y축 생성
// 				svg2.selectAll("g.axis.y")
// 					.call(yAxis);
					
// 			});
	
	</script>
</body>
</html>