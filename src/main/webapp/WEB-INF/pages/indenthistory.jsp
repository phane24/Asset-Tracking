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

function goBack()
	{
		window.location.href = 'http://localhost:8080/AssetTracking/homePage';
		//history.back();	
		//window.location.href('./AssetTracking/displayDevices');
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
 <table align="center">
	<br/><br/><br/>
  <tr height="30px"></tr>
  <tr><span><i style="float:right;margin-right: 25px;font-size: 25px;" class="fa fa-arrow-left" onclick="goBack()"></i></span></tr>
  <tr>

	<td width="30px"></td>
	<td align="center" >
	<main class="grid">
  <article>
    <img src='<c:url value="/resources/images/cart.png" />' alt="Sample photo">
    <div class="text">
      <h3>Approved Indents</h3>
     
      <button onclick="window.location.href = 'approvedIndents';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
  <article>
    <img src='<c:url value="/resources/images/order-ack.png" />' alt="Sample photo">
    <div class="text">
      <h3>Rejected Indents</h3>
   
      <button onclick="window.location.href = 'rejectedIndents';" style="background-color:#009ca6">GO</button>
    </div>
  </article>
 
  </main>
	</td>
	</tr>
	</table>
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