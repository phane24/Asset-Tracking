
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
<style>
.multiselect {
  width: 200px;
}

.selectBox {
  position: relative;
}

.selectBox select {
  width: 100%;
  font-weight: bold;
}

.overSelect {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
}

.checkboxes {
  display: none;
  border: 1px #dadada solid;
}

.checkboxes label {
  display: block;
}

</style>
<script>


$(document).ready(function(){


	$('#poId').attr('readonly',true); 
 });
 
$(function(){
	$('#datepick2').datepicker({
		dateFormat:"dd/mm/yy",
	})
	});



var jsonArr=[];
var assOrEqu;
function getCategoryItems(selectedCategory)
{
	alert(selectedCategory);
	$.ajax({
        type:"get",
        url:"getCategoryItems",
        contentType: 'application/json',
        datatype : "json",
        data:{"category":selectedCategory},
        success:function(data1) {
        	jsonArr = JSON.parse(data1);
        	alert(jsonArr);
        	//changeDrop(selectedCategory);
//         	if(selectedCategory=="Assets"){
//         		constructSelectOptions("Acheckboxes",jsonArr);
//         	}
        		
//         	else {
//         		constructSelectOptions("Echeckboxes",jsonArr);
//         	}
        	 changecat(jsonArr);
        	//changeDrop(selectedCategory);
        	//constructSelectOptions("Echeckboxes",jsonArr);
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function div_show(value,id)
{
	
 if(value == "assetCB")
 {
    document.getElementById('asset_div').style.display = "block";
	  document.getElementById('name').innerHTML = ""
	  document.getElementById('asset_options').style.display = "block";
	  document.getElementById('equip_options').style.display = "none";
	  document.getElementById("assets").value = id;
	  document.getElementById("equipments").value = "";
	  $('#form *').prop('readonly',true);
 }
 else
 {
 		document.getElementById('asset_div').style.display = "block";
 		document.getElementById('name').innerHTML = ""
 		document.getElementById('asset_options').style.display = "none";
 		document.getElementById("assets").value = "";
 		document.getElementById('equip_options').style.display = "block";
 	  	document.getElementById("equipments").value = id;
 	 	$('#form *').prop('readonly',true);
 }
 
 $('.close').on('click', function(){
     $('#asset_div').hide();
     $('#form *').prop('readonly',false);
     $("#"+id).prop('checked', false);    
	});
}

function constructSelectOptions(className,data)
{
  var options = "",assetsArray=[],vendorData=[];
 
  if(className=="vendor")
  	{
  		
  	for(var i=1;i<data.length;i++)
      {
  		vendorData.push(data[i].toUpperCase());
  		}
  	 data=_.uniq(vendorData);
  	}
  
  if(className=="Acheckboxes")
  	{
  	var htmlData="",assetsArray=[],dummyArray=[],Array=[],assArr=[];
  	  if(data!=undefined){
  		  for(var i=0;i<data.length;i++)
   		 {
				if(data[i]!=null)
				{
   			 assetsArray=data[i].split(",");
   			
   			for(var k=0;k<assetsArray.length;k++)

					{
						for(var j=0;j<dummyArray.length;j++)
						  {
								var Array=dummyArray[j].includes(assetsArray[k]);
								if(Array==true)
									var Array=assetsArray.splice(k, 1);
									
						 }
					}
					 for(var l=0;l<assetsArray.length;l++)
					 {
						 if(htmlData.includes(assetsArray[l]))
						{
							 
						}
						 else 
						 {
								 htmlData+="<label for='"+assetsArray[l]+"'><input type='checkbox' onclick='div_show(this.name,this.id);get_assets()' id='"+assetsArray[l]+"' name='assetCB' value='"+assetsArray[l]+"'/>"+assetsArray[l]+"</label>";
						 }
					 }
					 dummyArray=assetsArray;
  		 $("#"+className).html(htmlData);
  	 
				}
  	}
  	  }
  	}
  if(className=="Echeckboxes")
	{
	var htmlData="",equipsArray=[],dummyArray=[],Array=[],assArr=[];;
	  if(data!=undefined){
		  for(var i=0;i<data.length;i++)
		 {
				if(data[i]!=null)
				{
					equipsArray=data[i].split(",");
			// Array= _.filter(assetsArray, dummyArray, function(obj){ return _.intersection(assetsArray,dummyArray)});
			for(var k=0;k<equipsArray.length;k++)

					{
						for(var j=0;j<dummyArray.length;j++)
						  {
						var Array=dummyArray[j].includes(equipsArray[k]);
								if(Array==true)
									var Array=equipsArray.splice(k, 1);
									
							 }
					}
					 for(var l=0;l<equipsArray.length;l++)
					 {
						 if(htmlData.includes(equipsArray[l]))
						{
								 
						}
						 else
						 {						
		    				htmlData+="<label for='"+equipsArray[l]+"'><input type='checkbox' id='"+equipsArray[l]+"' name='equipCB' value='"+equipsArray[l]+"'/>"+equipsArray[l]+"</label>";
						 }
					 }
					 dummyArray=equipsArray;
		 $("#"+className).html(htmlData);
			}
	}
	  }
	}
  
  var optionValues =[];
  $('#Acheckboxes,#Echeckboxes option').each(function(){
     if($.inArray(this.value, optionValues) >-1){
        $(this).remove()
     }else{
        optionValues.push(this.value);
     }
  });
  
  if(className!="Echeckboxes" && className!="Acheckboxes")
  	{
  if(data!==undefined)
  {
	 options+="<option value=select>select</option>";
  for(var i=0;i<data.length;i++)
  {
   options += "<option value="+data[i]+">"+data[i]+"</option>"; //NO I18N
  }
  $("."+className).html(options);
  }
}
}

function changeDrop(value) {
	  
	  assOrEqu=value
	  if(value=="Assets")
	  {
		  document.getElementById("Acheckboxes").style.display = "block";
		  document.getElementById("Echeckboxes").style.display = "none";
	  }
	  else if(value=="Equipments")
	  {
		  document.getElementById("Echeckboxes").style.display = "block";
		  document.getElementById("Acheckboxes").style.display = "none";
	  }
	  
}

var expanded = false;
function showCheckboxes(ele) {
	  if(assOrEqu=="Assets")
		  var checkboxes = document.getElementById("Acheckboxes");
	  else if(assOrEqu=="Equipments")
		  var checkboxes = document.getElementById("Echeckboxes");
  if (!expanded) {
    checkboxes.style.display = "block";
    expanded = true;
  } else {
    checkboxes.style.display = "none";
    expanded = false;
  }
}


	    function changecat(value) {
	            var catOptions = "";
	            for (categoryId in jsonArr) {
	                catOptions += "<option>" + jsonArr[categoryId] + "</option>";
	            }
	            document.getElementById("categoryItemsSelect").innerHTML = catOptions;
	       
	    }

</script>
<body>
    <div align="center">
        <h1>Add Order</h1>
        <form:form action="addPurchaseOrder" method="post" modelAttribute="PurchaseOrder">
        <table>
         <form:hidden path="id"/>      
             <tr>
                <td>Purchase Order Id:</td>
                <td><form:input path="poId" id="poId" value=""/></td>
            </tr>           
            <tr>
                <td>Vendor Name:</td>
                <td>
<%--                 <form:select path="vendorName" id="vendors" class="vendors" items="vendorList"></form:select> --%>
					<form:select path = "vendorName">
	                     <form:option value = "none" label = "Select"/>
	                     <form:options items = "${vendorList}" />
                 	</form:select> 
                </td>
            </tr> 
            <tr>
                <td>Select Assets\Equipments</td>
                <td><form:select path="category" id="category" class="category" onblur="getCategoryItems(this.value);"  >
                		<form:option value="Assets">Assets</form:option>
                		<form:option value="Equipments">Equipments</form:option>
                	</form:select>
                </td>
            </tr>
            
             <tr>
                <td>Assets/Equipments:</td>
<%--                 <form:select path = "categoryAssets" multiple = "true" /> --%>
                <td> 
<!--                 <div class="multiselect"> -->
<!-- 				    <div class="selectBox" id="ass" onclick="showCheckboxes(this.id)"> -->
<%-- 				     <form:select path="categoryItems"> --%>
<!-- 				        <option value="Select">Select</option> -->
<%-- 				      </form:select> --%>
<!-- 				      <div class="overSelect"></div> -->
<!-- 				    </div> -->
<!-- 				    <div id="Acheckboxes" class="checkboxes" style="display:none"></div> -->
<!-- 				     <div id="Echeckboxes" class="checkboxes" id="equ" style="display:none"></div> -->
<!-- 				 </div>     -->

 					<form:select path = "categoryItems" id="categoryItemsSelect" class="categoryItemsSelect" multiple = "true" />
                </td>
            </tr> 
         
            
                       
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Add"></td>
            </tr>
        </table>
        </form:form>
    </div>
</body>
</html>