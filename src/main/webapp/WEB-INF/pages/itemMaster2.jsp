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
  <title>Majestic Admin</title>
  <!-- plugins:css -->
       <link href='<c:url value="/resources/vendors/mdi/css/materialdesignicons.min.css" />' rel="stylesheet">
      <link href='<c:url value="/resources/vendors/base/vendor.bundle.base.css" />' rel="stylesheet">
  <!-- endinject -->
  <!-- plugin css for this page -->
        <link href='<c:url value="/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.css" />' rel="stylesheet">

  <!-- End plugin css for this page -->
  <!-- inject:css -->
 <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
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
\
</head>

<script> 
$(function(){
  $("#header").load('<c:url value="/resources/common/header.jsp" />'); 
  $("#sidebar").load('<c:url value="/resources/common/navbar.jsp" />'); 
  $("#header_bar").load('<c:url value="/resources/common/header_bar.jsp" />'); 

});

$(document).ready(function(){	 
		 var categorySelect=$('#category').val();
		 changeCat(categorySelect);
		 getItemId();
		 var classSelect=$('#categoryClasses').val();
		 changeCat(classSelect);
		 $("#item_name").attr('required', '');  
	     $('#itemId').attr('readonly',true); 
		 $('#itemId').addClass('input-disabled');
	});


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
          </div>
		 <!-- custom board-->
        <form:form action="saveItem" method="post" modelAttribute="Item">
        <table>
            <form:hidden path="id"/>
            <tr height="25">
                <td>Item ID:</td>
                <td><form:input id="itemId" class="itemId" path="itemId" /></td>
            </tr>
            <tr height="25">
                <td>Assets/Equipments:</td>
                <td>
                	<form:select path="category" id="category" class="category" onblur="changeCat(this.value)">
               		 <form:option value="Assets">Assets</form:option>
              		 <form:option value="Equipments">Equipments</form:option>
                	</form:select>
                </td>
            </tr>
            <tr height="25">
                <td>Category</td>
                <td><form:select path="categoryClasses" id="categoryClasses" class="categoryClasses" style="width: 173px;" onblur="changeCat(this.value)"></form:select></td>
            </tr>
            <tr height="25">
                <td>Item Type:</td>
                <td><form:select id="item_type" class="item_type" path="itemType" /></td>
            </tr>
            <tr height="25">
                <td>Item Name:</td>
                <td><form:input id="item_name" class="item_name" path="itemName" /></td>
            </tr> 
            <tr height="25">
                <td>Item Description:</td>
                <td><form:textarea path="itemDesc" id="itemDesc" rows = "3" cols = "20"/></td>
            </tr>
             <tr height="10"></tr>
            <tr>
                <td colspan="2" align="center"><input id="submit" type="submit" value="Add"></td>
            </tr>
        </table>
        </form:form>
        </div>
              </div>
            </div>	  
	  <!-- ending-->
		 </div>
          
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright Â© 2018 <a href="https://www.urbanui.com/" target="_blank">Urbanui</a>. All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="mdi mdi-heart text-danger"></i></span>
          </div>
        </footer>
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
