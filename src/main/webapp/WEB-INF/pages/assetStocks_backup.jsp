
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
	<spring:url value="/resources/js/validations.js" var="validationsJs" />
		<spring:url value="resources/css/styling.css" var="mainCss" />
		
		

<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
	
	<link href="${mainCss}" rel="stylesheet" />
	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
    <script src="${validationsJs}"></script>
    
<title>Assets Stocks</title>
</head>

<script>
$(document).ready(function(){	
	//$("#vendorName,#emailId,#mobileNum,#address,#panNo,#gstNum,#contactPerson").attr('required', '');  
	getClassItems();
});

$(function(){
	$('#installationDate,#stockInHandDate,#manufactureDate,#expiryDate').datepicker({
		dateFormat:"mm/dd/yy",
	})
	});
	



var classArr=[],itemsArr=[],typeArr=[];
var selectedCat;

function getClassItems()
{
	var selectedClass=$('#classType').val();
	$.ajax({
        type:"get",
        url:"getClassItems",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"categorySelected":"Assets"},
        success:function(data1) {
        	typeArr = JSON.parse(data1);  
        	changeCat("ItemType");
        	getCategoryTypes();
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function changeCat(category) {
	if(category=="ItemType"){
    	var catOptions = "";
	    for (categoryId in typeArr) {
	        catOptions += "<option>" + typeArr[categoryId] + "</option>";
	    }
    	document.getElementById("asset").innerHTML = catOptions;
	}
	if(category=="ItemName"){
		var catOptions = "";
	    for (categoryId in itemsArr) {
	        catOptions += "<option>" + itemsArr[categoryId] + "</option>";
	    }
    	document.getElementById("assetName").innerHTML = catOptions;
	}
   
}


function getCategoryTypes()
{
	var selectedClass=$('#classType').val();
	var selectedType=$('#asset').val();
	
	$.ajax({
        type:"get",
        url:"getCategoryTypes",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedType":selectedType,"selectedClass":selectedClass,"selectedCategory":"Assets"},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	changeCat("ItemName");
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}




</script>

<body>
    <div align="center">
        <h1>Assets Stock</h1>
        <form:form action="addAssetStock" method="post" modelAttribute="AssetStock">
        <table>
            <form:hidden path="id"/>   
            <tr height="25">
               <td>Updation Type</td>
               <td>
<%--                   <form:radiobutton path = "updationType" value = "Single" label = "Single" /> --%>
<%--                   <form:radiobutton path = "updationType" value = "Bulk" label = "Bulk" /> --%>                  
                  <label><input type="radio" name="updationType" value="Single">Single</label> 
        			<label><input type="radio" name="updationType" value="Bulk">Bulk</label>
               </td>
            </tr>  
             <tr height="25">
                <td>Select Class Type</td>
                <td><form:select path="classType" id="classType" class="classType" onblur="getClassItems()" style="width:173px" >
                		<form:option value="Class A Store">Class A Store</form:option>
                		<form:option value="Class B Store">Class B Store</form:option>
                		<form:option value="Class C Store">Class C Store</form:option>
                	</form:select>
                </td>
            </tr>  
             <tr height="25">
                <td>Select Asset</td>
                <td><form:select path="asset" id="asset" onblur="getCategoryTypes()" style="width:173px" ></form:select>
                </td>
            </tr>  
             <tr height="25">
                <td>Select Asset Name</td>
                <td><form:select path="assetName" id="assetName" style="width:173px" > </form:select>
                </td>
            </tr> 
             <tr height="25">
                <td>Description:</td>
                <td><form:textarea path="assetDesc" id="assetDesc" rows = "3" cols = "20"/></td>
            </tr>
            <tr height="25">
                <td>Vendor Name:</td>
                <td><form:select path="vendorName" id="vendorName"> </form:select></td>
            </tr>
             <tr height="25">
                <td>Item Price:</td>
                <td><form:input path="itemPrice" name="item_price" id="itemPrice" /></td>
            </tr>
             <tr height="25">
                <td>Delivery Norms:</td>
                <td><form:input path="delNorms" id="delNorms"/></td>
            </tr>
             <tr height="25">
                <td>Original Stock:</td>
                <td><form:input id="orgStock" path="orgStock"  /></td>
            </tr>
             <tr height="25">
                <td>Installation Date:</td>
                <td><form:input type="text" id="installationDate" path="installationDate" placeholder="mm/dd/yyyy" value="" /></td>
            </tr> 
 			<tr height="25">
                <td>Stock In Hand:</td>
                <td><form:input path="stockInHand" id="stockInHand"/></td>
            </tr> 
             <tr height="25">
                <td>Stock In Hand Date:</td>
                <td><form:input type="text" path="stockInHandDate" placeholder="mm/dd/yyyy" id="stockInHandDate" value=""/></td>
            </tr>
             <tr height="25">
                <td>Date Of Manufacture:</td>
                <td><form:input type="text" id="manufactureDate" placeholder="mm/dd/yyyy" value=""  path="manufactureDate"/></td>
            </tr>
             <tr height="25">
                <td>Date Of Expiry:</td>
                <td> <form:input type="text" id="expiryDate" placeholder="mm/dd/yyyy" value=""  path="expiryDate"/></td>
            </tr>
            <tr height="10"></tr>   
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Add"></td>
            </tr>
        </table>
        </form:form>
    </div>
</body>
</html>