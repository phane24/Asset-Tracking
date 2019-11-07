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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
  
<style>
.grid { 
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  grid-gap: 20px;
  align-items: stretch;
  }
.grid > article {
  border: 1px solid #ccc;
  box-shadow: 2px 2px 6px 0px  rgba(0,0,0,0.3);
}
.grid > article img {
  max-width: 100%;
}
.text {
  padding: 0 20px 20px;
}
.text > button {
  background: gray;
  border: 0;
  color: white;
  padding: 10px;
  width: 100%;
  }
</style>
</head>

<script> 

$(function(){
	  //$("#header").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#sidebar").load('<c:url value="/resources/common/navbar.jsp" />'); 
	  $("#header_bar").load('<c:url value="/resources/common/header_bar.jsp" />'); 

	});

function sendImage(){
	
	
	var dcId=$("#dcId").val();
    html2canvas($("#dcView"), {
        onrendered: function(canvas) {
            theCanvas = canvas;
            //localStorage.setItem("myDC", canvas.toDataURL());
	            				var data = canvas.toDataURL();
					             image = data.replace("image/png", "image/octet-stream");
					             var link = document.createElement('a');
					             link.download = dcId;
					             link.href = image;
					             link.click(); 
					             saveData();
    }
}); 
}


function saveData()
{
	
	 var jsonStr = '{"items":[]}';
	 var obj = JSON.parse(jsonStr);
     var arrayReturn = [];
	
	//Setting all feilds to obj
	var dcId=$("#dcId").val();
    var indentId=$("#indentId").val();
    var siteName=$("#siteName").val();
    var siteId=$("#siteId").val();
	var dcDate=$("#dcDate").val();
	   
	   obj['items'].push({"dcId":dcId,"indentId":indentId,"siteName":siteName,"siteId":siteId,"dcDate":dcDate});
	   jsonStr = JSON.stringify(obj);
	   
	
 var url= "getDCWSImageAndSave";           
 $.ajax({  
	  
 	 type:"post",
 	 async:false,
 	 data:{input:jsonStr},
 	 dataType:"html",
 	 url:url,
    success: function(result){
      
      if(result=='success')
      {
    	alert("Added Successfully");
      	window.location.href = 'newWarehouseDC'
      }
    }
  }) 
 
} 
	
	
	
var indentArray = new Array();
indentArray.push(["Indent ID","Type", "Class Store","Name","Model No","Quantity","Requested Date"]);

$(document).ready(function(){
	$(".isa_success").fadeOut(5000);
	getDcId();
	 $('#dcId').attr('readonly',true); 
	 $('#dcId').addClass('input-disabled');
	 var today = new Date();
	 var today1=today.toISOString().split('T')[0];
	 $('#dcDate').val(today1);
	 $('#dcDate').attr('readonly',true);
	 $("select option[value='Select']").attr('disabled','disabled');
});
	 
function printDiv(divId) {
	var dcid=document.getElementById('dcId').value;
	var indentId=document.getElementById('indentId').value;
	var date=document.getElementById('dcDate').value;
	var siteName=document.getElementById('siteName').value;
    var printContents = document.getElementById(divId).innerHTML;
    var originalContents = document.body.innerHTML;
    document.body.innerHTML = "<html><head><title></title></head><body>" + printContents + "</body>";
    window.print();
    document.body.innerHTML = originalContents;
   // getDcId();
    $("#indentId").val(indentId);
    $("#dcDate").val(date);
    $("#dcId").val(dcid);
    $("#siteName").val(siteName);
  
}


