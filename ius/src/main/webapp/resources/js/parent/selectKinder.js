function view(kinder_num) {
	var kinder_num = kinder_num;
	var kinder_name = $("#kinder_name").val();
	
	opener.frm.kinder_num.value = kinder_num;
	opener.frm.kinder_name.value = kinder_name;
	self.close();
	
	check();
};



$(function(){
	$("#search").click(function(){
		var kinder_name = $("#kinder_name").val();
	
		$.ajax({
			url : "/ius/parent/search_kinder",
			type : "POST",
			data : {
				kinder_name : kinder_name
			},
			success: function(data) {
				$("#kinderList").text("");
				values = data.kinderList;
				output = "<tr><th>원생 이름</th><th>학급</th><th>담임 교사</th></tr>";				
				$.each(values, function(index, value) {
		
					output += "<tr>";
					output += "<td><a href=\"javascript:view(" + value.kinder_num + ");\">" + value.kinder_name + "</a></td>";
					output += "<td>" + value.class_name + "</td>";
					output += "<td>" + value.staff_name + "</td>";
					output += "</tr>";
				});
				
				$("#kinderList").html(output);
			}
			
		})

	});
	
	$('#kinder_name').keypress(function(event){
     if ( event.which == 13 ) {
         $('#search').click();
         return false;
     }
	});
	
	
})