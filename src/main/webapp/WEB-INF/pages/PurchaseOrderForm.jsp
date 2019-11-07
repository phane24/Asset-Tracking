<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

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
	getPOId();
	 $('#poId').attr('readonly',true); 
	 $('#poId').addClass('input-disabled');
	  
	 $('#assetsForm').submit(function(e) {
			var frm = $('#assetsForm');
			e.preventDefault();

		    var data = {}
		    var Form = this;

		    //Gather Data also remove undefined keys(buttons)
		    $.each(this, function(i, v){
		            var input = $(v);
		        data[input.attr("name")] = input.val();
		        delete data["undefined"];
		    });
		    
		    
 	$.ajax({
	        type:"post",
	        url:frm.attr('action'),
	        contentType: 'application/json',
	        datatype : "json",
	        data : JSON.stringify(data),
	        success:function(result) {
	                	//alert("result");
	                	$("#assetsForm")[0].reset();
	                	document.getElementById('SingleAssetsOrder').style.display="none";
	    	    		document.getElementById('SingleEquipsOrder').style.display="none";
	    	    		$("#submit").show();
	    	    		$("#cancel").show();
	        }	       
		});
 	});

 
$('#equipsForm').submit(function(e) {
	var frm1 = $('#equipsForm');
	e.preventDefault();

    var data1 = {}
    var Form1 = this;

    //Gather Data also remove undefined keys(buttons)
    $.each(this, function(i, v){
            var input1 = $(v);
        data1[input1.attr("name")] = input1.val();
        delete data1["undefined"];
    });
    
    
$.ajax({
    type:"post",
    url:frm1.attr('action'),
    contentType: 'application/json',
    datatype : "json",
    data : JSON.stringify(data1),
    success:function(result) {
            	//alert("result");
            	$("#equipsForm")[0].reset();
            	document.getElementById('SingleAssetsOrder').style.display="none";
	    		document.getElementById('SingleEquipsOrder').style.display="none";
	    		$("#submit").show();
	    		$("#cancel").show();
    },
    error:function()
    {
    	console.log("Error");
    }
});
});
});

