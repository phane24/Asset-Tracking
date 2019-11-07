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
</script>
<script>

$(document).ready(function(){	
	 
	$(".isa_success").fadeOut(5000);
		getIndentId();
		
	});


function getIndentId()
{
	var sid=$("#siteid").val();
	//alert(sid);
	var options='';
	$.ajax({
        type:"get",
        url:"getIndentIdBySiteId",
        contentType: 'application/json',
        data :{
            sid
          },
        datatype : "json",
        success:function(data) {
        	if(data!=null){
        	var arr = JSON.parse(data);
        	 options+="<option>Select IndentId</option>";
        	for(var i=0;i<arr.length;i++)
        	{
        		options+="<option>"+arr[i]+"</option>";
        	}
        	$('#indentId').html(options);
        	$('#indentId').attr('readonly',true); 
        	$('#indentId').addClass('input-disabled');
            $("select option:contains('Select')").attr("disabled","disabled");
        	}
        	else
        	{
        			alert("No Data to Display")	;
        		}
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function getItemId()
{
	var jsonArr1;
		$.ajax({
	        type:"get",
	        url:"getLastItemId",
	        contentType: 'application/json',
	        datatype : "json",
	        success:function(data) {
	        	var jsonArr=JSON.parse(data);	        	
	        	 if(jsonArr.length==0){
		        		jsonArr1="ITM001";
		        	}  	
	        	 else{
		        	var dataSplit=jsonArr[0].split("M");
		        	console.log(dataSplit[1]);
		        	var dataSplitInt=parseInt(dataSplit[1]);
		        	console.log(dataSplitInt+1);
		        	dataSplitInt=dataSplitInt+1;
		        	
		        	if(dataSplitInt>0&&dataSplitInt<=9)
		        		jsonArr1="ITM00"+dataSplitInt;
		        	else if(dataSplitInt>9&&dataSplitInt<99)
		        		jsonArr1="ITM0"+dataSplitInt;
		        	else if(dataSplitInt>99)
		        		jsonArr1="ITM"+dataSplitInt;        	
        		}	        	
	        	$('#itemId').val(jsonArr1);	        	
	        },
	        error:function()
	        {
	        	console.log("Error");
	        }
		});
}


var itemByCategory = {
	    Assets: ["Gateway", "Sensors", "Power Supply", "Asset Tracker","IO Extender","Data Connectivity","Converter","Smart Lock","Wires"],
	    Equipments: ["Log Periodic Antennas", "Wire Antennas", "Travelling Wave Antennas", "Microwave Antennas","Reflector Antennas"],

	}
	
var classesByCategory = {
		ClassAStore: ["Gateway", "Sensors", "Power Supply", "Asset Tracker","IO Extender","Data Connectivity","Converter","Smart Lock","Wires"],
		ClassBStore: ["Log Periodic Antennas", "Wire Antennas", "Travelling Wave Antennas", "Microwave Antennas","Reflector Antennas"],
		ClassCStore: ["Log Periodic Antennas", "Wire Antennas", "Travelling Wave Antennas", "Microwave Antennas","Reflector Antennas"],

	}
	
var classes = {
		 Assets: ["Class A Store","Class B Store","Class C Store"],
		 Equipments: ["Class A Store","Class B Store","Class C Store"]

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
		  
		<!--  	<jsp:include page="<c:url value='/resources/common/header.jsp' />" />-->
			
          </div>
 
		 <!-- custom board-->
		 	 
		                   <div class="col-12 grid-margin">
		                   		         <form:form action="addOrderAck" method="post" modelAttribute="OrderAck" class="forms-sample">		                   
              <div class="card">
                <div class="card-body">
                <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Order Acknowledgement </center></h4>
                   <div align="center"><span class="isa_success">${status}</span></div>
                   <div class="form-group row">
               	   	<div class="col-sm-9">
               	  		<span style="color:green;font-size:24px;float:right;"><% if(request.getParameter("status")!=null){%>
               	 		 <%out.print(request.getParameter("status"));}%></span>
               	  	 </div>
               	   </div>
                  <form class="form-sample">
                    <p class="card-description">
                      Order info
                    </p>
                     <div class="row">
                     	
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Site ID</label>
                          <div class="col-sm-9">
                            <form:select path="siteId" id="siteid" class="form-control" onchange="getIndentId()" >
                            <form:options items = "${siteId}" />
                             </form:select>
                          </div>
                        </div>
                      </div>
                      
                      
                      <div class="col-md-6">
                      
                      </div>
                    </div>
                    <div class="row">
                     	
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Indent ID</label>
                          <div class="col-sm-9">
                            <form:select path="indentId" id="indentId" class="form-control"> </form:select>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Verifier Name</label>
                          <div class="col-sm-9">
                           <form:input path="verName" id="verName" class="form-control"/>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Verifier Designation</label>
                          <div class="col-sm-9">
                            <form:input path="verDesignation" id="verDesignation" class="form-control"/>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Verifier Mobile Number</label>
                          <div class="col-sm-9">
						<form:input id="verMobNum" path="verMobNum" class="form-control" />                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                      
                      
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Verifier Email ID:</label>
                          <div class="col-sm-9">
                            <form:input id="verEmailId" path="verEmailId" class="form-control" />
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                      
                                        <div class="form-group row">
                      <label for="exampleInputMobile" class="col-sm-3 col-form-label">Received/Not</label>
                      <div class="col-sm-9">

                                                  <div class="form-group row">
                       
                          <div class="col-sm-4">
                            <div class="form-check">
                              <label class="form-check-label">
                  <form:radiobutton path = "receivedOrNot"  class="form-check-input" value = "Received" />Yes
                              </label>
                            </div>
                          </div>
                          <div class="col-sm-5">
                            <div class="form-check">
                              <label class="form-check-label">
                  <form:radiobutton path = "receivedOrNot" value = "No" class="form-check-input"  />No

                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                      </div>
                    </div>
                    <p class="card-description">
                    </p>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Received Date</label>
                          <div class="col-sm-9">
                          <form:input type="date" id="receivedDate" class="form-control" path="receivedDate" placeholder="mm/dd/yyyy" max="9999-12-31" value="" />
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Comments</label>
                          <div class="col-sm-9">
                            <form:textarea path="comments" class="form-control" id="comments" rows = "3" cols = "20"/>
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
