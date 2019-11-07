<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
<link rel="stylesheet" type="text/css" media="screen" href="/resources/css/styling.css" />
<spring:url value="resources/js/products.js" var="mainJs" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inventory</title>
<script src="${mainJs}"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="https://kendo.cdn.telerik.com/2019.1.115/styles/kendo.common-material.min.css" />
    <link rel="stylesheet" href="https://kendo.cdn.telerik.com/2019.1.115/styles/kendo.material.min.css" />
    <link rel="stylesheet" href="https://kendo.cdn.telerik.com/2019.1.115/styles/kendo.material.mobile.min.css" />

    <script src="https://kendo.cdn.telerik.com/2019.1.115/js/jquery.min.js"></script>
    <script src="https://kendo.cdn.telerik.com/2019.1.115/js/kendo.all.min.js"></script>
    
     <spring:url value="resources/css/styling.css" var="mainCss" />
    <spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
	<spring:url value="/resources/js/jquery.min.js" var="jqueryJs" />
	<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryuiJs" />
	
	 <spring:url value="resources/css/kendo.common-material.min.css" var="kendoCommonCss" />
	  <spring:url value="resources/css/kendo.material.min.css" var="kendoMaterialCss" />
	  <spring:url value="resources/css/kendo.material.mobile.min.css" var="kendoMobileCss" />
	<spring:url value="/resources/js/kendo.jquery.min.js" var="jqueryJs" />
	<spring:url value="/resources/js/kendo.all.min.js" var="jqueryuiJs" />
	
	
    
    <link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
    
    
    <style>
    
    </style>
    
    
</head>
<%-- <% --%>
<!-- 	response.setHeader("Cache-Control","no-cache,no-store,must-revalidate"); -->
<%-- %> --%>
 <script>
 

 
                $(document).ready(function() {
                	
                	 $.ajax({
                         type:"post",
                         url:"validUser",
                         contentType: 'application/json',
                         datatype : "json",
                         success:function(data) {
                             word_list = JSON.parse(data);
                        
                	 
                    $("#requestsGrid").kendoGrid({
                        dataSource: {
                            data: word_list,
                            schema: {
                                model: {
                                    fields: {
                                       
                                    }
                                }
                            },
                            pageSize: 20
                        },
                        height: 350,
                        scrollable: true,
                        sortable: true,
                        filterable: false,
                        pageable: {
                            input: true,
                            numeric: false
                        },
                        columns: [
                            { field: "id", title:  "ID",  width: "130px" },
                            { field: "requestnumber", title: "Request Number",  width: "130px" },
                            { field: "type", title: "Request Type",  width: "130px" },
                            { field: "name", title: "Request Name",  width: "130px" },
                            { field: "quantity", title: "Quantity",  width: "130px" },
                            { field: "requestedDate", title: "Requested Date", width: "130px" },
                            { field: "requiredDate", title: "Required Date", width: "130px" }
                        ]
                    });
                	 },
                     
                }); 
                	 $.ajax({
                         type:"post",
                         url:"validUser1",
                         contentType: 'application/json',
                         datatype : "json",
                         success:function(data) {
                             devicesList = JSON.parse(data);
                        
                	 
                    $("#devicesGrid").kendoGrid({
                        dataSource: {
                            data: devicesList,
                            schema: {
                                model: {
                                    fields: {
                                    }
                                }
                            },
                            pageSize: 20
                        },
                        height: 350,
                        scrollable: true,
                        sortable: true,
                        filterable: false,
                        pageable: {
                            input: true,
                            numeric: false
                        },
                        columns: [
                            { field: "id", title:  "ID",  width: "130px" },
                            { field: "deviceName", title: "Device Name",  width: "130px" },
                            { field: "remarks", title: "Remarks",  width: "130px" },
                            { command: { text: "View", click: showDetails }, title: " ", width: "180px" }
                        ]
                    });
                	 },
                     
                });
                });
                
                function showDetails(e) {
                	var selectedId = this.dataItem($(e.currentTarget).closest("tr")).id;
                	console.log(selectedId);
                	$.ajax({
                        type:"get",
                        url:"viewDevice",
                        contentType: 'application/json',
                        datatype : "json",
                        data:{"id":selectedId},
                        success:function(data1) {
                            console.log(data1);
                        }
                	});
                
                    
                }
            </script>
            

