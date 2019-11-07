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
$(function(){
  //$("#header").load('<c:url value="/resources/common/header.jsp" />'); 
  $("#sidebar").load('<c:url value="/resources/common/navbar.jsp" />'); 
  $("#header_bar").load('<c:url value="/resources/common/header_bar.jsp" />'); 

});

$(document).ready(function(){
	$(".isa_success").fadeOut(5000);
	//$("#vendorName,#emailId,#mobileNum,#address,#panNo,#gstNum,#contactPerson").attr('required', ''); 
	getSiteId();
	var o = new Option("Select", "Select");
	/// jquerify the DOM object 'o' so we can use the html method
		$(o).html("Select");
		$("#modelNum").append(o);
	getEquipName("Select");
	getClassItems("Select");
	
	
			$('#latitude').attr('readonly',true); 
        	$('#latitude').addClass('input-disabled');
        	$('#longitude').attr('readonly',true); 
        	$('#longitude').addClass('input-disabled');
			$('#Equip_Id').attr('readonly',true); 
        	$('#Equip_Id').addClass('input-disabled');
	
});

$(function(){
	$('#installationDate,#manufactureDate,#expiryDate').datepicker({
		dateFormat:"mm/dd/yy",
	})
	});

function getSiteId()
{
	var options='';
	$.ajax({
        type:"get",
        url:"getSiteId",
        contentType: 'application/json',
        datatype : "json",
        //data:{"vendorId":selectedVendorId},
        success:function(data) {
        	var arr = JSON.parse(data);
        	 options+="<option>Select SiteID</option>";
        	for(var i=0;i<arr.length;i++)
        	{
        		options+="<option>"+arr[i]+"</option>";
        	}
        	$('#getSiteId').html(options);
        	$('#getSiteId').attr('readonly',true); 
        	$('#getSiteId').addClass('input-disabled');
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function getLatLong(id)
{
	$.ajax({
        type:"get",
        url:"getLatLong",
        datatype : "json",
        data:{"siteId":id},
        success:function(data1) {
        	var arr = JSON.parse(data1);
        	$("#latitude").val(arr[0][0]);
        	$("#longitude").val(arr[0][1]);
        	$('#latitude').attr('readonly',true); 
        	$('#latitude').addClass('input-disabled');
        	$('#longitude').attr('readonly',true); 
        	$('#longitude').addClass('input-disabled');
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function getClassItems(selectedClass)
{
	var selectedCat,Options="";
	selectedCat="Equipments";
	$.ajax({
        type:"get",
        url:"getClassItems",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"categorySelected":selectedCat},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	Options += "<option>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	document.getElementById("equipment").innerHTML = Options;
			            $("select option:contains('Select')").attr("disabled","disabled");

        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function getEquipName(selectedEquip)
{
	selectedClass=$("#classType").val();
	var selectedCat,Options="";
	$.ajax({
        type:"get",
        url:"getEquipName",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"EquipSelected":selectedEquip},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	Options += "<option>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	document.getElementById("equipName").innerHTML = Options;
			            $("select option:contains('Select')").attr("disabled","disabled");

        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function getmodelTypes()
{
	var selectedClass=$('#classType').val();
	var selectedType="";
	var assetEquipe = "Equipments";

	 selectedType=$('#equipment').val();
	

	var selectedModel=$('#equipName').val();

	//alert(selectedType);
	$.ajax({
        type:"get",
        url:"getModelTypes",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedType":selectedType,"selectedClass":selectedClass,"selectedCategory":assetEquipe,"selectedModel":selectedModel},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
			alert(itemsArr);
        		var catOptions = "";
        		catOptions += "<option>Select</option>";
        	    for (categoryId in itemsArr) {
        	        catOptions += "<option>" + itemsArr[categoryId] + "</option>";
        	    }
            	document.getElementById("modelNum").innerHTML = catOptions;
        	
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function getAssetIdfromIndent()
{
	var selectedCat,options="";
	var siteId = $('#getSiteId').val();
	//alert(siteId);
	var selectequipasset = "Equipments";
	var selectedClass=$('#classType').val();
	var selectedAsset="";
	

		selectedAsset=$('#equipment').val();
	var selectedassetName=$('#equipName').val();
	var selectedModel = $('#modelNum').val();

		// alert(siteId);
	// alert(selectedClass);
	// alert(selectequipasset);
	// alert(selectedAsset);
	// alert(selectedassetName);
	// alert(selectedModel);
	
	$.ajax({
        type:"get",
        url:"getAssetIdfromIndent",
        contentType: 'application/json',
        datatype : "json",
        data:{"siteId":siteId,"equipAsset":selectequipasset,"selectedClass":selectedClass,"selectedAsset":selectedAsset,"selectedassetName":selectedassetName,"selectedModel":selectedModel},
        success:function(data1) {
        	//itemsArr = JSON.parse(data1);
			var arr = JSON.parse(data1);

			alert(arr);

        	$('#Equip_Id').val(arr[0]["equipAssetId"]);
        	$('#manufacturedDate').val(arr[0]["manufacturedDate"]);
        	$('#expiryDate').val(arr[0]["expiryDate"]);
			
        	$('#Equip_Id').attr('readonly',true); 
        	$('#Equip_Id').addClass('input-disabled');
        },
        error:function()
        {
        	console.log("Error");
        }
	});
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
		 
        <form:form action="addEquipInstallation" method="post" modelAttribute="EquipInstallation" class="forms-sample">
	       <div class="col-md-6 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Equipment Installation</center></h4>
                   <div align="center"><span class="isa_success">${status}</span></div>
                   <div class="form-group row">
               	   	<div class="col-sm-9">
               	  		<span style="color:green;font-size:24px;float:right;"><% if(request.getParameter("status")!=null){%>
               	 		 <%out.print(request.getParameter("status"));}%></span>
               	  	 </div>
               	   </div>
                  <p class="card-description">
                  </p>
                    <form:hidden path="Id"/> 
                    
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Site ID</label>
                      <div class="col-sm-9">
                       <form:select  id="getSiteId" path="siteId" placeholder="Site Id" class="form-control" onchange="getLatLong(this.value);"/>
                     </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Latitude</label>
                      <div class="col-sm-9">
						<form:input type="text" id="latitude"  path="latitude" placeholder="Latitude" class="form-control" />
						 </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Longitude</label>
                      <div class="col-sm-9">
						<form:input type="text" id="longitude" path="longitude" placeholder="Longitude" class="form-control" />
						 </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputPassword2" class="col-sm-3 col-form-label">Class Type</label>
                      <div class="col-sm-9">
                     <form:select path="Class_Type" id="classType" class="form-control classType"  onChange="getClassItems(this.value);">
                		<form:option value="Select">Select</form:option>
                		<form:option value="Class A Store">Class A Store</form:option>
                		<form:option value="Class B Store">Class B Store</form:option>
                		<form:option value="Class C Store">Class C Store</form:option>
                	</form:select>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Select Equipment</label>
                      <div class="col-sm-9">
                       <form:select  id="equipment" path="equipment" class="form-control" onchange="getEquipName(this.value)" />
                     </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Select Equipment Name</label>
                      <div class="col-sm-9">
                       <form:select  id="equipName" path="Equip_Name" class="form-control" onchange="getmodelTypes()"/>
                     </div>
                    </div>
					
										                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Select Model Number</label>
                      <div class="col-sm-9">
						<form:select id="modelNum" class="form-control" path="modelNum" onchange="getAssetIdfromIndent()"/>              
					  </div>
                    </div>
                    
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Equipment ID</label>
                      <div class="col-sm-9">
						<form:input type="text" id="Equip_Id" path="Equip_Id" placeholder="Equipment ID" class="form-control" />
						 </div>
                    </div>
                    
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Date of Manufacture</label>
                      <div class="col-sm-9">
						<form:input type="date" id="manufacturedDate" path="ManufacturedDate" class="form-control" max="9999-12-31" />
						 </div>
                    </div>
                    
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Date of Expiry</label>
                      <div class="col-sm-9">
						<form:input type="date" id="expiryDate" path="ExpiryDate" class="form-control" max="9999-12-31"/>
						 </div>
                    </div>
                    
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Installation Date</label>
                      <div class="col-sm-9">
						<form:input type="date" id="installationDate" path="InstalledDate" class="form-control" max="9999-12-31"/>
						 </div>
                    </div>
                    
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Serial NO</label>
                      <div class="col-sm-9">
						<form:input type="text" id="serialNo" path="SNo" placeholder="Serial NO" class="form-control" />
						 </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputMobile" class="col-sm-3 col-form-label">Installed</label>
                      <div class="col-sm-9">
                          <div class="form-group row">
                            <div class="col-sm-4">
                            <div class="form-check">
                              <label class="form-check-label">
                            <form:radiobutton path="Installed" class="form-check-input"  value="Yes" checked="checked"/>Yes
                              </label>
                            </div>
                          </div>
                          <div class="col-sm-5">
                            <div class="form-check">
                              <label class="form-check-label">
                              <form:radiobutton path="Installed" class="form-check-input"  value="No"/>No
                              </label>
                            </div>
                          </div>
                        </div>       
                      </div>
                    </div>
                    
           		<div class="form-group row">
                      <label for="exampleInputMobile" class="col-sm-3 col-form-label">Working</label>
                      <div class="col-sm-9">
                          <div class="form-group row">
                            <div class="col-sm-4">
                            <div class="form-check">
                              <label class="form-check-label">
                            <form:radiobutton path="Working" class="form-check-input"  value="Yes" checked="checked"/>Yes
                              </label>
                            </div>
                          </div>
                          <div class="col-sm-5">
                            <div class="form-check">
                              <label class="form-check-label">
                              <form:radiobutton path="Working" class="form-check-input"  value="No"/>No
                              </label>
                            </div>
                          </div>
                        </div>       
                      </div>
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
        <!-- <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright Â© 2018 <a href="https://www.urbanui.com/" target="_blank">Urbanui</a>. All rights reserved.</span>
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
