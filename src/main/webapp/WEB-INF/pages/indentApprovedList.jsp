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
</head>
<script> 
$(function(){
  //$("#header").load('<c:url value="/resources/common/header.jsp" />'); 
  $("#sidebar").load('<c:url value="/resources/common/navbar.jsp" />'); 
  $("#header_bar").load('<c:url value="/resources/common/header_bar.jsp" />'); 

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
<div align="center">
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
				
				<th>Asset Id</th>
				<th>Asset Name</th>	
				<th>Class Type</th>	
				<th>Equip Asset</th>	
				<th>Equip Name</th>
				<th>Quantity</th>
				<th>Model Num</th>
				<th>Requested Date</th>	
				<th>Approved Date</th>	
				<th>Status </th>
				<th>Approved By</th>
                        </tr>
                      </thead>
                      <tbody>
			<c:forEach var="indent" items="${approvedIndent}">
				<tr id=${indent.id }>

					<td><%-- <a href="detailapprovedindent?id=${indent.indentId}"> --%>${indent.indentId}<!-- </a> --></td>
					<td>${indent.siteId}</td>
					
					<td>${indent.assetId}</td>
					<td>${indent.assetName}</td>
					<td>${indent.classType}</td>
					<td>${indent.equipAsset}</td>
					<td>${indent.equipName}</td>
					<td>${indent.quantity}</td>
					<td>${indent.modelNum}</td>
					<td>${indent.reqDate}</td>
					<td>${indent.approvedDate}</td>
					<td>${indent.status}</td>
					<td>${indent.approvedBy}</td>
					
				</tr>
			</c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>	 

</div>

