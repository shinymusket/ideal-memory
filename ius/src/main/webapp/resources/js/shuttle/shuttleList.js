function route_view(shuttle_num, shuttle_name) {
	
	var shuttleName = shuttle_name;
	
		$.ajax({
			url : "/ius/bus/get_route_by_shuttle_id",
			type : "POST",
			data : {
				shuttle_num : shuttle_num
			},
			success: function(data){
				values = data.route;
				
				outtitle = shuttleName+ " 노선";
				output = "<tr><th class='time_hour'>시간</th><th class='time_minute'>승하차장</th></tr>";
				$.each(values, function(index, value) {
									
				output += "<tr>";
				output += "<td>"+ value.shuttle_hour +"시 " + value.shuttle_minute + "분</td>";
				output += "<td>"+ value.bus_stop +"</td></tr>";
				
				});
				
				$("#routeInfo").show();
				$("#routeTitle").html(outtitle);
				$("#routeInfo").html(output);
			}
		})
	};
