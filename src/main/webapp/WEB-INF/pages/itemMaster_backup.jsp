
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
	
	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
     <link href="${mainCss}" rel="stylesheet" />
    
<title>Item Master</title>
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
		 var categorySelect=$('#category').val();
		 changeCat(categorySelect);
		 getItemId();
		 var classSelect=$('#categoryClasses').val();
		 changeCat(classSelect);
		 $("#item_name").attr('required', '');  
	     $('#itemId').attr('readonly',true); 
		 $('#itemId').addClass('input-disabled');
	});


function getItemId()
{
	var jsonArr1;
		$.ajax({
	        type:"get",
	        url:"getLastItemId",
	        contentType: 'application/json',
	        datatype : "json",
	        success:function(data) {
	        	var jsonArr=JSON.parse(data);	        	
	        	 if(jsonArr.length==0){
		        		jsonArr1="ITM001";
		        	}  	
	        	 else{
		        	var dataSplit=jsonArr[0].split("M");
		        	console.log(dataSplit[1]);
		        	var dataSplitInt=parseInt(dataSplit[1]);
		        	console.log(dataSplitInt+1);
		        	dataSplitInt=dataSplitInt+1;
		        	
		        	if(dataSplitInt>0&&dataSplitInt<=9)
		        		jsonArr1="ITM00"+dataSplitInt;
		        	else if(dataSplitInt>9&&dataSplitInt<99)
		        		jsonArr1="ITM0"+dataSplitInt;
		        	else if(dataSplitInt>99)
		        		jsonArr1="ITM"+dataSplitInt;        	
        		}	        	
	        	$('#itemId').val(jsonArr1);	        	
	        },
	        error:function()
	        {
	        	console.log("Error");
	        }
		});
}


var itemByCategory = {
	    Assets: ["Gateway", "Sensors", "Power Supply", "Asset Tracker","IO Extender","Data Connectivity","Converter","Smart Lock","Wires"],
	    Equipments: ["Log Periodic Antennas", "Wire Antennas", "Travelling Wave Antennas", "Microwave Antennas","Reflector Antennas"],

	}
	
var classesByCategory = {
		ClassAStore: ["Gateway", "Sensors", "Power Supply", "Asset Tracker","IO Extender","Data Connectivity","Converter","Smart Lock","Wires"],
		ClassBStore: ["Log Periodic Antennas", "Wire Antennas", "Travelling Wave Antennas", "Microwave Antennas","Reflector Antennas"],
		ClassCStore: ["Log Periodic Antennas", "Wire Antennas", "Travelling Wave Antennas", "Microwave Antennas","Reflector Antennas"],

	}
	
var classes = {
		 Assets: ["Class A Store","Class B Store","Class C Store"],
		 Equipments: ["Class A Store","Class B Store","Class C Store"]

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

</script>
<body>
    <div align="center">
    <feildset>
        <legend>Item Master</legend>
        <form:form action="saveItem" method="post" modelAttribute="Item">
        <table>
            <form:hidden path="id"/>
            <tr height="25">
                <td>Item ID:</td>
                <td><form:input id="itemId" class="itemId" path="itemId" /></td>
            </tr>
            <tr height="25">
                <td>Assets/Equipments:</td>
                <td>
                	<form:select path="category" id="category" class="category" onblur="changeCat(this.value)">
               		 <form:option value="Assets">Assets</form:option>
              		 <form:option value="Equipments">Equipments</form:option>
                	</form:select>
                </td>
            </tr>
            <tr height="25">
                <td>Category</td>
                <td><form:select path="categoryClasses" id="categoryClasses" class="categoryClasses" style="width: 173px;" onblur="changeCat(this.value)"></form:select></td>
            </tr>
            <tr height="25">
                <td>Item Type:</td>
                <td><form:select id="item_type" class="item_type" path="itemType" /></td>
            </tr>
            <tr height="25">
                <td>Item Name:</td>
                <td><form:input id="item_name" class="item_name" path="itemName" /></td>
            </tr> 
            <tr height="25">
                <td>Item Description:</td>
                <td><form:textarea path="itemDesc" id="itemDesc" rows = "3" cols = "20"/></td>
            </tr>
             <tr height="10"></tr>
            <tr>
                <td colspan="2" align="center"><input id="submit" type="submit" value="Add"></td>
            </tr>
        </table>
        </form:form>
        </feildset>
    </div>
</body>
</html>