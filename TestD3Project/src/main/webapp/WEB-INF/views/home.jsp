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
	<h1>Hello D3!</h1>
	<p>Click on this text to update the chart with new data value</p>
	<%-- <P>  The time on the server is ${serverTime}. </P> --%>

	<script type="text/javascript">
	var dataset = [];
	for (var i = 0; i < 25; i++){
		var newNumber = Math.floor(Math.random() * 30)+1;
		dataset.push(newNumber);
	}
// 	d3.select("body") // DOM에서 body를 찾고, 메서드 체인을 위해서 참조 값을 넘긴다.
// 		.selectAll("p") //p문서요소를 모두 선택. dom에 존재하지 않으면 빈 선택물 반환
// 		.data(dataset) // 데이터 값이 몇 개인지 계산하고 파싱. 체인으로 연결된 모든 내용은 값마다 한번씩 실행
// 		.enter() // 해당 DOM 선택물이 있는지 살펴보고 데이터를 건네줌.
// 		.append("p") // enter() 메서드가 생성한 빈 플레이스 홀더 선택물 가져와 DOM에 p 문서요소 추가
// 		.text(function(d){ // 가장 가까운 DOM 선택물에 해당 문서요소와 엮인 데이터 집합의 값을 d로 할당
// 			return d; 
// 		}); // 새로만든 p참조에 값 삽입
	
// 	dataset.push(1);
// 	console.log(dataset);

// 	d3.select("body") // DOM에서 body를 찾고, 메서드 체인을 위해서 참조 값을 넘긴다.
// 		.selectAll("div") //p문서요소를 모두 선택. dom에 존재하지 않으면 빈 선택물 반환
// 		.data(dataset) // 데이터 값이 몇 개인지 계산하고 파싱. 체인으로 연결된 모든 내용은 값마다 한번씩 실행
// 		.enter() // 해당 DOM 선택물이 있는지 살펴보고 데이터를 건네줌.
// 		.append("div") // enter() 메서드가 생성한 빈 플레이스 홀더 선택물 가져와 DOM에 p 문서요소 추가
// 		.attr("class","bar")
// 		.style("height",function(d){
// 			var barHeight = d * 5;
// 			return barHeight + "px";
// 		});
	
// 	var dataset = [];
// 	for (var i = 0; i < 10; i++){
// 		var newNumber = Math.floor(Math.random() * 20)+1;
// 		dataset.push(newNumber);
// 	}
	
// 	var svg = d3.select("body").append("svg");
	var w = 1500;
	var h = 150;
// 	svg.attr("width",w)
// 		.attr("height",h);
	
// 	var circles = svg.selectAll("circle")
// 					.data(dataset)
// 					.enter()
// 					.append("circle");
// 	circles.attr("cx",function(d,i){
// 			return ( i * 50) + 25;
// 		})
// 			.attr("cy",h/2)
// 			.attr("r",function(d){
// 				return d;
// 			})
// 			.attr("fill","yellow")
// 			.attr("stroke", "orange")
// 			.attr("stroke-width", function(d){
// 				return d/2;
// 	});
	
			//Width and height
			var w = 600;
			var h = 250;
			
			var dataset = [ 5, 10, 13, 19, 21, 25, 22, 18, 15, 13,
							11, 12, 15, 20, 18, 17, 16, 18, 23, 25 ];

			dataset.push(123);
			
			
			var xScale = d3.scaleBand()
							.domain(d3.range(dataset.length))
							.rangeRound([0, w])// 치역의 양 끝점을 전달인자로 받아서, 정의역의 개수를 기준으로 그 수만큼 대역으로 조각 냄 
							.paddingInner(0.05);// 대역폭이 5%로 간격으로 사용
			
			var yScale = d3.scaleLinear()
							.domain([0, d3.max(dataset)])
							.range([0, h]);
			
			//Create SVG element
			var svg = d3.select("body")
						.append("svg")
						.attr("width", w)
						.attr("height", h);
			//Create bars
			svg.selectAll("rect")
			   .data(dataset)
			   .enter()
			   .append("rect")
			   .attr("x", function(d, i) {
			   		return xScale(i);
			   })
			   .attr("y", function(d) {
			   		return h - yScale(d);
			   })
			   .attr("width", xScale.bandwidth())// 막대사이 폭 설정
			   .attr("height", function(d) {
			   		return yScale(d);
			   })
			   .attr("fill", function(d) {
					return "rgb(0, 0, " + Math.round(d * 10) + ")";
			   });
			//Create labels
			svg.selectAll("text")
			   .data(dataset)
			   .enter()
			   .append("text")
			   .text(function(d) {
			   		return d;
			   })
			   .attr("text-anchor", "middle")
			   .attr("x", function(d, i) {
			   		return xScale(i) + xScale.bandwidth() / 2;
			   })
			   .attr("y", function(d) {
			   		return h - yScale(d) + 14;
			   })
			   .attr("font-family", "sans-serif")
			   .attr("font-size", "11px")
			   .attr("fill", "white");
			//On click, update with new data			
			d3.select("p")
				.on("click", function() {
					//New values for dataset
					var numValues = dataset.length;
					dataset = [];
					for(var i =0; i < numValues; i++){
						var newNumber = Math.floor(Math.random() * 100) + 10;
						dataset.push(newNumber);
					}
					//Update all rects
					svg.selectAll("rect")
					   .data(dataset)
					   .transition()
					   .duration(1000)
					   .attr("y", function(d) {
					   		return h - yScale(d);
					   })
					   .attr("height", function(d) {
					   		return yScale(d);
					   })
					   .attr("fill", function(d) {
							return "rgb(0, 0, " + Math.round(d * 10) + ")";
					   });
					//Update all labels
					svg.selectAll("text")
					   .data(dataset)
					   .text(function(d) {
					   		return d;
					   })
					   .attr("x", function(d, i) {
					   		return xScale(i) + xScale.bandwidth() / 2;
					   })
					   .attr("y", function(d) {
					   		return h - yScale(d) + 14;
					   });
					   				
				});
			
			//Create SVG element
			var svg3 = d3.select("body")
						.append("svg")
						.attr("width", 600)
						.attr("height", 400);

			var data = [{transX: 100}];

			svg3.selectAll("g")
				.data(data)
			    .enter()
			    .append("g")
			    .attr("transform", function(d) {
			          return "translate(" + d.transX + ") rotate(15)";
			        })
			     .call(function(g) { // 호출된 바로 앞의 객체를 매개변수로 넘겨주는 역할
			          g.append("rect")
			           .attr("width", "300").attr("height", "200").attr("fill", "red")
			          g.append("circle")
			           .attr("cx", "150").attr("cy", "100").attr("r", 80).attr("fill", "green")
			          g.append("text")
			           .attr("x", "150").attr("y", "125").attr("font-size", "60")
			           .attr("text-anchor", "middle").attr("fill", "white").text("SVG")
			        });

	
// 	svg.selectAll("rect")
// 		.data(dataset)
// 		.attr("y", function(d){
// 			return h - yScale(d);
// 		})
// 		.attr("height", function(){
// 			return yScale(d);
// 		});


	
</script>
</body>
</html>
