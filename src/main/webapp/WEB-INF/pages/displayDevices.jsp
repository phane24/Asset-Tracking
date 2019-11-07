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
  <!-- endinject -->
  <link rel="shortcut icon" href='<c:url value="/resources/images/favicon.png" />' />
  


<style>
.grid { 
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
  grid-gap: 50px;
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

function Approved(id)
{
	  document.getElementById(id).innerHTML =  window.location.search.substring(20);
	  document.getElementById(id).style.background="#71c016";
	  document.getElementById(id).style.color="white";
}

function Rejected(id)
{
	  document.getElementById(id).innerHTML =  window.location.search.substring(19);
	  document.getElementById(id).style.background="#ff4747";
	  document.getElementById(id).style.color="white";
}


function approveAndReject(id,status)
{
	var String=window.location.search.split("=")[1].split("&")[0];
	var tableId=String.charAt(String.length-1);
	
	if(status=="Approved")
	{		
		document.getElementById(id).style.background="#71c016";
	}
	else if(status=="Rejected")
	{
		 document.getElementById(id).style.background="#ff4747";
	}
	
	document.getElementById(id).innerHTML =  status;
	document.getElementById(id).style.color="white";
	
	/* function removeTR()
	{
		$('table#financeTable tr#'+tableId).remove();
	}
	setTimeout(removeTR,2000); */
}

$(document).ready(function(){
	
	if(window.location.search!="")
	{
		var id=window.location.search.split("=")[1].split("&")[0];
		var status=window.location.search.split("=")[2];
    	approveAndReject(id,status);
	}
	  	
});

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
		 
		  <% String s = session.getAttribute("role").toString(); %>

    <% if (s.equalsIgnoreCase(("financeAdmin"))) { %> 
    
    
    
    
    
    
    
     
	<%-- <div align="center">
	<legend align="center" style="font-size: 30px;color: dimgrey;"><b>Finance Approval</b></legend>
		
		<!-- <table border="1">
			<tr>
				<th>Indent ID</th>
				<th>Site Id</th>	
				<th>Item Name</th>	
				<th>Quantity</th>	
				<th>Stock In Hand</th>
				<th>Requested Date</th>			
			</tr>
			<c:forEach var="indent" items="${listIndent}">
				<tr>
					<td>${indent.indentId}</td>
					<td>${indent.siteId}</td>
					<td>${indent.itemName}</td>
					<td>${indent.quantity}</td>
					<td>${indent.stockInHand}</td>
					<td>${indent.reqDate}</td>
					<td><a href="saveStatus?indentId=${indent.indentId}&status=Approved"><button class="button" >Approve</button></a> 
 						&nbsp;&nbsp;&nbsp;&nbsp;<a href="saveStatus?indentId=${indent.indentId}&status=Reject"><button class="button1">Reject</button></a> 
 					</td>
				</tr>
			</c:forEach>
		</table>-->
		
		<div class="col-lg-12 grid-margin stretch-card" >
              <div class="card">
                <div class="card-body">
                  <div class="table-responsive">
                    <table class="table" id="financeTable">
                      <thead>
                        <tr>
				<th>Indent ID</th>
				<th>Site Id</th>	
				<th>Item Name</th>	
				<th>Quantity</th>	
				<th>Stock In Hand</th>
				<th>Requested Date</th>		
				<th>Action</th>		
				
                        </tr>
                      </thead>
                      <tbody>
			<c:forEach var="indent" items="${listIndent}">
				<tr id=${indent.id }>

					<td>${indent.indentId}</td>
					<td>${indent.siteId}</td>
					<td>${indent.itemName}</td>
					<td>${indent.quantity}</td>
					<td>${indent.stockInHand}</td>
					<td>${indent.reqDate}</td>
					<td><a href="saveStatus?indentId=${indent.indentId}&status=Approved&id=approve${indent.id}"><button  id="approve${indent.id}"  class="btn btn-outline-success btn-fw">Approve</button></a> 
 						&nbsp;&nbsp;&nbsp;&nbsp;<a href="saveStatus?indentId=${indent.indentId}&status=Rejected&id=reject${indent.id}"><button id="reject${indent.id}"  class="btn btn-outline-danger btn-fw">Reject</button></a> 
 					</td>
				</tr>
			</c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>	 

</div>
 --%>
 
 	<legend align="center" style="font-size: 30px;color: dimgrey;"><b>Finance Admin </b></legend>
	<table align="center">
	<br/><br/><br/>
	<tr>
	<td align="center" >
	
  <main class="grid">
 <!--  <button type="hidden" onclick="window.location.href = 'newSite';" style="background-color:#009ca6">GO</button>-->
 
 
  <article>
    <img src='<c:url value="/resources/images/" />' alt="Sample photo">
    <div class="text">
      <h3>Requests</h3>    
      <br> 
      <button onclick="window.location.href = 'financeapprovals';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/cart.svg" />' alt="Sample photo">
    <div class="text">
      <h3>History</h3>    
      <br> 
      <button onclick="window.location.href = 'indenthistory';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
 
   
 
</main>
	</td>
	</tr>
	</table>
   <% }%>  
   
   
   <% if (s.equalsIgnoreCase(("siteAdmin"))) { %> 
	
	<legend align="center" style="font-size: 30px;color: dimgrey;"><b>Site Admin </b></legend>
	<table align="center">
	<br/><br/><br/>
	<tr>
	<td align="center" >
	
  <main class="grid">
 <!--  <button type="hidden" onclick="window.location.href = 'newSite';" style="background-color:#009ca6">GO</button>-->
 
 
  <article>
    <img src='<c:url value="/resources/images/" />' alt="Sample photo">
    <div class="text">
      <h3>Add Site</h3>    
      <br> 
      <button onclick="window.location.href = 'newSite';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/cart.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Indent</h3>    
      <br> 
      <button onclick="window.location.href = 'newIndent_redirect';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/order-ack.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Order Acknowledgement</h3>
   
      <button onclick="window.location.href = 'newOrderAcknow';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/asset.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Asset Installation</h3>
      <br>
      <button onclick="window.location.href = 'newAssetInstallation';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/Equipment.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Equipment Installation</h3>
     
      <button onclick="window.location.href = 'newEquipInstallation';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
 
</main>
	</td>
	</tr>
	</table>
	  <% }%>  
   
	
	<% if (s.equalsIgnoreCase(("warehouseAdmin"))) { %> 
	
	<legend align="center" style="font-size: 30px;color: dimgrey;"><b>Warehouse Admin Display</b></legend>
	<table align="center">
	<br/><br/><br/>
	<tr>

  <td width="15px"></td>
  <td align="center" >
   <main class="grid">
  <article>
    <img src='<c:url value="/resources/images/item.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Item</h3>
      <button onclick="window.location.href = 'itemDesc';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/vendor.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Vendor</h3>
   
      <button onclick="window.location.href = 'vendorDesc';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/po.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Purchase Order</h3>
      
      <button onclick="window.location.href = 'newOrder';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/Dc.svg" />' alt="Sample photo">
    <div class="text">
      <h3>Delivery Challan</h3>
     
      <button onclick="window.location.href = 'deliveryChallanDesc';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
 
</main>
  </td>
  	</tr>
	</table>
	
	  <% }%> 
	  
	   <% if (s.equalsIgnoreCase("OperationsAdmin")) { %> 
	
	<div align="center">
	<legend align="center" style="font-size: 30px;color: dimgrey;"><b>Operations Admin Display</b></legend>
		
	<!-- 	<table border="1">
			<tr>
				<th>Indent ID</th>
				<th>Site Id</th>	
				<th>Item Name</th>	
				<th>Quantity</th>	
				<th>Stock In Hand</th>
				<th>Requested Date</th>			
			</tr>
			<c:forEach var="indent" items="${listIndent}">
				<tr>

					<td>${indent.indentId}</td>
					<td>${indent.siteId}</td>
					<td>${indent.itemName}</td>
					<td>${indent.quantity}</td>
					<td>${indent.stockInHand}</td>
					<td>${indent.reqDate}</td>
					<td><a href="saveStatus?indentId=${indent.indentId}&status=Approved"><button class="button">Approve</button></a> 
 						&nbsp;&nbsp;&nbsp;&nbsp;<a href="saveStatus?indentId=${indent.indentId}&status=Reject"><button class="button1">Reject</button></a> 
 					</td>

				</tr>
			</c:forEach>
		</table> -->
		
		<div class="col-lg-12 grid-margin stretch-card" >
              <div class="card">
                <div class="card-body">
                  
                  <div class="table-responsive">
                    <table class="table">
                      <thead>
                        <tr>
<th>Indent ID</th>
				<th>Site Id</th>	
				<th>Item Name</th>	
				<th>Quantity</th>	
				<th>Stock In Hand</th>
				<th>Requested Date</th>				
				<th>Action</th>		
				
                        </tr>
                      </thead>
                      <tbody>
<c:forEach var="indent" items="${listIndent}">
				<tr>

					<td>${indent.indentId}</td>
					<td>${indent.siteId}</td>
					<td>${indent.itemName}</td>
					<td>${indent.quantity}</td>
					<td>${indent.stockInHand}</td>
					<td>${indent.reqDate}</td>
					<td><a href="saveStatus?indentId=${indent.indentId}&status=Approved"><button class="btn btn-outline-success btn-fw">Approve</button></a> 
 						&nbsp;&nbsp;&nbsp;&nbsp;<a href="saveStatus?indentId=${indent.indentId}&status=Reject"><button class="btn btn-outline-danger btn-fw">Reject</button></a> 
 					</td>

				</tr>
			</c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>	
</div>
	
	  <% }%> 

	  <!-- ending-->
          </div>
          
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <!-- <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright Â© 2018 <a href="https://www.urbanui.com/" target="_blank">Urbanui</a>. All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="mdi mdi-heart text-danger"></i></span>
          </div>
        </footer>-->
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
