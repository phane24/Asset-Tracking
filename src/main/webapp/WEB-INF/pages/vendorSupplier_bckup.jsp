
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
	
	<link href="${mainCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
<title>Vendor Registration</title>
</head>

<script>

$(document).ready(function(){
	 
	 var categorySelect=$('#category').val();
	 $('#category').find('option:contains("Both")').hide();
	 alert($("#category").find("option:eq(2)"));
	$("#category").find("option:eq(2)").hide();
	 getCategoryItems(categorySelect);
	 
	 $("#test").click(function(){
		    var equips = [];
		    var assets = [];
		    $.each($(".equipments option:selected"), function(){            
		        equips.push($(this).val());
		    });
		    $.each($(".assets option:selected"), function(){            
		    	assets.push($(this).val());
		    });
		    if(assets.length> 0 && equips.length >0){
		    	$("#category").val("Both");
		    	alert($("#category").val());
		    }
		    $("form").submit();
		});
	 
	
 });
 



var jsonArr=[];
var assOrEqu;
function getCategoryItems(selectedCategory)
{
	$.ajax({
        type:"get",
        url:"getCategoryItems",
        contentType: 'application/json',
        datatype : "json",
        data:{"category":selectedCategory},
        success:function(data1) {
        	jsonArr = JSON.parse(data1);
        	alert(jsonArr);
        	changeDrop(selectedCategory);        	
        	changeCat(selectedCategory);
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function changeDrop(value) {
	  
	  assOrEqu=value
	  if(value=="Assets")
	  {
		  document.getElementById("assetsDiv").style.display = "block";
		  document.getElementById("equipDiv").style.display = "none";
	  }
	  else if(value=="Equipments")
	  {
		  document.getElementById("equipDiv").style.display = "block";
		  document.getElementById("assetsDiv").style.display = "none";
	  }
	  
}

function changeCat(categorySelected) {
    var catOptions = "";
    for (categoryId in jsonArr) {
        catOptions += "<option>" + jsonArr[categoryId] + "</option>";
    }
    if(categorySelected=="Assets"){
   		document.getElementById("categoryAssetsSelect").innerHTML = catOptions;
    }
    if(categorySelected=="Equipments"){
    	document.getElementById("categoryEquipSelect").innerHTML = catOptions;
    }
}



</script>

<body>
    <div align="center">
        <h1>Add Vendor</h1>
        <form:form action="addVendor" method="post" modelAttribute="VendorSupplier">
        <table>
            <form:hidden path="id"/>      
 			<tr>
                <td>Vendor ID:</td>
                <td><form:input value="" path="vendorId" /></td>
            </tr>
            <tr>
                <td>Vendor Name:</td>
                <td><form:input path="vendorName" /></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><form:textarea path="address" rows = "5" cols = "30"/></td>
            </tr>
            <tr>
                <td>Mobile Number:</td>
                <td><form:input path="mobNum"/></td>
            </tr>
            <tr>
                <td>Email ID:</td>
                <td><form:input path="emailId" /></td>
            </tr>            
            <tr>
                <td>Select Assets\Equipments:</td>
                <td><form:select path="category" id="category" onblur="getCategoryItems(this.value);" >
                		<form:option value="Assets">Assets</form:option>
                		<form:option value="Equipments">Equipments</form:option>
                		<form:option value="Both" style="display:none;">Both</form:option>
                	</form:select>
                </td>
            </tr>
             <tr>
               <td>Assets/Equipments:</td>
               <td>
               <div id="assetsDiv" style="display:none">
                  <form:select path = "categoryAssets" id="categoryAssetsSelect" class="assets" multiple = "true"></form:select></div>
                  <div id="equipDiv" style="display:none">
                  <form:select path = "categoryEquips" id="categoryEquipSelect" class="equipments" multiple = "true"></form:select></div>
               </td>
            </tr>        
                
            <tr>
                <td colspan="2" align="center"><input type="button" value="Add" id="test"></td>
            </tr>
        </table>
        </form:form>
    </div>
</body>
</html>