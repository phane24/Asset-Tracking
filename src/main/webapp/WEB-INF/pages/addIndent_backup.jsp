
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
	

<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
	
	<link href="${mainCss}" rel="stylesheet" />
	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
    <script src="${validationsJs}"></script>
    
<title>Indent</title>

<style>
	*, *:before, *:after {
 /* -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;*/
}

body {
  font-family: 'Nunito', sans-serif;
  color: #384047;
}

form {
  max-width: 300px;
  margin: 10px auto;
  padding: 10px 20px;
  background: #f4f7f8;
  border-radius: 8px;
}

h1 {
  margin: 0 0 30px 0;
  text-align: center;
}

input[type="text"],
input[type="password"],
input[type="date"],
input[type="datetime"],
input[type="email"],
input[type="number"],
input[type="search"],
input[type="tel"],
input[type="time"],
input[type="url"],
textarea,
select {
  background: rgba(255,255,255,0.1);
  /*border: none;
  font-size: 16px;
   color: #8a97a0;*/
  height: auto;
  margin: 0;
  outline: 0;
  padding: 15px;
  width: 100%;
  background-color: #e8eeef; 
  box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;
  margin-bottom: 30px;
}

input[type="radio"],
input[type="checkbox"] {
  margin: 0 4px 8px 0;
}

select {
  padding: 6px;
  height: 32px;
  border-radius: 2px;
}

#submit {
  padding: 19px 39px 18px 39px;
  color: #FFF;
  background-color: #00b1bf;
  font-size: 18px;
  text-align: center;
  font-style: normal;
  border-radius: 5px;
  width: 60%;
 /*border: 1px solid #3ac162;*/
  border-width: 1px 1px 3px;
 /* box-shadow: 0 -1px 0 rgba(255,255,255,0.1) inset; */
  margin-bottom: 10px;
  margin-left: 55px;
}

fieldset {
  margin-bottom: 30px;
  border: none;
}

legend {
   
  padding-block-start: 35px;
  font-size: 30px;
  margin-bottom: 20px;
  margin-top: 20px;
  color:#00b1bf;
  font-weight:bold;
  
}

label {
  display: block;
  margin-bottom: 8px;
}

label.light {
  font-weight: 300;
  display: inline;
}

.number {
  background-color: #5fcf80;
  color: #fff;
  height: 30px;
  width: 30px;
  display: inline-block;
  font-size: 0.8em;
  margin-right: 4px;
  line-height: 30px;
  text-align: center;
  text-shadow: 0 1px 0 rgba(255,255,255,0.2);
  border-radius: 100%;
}

td
{
 font-weight:bold;

}




@media screen and (min-width: 480px) {

  form {
    max-width: 480px;
  }

}

</style>

</head>

<script>


$(document).ready(function(){	 

		 getIndentId();
		 getSiteId();
		 $('#indentId').attr('readonly',true); 
		 $('#indentId').addClass('input-disabled');
		 
		 
		 $('.requestType').click(function() {
			 var radioValue=$("input[name='requestType']:checked").val();
			 if(radioValue=="New")
			{
				 document.getElementById("replacement").style.display='none';
				 document.getElementById("assetId").style.display='none';
				 document.getElementById("quantity").style.display='table-row';
				 document.getElementById("stockInHand").style.display='table-row';
				
			}
			 if(radioValue=="Replacement")
			{
				 document.getElementById("assetId").style.display='table-row';
				 document.getElementById("replacement").style.display='table-row';
				 document.getElementById("quantity").style.display='none';
				 document.getElementById("stockInHand").style.display='none';
					
			}
		});
	});

$(function(){
	$('#reqDate').datepicker({
		dateFormat:"mm/dd/yy",
	}).datepicker("setDate", new Date())
	});
	


function getIndentId()
{
	var jsonArr1;
		$.ajax({
	        type:"get",
	        url:"getLastIndentId",
	        contentType: 'application/json',
	        datatype : "json",
	        success:function(data) {
	        	var jsonArr=JSON.parse(data);	        	
	        	 if(jsonArr.length==0){
		        		jsonArr1="IND001";
		        	}  	
	        	 else{
		        	var dataSplit=jsonArr[0].split("D");
		        	
		        	var dataSplitInt=parseInt(dataSplit[1]);
		        	
		        	dataSplitInt=dataSplitInt+1;
		        	
		        	if(dataSplitInt>0&&dataSplitInt<=9)
		        		jsonArr1="IND00"+dataSplitInt;
		        	else if(dataSplitInt>9&&dataSplitInt<99)
		        		jsonArr1="IND0"+dataSplitInt;
		        	else if(dataSplitInt>99)
		        		jsonArr1="IND"+dataSplitInt;        	
        		}	        	
	        	$('#indentId').val(jsonArr1);	        	
	        },
	        error:function()
	        {
	        	console.log("Error");
	        }
		});
}

