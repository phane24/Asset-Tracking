<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="<c:url value="/resources/js/validations.js" />"></script>

  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Inventory Management</title>
  <!-- plugins:css -->
       <link href='<c:url value="/resources/vendors/mdi/css/materialdesignicons.min.css" />' rel="stylesheet">
      <link href='<c:url value="/resources/vendors/base/vendor.bundle.base.css" />' rel="stylesheet">
  <!-- endinject -->
  <!-- plugin css for this page -->
        <link href='<c:url value="/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.css" />' rel="stylesheet">

  <!-- End plugin css for this page -->
  <!-- inject:css -->
 <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
 <link href='<c:url value="/resources/css/main.css" />' rel="stylesheet">
  <!-- endinject -->
  <link rel="shortcut icon" href='<c:url value="/resources/images/favicon.png" />' />
  


<style>
.grid { 
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  grid-gap: 20px;
  align-items: stretch;
  }
.grid > article {
  border: 1px solid #ccc;
  box-shadow: 2px 2px 6px 0px  rgba(0,0,0,0.3);
}
.grid > article img {
  max-width: 100%;
}
.text {
  padding: 0 20px 20px;
}
.text > button {
  background: gray;
  border: 0;
  color: white;
  padding: 10px;
  width: 100%;
  }
</style>
</head>
<script> 
function ValidateNumber(id) {
	  var phoneNo = document.getElementById(id);

	  if (phoneNo.value.length < 10 || phoneNo.value.length > 10) {
		  $("#MobnumMsg").css("display","block");
	     $('#'+id).val('');
	  }
	  else{
		  $("#MobnumMsg").css("display","none");
	  }
	}  
	
$(document).ready(function(){	
	$(".isa_success").fadeOut(5000);
	getVendorId();
	$("#vendorName,#emailId,#mobileNum,#address,#panNo,#gstNum,#contactPerson").attr('required', '');  
	$('#vendorId').attr('readonly',true); 
	$('#vendorId').addClass('input-disabled');
});


$("#cancel").click(function (){

	window.location.href="redirect:/displaydevices";
	
});

//Does'nt allow Special Characters Only allows AlphaNumeric
$("#vendorName").keydown(function (e){
	var k = e.keyCode || e.which;
	var ok = k >= 65 && k <= 90 || // A-Z
		k >= 96 && k <= 105 || // a-z
		k >= 35 && k <= 40 || // arrows
		k == 9 || //tab
		k == 46 || //del
		k == 8 || // backspaces
		(!e.shiftKey && k >= 48 && k <= 57); // only 0-9 (ignore SHIFT options)

	if(!ok || (e.ctrlKey && e.altKey)){
		e.preventDefault();
	}
});

$(function(){
	 // $("#header").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#sidebar").load('<c:url value="/resources/common/navbar.jsp" />'); 
	  $("#header_bar").load('<c:url value="/resources/common/header_bar.jsp" />'); 

	});

function getVendorId()
{
	var jsonArr1;
	
		$.ajax({
	        type:"get",
	        url:"getLastVendorId",
	        contentType: 'application/json',
	        datatype : "json",
	        success:function(data) {
	        	var jsonArr=JSON.parse(data);	        	
	        	 if(jsonArr.length==0){
		        		jsonArr1="VEN001";
		        	}  	
	        	 else{
		        	var dataSplit=jsonArr[0].split("N");
		        	console.log(dataSplit[1]);
		        	var dataSplitInt=parseInt(dataSplit[1]);
		        	console.log(dataSplitInt+1);
		        	dataSplitInt=dataSplitInt+1;
		        	
		        	if(dataSplitInt>0&&dataSplitInt<=9)
		        		jsonArr1="VEN00"+dataSplitInt;
		        	else if(dataSplitInt>9&&dataSplitInt<99)
		        		jsonArr1="VEN0"+dataSplitInt;
		        	else if(dataSplitInt>99)
		        		jsonArr1="VEN"+dataSplitInt;        	
        		}	        	
	        	$('#vendorId').val(jsonArr1);	        	
	        },
	        error:function()
	        {
	        	console.log("Error");
	        }
		});
}

function fetchVendorAddress()
{
	selectedVendorName=$('#vendorName').val();
	

	$.ajax({
        type:"get",
        url:"getvendorAddress",
        contentType: 'application/json',
        datatype : "json",
        data:{"vendorName":selectedVendorName},
        success:function(data1) {
        	var jsonData = JSON.parse(data1);
        	if(jsonData.length!=0)
        	{
        		//insOrUpd=1;
				//$("#insOrUpd").val(insOrUpd);			
				$("#reg").css("display", "block");
				$("#vendorId").val(jsonData[0]);
				$("#contactPerson").val(jsonData[1]);
				$("#address").val(jsonData[2]);
				$("#mobileNum").val(jsonData[3]);
				$("#emailId").val(jsonData[4]);
				$("#panNo").val(jsonData[5]);
				$("#gstNum").val(jsonData[6]);
				$("#setId").val(jsonData[7]);
        	}
        },
        error:function()
        {
        	console.log("Error");
        }
	});

} 

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
      return false;
    }

    return true;
  }
