
function validateEmailId(email,emailId) {
	  
	  if (validateEmail(email)) {
	  } else {
		  alert("Not Valid Email");
	    $('#'+emailId).val('');
	  }
	 }
	 
function validateEmail(email) {
	  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	  return re.test(email);
	}
	
	
function isNumber(evt) {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	    alert("Please enter only Numbers.");
	    return false;
	  }
	  return true;
	}

	function ValidateNumber(id) {
	  var phoneNo = document.getElementById(id);

	  if (phoneNo.value.length < 10 || phoneNo.value.length > 10) {
	    alert("Mobile Number is not valid, Please Enter 10 Digit Mobile Number");
	     $('#'+id).val('');
	  }
	}
	
	
	function GST_valid(id)
	{
	///   36AAACI4487J1Z9
	var panVal = $('#'+id).val();
	var regpan = /^([0]{1}[1-9]{1}|[1-2]{1}[0-9]{1}|[3]{1}[0-7]{1})([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$/;
	if(regpan.test(panVal)){
	  
	} else {
	   alert("Invalid GST Number");
	   $('#'+id).val('');
	}
	}
	
	function validatePAN(id)
	{
		 var pan_no = document.getElementById(id).value;
		 var panPattern = /^([A-Z]{5})(\d{4})([A-Z]{1})$/.test(pan_no);

		 if(panPattern==false){
			 alert("Enter valid Pan no");	
			 $('#'+id).val('');
		 }
		
	}
	
	//To Allow Only Characters 
	function allowOnlyChars(e)
	{
		  var keyCode = e.which;
		  if (!( (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || (keyCode==32) ) && !(keyCode == 8))
		  {
			  return false;
		  }
	}
	 
	//To Allow Only Numbers
	function allowOnlyNumbers(e)
	{
		  var keyCode = e.which;
		  if (!(keyCode >=48 && keyCode<=57 ) || (keyCode==32))
		  {
			  return false;
		  }
	}
	
	