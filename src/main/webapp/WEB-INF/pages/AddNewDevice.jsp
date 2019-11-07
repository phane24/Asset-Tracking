
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
<spring:url value="/resources/js/jquery.min.js" var="jqueryJs" />
	<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryuiJs" />
	<spring:url value="resources/css/styling.css" var="mainCss" />
	
	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
    <link href="${mainCss}" rel="stylesheet" />
<title>Device Addition</title>

</head>

<script>
function StockInHandFun()
{
	var receivedNum=document.getElementById('recvStock').value;
	var deliveredNum=document.getElementById('deliveredStock').value;
	document.getElementById('stockinhand').value=receivedNum-deliveredNum;
	
}


$(document).ready(function(){
	$("#deviceName,#StockReceivedDate,#mobileNum,#pwd,#cpwd").attr('required', '');  
	$('#stockinhand').attr('readonly','true');
	 $('#stockinhand').addClass('input-disabled');
 });
 
 
$(function(){
	$('#datepicker').datepicker({
		dateFormat:"dd/mm/yy",
	})
	});
	
 

</script>
<body>
    <div align="center">
        <h1>Add/Edit Device</h1>
        <form:form action="addDevice" method="post" modelAttribute="Device">
        <table>
            <form:hidden path="id"/>
            <tr height="25">
                <td>Device Name:</td>
                <td><form:input path="deviceName"/></td>
            </tr>
            <tr height="25">
                <td>Vendor Name:</td>
<%--                 <td><form:input path="vendorName"/></td> --%>
 				<td>
					<form:select path = "vendorName" style="width:174px">
	                     <form:option value = "none" label = "Select"/>
	                     <form:options items = "${vendorList}" />
                 	</form:select> 
                </td>
            </tr>
            <tr height="25">
                <td>Received Date:</td>
				<td><form:input type="text" id="datepicker" path="stockReceivedDate" /></td>
            </tr>
            <tr height="25">
                <td>Received Stock</td>
                <td><form:input id="recvStock" path="receivedStockNum"/></td>
            </tr>
            <tr height="25">
                <td>Delivered Stock:</td>
                <td><form:input id="deliveredStock" path="deliveredStockNum" oninput="StockInHandFun()"/></td>
            </tr>            
            <tr height="25">
                <td>Delivered To:</td>
                <td><form:input path="deliveredTo"/></td>
            </tr>
            <tr height="25">
                <td>Stock In Hand:</td>
                <td><form:input id="stockinhand" path="stockInHand"/></td>
            </tr>
            <tr height="25">
                <td>Remarks:</td>
                <td><form:textarea path="remarks" /></td>
            </tr>   
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Add"></td>
            </tr>
        </table>
        </form:form>
    </div>
</body>
</html>