<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<div align="center">
	<legend align="center" style="font-size: 30px;color: dimgrey;"><b>Operations Admin Display</b></legend>
		
	<!-- 	<table border="1">
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
		</table> -->
		
		<div class="col-lg-12 grid-margin stretch-card" >
              <div class="card">
                <div class="card-body">
                  
                  <div class="table-responsive">
                    <table class="table">
                      <thead>
                        <tr>
<th>Indent ID</th>
				<th>Site Id</th>	
				<th>Item Name</th>	
				<th>Quantity</th>	
				<th>Stock In Hand</th>
				<th>Requested Date</th>				
				<th>Action</th>		
				
                        </tr>
                      </thead>
                      <tbody>
<c:forEach var="indent" items="${listIndent}">
				<tr>

					<td>${indent.indentId}</td>
					<td>${indent.siteId}</td>
					<td>${indent.itemName}</td>
					<td>${indent.quantity}</td>
					<td>${indent.stockInHand}</td>
					<td>${indent.reqDate}</td>
					<td><a href="saveStatus?indentId=${indent.indentId}&status=Approved"><button class="btn btn-outline-success btn-fw">Approve</button></a> 
 						&nbsp;&nbsp;&nbsp;&nbsp;<a href="saveStatus?indentId=${indent.indentId}&status=Reject"><button class="btn btn-outline-danger btn-fw">Reject</button></a> 
 					</td>

				</tr>
			</c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>	
</div>

</body>
</html>