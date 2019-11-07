<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

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
var selectedClass;
$(function(){
  //$("#header").load('<c:url value="/resources/common/header.jsp" />'); 
  $("#sidebar").load('<c:url value="/resources/common/navbar.jsp" />'); 
  $("#header_bar").load('<c:url value="/resources/common/header_bar.jsp" />'); 

});
$(document).ready(function(){	 
	$(".isa_success").fadeOut(5000);
	$('#vendorName').addClass('input-disabled');
 });

function getVendorId(selectedVendorName)
{
	$.ajax({
        type:"get",
        url:"getVendorId",
        contentType: 'application/json',
        datatype : "json",
        data:{"vendorName":selectedVendorName},
        success:function(data1) {
        	
        	//var arr = JSON.parse(data1);
        	$('#vendorId').val(data1);
        	$('#vendorId').attr('readonly',true); 
        	
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}



var classArr=[],itemsArr=[];
var selectedCat;
function getCategoryClasses(selectedCategory)
{
	selectedCat=selectedCategory;
	$.ajax({
        type:"get",
        url:"getCategoryClasses",
        contentType: 'application/json',
        datatype : "json",
        data:{"category":selectedCategory},
        success:function(data1) {
        	classArr = JSON.parse(data1);       	
        	changeClass(selectedCategory);
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function getClassItems(selectedClass)
{
		$.ajax({
        type:"get",
        url:"getClassItems",
        contentType:'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"categorySelected":selectedCat},
        success:function(result) {
        	itemsArr = JSON.parse(result);
        	//alert(itemsArr);
        	//changeDrop(selectedClass);        	
        	changeCat(selectedClass);
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function changeClass(categorySelected) {
    var catOptions = "";
    catOptions += "<option value=''>Select</option>";
    for (categoryId in classArr) {
        catOptions += "<option>" + classArr[categoryId] + "</option>";
    }
   		document.getElementById("categoryClass").innerHTML = catOptions;
}

function changeCat(classSelected) {
    var catOptions = "";
    for (categoryId in itemsArr) {
        catOptions += "<option>" + itemsArr[categoryId] + "</option>";
    }
    if(selectedCat=="Assets" && classSelected=="Class A Store"){
    	document.getElementById("classAAssetsSelect").innerHTML = catOptions;
    	
    	  document.getElementById("classAAssetsDiv").style.display = "";
		  document.getElementById("classBAssetsDiv").style.display = "none";
		  document.getElementById("classCAssetsDiv").style.display = "none";
		  document.getElementById("classAEquipsDiv").style.display = "none";
		  document.getElementById("classBEquipsDiv").style.display = "none";
		  document.getElementById("classCEquipsDiv").style.display = "none";
    }
    else if(selectedCat=="Assets" && classSelected=="Class B Store"){
    	document.getElementById("classBAssetsSelect").innerHTML = catOptions;
    	
    	  document.getElementById("classAAssetsDiv").style.display = "none";
		  document.getElementById("classBAssetsDiv").style.display = "";
		  document.getElementById("classCAssetsDiv").style.display = "none";
		  document.getElementById("classAEquipsDiv").style.display = "none";
		  document.getElementById("classBEquipsDiv").style.display = "none";
		  document.getElementById("classCEquipsDiv").style.display = "none";
    }
    else if(selectedCat=="Assets" && classSelected=="Class C Store"){
   		document.getElementById("classCAssetsSelect").innerHTML = catOptions;
   		
   		  document.getElementById("classAAssetsDiv").style.display = "none";
		  document.getElementById("classBAssetsDiv").style.display = "none";
		  document.getElementById("classCAssetsDiv").style.display = "";
		  document.getElementById("classAEquipsDiv").style.display = "none";
		  document.getElementById("classBEquipsDiv").style.display = "none";
		  document.getElementById("classCEquipsDiv").style.display = "none";
    }
    else if(selectedCat=="Equipments" && classSelected=="Class A Store"){
    	document.getElementById("classAEquipsSelect").innerHTML = catOptions;
    	
    	  document.getElementById("classAAssetsDiv").style.display = "none";
		  document.getElementById("classBAssetsDiv").style.display = "none";
		  document.getElementById("classCAssetsDiv").style.display = "none";
		  document.getElementById("classAEquipsDiv").style.display = "";
		  document.getElementById("classBEquipsDiv").style.display = "none";
		  document.getElementById("classCEquipsDiv").style.display = "none";
    }
    else if(selectedCat=="Equipments" && classSelected=="Class B Store"){
   		document.getElementById("classBEquipsSelect").innerHTML = catOptions;
   		
   		  document.getElementById("classAAssetsDiv").style.display = "none";
		  document.getElementById("classBAssetsDiv").style.display = "none";
		  document.getElementById("classCAssetsDiv").style.display = "none";
		  document.getElementById("classAEquipsDiv").style.display = "none";
		  document.getElementById("classBEquipsDiv").style.display = "";
		  document.getElementById("classCEquipsDiv").style.display = "none";
    }
    else if(selectedCat=="Equipments" && classSelected=="Class C Store"){
    	document.getElementById("classCEquipsSelect").innerHTML = catOptions;
    	
    	  document.getElementById("classAAssetsDiv").style.display = "none";
		  document.getElementById("classBAssetsDiv").style.display = "none";
		  document.getElementById("classCAssetsDiv").style.display = "none";
		  document.getElementById("classAEquipsDiv").style.display = "none";
		  document.getElementById("classBEquipsDiv").style.display = "none";
		  document.getElementById("classCEquipsDiv").style.display = "";
    }
}

function validate(){
	var classA=document.getElementById("classAAssetsSelect").value;
	var classB=document.getElementById("classBAssetsSelect").value;
	var classC=document.getElementById("classCAssetsSelect").value;
	var classAE=document.getElementById("classAEquipsSelect").value;
	var classBE=document.getElementById("classBEquipsSelect").value;
	var classCE=document.getElementById("classCEquipsSelect").value;
	if((classA!="")||(classB!="")||(classC!="")||(classAE!="")||(classBE!="")||(classCE!="")){
		$("#classMsg").css("display","none");
		return true;
		
	}
	else{
		$("#classMsg").css("display","block");
		return false;	
	}

	/* if(selectedClass==""){
		
	} */
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
        <form:form action="saveVendor" method="post" modelAttribute="VendorSupplier" onsubmit="return validate();">
         
			<form:hidden path="id"/>
		       <div class="col-md-6 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                 <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Vendor Supplier</center></h4>
                   <div align="center"><span class="isa_success">${status}</span></div>
                   <div class="form-group row">
               	   	<div class="col-sm-9">
               	  		<span style="color:green;font-size:24px;float:right;"><% if(request.getParameter("status")!=null){%>
               	 		 <%out.print(request.getParameter("status"));}%></span>
               	  	 </div>
               	   </div>
                  
                  <p class="card-description">
                  </p>
                   <!-- <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Vendor ID</label>
                      <div class="col-sm-9">
						<form:select id="vendorId" class="form-control"  path="vendorId" onchange="getVendorName(this.value);" required="required" >
						     <form:option  value="">Select</form:option> 
							 <form:options items = "${vendorIds}" />
							 
						</form:select>   
						 </div>
                    </div>
                    
                 <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Vendor Name</label>
                      <div class="col-sm-9">
						<form:input type="text" id="vendorName" name="Vendor Name"  path="vendorName" class="form-control"  />
						 </div>
                    </div>-->
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Vendor Name</label>
                      <div class="col-sm-9">
						<form:select id="vendorName" class="form-control"  path="vendorName" onchange="getVendorId(this.value);" required="required" >
						     <form:option  value="">Select</form:option> 
							 <form:options items = "${vendorNames}" />
							 
						</form:select> 
						 </div>
                    </div>
                     <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Vendor Id</label>
                      <div class="col-sm-9">
						<form:input type="text" id="vendorId" name="vendorId"  path="vendorId" class="form-control"  />
						 </div>
                    </div>
           
                     <div class="form-group row">
                      <label for="exampleInputPassword2" class="col-sm-3 col-form-label">Class Type</label>
                      <div class="col-sm-9">
                      <form:select path="category" id="category" class="form-control"  onchange="getCategoryClasses(this.value);" required="required">
                	    <form:option value="">Select</form:option>
                		<form:option value="Assets">Assets</form:option>
                		<form:option value="Equipments">Equipments</form:option>
                	</form:select>
                      </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Classes</label>
                      <div class="col-sm-9">
						<form:select id="categoryClass" class="form-control" path="categoryClass"  value="Classes" onchange="getClassItems(this.value);" required="required"> 
						 <form:option value=" ">Select</form:option>
						 </form:select>     
						 </div>
                    </div>
                   
                   <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Assets/Equipments:</label>
                      <div class="col-sm-9">
				  <div id="classAAssetsDiv" style="display:none">
                  <form:select path = "classAAssets" id="classAAssetsSelect" multiple = "true" style="width: 173px;" ></form:select></div>
                  <div id="classBAssetsDiv" style="display:none">
                  <form:select path = "classBAssets" id="classBAssetsSelect" multiple = "true" style="width: 173px;" ></form:select></div>
                   <div id="classCAssetsDiv" style="display:none">
                  <form:select path = "classCAssets" id="classCAssetsSelect" multiple = "true" style="width: 173px;" ></form:select></div>
                  <div id="classAEquipsDiv" style="display:none">
                  <form:select path = "classAEquips" id="classAEquipsSelect" multiple = "true" style="width: 173px;" ></form:select></div>
                  <div id="classBEquipsDiv" style="display:none">
                  <form:select path = "classBEquips" id="classBEquipsSelect" multiple = "true" style="width: 173px;" ></form:select></div>
                  <div id="classCEquipsDiv" style="display:none">
                  <form:select path = "classCEquips" id="classCEquipsSelect" multiple = "true" style="width: 173px;" ></form:select></div>      
						 </div>		 
						  <span id="classMsg" style="color:red;display:none;">*Please Select any Asset or Equipment*</span> 
                    </div>
                    
                     <button type="submit" class="btn btn-primary mr-2">Submit</button>
                   	 <button class="btn btn-light"  type="button" onclick="window.location.href = 'homePage'"  id="cancel">Cancel</button>
                           
                      </form:form>
                </div>
              </div>
            </div>	  
	  <!-- ending-->
		 </div>
          
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
       <!--  <footer class="footer">
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
