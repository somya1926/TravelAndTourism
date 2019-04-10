
function sendAlert(){
	if (confirm("Are you sure you want to logout ?")) {
		
		var form = document.createElement("form");
	    form.setAttribute("method", "post");
	    form.setAttribute("action", '../logout');
        document.body.appendChild(form);
	    form.submit();
	} 
};
function unregister() {
	  var person = prompt("To confirm De-registration please enter 'yes' :");
	  if (person =='yes') {
		  var form = document.createElement("form");
		    form.setAttribute("method", "post");
		    form.setAttribute("action", 'UserDeReg');
	        document.body.appendChild(form);
		    form.submit();
	  }else{
		  location.href='userHome'; 
	  }
	};
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

function openPopupSelf(URL,V,K){
	window.open(`${URL}?val=${V}&key=${K}`,
			'_blank','scrollbars=yes, resizable=yes, height=300,width=280,top=200,left=300');
};
function openPopup(URL,V,K){
	window.open(`../${URL}?val=${V}&key=${K}`,
			'_blank','scrollbars=yes, resizable=yes, height=300,width=280,top=200,left=300');
};

function closePopup(){
	window.close();
};
