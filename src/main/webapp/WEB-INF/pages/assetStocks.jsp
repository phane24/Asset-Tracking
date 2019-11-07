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
$(function(){
 // $("#header").load('<c:url value="/resources/common/header.jsp" />'); 
  $("#sidebar").load('<c:url value="/resources/common/navbar.jsp" />'); 
  $("#header_bar").load('<c:url value="/resources/common/header_bar.jsp" />'); 

});

$(document).ready(function(){
	$(".isa_success").fadeOut(5000);
	//$("#vendorName,#emailId,#mobileNum,#address,#panNo,#gstNum,#contactPerson").attr('required', '');  
	getClassItems();
	getCategoryTypes();
	getmodelTypes();
	  $('#stockInHand').attr('readonly',true); 
		 $('#stockInHand').addClass('input-disabled');
	
});

$(function(){
	$('#installationDate,#stockInHandDate,#manufactureDate,#expiryDate').datepicker({
		dateFormat:"mm/dd/yy",
	})
	});

var classArr=[],itemsArr=[],typeArr=[];
var selectedCat;

function getClassItems()
{
	var selectedClass=$('#classType').val();
	$.ajax({
        type:"get",
        url:"getClassItems",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"categorySelected":"Assets"},
        success:function(data1) {
        	typeArr = JSON.parse(data1);  
        	changeCat("ItemType");
        	getCategoryTypes();
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function changeCat(category) {
	if(category=="ItemType"){
    	var catOptions = "";
    	 catOptions += "<option>Select</option>";
	    for (categoryId in typeArr) {
	        catOptions += "<option>" + typeArr[categoryId] + "</option>";
	    }
    	document.getElementById("asset").innerHTML = catOptions;
        $("select option:contains('Select')").attr("disabled","disabled");

	}
	if(category=="ItemName"){
		var catOptions = "";
		 catOptions += "<option>Select</option>";
	    for (categoryId in itemsArr) {
	        catOptions += "<option>" + itemsArr[categoryId] + "</option>";
	    }
    	document.getElementById("assetName").innerHTML = catOptions;
        $("select option:contains('Select')").attr("disabled","disabled");

	}
	
	if(category=="modelNum"){
		var catOptions = "";
		 catOptions += "<option>Select</option>";
	    for (categoryId in itemsArr) {
	        catOptions += "<option>" + itemsArr[categoryId] + "</option>";
	    }
    	document.getElementById("modelNum").innerHTML = catOptions;
        $("select option:contains('Select')").attr("disabled","disabled");

	}
   
}


function getCategoryTypes()
{
	var selectedClass=$('#classType').val();
	var selectedType=$('#asset').val();
	
	$.ajax({
        type:"get",
        url:"getCategoryTypes",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedType":selectedType,"selectedClass":selectedClass,"selectedCategory":"Assets"},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	changeCat("ItemName");
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
	var selectedType=$('#asset').val();
	var selectedModel=$('#assetName').val();

	//alert(selectedModel);
	$.ajax({
        type:"get",
        url:"getModelTypes",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedType":selectedType,"selectedClass":selectedClass,"selectedCategory":"Assets","selectedModel":selectedModel},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	changeCat("modelNum");
        //	alert(itemsArr);
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function gestockinhand()
{
	var selectequipasset = "Asset";
	var selectedClass=$('#classType').val();
	var selectedAsset=$('#asset').val();
	var selectedassetName=$('#assetName').val();
	var selectedModel = $('#modelNum').val();
	var selectedSNo=$('#sno').val();
	
	
	//alert(selectedClass);
	//alert(selectequipasset);
	//alert(selectedAsset);
	//alert(selectedassetName);
	//alert(selectedModel);
	
	$.ajax({
        type:"get",
        url:"getStockinhand",
        contentType: 'application/json',
        datatype : "json",
        data:{"equipAsset":selectequipasset,"selectedClass":selectedClass,"selectedAsset":selectedAsset,"selectedassetName":selectedassetName,"selectedModel":selectedModel,"selectedSNo":selectedSNo},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	//changeCat("modelNum");
       	//alert(itemsArr.length);
		if(itemsArr.length==0)
		{	
		$('#stockInHand').val("0");
		}
		else
		{
    	$('#stockInHand').val(itemsArr.length);
		}
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function fetchStocksData()
{
	//var selectequipasset = "Asset";
	var selectedClass=$('#classType').val();
	var selectedAsset=$('#asset').val();
	var selectedassetName=$('#assetName').val();
	var selectedModel = $('#modelNum').val();
	var selectedSNo=$('#sno').val();
	$.ajax({
        type:"get",
        url:"fetchStocksData",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedClass":selectedClass,"selectedAsset":selectedAsset,"selectedassetName":selectedassetName,"selectedModel":selectedModel,"selectedSNo":selectedSNo},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
		
		if(itemsArr.length==1)
		{
		$('#primarykey').val(itemsArr[0].id);
		$('#assetDesc').val(itemsArr[0].assetDesc);
		$('#itemPrice').val(itemsArr[0].itemPrice);
		$('#delNorms').val(itemsArr[0].delNorms);
		$('#reorderLevel').val(itemsArr[0].reorderLevel);
		var radioValue = $("input[name='updationType']:checked").val();
			if(radioValue=="Bulk")
			{
			$('#orgStock').attr('readonly',false); 
			$('#orgStock').addClass('input-disabled');
			}
			else
			{
			$('#orgStock').val(itemsArr[0].orgStock+1);
			$('#orgStock').attr('readonly',true); 
			$('#orgStock').addClass('input-disabled');
			}
		$("#submit").prop('disabled',true);
		$("#update").prop('disabled',false);
		$('#reorderLevel').attr('readonly',true); 
		$('#reorderLevel').addClass('input-disabled');
		$('#stockInHand').val(itemsArr[0].stockInHand);
		$('#stockInHandDate').val(itemsArr[0].stockInHandDate);
		$('#expiryDate').val(itemsArr[0].expiryDate);
		$('#manufactureDate').val(itemsArr[0].manufactureDate);
		
		gestockinhand();
		}
		else
		{
		alert("New Entry");
		$('#primarykey').val(" ");
		$('#assetDesc').val(" ");
		$('#itemPrice').val(" ");
		$('#delNorms').val(" ");
		$('#reorderLevel').val(" ");
		var radioValue = $("input[name='updationType']:checked").val();
			if(radioValue=="Bulk")
			{
			$('#orgStock').attr('readonly',false); 
			$('#orgStock').addClass('input-disabled');
			}
			else
			{
			$('#orgStock').val("1");
			$('#stockInHand').val(" ");
			$('#stockInHandDate').val(" ");
			$('#orgStock').attr('readonly',true); 
			$('#orgStock').addClass('input-disabled');
			}
		$("#update").prop('disabled',true);
		$("#submit").prop('disabled',false);
		$('#expiryDate').val(" ");	
		$('#manufactureDate').val(" ");
		
		gestockinhand();
		}
		
		
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function update_data()
{
	var selectedId=$('#primarykey').val();
	var selectedClass=$('#classType').val();
	var selectedAsset=$('#asset').val();
	var selectedassetName=$('#assetName').val();
	var selectedModel = $('#modelNum').val();
	var selectedSNo=$('#sno').val();
	var selectedassetDesc = $('#assetDesc').val();
	var selectedvendorName = $('#vendorName').val();
	var selecteditemPrice = $('#itemPrice').val();
	var selecteddelNorms = $('#delNorms').val();
	var selectedorgStock = $('#orgStock').val();
	var selectedstockInHand = $('#stockInHand').val();
	var selectedstockInHandDate = $('#stockInHandDate').val();
	var selectedmanufactureDate = $('#manufactureDate').val();
	var selectedexpiryDate = $('#expiryDate').val();
	var selectedreorderLevel = $('#reorderLevel').val();

	$.ajax({
        type:"get",
        url:"updateStocksData",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedClass":selectedClass,"selectedAsset":selectedAsset,"selectedassetName":selectedassetName,"selectedModel":selectedModel,"selectedSNo":selectedSNo,"selectedassetDesc":selectedassetDesc,"selectedvendorName":selectedvendorName,"selecteditemPrice":selecteditemPrice,"selecteddelNorms":selecteddelNorms,"selectedorgStock":selectedorgStock,"selectedstockInHand":selectedstockInHand,"selectedstockInHandDate":selectedstockInHandDate,"selectedmanufactureDate":selectedmanufactureDate,"selectedexpiryDate":selectedexpiryDate,"selectedId":selectedId,"selectedreorderLevel":selectedreorderLevel},
        success:function(data1) {
        	alert(data1);
			location.reload(true);
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
         <form:form action="addAssetStock" method="post" modelAttribute="AssetStock" class="forms-sample">
		 
		 <form:hidden path="id"/>
		       <div class="col-md-6 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                     <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Assets Stock</center></h4>
                  <div align="center"><span class="isa_success">${status}</span></div>
                   <div class="form-group row">
               	   	<div class="col-sm-9">
               	  		<span style="color:green;font-size:24px;float:right;"><% if(request.getParameter("status")!=null){%>
               	 		 <%out.print(request.getParameter("status"));}%></span>
               	  	 </div>
               	   </div>
                  <p class="card-description">
                  </p>
                      <div class="form-group row">
                      <label for="exampleInputMobile" class="col-sm-3 col-form-label">Updation Type</label>
                      <div class="col-sm-9">
                        <div class="form-group row">
                          <div class="col-sm-4">
                            <div class="form-check">
                              <label class="form-check-label">
                            <label><input type="radio" name="updationType" value="Single" class="form-check-input" checked="checked">Single</label> 
                              </label>
                            </div>
                          </div>
                          <div class="col-sm-5">
                            <div class="form-check">
                              <label class="form-check-label">
                          
                             <label><input type="radio" name="updationType" class="form-check-input" value="Bulk">Bulk</label>
                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                        
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Select Class Type</label>
                     <div class="col-sm-9">
                       <form:select  id="classType" path="classType" placeholder="Class Type" onchange="getClassItems()" class="form-control" >
                       	<form:option value="Select">Select</form:option>
                       	<form:option value="Class A Store">Class A Store</form:option>
                		<form:option value="Class B Store">Class B Store</form:option>
                		<form:option value="Class C Store">Class C Store</form:option>
                		</form:select>
                		</div>
                    </div>
                    
           
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Select Asset</label>
                      <div class="col-sm-9">
						<form:select id="asset" class="form-control" path="asset"  onchange="getCategoryTypes()"/>              
					  </div>
                    </div>
                    
                	<div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Select Asset Name</label>
                      <div class="col-sm-9">
						<form:select id="assetName" class="form-control" path="assetName" onchange="getmodelTypes()"/>              
					  </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Select Model Number</label>
                      <div class="col-sm-9">
						<form:select id="modelNum" class="form-control" path="modelNum" onchange="fetchStocksData();gestockinhand();"/>              
					  </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Serial No</label>
                      <div class="col-sm-9">
						<form:input id="sno" class="form-control" path="" />              
					  </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Description</label>
                      <div class="col-sm-9">
						<form:textarea path="assetDesc" id="assetDesc" rows = "3" cols = "20" class="form-control" />              
					  </div>
                    </div>
                    
                    <!-- <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Vendor Name:</label>
                      <div class="col-sm-9">
						<form:select id="vendorName" class="form-control" path="vendorName" />              
					  </div>
                    </div>-->
					
					                  <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Vendor Name</label>
                      <div class="col-sm-9">
                       <form:select  id="vendorName" path="vendorName" placeholder="Vendor Name" class="form-control" >
                       	<form:option value="Select">Select</form:option>	
                       		<form:options items = "${vendorList}" />
                       </form:select> 
                      
                      </div>
                    </div>
                  
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Item Price:</label>
                      <div class="col-sm-9">
						<form:input type="text" id="itemPrice" name="item_price" placeholder="Item Price" value=""  path="itemPrice" onkeypress="return allowOnlyNumbers(event)" class="form-control"/>
						 </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Delivery Norms</label>
                      <div class="col-sm-9">
						<form:input type="text" id="delNorms" name="Delivery Norms"  path="delNorms" onkeypress="return allowOnlyNumbers(event)" class="form-control"/>
						 </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Original Stock:</label>
                      <div class="col-sm-9">
						<form:input type="text" id="orgStock" name="Original Stock"  path="orgStock" onkeypress="return allowOnlyNumbers(event)" class="form-control"/>
						 </div>
                     </div>
                     

                    
                       <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Stock In Hand:</label>
                      <div class="col-sm-9">
						<form:input type="text" id="stockInHand" placeholder="Stock In Hand" name="stockInHand"  onkeypress="return allowOnlyNumbers(event)" path="stockInHand" class="form-control" />
						 </div>
                     </div>
                    
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Reorder Level:</label>
                      <div class="col-sm-9">
						<form:input type="text" id="reorderLevel"  name="reorderlevel" placeholder="Reorder Level"  path="reorderLevel" class="form-control" />
						 </div>
                     </div>
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Stock In Hand Date:</label>
                      <div class="col-sm-9">
						<form:input type="date" id="stockInHandDate" placeholder="mm/dd/yyyy" name="stockInHandDate"  path="stockInHandDate" class="form-control" max="9999-12-31"/>
						 </div>
                     </div>
                     
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Date Of Manufacture:</label>
                      <div class="col-sm-9"> 
						<form:input type="date" id="manufactureDate" placeholder="mm/dd/yyyy" name="manufactureDate"  path="manufactureDate" class="form-control" max="9999-12-31"/>
						 </div>
                     </div>
                      <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Date Of Expiry:</label>
                      <div class="col-sm-9">
						<form:input type="date" id="expiryDate" placeholder="mm/dd/yyyy" name="expiryDate"  path="expiryDate" class="form-control" max="9999-12-31"/>
<input type="hidden" id="primarykey"/>
						 </div>
                     </div>
                         <button type="submit" class="btn btn-primary mr-2" id="submit">Submit</button>
                      <button class="btn btn-light"  type="button" onclick="update_data();"  id="update">Update</button>                       
                   	 <button class="btn btn-light"  type="button" onclick="window.location.href = '/homePage"  id="cancel">Cancel</button>
                            </form:form>
                </div>
              </div>
            </div>	  
	  <!-- ending-->
		 </div>
          
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
      <!--   <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright Â© 2018 <a href="https://www.urbanui.com/" target="_blank">Cyient</a>. All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="mdi mdi-heart text-danger"></i></span>
          </div>
        </footer>
        -->
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