<style>
 .button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 6px 26px;
  text-align: center;
 
}

 .button1 {
  background-color: #f44336; /* Green */
 border: none;
  color: white;
  padding: 6px 26px;
  text-align: center;
 
}
    
   legend {
   
  padding-block-start: 35px;
  font-size: 30px;
  margin-bottom: 20px;
  margin-top: 20px;
  color:#00b1bf;
  font-weight:bold;
  
}

.goButton{

 background-color: #00b1bf; 
  border-radius: 25px;
  border: 2px solid white;
  color: white;
  padding: 6px 26px;
  text-align: center;
 
}

            
</style>

<body>
<div align="right">
<h3>Welcome ${sessionScope.userName}</h3><a href="logout">  Logout</a>

</div>
 
 <% String s = session.getAttribute("userName").toString(); %>

    <% if (s.equals("finance")) { %> 
     
<div align="center">
<legend>Finance Approval</legend>
		
		<table border="1">
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
		</table>

</div>

   <% }%>  
   
   
   <% if (s.equals("siteAdmin")) { %> 
	
	<legend align="center">Site Admin Display</legend>
	<table align="center">
	<br/><br/><br/>
	<tr>
	<td align="center" >
	 <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/images/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Indent</h4>
       <!--   <a href="newIndent" class="btn btn-primary">GO</a> -->
       <a href="newIndent" class="goButton">GO</a>
    </div>
  </div>
  </td>
  <td width="15px"></td>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="/UseCases/logo.png" alt="Card image" style="width:100%"> -->
    <div class="card-body">
      <h4 class="card-title">Order Acknowledgement</h4>
      <!-- <p class="card-text">Approval</p>-->
      <a href="newOrderAcknow" class="goButton">GO</a>
    </div>
  </div>
  </td>
  </tr>
  <tr height="20px"></tr>
  <tr>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
   <!--  <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%"> -->
    <div class="card-body">
      <h4 class="card-title">Asset Installation</h4>
        <a href="newAssetInstallation" class="goButton">GO</a>
    </div>
  </div>
	</td>
	<td width="15px"></td>
	<td align="center" >
   <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Equipment Installation</h4>
        <a href="newEquipInstallation" class="goButton">GO</a>
    </div>
  </div>
	</td>
	</tr>
	</table>
	  <% }%>  
   
	
	 <% if (s.equals("warehouseAdmin")) { %> 
	
	<legend align="center">Warehouse Admin Display</legend>
	<table align="center">
	<br/><br/><br/>
	<tr>
	<td align="center" >
	 <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<c:url value="/resources/images/logo.png" />" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Items</h4>
         <a href="newItem" class="goButton">GO</a>
    </div>
  </div>
  </td>
  <td width="15px"></td>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
   <!--  <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%"> -->
    <div class="card-body">
      <h4 class="card-title">Vendors</h4>
      <!-- <p class="card-text">Approval</p>-->
      <a href="newVendor" class="goButton">GO</a>
    </div>
  </div>
  </td>
  </tr>
  <tr height="30px"></tr>
  <tr>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Vendor Supplier</h4>
        <a href="newVendorSupplier" class="goButton">GO</a>
    </div>
  </div>
	</td>
	<td width="15px"></td>
	<td align="center" >
   <div class="card" style="width:400px;height: 200px;">
  <!--   <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Purchase Order</h4>
        <a href="newOrder" class="goButton">GO</a>
    </div>
  </div>
	</td>
	</tr>
	<tr height="30px"></tr>
	<tr>
	<td></td>
	<td align="center" >
	 <div class="card" style="width:400px;;height: 200px;align:center">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Delivery Challan</h4>
         <a href="newDeliveryChallan" class="goButton">GO</a>
    </div>
  </div>
  </td>
  	</tr>
	</table>
	
	  <% }%> 

	  
	   <% if (s.equals("OperationsAdmin")) { %> 
	
	<div align="center">
<legend>Operations Approval</legend>
		
		<table border="1">
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
		</table>

</div>
	
	  <% }%> 
	  
	  
</body>
</html>