var classArr=[],itemsArr=[];
var selectedCat;
function getCategoryClasses(selectedCategory)
{
	//var value=$("#vendorDis").val();
	//$("#vendorName").val(value);
	
	 $('#vendorName').attr('readonly','true'); 
	 //$('#vendorName').addClass('input-disabled');
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

var vendorArr=[],vendorName;
function getVendorId(venName){
	$.ajax({
        type:"get",
        url:"getVendorId",
        contentType: 'application/json',
        datatype : "json",
        data:{"vendorName":venName},
        success:function(data1) {
        	vendorArr = data1;
        	vendorName=venName;
        	$('#vendorId').val(data1);
        	       	
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function changeClass(categorySelected) {
    var catOptions = "";
    catOptions += "<option>Select</option>";
    for (categoryId in classArr) {
        catOptions += "<option>" + classArr[categoryId] + "</option>";
    }
   		document.getElementById("categoryClass").innerHTML = catOptions;
}


function getClassItems(selectedClass)
{
	
	var selectedVendor=$("#vendorName").val();
	
	$.ajax({
        type:"get",
        url:"getClassVendorItems",
        //url:"getClassItems",
        contentType: 'application/json',
        datype : "json",
        //data:{"classSelected":selectedClass,"categorySelected":selectedCat},
        data:{"classSelected":selectedClass,"categorySelected":selectedCat,"vendorSelected":selectedVendor},
        success:function(result) {
         jsonData = JSON.parse(result);
         itemsArr=[];
         if(jsonData.length!=0)
         {
        	if(selectedCat=="Assets")
        		{
        		if(selectedClass=="Class A Store")
        			itemsArr=jsonData[0].classAAssets;
        		else if(selectedClass=="Class B Store")
        			itemsArr=jsonData[0].classBAssets;
        		else if(selectedClass=="Class C Store")
        			itemsArr=jsonData[0].classCAssets;
        	}
        	else if(selectedCat=="Equipments")
        	{
        		if(selectedClass=="Class A Store")
        			itemsArr=jsonData[0].classAEquips;
        		else if(selectedClass=="Class B Store")
        			itemsArr=jsonData[0].classBEquips;
        		else if(selectedClass=="Class C Store")
        			itemsArr=jsonData[0].classCEquips;
        	}
         }
        	changeCat(selectedClass);
         
        },
        error:function()
        {
        	console.log("Error");
        }
	});
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
	    
	    
	    function getPOId()
	    {
	    	var jsonArr1;
	    		$.ajax({
	    	        type:"get",
	    	        url:"getLastPurchaseId",
	    	        contentType: 'application/json',
	    	        datatype : "json",
	    	        success:function(data) {
	    	        	var jsonArr=JSON.parse(data);	        	
	    	        	 if(jsonArr.length==0){
	    		        		jsonArr1="PO001";
	    		        	}  	
	    	        	 else{
	    		        	var dataSplit=jsonArr[0].split("O");
	    		        	console.log(dataSplit[1]);
	    		        	var dataSplitInt=parseInt(dataSplit[1]);
	    		        	console.log(dataSplitInt+1);
	    		        	dataSplitInt=dataSplitInt+1;
	    		        	
	    		        	if(dataSplitInt>0&&dataSplitInt<=9)
	    		        		jsonArr1="PO00"+dataSplitInt;
	    		        	else if(dataSplitInt>9&&dataSplitInt<99)
	    		        		jsonArr1="PO0"+dataSplitInt;
	    		        	else if(dataSplitInt>99)
	    		        		jsonArr1="PO"+dataSplitInt;        	
	            		}	        	
	    	        	$('#poId').val(jsonArr1);	        	
	    	        },
	    	        error:function()
	    	        {
	    	        	console.log("Error");
	    	        }
	    		});
	    }
	    
	    var categoryTypesArr=[];
	    function getTypes(category,selectedType){
	    	var selCategory=document.getElementById('category').value;
	    	var selClass=document.getElementById('categoryClass').value;
	    	
	    	$.ajax({
    	        type:"get",
    	        url:"getCategoryTypes",
    	        contentType: 'application/json',
    	        datatype : "json",
    	        data:{"selectedCategory":selCategory,"selectedClass":selClass,"selectedType":selectedType},
    	        success:function(data) {
    	        	categoryTypesArr=JSON.parse(data);	 
    	        	categoryTypes(category);
    	        },
    	        error:function()
    	        {
    	        	console.log("Error");
    	        }
    		});
	    }
	    
	    
	    function categoryTypes(selCat) {
	        var catOptions = "";
	        for (categoryId in categoryTypesArr) {
	            catOptions += "<option>" + categoryTypesArr[categoryId] + "</option>";
	        }
	        var selClass=document.getElementById('categoryClass').value;
	        if(selCat=="Assets"){
	       		document.getElementById("assetsType").innerHTML = catOptions;		       
		        $('#assetsCategoryClass').val(selClass);
	        }
	        else if(selCat=="Equipments"){
	        	document.getElementById("equipsType").innerHTML = catOptions;
		        $('#equipsCategoryClass').val(selClass);
	        }
	    }
	    
	    
	    function div_show(selectedId,selectedValue){
	    	var selectedPoId=document.getElementById('poId').value;	
	    	if(selectedValue!=""){	    		
		    	if(selectedId.includes("Assets"))
		    	{
		    		document.getElementById('SingleAssetsOrder').style.display="";
		    		document.getElementById('SingleEquipsOrder').style.display="none";
		    		$('#assetsPoId').val(selectedPoId);
		    		 $('#assetsCategory').val(selectedValue);		
		    		 $('#assetsVendorId').val(vendorArr);	
		    		 $('#assetsVendorName').val(vendorName);	
		    		 getTypes("Assets",selectedValue);
		    		 $('#assetsPoId,#assetsCategory').attr('readonly',true); 
		    		 $('#assetsPoId,#assetsCategory').addClass('input-disabled');	    		
		    	}
		    	else if(selectedId.includes("Equips"))
		    	{
		    		document.getElementById('SingleAssetsOrder').style.display="none";
		    		document.getElementById('SingleEquipsOrder').style.display="";
		    		$('#equipsPoId').val(selectedPoId);
		    		$('#equipsCategory').val(selectedValue);
		    		$('#equipsVendorId').val(vendorArr);	
		    		$('#equipsVendorName').val(vendorName);
		    		getTypes("Equipments",selectedValue);
		    		 $('#equipsPoId,#equipsCategory').attr('readonly',true); 
		    		 $('#equipsPoId,#equipsCategory').addClass('input-disabled');	    		 
		    	}
	    	}
	    	else if(selectedValue=="") 
	    	{
	    		alert("Please select Any Value");
	    	}	    		
	    }
	    
	    
	    function calculatePrice(selectOrder)
	    {
	    	if(selectOrder=="Assets")
	    	{
	    		var quanAssets=document.getElementById('assetsQuantity').value;
	    		var priceAssets=document.getElementById('assetsPrice').value;
	    		$('#assetsTotalPrice').val((quanAssets*priceAssets));
	    		 $('#assetsTotalPrice').attr('readonly',true); 
	    		 $('#assetsTotalPrice').addClass('input-disabled');	 
	    	}
	    	else if(selectOrder=="Equipments")
	    	{
	    		var quanEquips=document.getElementById('equipsQuantity').value;
	    		var priceEquips=document.getElementById('equipsPrice').value;
	    		$('#equipsTotalPrice').val((quanEquips*priceEquips));
	    		 $('#equipsTotalPrice').attr('readonly',true); 
	    		 $('#equipsTotalPrice').addClass('input-disabled');	    	
	    	}
	    }
	    
	    //////For Indents ////
	
	  
function getIndentData(indentId)
  {
	var tableArr=[],arr=[];
	 	$.ajax({
	        type:"get",
	        url:"getIndentItems",
	        contentType: 'application/json',
	        datatype : "json",
	        data:{"indentId":indentId},
	        success:function(data) {
	      	  var jsonArr=$.parseJSON(data);
			  for(var i=0;i<jsonArr.length;i++)
			  {
				    tableArr.push(jsonArr[i].indentId);
				    tableArr.push(jsonArr[i].equipAsset);
				    if(jsonArr[i].equipAsset=="Assets")
				    	tableArr.push(jsonArr[i].assetName);
				    else
				    	tableArr.push(jsonArr[i].equipName);
				    tableArr.push(jsonArr[i].classType);
				    tableArr.push(jsonArr[i].itemName);
				    tableArr.push(jsonArr[i].quantity);
		   	  }
				for(var i=0;i<tableArr.length;i=i+6)
				   {
				   		arr.push([tableArr[i],tableArr[i+1],tableArr[i+2],tableArr[i+3],tableArr[i+4],tableArr[i+5]]);
				   }
				indentTableData(arr);
				arr=[];
	        },
	        error:function()
	        {
	        	console.log("Error");
	        }
		});
  }
	    
	       function indentTableData(dataSet)
	  	 {
	  	
	  			$('#indentTable').DataTable({
	  			destroy:true,					
	  	        data: dataSet,
	  	        "searching": false,
	  	        "bPaginate": false,
	  	        "bLengthChange": false,
	  	        "bFilter": true,
	  	        "bInfo": false,
	  	        "bAutoWidth": false,
	  	        "bSort" : false,
	  	        columns: [
	  				{title: "IndentID",css:{"text-align":"right"}},
	  				{title: "Equip/Asset" },
	  				{title: "Name" },
	  				{title: "Class_Type" },
	  				{title: "Item_type" },
	  				{title: "Quantity" }
	  			]
	  			          
	  	    });
	  	}
	       
	    
	//////////////
	    
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
        <!--   <div align="center" id="PurchaseOrderForm"> -->
		 <!-- custom board-->
        	<form:form action="savePurchaseOrder" method="post" modelAttribute="PurchaseOrder">
      
		       <div class="col-md-6 grid-margin stretch-card">
              	<div class="card">
              	  <div class="card-body">
               	   <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Purchase Order</center></h4>
                   <div align="center"><span class="isa_success">${status}</span></div>
                   <div class="form-group row">
               	   	<div class="col-sm-9">
               	  		<span style="color:green;font-size:24px;float:right;"><% if(request.getParameter("status")!=null){%>
               	 		 <%out.print(request.getParameter("status"));}%></span>
               	  	 </div>
               	   </div>
               		   <p class="card-description">                    
               		   </p>
                  
                  <form:hidden path="vendorId" id="vendorId"/>  
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Purchase Order Id</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="poId"  path="poId" class="form-control" placeholder="POID"/>
                      </div>
                    </div>
                    
                        <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Vendor Name</label>
                      <div class="col-sm-9">
                       <form:select  id="vendorName" path="vendorName" placeholder="Vendor Name" class="form-control" onchange="getVendorId(this.value);">
                       	<form:option value="Select">Select</form:option>
                       		<form:options items = "${vendorList}" />
                       </form:select> 
                      </div>
                    </div>
                    
                    
                    <div class="form-group row">
                      <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">Indent ID</label>
                      <div class="col-sm-9">
						<form:select id="indentId" class="form-control"  onchange="getIndentData(this.value);" path="indentId">
						<form:option value="Select">Select</form:option>
							 <form:options items = "${approvedIndentIds}" />
						</form:select>   
						 </div>
                    </div>
              		 <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">PO Date</label>
                      <div class="col-sm-9">
                      <form:input type="date"  placeholder="mm/dd/yyyy" value="" path="poDate" class="form-control" max="9999-12-31"/>
                      </div>
                    </div>
                    
           			<div class="form-group row">
                      <label for="exampleInputPassword2" class="col-sm-3 col-form-label">Select Assets\Equipments</label>
                      <div class="col-sm-9">
                      <form:select path="category" id="category" class="form-control" onchange="getCategoryClasses(this.value);"  >
               				 <form:option value="Select">Select</form:option>
               		 		 <form:option value="Assets">Assets</form:option>
              				 <form:option value="Equipments">Equipments</form:option>
                	  </form:select>
                      </div>
                    </div>
                    
                  <div class="form-group row">
                      <label for="exampleInputPassword2" class="col-sm-3 col-form-label">Classes</label>
                      <div class="col-sm-9">
                      <form:select path="categoryClass" id="categoryClass" class="form-control" onchange="getClassItems(this.value);" />
                      </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputPassword2" class="col-sm-3 col-form-label">Assets/Equipments</label>
                      <div class="col-sm-9">
                      <div id="classAAssetsDiv" style="display:none;">
                  		<form:select path = "classAAssets" id="classAAssetsSelect" multiple = "true" style="width: 173px;height:150px" onclick="div_show(this.id,this.value)"></form:select></div>
                 	  <div id="classBAssetsDiv" style="display:none">
                 		 <form:select path = "classBAssets" id="classBAssetsSelect" multiple = "true" style="width: 173px;height:150px" onclick="div_show(this.id,this.value)"></form:select></div>
                 	  <div id="classCAssetsDiv" style="display:none">
                 		 <form:select path = "classCAssets" id="classCAssetsSelect" multiple = "true" style="width: 173px;height:150px" onclick="div_show(this.id,this.value)"></form:select></div>
                 	  <div id="classAEquipsDiv" style="display:none">
                 		 <form:select path = "classAEquips" id="classAEquipsSelect" multiple = "true" style="width: 173px;height:150px" onclick="div_show(this.id,this.value)"></form:select></div>
                 	  <div id="classBEquipsDiv" style="display:none">
                 		 <form:select path = "classBEquips" id="classBEquipsSelect" multiple = "true" style="width: 173px;height:150px" onclick="div_show(this.id,this.value)"></form:select></div>
                 	  <div id="classCEquipsDiv" style="display:none">
                 		 <form:select path = "classCEquips" id="classCEquipsSelect" multiple = "true" style="width: 173px;height:150px" onclick="div_show(this.id,this.value)"></form:select></div>
                      </div>
                    </div>
                    <button style="display: none" type="submit" class="btn btn-primary mr-2" id="submit" >Submit</button>
                    <button style="display: none" class="btn btn-light"  type="button" onclick="window.location.href = 'homePage'"  id="cancel" >Cancel</button>
                    
                    </div>
             </div>
                      <div class="card">
                <div class="card-body">
                		<div class="col-lg-12 grid-margin stretch-card" >
              
                <div class="card-body">
    		<table id="indentTable" class="table table-striped table-bordered table-hover" style="font-size:15px;margin-right: -1250px;margin-top: -285px;"></table>   
    	       </div>
              
            </div>	 
           </div>
         </div>
         
                  </div>
        </form:form>
       <!--  </div> -->
        
        
<!--     Purchase Assets -->
    
    <br/><br/><br/>
    
     <div  id="SingleAssetsOrder" style="display:none"> 
     <div class="col-md-6 grid-margin stretch-card">
              	<div class="card">
              	  <div class="card-body">
         <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Single Item Order</center></h4>
                   
        <form:form action="saveAssetsOrder" method="post" modelAttribute="PurchaseOrderAssets" id="assetsForm">
                 	<form:hidden path="assetsId"/>  
         			<form:hidden path="assetsCategoryClass" id="assetsCategoryClass" value=""/> 
         			<form:hidden path="assetsVendorId" id="assetsVendorId" value=""/> 
         			<form:hidden path="assetsVendorName" id="assetsVendorName" value=""/> 
                    
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Purchase Order Id</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="assetsPoId"  path="assetsPoId" class="form-control" placeholder="POID"/>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Category</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="assetsCategory"  path="assetsCategory" class="form-control" placeholder="Category"/>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Type</label>
                      <div class="col-sm-9">
                       <form:select  id="assetsType" path="assetsType" placeholder="Type" class="form-control" />
                      </div>
                    </div>
                    
              		 <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Name</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="assetsName" path="assetsName" class="form-control"/>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Quantity</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="assetsQuantity" path="assetsQuantity" class="form-control"/>
                      </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Price</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="assetsPrice" path="assetsPrice" onchange="calculatePrice('Assets')" class="form-control"/>
                      </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Total Price</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="assetsTotalPrice" path="assetsTotalPrice" class="form-control" />
                      </div>
                    </div>
                               			                 
                     <button type="submit" class="btn btn-primary mr-2" id="soSubmit" >Submit</button>
                     <button class="btn btn-light"  type="button" onclick="window.location.href = 'http://localhost:8080/AssetTracking/homePage'"  id="cancel">Cancel</button>
        </form:form>
  </div> 
  </div>
  </div>
  </div>
  
    
    <!--     Purchase Equipments -->
    
     <div id="SingleEquipsOrder" style="display:none"> 
        <div class="col-md-6 grid-margin stretch-card">
              	<div class="card">
              	  <div class="card-body">
         <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Single Item Order</center></h4>
                   
        <form:form action="saveEquipsOrder" method="post" modelAttribute="PurchaseOrderEquips" id="equipsForm">
        			<form:hidden path="equipsId"/>    
         			<form:hidden path="equipsCategoryClass" id="equipsCategoryClass" value=""/> 
        			<form:hidden path="equipsVendorId" id="equipsVendorId" value=""/>   
        			<form:hidden path="equipsVendorName" id="equipsVendorName" value=""/>   
         
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Purchase Order Id</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="equipsPoId"  path="equipsPoId" class="form-control" placeholder="POID"/>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Category</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="equipsCategory"  path="equipsCategory" class="form-control" placeholder="Category"/>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Type</label>
                      <div class="col-sm-9">
                       <form:select  id="equipsType" path="equipsType" placeholder="Type" class="form-control" />
                      </div>
                    </div>
                    
              		 <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Name</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="equipsName" path="equipsName" class="form-control"/>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Quantity</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="equipsQuantity" path="equipsQuantity" class="form-control"/>
                      </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Price</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="equipsPrice" path="equipsPrice" onchange="calculatePrice('Equipments')" class="form-control"/>
                      </div>
                    </div>
                    
                     <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Total Price</label>
                      <div class="col-sm-9">
                      <form:input type="text"  id="equipsTotalPrice" path="equipsTotalPrice" class="form-control" />
                      </div>
                    </div>
                               			                 
                    <button type="submit" class="btn btn-primary mr-2">Submit</button>
                    <button class="btn btn-light"  type="button" onclick="window.location.href = 'http://localhost:8080/AssetTracking/homePage'"  id="cancel">Cancel</button>
        </form:form>
         
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




















































....