function getSiteId()
{
	var options='';
	$.ajax({
        type:"get",
        url:"getSiteId",
        contentType: 'application/json',
        datatype : "json",
        //data:{"vendorId":selectedVendorId},
        success:function(data) {
        	var arr = JSON.parse(data);
        	 options+="<option>Select SiteID</option>";
        	for(var i=0;i<arr.length;i++)
        	{
        		options+="<option>"+arr[i]+"</option>";
        	}
        	$('#getSiteId').html(options);
        	$('#getSiteId').attr('readonly',true); 
        	$('#getSiteId').addClass('input-disabled');
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function display(value)
{
	if(value=="Assets")
	{
		document.getElementById("equipment").style.display='none';
		document.getElementById("asset").style.display='table-row';
	}
	else if(value=="Equipments")
	{
		document.getElementById("asset").style.display='none';
		 document.getElementById("equipment").style.display='table-row';
	}
	
}


	    function changeCat(value) {
			value=value.split(" ").join("");
			if(value=="Assets"||value=="Equipments"){
	            var catOptions = "";
	            for (categoryId in classes[value]) {
	                catOptions += "<option>" + classes[value][categoryId] + "</option>";
	            }
	            document.getElementById("categoryClasses").innerHTML = catOptions;	
			}
			else{				
	            var catOptions = "";
	            for (categoryId in classesByCategory[value]) {
	                catOptions += "<option>" + classesByCategory[value][categoryId] + "</option>";
	            }
	            document.getElementById("item_type").innerHTML = catOptions;	
			}	
	    }
	    
function getClassItems(selectedClass)
{
	var selectedCat,Options="";
	//selectedCat="Assets";
	selectedCat=$("#eqiupAsset").val()
	$.ajax({
        type:"get",
        url:"getClassItems",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"categorySelected":selectedCat},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	Options += "<option>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	if(selectedCat=="Assets")
        		document.getElementById("assetName").innerHTML = Options;
        	else if(selectedCat=="Equipments")
        		document.getElementById("equipName").innerHTML = Options;
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function getAssetName(selectedAsset)
{
	selectedClass=$("#classType").val();
	var selectedCat,Options="";
	$.ajax({
        type:"get",
        url:"getAssetName",
        contentType: 'application/json',
        datatype : "json",
        data:{"classSelected":selectedClass,"AssetSelected":selectedAsset},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	Options += "<option>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	document.getElementById("itemName").innerHTML = Options;
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function getAssetId(assetName)
{
	var selectedCat,Options="";
	$.ajax({
        type:"get",
        url:"getAssetId",
        contentType: 'application/json',
        datatype : "json",
        data:{"assetName":assetName},
        success:function(data1) {
        	itemsArr = JSON.parse(data1);
        	Options += "<option>Select</option>";
        	for(var i=0;i<itemsArr.length;i++)
        	{
        		Options += "<option>" + itemsArr[i] + "</option>";
        	}
        	document.getElementById("assetIdValue").innerHTML = Options;
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
    <fieldset>
        <legend>Indent Form</legend>
        <form:form action="saveIndent" method="post" modelAttribute="Indent">
        <table>
            <form:hidden path="id"/>
            <tr height="25">
                <td>Indent ID</td>
                <td><form:input type="text" id="indentId" class="indentId" path="indentId" style="background-color:#D3D3D3"/></td>
            </tr>           
            <tr height="25" id="siteId">
                <td>Site ID</td>
                <td><form:select  id="getSiteId" class="siteId" path="siteId" placeholder="Site Id" /></td>
            </tr>           
            <tr height="25">
            	<td>Request Type</td>
            	<td><form:radiobutton path="requestType" class="requestType" name="requestType" value="New" checked="checked"/>New</td>
            	<td><form:radiobutton path="requestType" class="requestType" name="requestType" value="Replacement"/>Replacement</td>
            </tr>
             <tr height="25" style="display:none" id="replacement">
            	<td>Replacement Type</td>
            	<td><form:radiobutton path="replacementType" class="replacementType" value="Retire"/>Retire</td>
            	<td><form:radiobutton path="replacementType" class="replacementType" value="Repair Back"/>Repair Back</td>
            </tr>
            <tr height="25">
                <td>Assets/Equipments</td>
                <td>
                	<form:select path="eqiupAsset" id="eqiupAsset" class="eqiupAsset" onchange="display(this.value);"  >
               		 <form:option value="Select">Select</form:option>
               		 <form:option value="Assets">Assets</form:option>
              		 <form:option value="Equipments">Equipments</form:option>
                	</form:select>
                </td>
            </tr>
            <tr height="25">
                <td>Class Type</td>
                <td><form:select path="classType" id="classType" class="classType"  onChange="getClassItems(this.value);">
                	<form:option value="Select">Select</form:option>
                		<form:option value="Class A Store">Class A Store</form:option>
                		<form:option value="Class B Store">Class B Store</form:option>
                		<form:option value="Class C Store">Class C Store</form:option>
                </form:select></td>
            </tr>
            <tr height="25" style="display:none" id="asset">
                <td>Asset Name</td>
                <td><form:select id="assetName" class="assetName" path="assetName"  value="Assets" onchange="getAssetName(this.value)"/></td>
            </tr>
             <tr height="25" style="display:none" id="equipment">
                <td>Equipment Name</td>
                <td><form:select id="equipName" class="equipName" path="equipName"  value="Equipments" onchange="getAssetName(this.value)"/></td>
            </tr>
            <tr height="25">
                <td>Name</td>
                <td><form:select id="itemName" class="itemName" path="itemName"  onchange="getAssetId(this.value);"/></td>
            </tr> 
            <tr height="25" id="assetId" style="display:none;">
                <td>Asset ID</td>
                <td><form:select id="assetIdValue" class="assetId" path="assetId" /></td>
            </tr> 
            <tr height="25" id="quantity">
                <td>Quantity</td>
                <td><form:input type="number"  class="quantity" path="quantity"></form:input></td>
            </tr>
             <tr height="25" id="stockInHand">
                <td>Stock In Hand</td>
                <td><form:input type="number"  class="stockInHand" path="stockInHand"></form:input></td>
            </tr>        
            <tr height="25">
                <td>Requested Date</td>               
                <td><form:input type="text" id="reqDate" placeholder="mm/dd/yyyy" value=""  path="reqDate"/></td>
            </tr>
             <tr height="10"></tr>
            <tr>
                <td colspan="2" align="center"><input id="submit" type="submit" value="Add"></td>
            </tr>
        </table>
        </form:form>
        </fieldset>
    </div>
</body>
</html>