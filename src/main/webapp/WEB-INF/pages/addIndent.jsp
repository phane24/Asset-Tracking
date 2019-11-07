<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
<script language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script language="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
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
	document.getElementById("equipDiv").style.display='none';
	document.getElementById("assetDiv").style.display='none';
	document.getElementById('sid').style.display = "none";
	document.getElementById('R_R').style.display = "none";
	var o = new Option("Select", "Select");
/// jquerify the DOM object 'o' so we can use the html method
	$(o).html("Select");
	$("#assetName").append(o);
	$("#equipName").append(o);
	$("#itemName").append(o);
	$("#modelNum").append(o);
	$("#item_type").append(o);
    $("select option:contains('Select')").attr("disabled","disabled");
});
</script>
<script>
var dataSet = [];


$(document).ready(function(){	 
	$(".isa_success").fadeOut(5000);
		 getIndentId();
		 dateFun();
		// getSiteId();
		 $('#indentId').attr('readonly',true); 
		 $('#indentId').addClass('input-disabled');
		$('#stockInHand').attr('readonly',true); 
		 $('#stockInHand').addClass('input-disabled');
		 //$("select option[value='Select']").attr('disabled','disabled');
		 
		 $('.requestType').click(function() {
			 var radioValue=$("input[name='requestType']:checked").val();
			 if(radioValue=="New")
			{
				 document.getElementById("replacement").style.display='none';
				 document.getElementById("assetId").style.display='none';
				 document.getElementById("quantity").style.display='table-row';
				 document.getElementById("stockInHand").style.display='table-row';
				
			}
			 if(radioValue=="Replacement")
			{
				 document.getElementById("assetId").style.display='table-row';
				 document.getElementById("replacement").style.display='table-row';
				 document.getElementById("quantity").style.display='none';
				 document.getElementById("stockInHand").style.display='none';
					
			}
		});
	});

/* $(function(){
	$('#reqDate').datepicker({
		dateFormat:"mm/dd/yy",
	}).datepicker("setDate", new Date())
	}); */
	


function getIndentId()
{
	var jsonArr1;
		$.ajax({
	        type:"get",
	        url:"getLastIndentId",
	        contentType: 'application/json',
	        datatype : "json",
	        success:function(data) {
	        	var jsonArr=JSON.parse(data);	        	
	        	 if(jsonArr.length==0){
		        		jsonArr1="IND001";
		        	}  	
	        	 else{
		        	var dataSplit=jsonArr[0].split("D");
		        	
		        	var dataSplitInt=parseInt(dataSplit[1]);
		        	
		        	dataSplitInt=dataSplitInt+1;
		        	
		        	if(dataSplitInt>0&&dataSplitInt<=9)
		        		jsonArr1="IND00"+dataSplitInt;
		        	else if(dataSplitInt>9&&dataSplitInt<99)
		        		jsonArr1="IND0"+dataSplitInt;
		        	else if(dataSplitInt>99)
		        		jsonArr1="IND"+dataSplitInt;        	
        		}	        	
	        	$('#indentId').val(jsonArr1);	        	
	        },
	        error:function()
	        {
	        	console.log("Error");
	        }
		});
}
	function dateFun()
	{
		var today = new Date();
	 	var dd = today.getDate();
	 	var mm = today.getMonth() + 1;
	 	var yyyy = today.getFullYear();

	 	if (dd < 10) {
	 	  dd = '0' + dd;
	 	}

	 	if (mm < 10) {
	 	  mm = '0' + mm;
	 	} 

	 	today = yyyy + '-' + mm + '-' + dd;
		document.getElementById('reqDate').value=today;
	}

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
        	 options+="<option disabled>Select</option>";
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

function display(value)
{
	if(value=="Assets")
	{
		document.getElementById("equipDiv").style.display='none';
		document.getElementById("assetDiv").style.display='block';
		
	}
	else if(value=="Equipments")
	{
		document.getElementById("assetDiv").style.display='none';
		 document.getElementById("equipDiv").style.display='block';
	}
	
}


	    function changeCat(value) {
			value=value.split(" ").join("");
			if(value=="Assets"||value=="Equipments"){
	            var catOptions = "";
	            for (categoryId in classes[value]) {
	                catOptions += "<option>" + classes[value][categoryId] + "</option>";
	            }
	            document.getElementById("categoryClasses").innerHTML = catOptions;	
			}
			else{				
	            var catOptions = "";
	            for (categoryId in classesByCategory[value]) {
	                catOptions += "<option>" + classesByCategory[value][categoryId] + "</option>";
	            }
	            document.getElementById("item_type").innerHTML = catOptions;	
			}	
				
	    }
	    