var classArr=[],itemsArr=[];
var selectedCat;
function getCategoryClasses(selectedCategory)
{
	selectedCat=selectedCategory;
	$.ajax({
        type:"get",
        url:"getCategoryClasses",
        contentType: 'application/json',
        datatype : "json",
        data:{"category":selectedCategory},
        success:function(data1) {
        	classArr = JSON.parse(data1);       	
        	changeClass(selectedCategory);
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function getDcId()
{
	var jsonArr1;
	$.ajax({
        type:"get",
        url:"getWSLastChallanId",
        contentType: 'application/json',
        datatype : "json",
        success:function(data) {
        	var jsonArr=JSON.parse(data);	        	
        	 if(jsonArr.length==0){
	        		jsonArr1="DCWS001";
	        	}  	
        	 else{
	        	var dataSplit=jsonArr[0].split("S");
	        	console.log(dataSplit[1]);
	        	var dataSplitInt=parseInt(dataSplit[1]);
	        	console.log(dataSplitInt+1);
	        	dataSplitInt=dataSplitInt+1;
	        	
	        	if(dataSplitInt>0&&dataSplitInt<=9)
	        		jsonArr1="DCWS00"+dataSplitInt;
	        	else if(dataSplitInt>9&&dataSplitInt<99)
	        		jsonArr1="DCWS0"+dataSplitInt;
	        	else if(dataSplitInt>99)
	        		jsonArr1="DCWS"+dataSplitInt;        	
       		}	        	
        	$('#dcId').val(jsonArr1);
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}


function getSiteName()
{
	var jsonArr1;
	var indentId=document.getElementById('indentId').value;
	$.ajax({
        type:"get",
        url:"getSiteName",
        contentType: 'application/json',
        datatype : "json",
        data:{"IndentId":indentId},
        success:function(data1) {
        	var jsonArr=JSON.parse(data1);
        	$('#siteId').val(jsonArr[0]);	 
        	$('#siteName').val(jsonArr[1]);
        	 $('#siteName').attr('readonly',true); 
        	 $('#siteName').addClass('input-disabled');
        	 viewDelChallan();
        },
        error:function()
        {
        	console.log("Error");
        }
	});
}

function viewDelChallan()
{	
	getView();
	getIndentData();
}

function getView()
{
	  var siteId=$("#siteId").val();
	  var siteName=$('#siteName').val();
	  
			   document.getElementById('dcView').style.display = 'block';
			   var options="";
					   options+="<tr><TD height='25' align=left width='120'><b>To</b></TD></tr><tr><TD height='25' align=left width='120'>"+siteId+"</TD></tr><tr><TD height='25' align=left width='120'>"+siteName+"</TD></tr>"
			   $("#dcTo").html(options);
			  
	   
	  
}

function getIndentData(){
	var total=0;
	indentIdVal=$('#indentId').val();
	$.ajax({
		  type:"get",
	        url:"getIndentDetails",
	        contentType: 'application/json',
	        datatype : "json",
	        data:{"indentId":indentIdVal},
	        success:function(data1) {
        	var jsonArr1 = $.parseJSON(data1);
		    console.log(jsonArr1);
		   
		  var arr=[];
		  for(var i=0;i<jsonArr1.length;i++)
		  {
			  if(jsonArr1[i]!='--')
			  {
				   
					arr.push(jsonArr1[i]);
			  }
				else
				{
					
					indentArray.push(arr);
					arr=[];
				}
				
		   }
		  
		  for(var i=1;i<indentArray.length;i++)
		  {
				  total=total+[i][6];
		  }
		  
		  GenerateTable();
      }
   });
}
 
function GenerateTable() {
    //Build an array containing Customer records.
   
//     indentArray.push([1, "John Hammond", "United States"]);

 
    //Create a HTML Table element.
    var table = document.createElement("TABLE");
	var totalCount=0,taxCount=0;
    table.border = "1";
    table.width="100%"
 
    //Get the count of columns.
    var columnCount = indentArray[0].length;
 
    //Add the header row.
    var row = table.insertRow(-1);
    for (var i = 0; i < columnCount; i++) {
        var headerCell = document.createElement("TH");
        headerCell.innerHTML = indentArray[0][i];
        row.appendChild(headerCell);
    }
 
    //Add the data rows.
    for (var i = 1; i < indentArray.length; i++) {
        row = table.insertRow(-1);
        for (var j = 0; j < columnCount; j++) {
            var cell = row.insertCell(-1);
            cell.innerHTML = indentArray[i][j];			
        }
	
    }

    var dvTable = document.getElementById("delChallantbl");
    dvTable.innerHTML = "";
    if($('div#dcView table')[3]!=undefined)
    	$('div#dcView table')[3].remove();
    dvTable.appendChild(table);
    indentArray = [];
    indentArray.push(["Indent ID","Type", "Class Store","Name","Model No","Quantity","Requested Date"]);
}

</script>

<body>
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
		 <!-- custom board-->
      <!--   <form:form action="saveWarehouseDC" method="post" modelAttribute="warehouse_DC"> -->
        <div class="col-md-6 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                   <h4 class="card-title" style="color:darkgrey;font-size:1.845rem;"><center>Delivery Challan (Warehouse-Site)</center></h4>
                  <div align="center"><span class="isa_success">${status}</span></div>
                  <p class="card-description">
                  </p>
                  	 <form:hidden path="id"/>  
          				<form:hidden path="siteId" value=""/>  
          				
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">DC Id</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="dcId"  path="dcId" class="form-control" placeholder="DC ID"/>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputEmail2" class="col-sm-3 col-form-label">Indent Id</label>
                      <div class="col-sm-9">
                      
                       <form:select  id="indentId" path="indentId" placeholder="Indent Id" class="form-control" onchange="getSiteName();">
                       	<form:option value="Select">Select</form:option>
                       		<form:options items = "${indentIdsInDC}"></form:options>
                		</form:select>
                      </div>
                    </div>
                    
                    <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">Site Name</label>
                      <div class="col-sm-9">
                      <form:input type="text" id="siteName"  path="siteName" class="form-control" placeholder="Site Name" />
                      </div>
                    </div>
                    
                      <div class="form-group row">
                      <label for="exampleInputUsername2" class="col-sm-3 col-form-label">DC Date</label>
                      <div class="col-sm-9">
                      <form:input type="date" id="dcDate"  path="dcDate" class="form-control" placeholder="dd/mm/yyyy" />
                      </div>
                    </div>
                    
                <!--    <button  id="view "  type="button" class="btn btn-primary mr-2" value="View" onclick="viewDelChallan()">View</button>-->
                    <button type="button" class="btn btn-right" onclick="sendImage();" id="send">Send</button>
                    <button id="print" class="btn btn-primary mr-2" value="Print" onclick="printDiv('dcView')" type="button">Print</button>
                    <!-- <button type="submit" class="btn btn-light">Save</button> -->
       <!--  </form:form> -->
    </div>
   
     <div id="dcView" style="display:none;">
     </br></br>
       <div id="dcDiv" class="center" style="border:2px solid black;height:260px;">
       <table cellSpacing=0 cellPadding=4 width=50% border=0 id="dcFrom" align="left"  style="margin-top:10px;margin-bottom:10px;" >
      	<tr><TD height='25' align=left width='120'><b>From</b></TD></tr>
      <tr><TD height='25' align=left width='120'>Warehouse</TD></tr>
      <tr><TD height='25' align=left width='120'>Madhapur</TD></tr>
      <tr><TD height='25' align=left width='120'>Hyderabad</TD></tr>
       </table>
     
       <table cellSpacing=0 cellPadding=4 width=50% border=0 id="dcTo" align="right" style="margin-top:10px;margin-bottom:10px;" >
      
       </table>
<br><br>
<br>      <br>
           
          </div>
           <table id="delChallantbl" class="table" style="width:100%"></table>
           
              </div>
            </div>	  
	  <!-- ending-->
		 </div>
          
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
       <!--  <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright Â© 2018 <a href="https://www.urbanui.com/" target="_blank">Urbanui</a>. All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="mdi mdi-heart text-danger"></i></span>
          </div>
        </footer>
        -->
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- plugins:js -->
 <link href='<c:url value="/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.css" />' rel="stylesheet">
 
  <script src='<c:url value="/resources/vendors/base/vendor.bundle.base.js" />'></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <script src='<c:url value="/resources/vendors/chart.js/Chart.min.js"/>'></script>
  <script src='<c:url value="/resources/vendors/datatables.net/jquery.dataTables.js"/>' ></script>
  <script src='<c:url value="/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.js"/>'></script>
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src='<c:url value="/resources/js/off-canvas.js"/>'></script>
  <script src='<c:url value="/resources/js/hoverable-collapse.js"/>'></script>
  <script src='<c:url value="/resources/js/template.js"/>'></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src='<c:url value="/resources/js/dashboard.js"/>'></script>
  <script src='<c:url value="/resources/js/data-table.js"/>'></script>
  <script src='<c:url value="/resources/js/jquery.dataTables.js"/>'></script>
  <script src='<c:url value="/resources/js/dataTables.bootstrap4.js"/>'></script>
  <!-- End custom js for this page-->
  
</body>
</html>