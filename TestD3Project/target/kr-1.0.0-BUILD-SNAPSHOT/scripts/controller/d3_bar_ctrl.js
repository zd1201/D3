ojtD3.controller("D3BarCtrl", function($scope, $http, $interval) {
	
	// 날짜 형식
	 	var  time_format = d3.timeFormat("%H:%M:%S");
		var dataset = [];
		var interval;
		
		var numDataPoints = 12; // 데이터 개수	
		var minValue = 5; // 최소 값
		var maxRange = 30; // 최대 값
		var svgWidth = 960;
		var svgHeight = 500;
		var barPadding = 1;
		var padding = 30;
		
	 	var  time_format = d3.timeFormat("%H:%M:%S");
		var dataset = [];
		var interval;

//			 	var dataset = [    {time: "12:34:43", value: 9},
//					               {time: "12:34:43", value: 7},
//					               {time: "12:34:44", value: 23},
//					               {time: "12:34:45", value: 27},
//					               {time: "12:34:46", value: 31},
//					               {time: "12:34:47", value: 13},
//					               {time: "12:34:48", value: 3},
//					               {time: "12:34:49", value: 9},
//					               {time: "12:34:50", value: 9},
//					               {time: "12:34:51", value: 9},]
											
		var dataset = [];

		var svg2 = d3.select('#chart')
						.attr("width", svgWidth)
						.attr("height", svgHeight);


		var xScale = d3.scaleBand()
//						.domain(dataset.map(function(d) { return d.time; })) // 정의역
						.rangeRound([ padding , svgWidth - padding * 2]) // 치역 padding 부터 
						.paddingInner(0.05);

		var yScale = d3.scaleLinear()
//						.domain([ 0, d3.max(dataset, function(d) {
//							return d.value;
//						})])
						.range([ svgHeight - padding, padding]);
	
//		var x_domain = d3.extent(dataset, function(d) { 
//							return new Date(d.time); 
//						});
//
//		var axisXScale = d3.scaleTime()
//							.domain(x_domain)
//							.rangeRound([padding, svgWidth - padding * 2]);
	
		var barYScale = d3.scaleLinear()
							.domain([ 0, d3.max(dataset, function(d) {
								return d.value;
							})])
							.range([ 0, svgHeight - padding]);
	
	
		// x축 생성하는 축 함수 정의
		// 축은 어떤 척도를 다뤄야 하는지 반드리 알려줘야 함
		// 축을 나타내는 선을 기준으로 라벨의 위치 지정. 기본값은 bottom, 라벨이 선 아래쪽에 표시 됨
	 	var xAxis = d3.axisBottom()
	 				.scale(xScale);
	
//		var xAxis = d3.axisBottom()
//						.scale(axisXScale)
//						.tickFormat(time_format);
		// x축 생성
		svg2.append("g")
			.attr("class", "x axis")
			.attr("transform", "translate(0,"+(svgHeight - padding)+")")
			.call(xAxis);
	
		var yAxis = d3.axisLeft()
						.scale(yScale);
	
	
		// y축 생성
		svg2.append("g")
			.attr("class", "y axis")
			.attr("transform", "translate("+ padding+",0)")
			.call(yAxis);

		var time = function(d) {
			return d.time;
		}

//		svg2.selectAll("rect")
//			.data(dataset, time)
//			.enter()
//			.append("rect")
//			.attr("x", function(d) {
//					return xScale(d.time);
//				})
//			.attr("y", function(d) {
//					return svgHeight - padding - barYScale(d.value);
//				})
//			.attr("width", xScale.bandwidth())
//			.attr("height", function(d) {
//					return barYScale(d.value);
//				})
//			.attr("opacity",0)
//			.attr("fill", function(d) {
//					return "rgb(0, 0, " + (d.value * 10) + ")";
//				})
//			.on("mouseout",function(d) {
//				d3.select(this)
//					.transition()
//					.duration(250)
//					.attr("fill","rgb(0, 0, " + (d.value * 10) + ")");
//				})
//			.append("title")
//			.text(function(d){
//				return "This value is " + d.value;
//			});

//		svg2.selectAll("text")
//			.data(dataset, time)
//			.enter()
//			.append("text")
//				.text(function(d) {
//					return d.value;
//				})
//				.attr("x", function(d, i) {
//					return xScale(i) + xScale.bandwidth() / 2;
//				})
//				.attr("y", function(d) {
//					return svgHeight - barYScale(d.value);
//				})
//				.attr("font-family", "sans-serif").attr("font-size", "8px")
//				.attr("opacity",0)
//				.attr("class", "label");
//				.attr("fill", "white").attr("text-anchor", "middle");

		// 서버에 새로운 데이터 요청
		var getData = function() {
	 		
				var req = {
					method : "GET",
					url : ctx + "/getBarData",
					headers : {
						"Content-Type" : "application/json; charset=UTF-8"
					}
				};

				$http(req) // 요청 파라미터
				.then(function (response) {
					
					if( dataset.length < 1) {
						
						 var now = new Date();
				         hours = now.getHours();
				         minutes = now.getMinutes();
				         seconds = now.getSeconds();
				         
				         if (hours < 10){
				             hours = "0" + hours;
				         }
				         if (minutes < 10){
				             minutes = "0" + minutes;
				         }
				         if (seconds < 10){
				             seconds = "0" + seconds;
				         }
				         
						for(var i=0; i < 10;i++){
							dataset.push({time: hours + ":" + minutes + ":" + (seconds - i - 1), value: 0});
						}
						
						redraw();
					}
					
					$scope.newData = response.data.value;
				}, function (response) {
					alert(response);
				});
		};
		
		
		// dataset value
		var next = function(dataset){
	        var now = new Date();
	         hours = now.getHours();
	         minutes = now.getMinutes();
	         seconds = now.getSeconds();
	  
	         if (hours < 10){
	             hours = "0" + hours;
	         }
	         if (minutes < 10){
	             minutes = "0" + minutes;
	         }
	         if (seconds < 10){
	             seconds = "0" + seconds;
	         }
	      
	    // insert current time into html
//	    document.getElementById("dpTime").innerHTML = hours + ":" + minutes + ":" + seconds;
	    
	    // create new data value
	         getData();
	         console.log("$scope.newData"+$scope.newData);
		    return {
		    	time : hours + ":" + minutes + ":" + seconds,
				value : $scope.newData
		    }
	 };
	 
	 	getData();
		// 1초마다 dataset 갱신
		 stopTime = $interval(function(){
			 if(dataset.length > 9){
				 dataset.shift();
			 }
			 
			 // push new data
			 dataset.push(next());
			 console.log("dataset.length"+dataset.length);
			 redraw();

		 }, 2000);
		 
		 
		 var redraw = function(){
				// 추가되는 막대를 위한 공간 확보를 위해 x축의 척도 조절
			  xScale.domain(dataset.map(function(d) { return d.time; }));
			  yScale.domain([0, d3.max(dataset, function(d) { return d.value; })]);
			  
			  barYScale.domain([ 0, d3.max(dataset, function(d) {
				  return d.value;
			  }) ]);
			
				// x축 
				svg2.select(".x.axis")
//			  .transition()
//			  .duration(300)
			  .call(xAxis);
			
				// y축 생성
				svg2.select(".y.axis").transition().duration(300).call(yAxis);
				
			
//					x_domain = d3.extent(dataset, function(d) {
//						return new Date(d.time); 
//					});
//				
//			
//					axisXScale.domain(x_domain)
				
					xAxis.scale(xScale);
					yAxis.scale(yScale);
				
				
				// 데이터가 갱신된 선택물 저장
				var bars = svg2.selectAll("rect")
								.data(dataset,time);
				// 모자란 선택물 추출
				bars.enter()
					.append("rect")
					.attr("x", svgWidth - padding * 2) // 새로운 rect의 가로위치를 svg 오른쪽 모서리를 바깥쪽 위치로 설정
					.attr("y", function(d) {
							return svgHeight - padding - barYScale(d.value);
						})
					.attr("width", xScale.bandwidth())
					.attr("height",	function(d) {
							return barYScale(d.value);
					})
					.attr("fill",function(d) {
							return "rgb(0,0, " + Math.round(d.value * 10) + ")";
					})
					.merge(bars) // 막대 갱신
//					.transition()
//					.duration(500)
					.attr("x",function(d) {
								return xScale(d.time);
					})
					.attr("y", function(d) {
							return svgHeight - padding - barYScale(d.value);
						})
					.attr("width", xScale.bandwidth())
					.attr("height", function(d) {
							return barYScale(d.value);
					})
					.on("mouseover", function(d) {
							//Get this bar's x/y values, then augment for the tooltip
							var xPosition = svgWidth/2 + parseFloat(d3.select(this).attr("x")) + xScale.bandwidth()*3;
							var yPosition = parseFloat(d3.select(this).attr("y")) / 2 + svgHeight / 2;
							//Update the tooltip position and value
							d3.select("#tooltip")
								.style("left", xPosition + "px")
								.style("top", yPosition + "px")						
								.select("#value")
								.text(d.value);
			   
							//Show the tooltip
							d3.select("#tooltip").classed("hidden", false);
					 })
					.on("mouseout", function() {
						//Hide the tooltip
						d3.select("#tooltip").classed("hidden", true);
					 });

				bars.exit()
//					.transition()
//					.duration(500)
					.attr("x",-xScale.bandwidth()) 
				// 왼쪽으로 제거
				// 이전 트랜지션이 완전히 끝나기를 기다렸다가 dom에서 문서요소 삭제
				.remove();

//				// 라벨 선택
//				var labels = svg2.selectAll("#valueLabel")
//								.data(dataset,time);
//				
//				//라벨 갱신
//				labels.enter()
//					.append("text")
//					.text(function(d) {
//						return d.value;
//				})
//				.attr("id", "valueLabel")
//				.attr("x", svgWidth - padding * 2)
//				.attr("y", function(d) {
//					return svgHeight - barYScale(d.value);
//				})
//				.attr("font-family", "sans-serif")
//				.attr("font-size", "8px")
//				.attr("fill", "white")
//				.attr("text-anchor", "middle")
//				.attr("class","label")
//				.attr("opacity",1)
//				.merge(labels) //Update…
////				.transition()
////				.duration(500)
//				.attr("x", function(d, i) {
//							return xScale(d.time) + xScale.bandwidth() / 2;
//				});
////
//				labels.exit()
//						.transition()
//						.duration(500)
//						.attr("x",-xScale.bandwidth())
//						.remove();
		 }
});
