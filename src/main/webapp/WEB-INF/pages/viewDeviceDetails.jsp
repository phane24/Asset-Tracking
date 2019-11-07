<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Device Details</title>
<spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
<spring:url value="resources/js/jquery.min.js" var="jqueryJs" />
	<spring:url value="resources/js/jquery-ui.min.js" var="jqueryuiJs" />
	
	<link href="${mainCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
    
   
</head>
<body>
	<div align="center">
		<h1>C-TOC IOT Devices</h1>
		
<!-- 		<table border="1"> -->
<!-- <tr> -->
<!-- 			<th>ID</th> -->
<!-- 			<th>Device Name</th> -->
<!-- 			<th>Vendor Name</th> -->
<!--  			<th>Stock Received Date</th>  -->
<!-- 			<th>Received Stock</th> -->
<!-- 			<th>Delivered Stock</th> -->
<!-- 			<th>Delivered To</th> -->
<!-- 			<th>Stock In Hand</th> -->
<!-- 			<th>Remarks</th> -->
<!-- </tr> -->
<%-- 			<c:forEach var="device" items="${Device}"> --%>
<!-- 				<tr> -->
<%-- 					<td>${device.id}</td> --%>
<%-- 					<td>${device.deviceName}</td> --%>
<%-- 					<td>${device.vendorName}</td> --%>
<%--  					<td>${device.stockReceivedDate}</td>  --%>
<%-- 					<td>${device.receivedStockNum}</td> --%>
<%-- 					<td>${device.deliveredStockNum}</td> --%>
<%-- 					<td>${device.deliveredTo}</td> --%>
<%-- 					<td>${device.stockInHand}</td>					 --%>
<%-- 					<td>${device.remarks}</td> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</table> -->
	
	
	
	
	  <div class="mainDiv" style="margin-top:100px">
  <table>
  <tr>
  <td class="tblClass"><b>ID </b></td><td class="tblClass">${Device.id}</td>
  </tr>
  <tr>
  <td class="tblClass"><b>Device Name </b></td><td class="tblClass">${Device.deviceName}</td>
  </tr>
  <tr>
  <td class="tblClass"><b>Stock Received Date </b></td><td class="tblClass">${Device.stockReceivedDate}</td>
  </tr>
  <tr>
  <td class="tblClass"><b>Delivered To </b></td><td width="250px"class="tblClass">${Device.deliveredTo}</td>
  </tr>
  <tr>
  <td class="tblClass"><b>Delivered Stock </b></td><td class="tblClass">${Device.deliveredStockNum}</td>
  </tr>
  <tr>
  <td class="tblClass"><b>Received Stock </b></td><td class="tblClass">${Device.receivedStockNum}</td>
  </tr>
  <tr>
  <td class="tblClass"><b>stock In Hand</b></td><td class="tblClass">${Device.stockInHand}</td>
  </tr>
  <tr>
  <td class="tblClass"><b>Remarks</b></td><td class="tblClass">${Device.remarks}</td>
  </tr>  
  <tr>
  <td class="tblClass"></td><td><a href="displaydevice"><input type="button" value="Back"/></a></td>
  </tr>
  </table>
  </div>
  </div>
	
</body>
</html>