function getClassItems(selectedClass)
{
	var selectedCat,Options="";
	//selectedCat="Assets";
	selectedCat=$("#eqiupAsset").val()
	$.ajax({
        type:"get",
        url:"getClassItems",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"categorySelected":selectedCat},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	Options += "<option disabled>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	if(selectedCat=="Assets")
        		document.getElementById("assetName").innerHTML = Options;
        	else if(selectedCat=="Equipments")
        		document.getElementById("equipName").innerHTML = Options;
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function getAssetName(selectedAsset)
{
	selectedClass=$("#classType").val();
	var selectedCat,Options="";
	$.ajax({
        type:"get",
        url:"getAssetName",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"AssetSelected":selectedAsset},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	//Options += "<option disabled>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	document.getElementById("itemName").innerHTML = Options;
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

/*
function getAssetId(assetName)
{
	var selectedCat,Options="";
	$.ajax({
        type:"get",
        url:"getAssetId",
        contentType: 'application/json',
        datatype : "json",
        data:{"assetName":assetName},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	Options += "<option>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	document.getElementById("assetIdValue").innerHTML = Options;
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}
*/
function getmodelTypes()
{
	var selectedClass=$('#classType').val();
	var selectedType="";
	var assetEquipe = $('#eqiupAsset').val();
	if(assetEquipe=="Assets")
		{
	 selectedType=$('#assetName').val();
		}
	else
		{
selectedType=$('#equipName').val();
		}
		
	var selectedModel=$('#itemName').val();

	//alert(selectedType);
	$.ajax({
        type:"get",
        url:"getModelTypes",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedType":selectedType,"selectedClass":selectedClass,"selectedCategory":assetEquipe,"selectedModel":selectedModel},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);

        		var catOptions = "";
        		//catOptions += "<option disabled>Select</option>";
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


function gestockinhand()
{
	var selectequipasset = $('#eqiupAsset').val();
	var selectedClass=$('#classType').val();
	var selectedAsset="";
	
	if(selectequipasset=="Assets")
	{
		selectedAsset=$('#assetName').val();
	}
else
	{
	selectedAsset=$('#equipName').val();
	}
	
	var selectedassetName=$('#itemName').val();
	var selectedModel = $('#modelNum').val();

	
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
        data:{"equipAsset":selectequipasset,"selectedClass":selectedClass,"selectedAsset":selectedAsset,"selectedassetName":selectedassetName,"selectedModel":selectedModel},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
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
	getAssetIdfromIndent();
}

function getAssetIdfromIndent()
{
	var selectedCat,options="";
	var siteId = $('#getSiteId').val();
	//alert(siteId);
	var selectequipasset = $('#eqiupAsset').val();
	var selectedClass=$('#classType').val();
	var selectedAsset="";
	
	if(selectequipasset=="Assets")
	{
		selectedAsset=$('#assetName').val();
	}
else
	{
	selectedAsset=$('#equipName').val();
	}
	
	var selectedassetName=$('#itemName').val();
	var selectedModel = $('#modelNum').val();

	
	//alert(selectedClass);
	//alert(selectequipasset);
	//alert(selectedAsset);
	//alert(selectedassetName);
	//alert(selectedModel);
	
	$.ajax({
        type:"get",
        url:"getAssetIdfromIndent",
        contentType: 'application/json',
        datatype : "json",
        data:{"siteId":siteId,"equipAsset":selectequipasset,"selectedClass":selectedClass,"selectedAsset":selectedAsset,"selectedassetName":selectedassetName,"selectedModel":selectedModel},
        success:function(data1) {
        	//itemsArr = JSON.parse(data1);
			var arr = JSON.parse(data1);
			//alert(arr[0]["equipAssetId"]);
        	options+="<option>Select</option>";
        	for(var i=0;i<arr.length;i++)
        	{
        		options+="<option>"+arr[i]["equipAssetId"]+"</option>";
        	}
        	$('#assetIdValue').html(options);
        	$('#assetIdValue').attr('readonly',true); 
        	$('#assetIdValue').addClass('input-disabled');
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function new_item()
{
document.getElementById('R_R').style.display = "none";
document.getElementById('R_R_1').style.display = "block";
document.getElementById('sid').style.display = "none";
}

function replacement()
{
document.getElementById('R_R').style.display = "block";
document.getElementById('R_R_1').style.display = "none";
document.getElementById('sid').style.display = "block";
}



var jsonStr = '{"items":[]}';
var obj = JSON.parse(jsonStr);
 var arrayReturn = [];
function add_cart()
{

var indentId = $('#indentId').val();
var request_for = $("input[name='request_for']:checked").val();
var request_type = $("input[name='requestType']:checked").val();
var repair_retair = $("input[name='replacementType']:checked").val();
siteId = $('#getSiteId').val();
if(request_for=="site")
{
siteId = $('#siteId').val();
$("#siteId").attr("disabled","true");
}
//else
//{
//siteId = $('#shelterId').val();
//}
var type = $('#eqiupAsset').val();
var equipments = $('#equipName').val();
var Assertname = $('#assetName').val();
var name = $('#itemName').val();
var AssertId = $('#AssertId').val();
var quantity = $('#quantity').val();
var stockinhand = $('#stockInHand').val();
var requestedDate = $('#reqDate').val();
var class_type = $('#classType').val();
var modelnumber = $('#modelNum').val();

obj['items'].push({"indentId":indentId,"siteId":siteId,"request_type":request_type,"repair_retair":repair_retair,"type":type,"Assertname":Assertname,"equipments":equipments,"name":name,"modelnumber":modelnumber,"AssertId":AssertId,"quantity":quantity,"stockinhand":stockinhand,"requestedDate":requestedDate,"class":class_type});
var dummy="";

if(type=="Assets")
{
dummy = Assertname;
}
else
{
 dummy = equipments;

}
//dataSet.push([type,dummy,name,quantity,stockinhand,class_type]);
jsonStr = JSON.stringify(obj);
//console.log(jsonStr);

alert("items added cart");
$("#getSiteId").prop("disabled","true");
$("#class").val('class_a');
$("#name").val('Select Name');
$("#quantity").val(' ');
$("#requestedDate").val(' ');


var table = $('#example').DataTable();

var rowNode = table
   .row.add( [type,dummy,name,modelnumber,quantity,stockinhand,class_type] )
   .draw()
   .node();
	
/*	
arrayReturn.push([type,dummy,name,quantity,stockinhand,class_type]);
inittable(arrayReturn);
*/

}


function inittable(data) {	
		//console.log(data);
		$('#example').DataTable( {
			"data": data
		} );
	}


function submit_logic()
{
	validateId();
	var url="newIndent"; 
       $.ajax({
         type:"post",
         async:false,
         data:{input : jsonStr},
         dataType : "json",
         url:url,
       success:function(result)
         {			  
            alert(result);         
         }
     })
    
	  alert("Indent Raised");
	     location.reload(true);
}


function validate(id,msgId)
{
	var id=document.getElementById(id).value;
	if(id=="Select")
	{
			$("#"+msgId).css("display","block");
			return false;
	}
	else
	{
		$("#"+msgId).css("display","none");	
	}
}


function validateId(){
	var siteid=document.getElementById("getSiteId").value;
	if(siteid=="Select SiteID"){
		$("#siteIdMsg").css("display","block");
		return false;
	}
	else{
		$("#siteIdMsg").css("display","none");
	}
	var eqasset=document.getElementById("eqiupAsset").value;
	if(eqasset=="Select"){
		$("#eqiupAssetMsg").css("display","block");
		return false;
	}
	else{
		$("#eqiupAssetMsg").css("display","none");
	}
	var classtype=document.getElementById("classType").value;
	if(classtype=="Select"){
		$("#classTypeMsg").css("display","block");
		return false;
	}
	else{
		$("#classTypeMsg").css("display","none");
	}
	var eqassets=document.getElementById("eqiupAsset").value;
	if(eqassets=="Assets"){
		var asset=document.getElementById("assetName").value;
	
		if(asset=="Select"){
			$("#assetNameMsg").css("display","block");	
			return false;
		}
		else{
			$("#assetNameMsg").css("display","none");	
		}
	}
	var eqasseteq=document.getElementById("eqiupAsset").value;
	if(eqasseteq=="Equipments"){
		var equipment=document.getElementById("equipName").value;
		if(equipment=="Select"){
			$("#equipNameMsg").css("display","block");	
			return false;
		}
		else{
			$("#equipNameMsg").css("display","none");	
		}
	}

	var name=document.getElementById("itemName").value;
	if(name=="Select"){
		$("#itemNameMsg").css("display","block");
		return false;
	}
	else{
		$("#itemNameMsg").css("display","none");
	}
	var quantity=document.getElementById("quantity").value;
	if(quantity==""){
		$("#quantityMsg").css("display","block");
		return false;
	}
	else{
		$("#quantityMsg").css("display","none");
	}
	var stockInHand=document.getElementById("stockInHand").value;
	if(stockInHand==""){
		$("#stockInHandMsg").css("display","block");
		return false;
	}
	else{
		$("#stockInHandMsg").css("display","none");
	}
	var reqDate=document.getElementById("reqDate").value;
	
	if(reqDate==""){
		$("#reqDateMsg").css("display","block");
		return false;
	}
	else{
		$("#reqDateMsg").css("display","none");
	}
	
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
		       <!--  <form:form action="saveIndent" method="post" modelAttribute="Indent" class="forms-sample" onsubmit="return validate();">-->
		 			
		       <div class="col-md-6 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                   <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Add Indent</center></h4>
                  <div align="center"><span class="isa_success">${status}</span></div>
                  <p class="card-description">
                    
                  </p>
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Indent ID</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="indentId"  path="indentId" class="form-control" placeholder="Indent ID"/>
                  <!--     <input type="text" class="form-control" id="exampleInputUsername2" placeholder="Username">-->   
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Site ID</label>
                      <div class="col-sm-9">
                       <form:select  id="getSiteId" path="siteId" placeholder="Site Id" class="form-control">
                       		<form:options items = "${siteId}" />
                       </form:select>
                       <span id="siteIdMsg" style="color:red;display:none;">*Please Select SiteID*</span> 
                     <!--    <input type="email" class="form-control" id="exampleInputEmail2" placeholder="Email">-->
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="exampleInputMobile" class="col-sm-3 col-form-label">Request Type</label>
                      <div class="col-sm-9">
                      
                    <!--     <input type="text" class="form-control" id="exampleInputMobile" placeholder="Mobile number">--> 
                         
                                                  <div class="form-group row">
                       
                          <div class="col-sm-4">
                            <div class="form-check">
                              <label class="form-check-label">
                            <form:radiobutton path="requestType" class="form-check-input" name="requestType" value="New"  onchange="new_item()" checked="checked"/>New
                              </label>
                            </div>
                          </div>
                          <div class="col-sm-5">
                            <div class="form-check">
                              <label class="form-check-label">
                              <form:radiobutton path="requestType" class="form-check-input" name="requestType" onchange = "replacement()" value="Replacement"/>Replacement

                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="R_R">
                    
                                        <div class="form-group row">
                      <label for="exampleInputMobile" class="col-sm-3 col-form-label">Replacement Type</label>
                      <div class="col-sm-9">

                                                  <div class="form-group row">
                       
                          <div class="col-sm-4">
                            <div class="form-check">
                              <label class="form-check-label">
                            <form:radiobutton path="replacementType" class="form-check-input"  value="Retire" checked="checked"/>Retire 
                              </label>
                            </div>
                          </div>
                          <div class="col-sm-5">
                            <div class="form-check">
                              <label class="form-check-label">
                              <form:radiobutton path="replacementType" class="form-check-input"  value="Repair Back"/>Repair Back

                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputPassword2" class="col-sm-3 col-form-label">Asset/Equipments</label>
                      <div class="col-sm-9">
                      <form:select path="eqiupAsset" id="eqiupAsset" class="form-control" onchange="display(this.value);"  >
               		 <form:option value="Select" >Select</form:option>
               		 <form:option value="Assets">Assets</form:option>
              		 <form:option value="Equipments">Equipments</form:option>
                	</form:select>
                	<span id="eqiupAssetMsg" style="color:red;display:none;">*Please Select Assets/Equipments*</span> 
                      </div>
                    </div>
                    
                                        <div class="form-group row">
                      <label for="exampleInputPassword2" class="col-sm-3 col-form-label">Class Type</label>
                      <div class="col-sm-9">
                      <form:select path="classType" id="classType" class="form-control"  onclick="getClassItems(this.value);">
                	<form:option value="Select" >Select</form:option>
                		<form:option value="Class A Store">Class A Store</form:option>
                		<form:option value="Class B Store">Class B Store</form:option>
                		<form:option value="Class C Store">Class C Store</form:option>
                </form:select>
                <span id="classTypeMsg" style="color:red;display:none;">*Please Select Class Type*</span> 
                      </div>
                    </div>
                    <div id="assetDiv">
                   <div class="form-group row"  >
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label" >Asset Name</label>
                      
                      <div class="col-sm-9" >
						<form:select id="assetName" class="form-control" path="assetName"  value="Assets" onclick="getAssetName(this.value)"  />
						 <span id="assetNameMsg" style="color:red;display:none;">*Please Select Asset Name*</span>  
						 </div>
                    </div>
                    </div>
                    
                    <div id="equipDiv">
                     <div class="form-group row"  >
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label" >Equipment Name</label>
                      <div class="col-sm-9" >
						<form:select id="equipName" class="form-control" path="equipName"  value="Equipments" onclick="getAssetName(this.value)" />
						 <span id="equipNameMsg" style="color:red;display:none;">*Please Select Equipment Name*</span>     
						 </div>
                    </div>
                    </div>
                
                    
                                                            <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Name</label>
                      <div class="col-sm-9">
						<form:select id="itemName" class="form-control" path="itemName"  onclick="getmodelTypes();"> 
                	<form:option value="Select" >Select</form:option>
						                </form:select>

						<span id="itemNameMsg" style="color:red;display:none;">*Please Select Name*</span>   
						 </div>
                    </div>
                    
                    
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Select Model Number</label>
                      <div class="col-sm-9">
						<form:select id="modelNum" class="form-control" path="modelNum" onchange="gestockinhand();"/>              
					  </div>
                    </div>
                    		<div id="sid">
                    
                                                          <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Asset ID</label>
                      <div class="col-sm-9">
						<form:select id="assetIdValue" class="form-control"  path="assetId" />   
						 </div>
                    </div> 
                    </div>
                    
                    <div id = "R_R_1">
                                                                              <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Quantity</label>
                      <div class="col-sm-9">
						<form:input type="number" id="quantity" class="form-control" path="quantity"/>  
						<span id="quantityMsg" style="color:red;display:none;">*Please Enter Quantity*</span>
						 </div>
                    </div>
                                                                                                  <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Stock In Hand</label>
                      <div class="col-sm-9">
						<form:input type="number"  id="stockInHand" class="form-control" path="stockInHand"></form:input>
						<span id="stockInHandMsg" style="color:red;display:none;">*Please Enter Stock In Hand*</span>  
						<button class="btn btn-light"  type="button" onclick="add_cart();"  id="cart">Add to cart</button>
						 </div>
                    </div>
                    </div>
                                  <form:hidden path="reqDate" id="reqDate"/>
                    
                       <%--  <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Requested Date</label>
                      <div class="col-sm-9">
                      
                      <form:input type="date" id="reqDate" class="form-control" path="reqDate" placeholder="mm/dd/yyyy" max="9999-12-31" value="" />
                       <button class="btn btn-light"  type="button" onclick="add_cart();"  id="cart">Add to cart</button>
						
						<span id="reqDateMsg" style="color:red;display:none;">*Please Enter Requested Date*</span>  
						 </div>
                    </div> --%>

                    <button type="button" class="btn btn-primary mr-2" onclick="submit_logic();">Submit</button>
                     <button class="btn btn-light"  type="button" onclick="window.location.href = 'homePage'"  id="cancel">Cancel</button>
                          <!--  </form:form>-->
                </div>
              </div>
              
              <div class="card">
                <div class="card-body">
                		<div class="col-lg-12 grid-margin stretch-card" >
              <div class="card">
                <div class="card-body">
                <table id="example"   class="display" width="100%" >
				<thead>
            <tr>
                <th>Type</th>
                <th>Item catogry</th>
                <th>Name</th>
                <th>Model</th>				
				<th>Quantity</th>
                <th>stock in hand</th>
                <th>class type</th>

            </tr>
        </thead>
				</table>

                </div>
              </div>
            </div>	 
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
        </footer>
        -->
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->


  
  
  
</body>

</html>
