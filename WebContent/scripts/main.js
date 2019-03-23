
function sendAlert(){
	if (confirm("Are you sure you want to logout ?")) {
		location.href='logout.jsp';
	} 
};
function sendPrompt() {
	if (confirm("Book Now ?")) {
		location.href='booking.jsp';
	} 
};
$(function() {
	$("#datepicker").datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true,
		minDate:'m',
		showButtonPanel: true
	});
});
$(function() {
	$("#expiryDate").datepicker({
		dateFormat: 'mm/y',
		changeMonth: true,
		changeYear: true,
		minDate:'m',
		showButtonPanel: true,
		onClose: function(dateText, inst) {
			var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
			var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			$(this).datepicker('setDate', new Date(year, month, 1));
		}
		
	});
});


function openPopup(URL,V,K){
	
	window.open(URL+'?val='+V+"&key="+K,
			'_blank','scrollbars=yes, resizable=yes, height=300,width=280,top=200,left=300');
}
function closePopup(){
	window.close();
}
