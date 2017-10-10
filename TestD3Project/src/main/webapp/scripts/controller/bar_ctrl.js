//var ojtD3 = angular.module('ojtD3', []);

ojtD3.controller("barCtrl", function($scope, $interval, $http) {
		
	// define margin
	var margin = {top: 20, right: 20, bottom: 30, left: 40},
	    width = 960 - margin.left - margin.right,
	    height = 500 - margin.top - margin.bottom;

	var dataset = [];

	// define x scale
	var x = d3.scaleBand()
				.rangeRound([0, width]) // sculpted into bands
				.paddingInner(0.05); // bandwidth interval
	// define y scale
	var y = d3.scaleLinear()
	    		.range([height, 0]);

	// define x axis
	var xAxis = d3.axisBottom()
					.scale(x)
					.ticks(10);

	// define y axis
	var yAxis = d3.axisLeft()
	    		.scale(y)
	    		.ticks(10, "%");
	
	// create SVG element
	var svg = d3.select("body").append("svg")
	    .attr("width", width + margin.left + margin.right)
	    .attr("height", height + margin.top + margin.bottom)
	    .append("g")
	    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	// create x axis
	svg.append("g")
	    .attr("class", "x axis")
	    .attr("transform", "translate(0," + height + ")")
	
	// create y axis
	svg.append("g")
	    .attr("class", "y axis")
	    .append("text")
	    .attr("transform", "rotate(-90)")
	    .attr("y", 6)
	    .attr("dy", ".71em")
	    .style("text-anchor", "end")
	    .text("Frequency");
	
	// push new data in dataset
	$scope.makeDataset = function(dataset){
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
    document.getElementById("dpTime").innerHTML = hours + ":" + minutes + ":" + seconds;
    
    // create new data value
 	var newNumber = Math.floor(Math.random() * 30)+10;

 	// push new data
 	dataset.push({
		time : hours + ":" + minutes + ":" + seconds,
		value : newNumber
	});

 };
 
	var time = function(d) {
		return d.time;
	}
	
	// 1초마다 dataset 갱신
	 interval = $interval(function(){
		 if(dataset.length > 5){
			 dataset.shift();
		 }
		 $scope.makeDataset(dataset);
		 draw(dataset);
	 }, 1000);
	
//	 function replay(dataset){
//		 dataset.forEach(function(d, i){
//		 		setTimeout(function(){
//		 			$scope.makeDataset(dataset);
//		 			draw(dataset);
//		 		}, i * 1000);
//		 	});	 
//	 }
	 
	 // draw bar chart
	function draw(data) {
		
		// define for axis
		  x.domain(dataset.map(function(d) { return d.time; }));
		  y.domain([0, d3.max(dataset, function(d) { return d.value; })]);
		  
		  xAxis = d3.axisBottom()
					.scale(x)
					.ticks(10);

		  yAxis = d3.axisLeft()
					.scale(y)
					.ticks(10, "%");
			
	// call axis
	  svg.select('.x.axis')
	  	.transition()
	  	.duration(300)
	  	.call(xAxis);

	  svg.select(".y.axis")
		  .transition()
		  .duration(300)
		  .call(yAxis)

	  // THIS IS THE ACTUAL WORK!
	  var bars = svg.selectAll(".bar")
	  				.data(data, time);

	  // data that needs DOM = enter() (a set/selection, not an event!)
	  bars.enter()
	  	.append("rect")
	    .attr("class", "bar")
	    .attr("x", width)
	    .attr("y", y(0))
	    .attr("height", height - y(0))
	  	.attr("fill", function(d) {
	  		console.log("inserted", d);
			return "rgb(0, 0, " + (d.value * 10) + ")";
		})
		.on("mouseover", function(d){
			
			// define position for tooltip
			var xPosition = parseFloat(d3.select(this).attr("x")) + x.bandwidth() /2;
			var yPosition = parseFloat(d3.select(this).attr("y")) + 14;
			
			// create text element and show text when it's mouseover
			svg.append("text")
			.attr("id", "tooltip")
			.attr("x", xPosition)
			.attr("y", yPosition)
			.attr("text-anchor", "middle")
			.attr("font-family", "sans-serif")
			.attr("font-size", "11px")
			.attr("font-weight", "bold")
			.attr("fill", "black")
			.text(d.value);
			
		})
		// tooltip when it's mouseout
		.on("mouseout", function(d){
			d3.select("#tooltip").remove();
			d3.select(this)
			.transition()
			.duration(250)
			.attr("fill","rgb(0, 0, " + (d.value * 10) + ")");
		});
	  
	  // remove after transition
	  bars.exit()
	  .transition()
	  .duration(300)
	  .attr("y", y(0))
	  .attr("height", function(dd){
		  console.log("deleted", dd);
		  return height - y(0);
	  })
	  .style('fill-opacity', 1e-6)
	  .remove();
	  
	  // update bar with new data
	  bars.transition()
	  		.duration(300)
	  		.attr("x", function(d, i) { 
	  			return x(i+1); 
	  			})
	    .attr("width", x.bandwidth())
	    .attr("y", function(d) { 
	    	return y(d.value); 
	    	})
	    .attr("height", function(d) { 
	    	return height - y(d.value); 
	    	});
	  
		}// end draw function

	});