ojtD3.controller("D3LineCtrl", function($scope, $http, $interval) {

	 	var t = -1;
	    var n = 40;
	    var v = 0;
	    $scope.newData = null;
	    
	    var data = d3.range(n).map(next);
		
	    stopTime = $interval(function(){
	    	data.push(next());
	    	tick();
	    	data.shift();	
	    }, 400);

	    // 서버에 새로운 데이터 요청
		function getData() {
				var req = {
					method : "GET",
					url : ctx + "/getBarData",
					headers : {
						"Content-Type" : "application/json; charset=UTF-8"
					}
				};

				$http(req) // 요청 파라미터
				.then(function (response) {
					
					$scope.newData = response.data.value;
					
					console.log("i'm here $scope.newData: "+$scope.newData);
					
					if(data.length < 1){
						data.push({
							time: 0,
							value: $scope.newData
						})	
					}
					
				}, function (response) {
					alert(response);
				});
		}
		
		function next() {
			getData();
			console.log("$scope.newData: "+$scope.newData);
			return {
				time : ++t,
				// value: v = Math.floor(Math.random()*20)
				value : v = $scope.newData
			};
		}
		

	    var margin = {top: 10, right: 10, bottom: 20, left: 40},
	        width = 960 - margin.left - margin.right,
	        height = 500 - margin.top - margin.bottom;
		 
	    var x = d3.scaleLinear()
	        .domain([0, n - 1])
	        .range([0, width]);
		 
	    var y = d3.scaleLinear()
	        .domain([0, 30])
	        .range([height, 0]);
		 
	    var line = d3.line().curve(d3.curveCardinal)
	        .x(function(d, i) {return x(d.time); })
	        .y(function(d, i) { return y(d.value); });
			 
	    var svg = d3.select("#chart")
	        .attr("width", width + margin.left + margin.right)
	        .attr("height", height + margin.top + margin.bottom);
		
	    var g = svg.append("g")
	        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
	    var graph = g.append("svg")
	        .attr("width", width)
	        .attr("height", height + margin.top + margin.bottom);	
		 
	    var xAxis = d3.axisBottom().scale(x);
	    var axis = graph.append("g")
	        .attr("class", "x axis")
	        .attr("transform", "translate(0," + height + ")")
	        .call(xAxis);
		 
	    g.append("g")
	        .attr("class", "y axis")
	        .call(d3.axisLeft().scale(y));
		 
		var path = graph
			.append("g")
			.append("path")
			.data([data])
			.attr("class", "line")
			.attr("d", line)
			.attr("shape-rendering","auto");
	
		
			 
	    function tick() 
		{ 
	        // push a new data point onto the back
//	        data.push(next());

	        // update domain
	        x.domain([t - n, t]);
		
	        // redraw path, shift path left
	        path
	            .attr("d", line)
	            .attr("transform", null)
	            .transition()
	            .duration(500)
	            .ease(d3.easeLinear,2)
	            .attr("transform", "translate(" + t - 1 + ")")
	            .on("end", tick);
	        
		
	        // shift axis left
	        axis
	            .transition()
	            .duration(500)
	            .ease(d3.easeLinear,2)
	            .call(d3.axisBottom().scale(x));
	        
		 
	        // pop the old data point off the front
//	        data.shift();	 
	    } 
});