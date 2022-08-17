	$(function(){
		$("#searchPwd").click(function(){
			var popupWidth = 600;
			var popupHeight = 250;
			var popupX = (window.screen.width/2) - (popupWidth/2);
			var popupY = (window.screen.height/2) - (popupHeight/2);
				
			let url = "./main/search_password";
			window.open(url, '', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		})
	})