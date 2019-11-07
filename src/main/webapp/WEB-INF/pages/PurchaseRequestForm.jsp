
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
<spring:url value="/resources/js/jquery.min.js" var="jqueryJs" />
	<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryuiJs" />
	<spring:url value="resources/css/styling.css" var="mainCss" />
	
	 	<link href="${mainCss}" rel="stylesheet" />	
	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
	

<title>Purchase Request Form</title>
</head>
<script>

 
$(function(){
	$('#datepick').datepicker({
		dateFormat:"mm/dd/yy",
	}).datepicker("setDate", new Date())
	});

$(function(){
	$('#datepick2').datepicker({
		dateFormat:"mm/dd/yy",
	})
	});
	
	function fetchPurchaseRequestID()
	{
		var val = Math.floor(1 + Math.random() * 100);
	
		var timestamp=Math.round(new Date().getTime()/10000000)
	
		requestnumber="REQ" + timestamp  + val;
		document.getElementById('reqnumber').value=requestnumber;		
	}
	
	


function getRequestNum()
{
var personJson = $('#person').val();
alert("Your Request Number is "+personJson);
}

$(document).ready(function(){
	fetchPurchaseRequestID();
	 $('#datepick').attr('readonly',true); 
	 $('#datepick').addClass('input-disabled');
});

function ldVal()
{
sdate=document.getElementById("datepick").value;
edate=document.getElementById("datepick2").value;
if(Date.parse(sdate)>= Date.parse(edate))
{
	alert("End Date Should be greater than Start Date");
	$("#datepick2").val("");
}
} 
	
</script>
<body>
    <div align="center">
        <h1>Purchase Request</h1>
        <form:form action="savePurchaseRequest" id="prform" method="post" modelAttribute="purchaseRequest" >
        <table>
            <form:hidden path="id"/>
            <form:hidden id="reqnumber" path="requestnumber"/>
            <tr>
                <td>Type:</td>
                <td><form:select path="type" ><form:option value="Assets"/><form:option value="Equipments"/></form:select></td>
             </tr>
            <tr>
                <td> Name:</td>
                <td><form:input path="name" /></td>
            </tr>
             <tr>
                <td> Quantity:</td>
                <td><form:input path="quantity" /></td>
            </tr>
            <tr>
                <td>Requested Date:</td>
                <td><form:input type="text"  id="datepick" placeholder="dd/mm/yyyy" value="" path="requestedDate"/></td>
            </tr>
            <tr>
                <td>Required Date:</td>
                <td><form:input type="text" id="datepick2" placeholder="dd/mm/yyyy" value=""  path="requiredDate" onchange="ldVal()"/></td>
            </tr>
           
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Submit"></td>
            </tr>
        </table>
        </form:form>
         <input type="hidden" id="person" value="${LastRequestNumber}">
         </div>
</body>
</html>