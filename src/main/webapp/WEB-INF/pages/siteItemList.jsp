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
$( document ).ready(function() {
	if((window.location.search)!="")
    {
		var s=window.location.search.split("=")[1].split("&")[0];
		$("#siteid").val(s);
    }


$("select option[value='Select']").attr('disabled','disabled');
});
function validate(){
	
	var siteid=document.getElementById("siteid").value;
	 if(siteid=="Select"){
	  $("#siteIdMsg").css("display","block");
	  return false;
	 }
	 else
	{
		 $("#siteIdMsg").css("display","none");
		  return true;
	}
}
</script>



<body>
<h1>${siteids} hi</h1>

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
                  <div class="col-lg-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                <legend align="center" style="font-size: 30px;color: dimgrey;"><b> Site Item List</b></legend></br>
                  <div class="table-responsive">
                  <form:form action="fetchSiteIds" method="get" modelAttribute="indentTracker" onsubmit="return validate();" >
                  <table class="table">
                  	<tr>
                  		<td> <form:select  name="siteid" id="siteid" path="siteId" class="form-control" onchange="validate();" >                  		                       
                       	<form:option value="Select" >Select</form:option>
                       		<form:options items = "${siteIds}" />
                       </form:select>
                        <span id="siteIdMsg" style="color:red;display:none;">*Please Select SiteID*</span> 
                        </td>
                  		<td><button type="submit" class="btn btn-primary mr-2" id="submit"  >Submit</td>
                  	</tr>
                  </table>
                  </form:form>
                    <table class="table">
                      <thead>
                        <tr>
				<th>Class Name</th>	
				<th>Equip Asset</th>	
				<th>Equip AssetID</th>
				<th>Expiry Date</th>
				<th>IndentID</th>
				<th>Item Name</th>	
				<th>Item Type</th>	
				<th>Manufactured Date</th>
				<th>Model Num</th>
				<th>Site ID</th>		
				<th>Vendor</th>		
                        </tr>
                      </thead>
                      <tbody>
                       <c:forEach var="item" items="${itemList}">
				<tr>

					<td>${item.className}</td>
					<td>${item.equipAsset}</td>
					<td>${item.equipAssetId}</td>
					<td>${item.expiryDate}</td>
					<td>${item.indentId}</td>
					
					<td>${item.itemName}</td>
					<td>${item.itemType}</td>
					<td>${item.manufacturedDate}</td>
					<td>${item.modelNum}</td>
					<td>${item.siteId}</td>
					<td>${item.vendor}</td>
					
					
				</tr>
			</c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>	 
