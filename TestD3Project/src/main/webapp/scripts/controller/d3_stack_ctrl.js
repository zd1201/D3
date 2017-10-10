ojtD3.controller("D3StackCtrl", function($scope, $http, $interval) {

	var data = [];
//	$scope.newData = 10;
	//svg 영역
	var svg = d3.select("svg"),
		    margin = {top: 20, right: 20, bottom: 30, left: 40},
		    width = +svg.attr("width") - margin.left - margin.right,
		    height = +svg.attr("height") - margin.top - margin.bottom,
		    g = svg.append("g")
		    		.attr("id","stack1")
		    		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
	
	// key 값 정의
	var keys =  ["New York", "San Francisco", "Portland"] ;

	// x축 함수 정의
	var x = d3.scaleBand()
	    .rangeRound([0, width])
	    .paddingInner(0.05)
	    .align(0.1);
	
	// y축 함수 정의
	var y = d3.scaleLinear()
			.rangeRound([height, 50]);
	
	//z축 함수 정의
	var z = d3.scaleOrdinal()
	    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

	//z축 도메인 정의
	z.domain(keys);
	  
	  // x축 생성
	  g.append("g")
	   .attr("class", "x axis")
	   .attr("transform", "translate(0," + height + ")");
	  
	  // y축 생성
	  g.append("g")
	   .attr("class", "y axis")
	   .append("text")
	   .attr("x", 2)
	   .attr("y", y(y.ticks().pop()) + 0.5)
	   .attr("dy", "0.32em")
	   .attr("fill", "#000")
	   .attr("font-weight", "bold")
	   .attr("text-anchor", "start")
	   .text("Population");
	
	  // 범례 생성
	  var legend = g.append("g")
	  .attr("font-family", "sans-serif")
	  .attr("font-size", 10)
	  .attr("text-anchor", "end")
	  .selectAll("g")
	  .data(keys.slice().reverse())
	  .enter().append("g")
	  .attr("transform", function(d, i) { 
		  return "translate(0," + i * 20 + ")"; 
	  });
	  
	  // 범례 사각형 표시
	  legend.append("rect")
	  .attr("x", width - 19)
	  .attr("width", 19)
	  .attr("height", 19)
	  .attr("fill", z);
	  
	  // 범례 이름
	  legend.append("text")
	  .attr("x", width - 24)
	  .attr("y", 9.5)
	  .attr("dy", "0.32em")
	  .text(function(d) { 
		  return d; 
	  });
  
  
  // 서버에 새로운 데이터 요청
  var getData = function() {
			
			var req = {
				method : "GET",
				url : ctx + "/getStackData",
				headers : {
					"Content-Type" : "application/json; charset=UTF-8"
				}
			};

			$http(req) // 요청 파라미터
			.then(function (response) {
				
				if( data.length < 1) {
					
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
						data.push({
									"time": hours + ":" + minutes + ":" + (seconds - i - 1), 
									"New York": 0,
									"San Francisco": 0,
									"Portland": 0,
									"total": 0
							});
					}
					redraw();
				}
				
				$scope.newData = response.data.value;
			}, function (response) {
				alert(response);
			});
	};
	

	// 스택 바 생성
//var draw = function (){	
//	  g.append("g")
////	   .attr("id","stack1")
//	   .selectAll("g")
//	   .data(d3.stack().keys(keys)(data))
//	   .enter().append("g")
//	   .attr("fill", function(d) { //key 별로 색 채우기
//	    	 return z(d.key); 
//	    })
//	    .selectAll("rect")
//	    .data(function(d) { 
//	    	return d; 
//	    })
//	    .enter().append("rect")
//	    .attr("x", function(d) { 
//	    	  return x(d.data.time); 
//	    })
//	    .attr("y", function(d) {
//	    	console.log("d[1]"+d[1]);
//	    	return y(d[1]); 
//	    })
//	    .attr("height", function(d) {
//	    	console.log("d[0]"+d[0]);
//	    	return y(d[0]) - y(d[1]); 
//	    })
//	    .attr("width", x.bandwidth())
//	  	.attr("opacity", 0);
//	}
	  
var redraw = function (){
	
	
  // 데이터 생성
//	var data = [
//{"time": "CA", "New York": 2704659, "San Francisco": 4499890, "Portland": 2159981, "total": 9364530},
//{"time": "Cb", "New York": 2704659, "San Francisco": 4499890, "Portland": 2159981, "total": 9364530}]
//	var data = [
//{"time": "CA", "New York": 2704659, "San Francisco": 4499890, "Portland": 2159981}];

	console.log(data);
  
  
//  // 데이터 오름차순 정렬
//  data.sort(function(a, b) { 
//	  return b.total - a.total; 
//  });
  
  
  // x축 도메인 정의
  x.domain(data.map(function(d) { 
	  return d.time; 
	  }));
  
  //y축 도메인 정의
  y.domain([0, d3.max(data, function(d) {
	  return d.total; 
  })])
  .nice();

//  y.domain([0, d3.max(data, function(d, i, columns) {
//	  for (i = 1, t = 0; i < columns.length; ++i) t += d[columns[i]] = +d[columns[i]];
//	  d.total = t;
//	  console.log(d.total);
//	  return d. total;
//  })])
//  .nice();

  
  
  /////////////////////////////////////////////////////////////////////////
  
//데이터가 갱신된 선택물 저장
	var stacks = svg.selectAll("#stack1")
					 .data(d3.stack().keys(keys)(data));
  /////////////////////////////////////////////////////////////////////////
  
d3.selectAll("#stack2").remove();
	
  stacks.append("g")
  .attr("id","stack2")
   .selectAll("g")
   .data(d3.stack().keys(keys)(data))
   .enter().append("g")
   .attr("fill", function(d) { //key 별로 색 채우기
    	 return z(d.key); 
    })
    .selectAll("rect")
    .data(function(d) { 
    	return d; 
    })
    .enter().append("rect")
    .attr("x", function(d) { 
    	  return x(d.data.time); 
    })
    .attr("y", function(d) {
    	console.log("d[1]"+d[1]);
    	return y(d[1]); 
    })
    .attr("height", function(d) {
    	console.log("d[0]"+d[0]);
    	return y(d[0]) - y(d[1]); 
    })
    .attr("width", x.bandwidth());

//  // x축 생성
//  g.append("g")
//   .attr("class", "axis")
//   .attr("transform", "translate(0," + height + ")")
//   .call(d3.axisBottom(x));
//  
//  // y축 생성
//  g.append("g")
//   .attr("class", "axis")
//   .call(d3.axisLeft(y).ticks(null, "s"))
//   .append("text")
//   .attr("x", 2)
////   .attr("y", y(y.ticks().pop()) + 0.5)
//   .attr("dy", "0.32em")
//   .attr("fill", "#000")
//   .attr("font-weight", "bold")
//   .attr("text-anchor", "start")
//   .text("Population");
  
	stacks.exit()
//	.transition()
//	.duration(500)
	.attr("x",-x.bandwidth()) 
//왼쪽으로 제거
//이전 트랜지션이 완전히 끝나기를 기다렸다가 dom에서 문서요소 삭제
	.remove();
	
	
	// x축 
	svg.select(".x.axis")
		//.transition()
		//.duration(300)
		.call(d3.axisBottom(x));

	// y축 생성
	svg.select(".y.axis")
		.transition()
		.duration(300)
		.call(d3.axisLeft(y).ticks(null, "s"))
}
  	
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
    
    // create new data value
         getData();
         
        console.log("$scope.newData i'm next"+$scope.newData);
	    return {
				"time": hours + ":" + minutes + ":" + seconds, 
				"New York": $scope.newData[0],
				"San Francisco": $scope.newData[1],
				"Portland": $scope.newData[2],
				"total": $scope.newData[0] + $scope.newData[1] + $scope.newData[2]
			}
	};
 
 
	getData();
	
  //1초마다 dataset 갱신
	 stopTime = $interval(function(){
		 if(data.length > 9){
			 data.shift();
		 }
		 
		 // push new data
		 data.push(next());
		 
		 redraw();

	 }, 2000);
	
});