function GST_valid(id)
{
///   36AAACI4487J1Z9
var panVal = $('#'+id).val();
var regpan = /^([0]{1}[1-9]{1}|[1-2]{1}[0-9]{1}|[3]{1}[0-7]{1})([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$/;
if(regpan.test(panVal)){
	$("#gstinMsg").css("display","none");
} else {
	$("#gstinMsg").css("display","block");
   $('#'+id).val('');
}
}

function validatePAN(id)
{
	 var pan_no = document.getElementById(id).value;
	 var panPattern = /^([A-Z]{5})(\d{4})([A-Z]{1})$/.test(pan_no);

	 if(panPattern==false){
		 $("#panMsg").css("display","block");	
		 $('#'+id).val('');
	 }
	 else{
		 $("#panMsg").css("display","none");	
	 }
}
function validateEmailId(email,emailId) {
	  
	  if (validateEmail(email)) {
		  $("#emailMsg").css("display","none");	
	  } else {
		  $("#emailMsg").css("display","block");	
	    $('#'+emailId).val('');
	  }
	 }
	 
function validateEmail(email) {
	  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	  return re.test(email);
	}
</script>
<body>
  <div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <div id="header_bar">
	</div>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_sidebar.html -->
	  <div id="sidebar">
	        <!-- code located at common/... -->
	  </div>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
          <div class="row" id="header">
          </div>
		 <!-- custom board-->
        <form:form action="addVendor" method="post" modelAttribute="VendorReg" class="forms-sample">
       	<form:hidden path="id" id="setId"/>
		       <div class="col-md-6 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Add Vendor</center></h4>
                   <%-- <div class="isa_success" id="isa_success" onclick="fadeOut(this.id);">${status}</div>  --%>
                 <div align="center"><span class="isa_success">${status}</span></div>                  
                  <p class="card-description">
                  </p>
                      <div class="form-group row">  
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Vendor ID</label>
                      <div class="col-sm-9">
						<form:input type="text" id="vendorId" name="Vendor ID"  path="vendorId" class="form-control"/>
						 </div>
                    </div>
                        
                 <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Vendor Name</label>
                      <div class="col-sm-9">
						<form:input type="text" id="vendorName" name="Vendor Name" class="form-control" path="vendorName" onkeyup="this.value = this.value.toUpperCase();" onkeypress="return(event.charCode > 64 && 
event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)" onblur="fetchVendorAddress();" required="required"/>
						 </div>
                    </div>
           
                   <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Contact Person</label>
                      <div class="col-sm-9">
						<form:input type="text" id="contactPerson"  class="form-control" name="Contact Person"  path="contactPerson" onkeypress="return (event.charCode > 64 && 
event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)"  required="required"/>
						 </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Address</label>
                      <div class="col-sm-9">
						<form:textarea path="address" id="address"  rows = "3" cols = "20" class="form-control" required="required"/>              
					  </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Mobile Number</label>
                      <div class="col-sm-9">
							<form:input type="text" class="form-control" id="mobileNum" name="mobileNum"  path="mobNum" onkeypress="return isNumber(event);" onchange="ValidateNumber(this.id)" required="required"/> 
							 <span id="MobnumMsg" style="color:red;display:none;">*Mobile Number is not valid, Please Enter 10 Digit Mobile Number*</span>    
							           
					  </div>
                    </div>
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Email ID</label>
                      <div class="col-sm-9">
							<form:input type="text" class="form-control" id="emailId" name="emailId"  path="emailId" onchange="validateEmailId(this.value,this.id)" required="required"/>    
							<span id="emailMsg" style="color:red;display:none;">*Email Id is not valid*</span>            
					  </div>
                    </div>
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Pan No</label>
                      <div class="col-sm-9">
						<form:input type="text" class="form-control" id="panNo" name="PAN No"  path="panNo" onkeyup="this.value = this.value.toUpperCase();" onchange="validatePAN(this.id)" required="required"/>
						<span id="panMsg" style="color:red;display:none;">*PAN Number is not valid*</span>  
						 </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">GSTIN Number</label>
                      <div class="col-sm-9">
						<form:input type="text"  class="form-control" id="gstNum" name="GSTIN No"  path="gstNum" onchange="GST_valid(this.id)" required="required"/>
						<span id="gstinMsg" style="color:red;display:none;">*GSTIN Number is not valid*</span>  
						 </div>
                     </div>
                     
                         <button type="submit" class="btn btn-primary mr-2">Submit</button>
                   		 <button class="btn btn-light"  type="button" onclick="window.location.href = ''"  id="cancel">Cancel</button>
                           
                     </form:form>
                </div>
              </div>
            </div>	  
	  <!-- ending-->
		 </div>
          
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <!-- <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright Ã‚Â© 2018 <a href="https://www.urbanui.com/" target="_blank">Urbanui</a>. All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="mdi mdi-heart text-danger"></i></span>
          </div>
        </footer> -->
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- plugins:js -->
 <link href='<c:url value="/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.css" />' rel="stylesheet">
 
  <script src='<c:url value="/resources/vendors/base/vendor.bundle.base.js" />'></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <script src='<c:url value="/resources/vendors/chart.js/Chart.min.js"/>'></script>
  <script src='<c:url value="/resources/vendors/datatables.net/jquery.dataTables.js"/>' ></script>
  <script src='<c:url value="/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.js"/>'></script>
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src='<c:url value="/resources/js/off-canvas.js"/>'></script>
  <script src='<c:url value="/resources/js/hoverable-collapse.js"/>'></script>
  <script src='<c:url value="/resources/js/template.js"/>'></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src='<c:url value="/resources/js/dashboard.js"/>'></script>
  <script src='<c:url value="/resources/js/data-table.js"/>'></script>
  <script src='<c:url value="/resources/js/jquery.dataTables.js"/>'></script>
  <script src='<c:url value="/resources/js/dataTables.bootstrap4.js"/>'></script>
  <!-- End custom js for this page-->
  
  
  
</body>

</html>
