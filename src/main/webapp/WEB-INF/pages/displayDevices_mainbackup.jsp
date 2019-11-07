<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Majestic Admin</title>
  <!-- plugins:css -->
       <link href='<c:url value="/resources/vendors/mdi/css/materialdesignicons.min.css" />' rel="stylesheet">
      <link href='<c:url value="/resources/vendors/base/vendor.bundle.base.css" />' rel="stylesheet">
  <!-- endinject -->
  <!-- plugin css for this page -->
        <link href='<c:url value="/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.css" />' rel="stylesheet">

  <!-- End plugin css for this page -->
  <!-- inject:css -->
 <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
  <!-- endinject -->
  <link rel="shortcut icon" href='<c:url value="/resources/images/favicon.png" />' />
</head>
<body>
  <div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
            <div class="navbar-brand-wrapper d-flex justify-content-center">
        <div class="navbar-brand-inner-wrapper d-flex justify-content-between align-items-center w-100">  
          <a class="navbar-brand brand-logo" href="validateUser"><img src='<c:url value="/resources/images/logo.svg" />' alt="logo"></a>
          <a class="navbar-brand brand-logo-mini" href="validateUser"><img src='<c:url value="/resources/images/logo-mini.svg" />' alt="logo"></a>
          <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
            <span class="mdi mdi-sort-variant"></span>
          </button>
        </div>  
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
        <ul class="navbar-nav mr-lg-4 w-100">
          <li class="nav-item nav-search d-none d-lg-block w-100">
            <div class="input-group">
              <div class="input-group-prepend">
                <span class="input-group-text" id="search">
                  <i class="mdi mdi-magnify"></i>
                </span>
              </div>
              <input type="text" class="form-control" placeholder="Search now" aria-label="search" aria-describedby="search">
            </div>
          </li>
        </ul>
        <ul class="navbar-nav navbar-nav-right">
          <li class="nav-item dropdown mr-1">
            <a class="nav-link count-indicator dropdown-toggle d-flex justify-content-center align-items-center" id="messageDropdown" href="#" data-toggle="dropdown">
              <i class="mdi mdi-message-text mx-0"></i>
              <span class="count"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="messageDropdown">
              <p class="mb-0 font-weight-normal float-left dropdown-header">Messages</p>
              <a class="dropdown-item">
                <div class="item-thumbnail">
                    <img src="images/faces/face4.jpg" alt="image" class="profile-pic">
                </div>
                <div class="item-content flex-grow">
                  <h6 class="ellipsis font-weight-normal">David Grey
                  </h6>
                  <p class="font-weight-light small-text text-muted mb-0">
                    The meeting is cancelled
                  </p>
                </div>
              </a>
              <a class="dropdown-item">
                <div class="item-thumbnail">
                    <img src="images/faces/face2.jpg" alt="image" class="profile-pic">
                </div>
                <div class="item-content flex-grow">
                  <h6 class="ellipsis font-weight-normal">Tim Cook
                  </h6>
                  <p class="font-weight-light small-text text-muted mb-0">
                    New product launch
                  </p>
                </div>
              </a>
              <a class="dropdown-item">
                <div class="item-thumbnail">
                    <img src="images/faces/face3.jpg" alt="image" class="profile-pic">
                </div>
                <div class="item-content flex-grow">
                  <h6 class="ellipsis font-weight-normal"> Johnson
                  </h6>
                  <p class="font-weight-light small-text text-muted mb-0">
                    Upcoming board meeting
                  </p>
                </div>
              </a>
            </div>
          </li>
          <li class="nav-item dropdown mr-4">
            <a class="nav-link count-indicator dropdown-toggle d-flex align-items-center justify-content-center notification-dropdown" id="notificationDropdown" href="#" data-toggle="dropdown">
              <i class="mdi mdi-bell mx-0"></i>
              <span class="count"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="notificationDropdown">
              <p class="mb-0 font-weight-normal float-left dropdown-header">Notifications</p>
              <a class="dropdown-item">
                <div class="item-thumbnail">
                  <div class="item-icon bg-success">
                    <i class="mdi mdi-information mx-0"></i>
                  </div>
                </div>
                <div class="item-content">
                  <h6 class="font-weight-normal">Application Error</h6>
                  <p class="font-weight-light small-text mb-0 text-muted">
                    Just now
                  </p>
                </div>
              </a>
              <a class="dropdown-item">
                <div class="item-thumbnail">
                  <div class="item-icon bg-warning">
                    <i class="mdi mdi-settings mx-0"></i>
                  </div>
                </div>
                <div class="item-content">
                  <h6 class="font-weight-normal">Settings</h6>
                  <p class="font-weight-light small-text mb-0 text-muted">
                    Private message
                  </p>
                </div>
              </a>
              <a class="dropdown-item">
                <div class="item-thumbnail">
                  <div class="item-icon bg-info">
                    <i class="mdi mdi-account-box mx-0"></i>
                  </div>
                </div>
                <div class="item-content">
                  <h6 class="font-weight-normal">New user registration</h6>
                  <p class="font-weight-light small-text mb-0 text-muted">
                    2 days ago
                  </p>
                </div>
              </a>
            </div>
          </li>
          <li class="nav-item nav-profile dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
              <img src="images/faces/face5.jpg" alt="profile"/>
              <span class="nav-profile-name">${sessionScope.userName}</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
              <a class="dropdown-item">
                <i class="mdi mdi-settings text-primary"></i>
                Settings
              </a>
              <a class="dropdown-item" href="logout">
                <i class="mdi mdi-logout text-primary"></i>
                Logout
              </a>
            </div>
          </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="mdi mdi-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_sidebar.html -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="validateUser">
              <i class="mdi mdi-home menu-icon"></i>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <i class="mdi mdi-circle-outline menu-icon"></i>
              <span class="menu-title">UI Elements</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Buttons</a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/ui-features/typography.html">Typography</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/forms/basic_elements.html">
              <i class="mdi mdi-view-headline menu-icon"></i>
              <span class="menu-title">Form elements</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/charts/chartjs.html">
              <i class="mdi mdi-chart-pie menu-icon"></i>
              <span class="menu-title">Charts</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/tables/basic-table.html">
              <i class="mdi mdi-grid-large menu-icon"></i>
              <span class="menu-title">Tables</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/icons/mdi.html">
              <i class="mdi mdi-emoticon menu-icon"></i>
              <span class="menu-title">Icons</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
              <i class="mdi mdi-account menu-icon"></i>
              <span class="menu-title">User Pages</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="pages/samples/login.html"> Login </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/login-2.html"> Login 2 </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/register.html"> Register </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/register-2.html"> Register 2 </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/lock-screen.html"> Lockscreen </a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="documentation/documentation.html">
              <i class="mdi mdi-file-document-box-outline menu-icon"></i>
              <span class="menu-title">Documentation</span>
            </a>
          </li>
        </ul>
      </nav>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
          <div class="row">
            <div class="col-md-12 grid-margin">
              <div class="d-flex justify-content-between flex-wrap">
                <div class="d-flex align-items-end flex-wrap">
                  <div class="mr-md-3 mr-xl-5">
                    <h2>Welcome back,</h2>
                    <p class="mb-md-0">Your dashboard </p>
                  </div>

                </div>
                <div class="d-flex justify-content-between align-items-end flex-wrap">
                  <button type="button" class="btn btn-light bg-white btn-icon mr-3 d-none d-md-block ">
                    <i class="mdi mdi-download text-muted"></i>
                  </button>
                  <button type="button" class="btn btn-light bg-white btn-icon mr-3 mt-2 mt-xl-0">
                    <i class="mdi mdi-clock-outline text-muted"></i>
                  </button>
                  <button type="button" class="btn btn-light bg-white btn-icon mr-3 mt-2 mt-xl-0">
                    <i class="mdi mdi-plus text-muted"></i>
                  </button>
                  <button class="btn btn-primary mt-2 mt-xl-0">Download report</button>
                </div>
              </div>
            </div>
          </div>

         
		 
		 
		 
		 
		 
		 
		 <!-- custom board-->
		 
		  <% String s = session.getAttribute("userName").toString(); %>

    <% if (s.equals("finance")) { %> 
     
<div align="center">
<legend>Finance Approval</legend>
		
		<table border="1">
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
		</table>

</div>

   <% }%>  
   
   
   <% if (s.equals("siteAdmin")) { %> 
	
	<legend align="center">Site Admin Display</legend>
	<table align="center">
	<br/><br/><br/>
	<tr>
	<td align="center" >
	 <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/images/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Indent</h4>
       <!--   <a href="newIndent" class="btn btn-primary">GO</a> -->
       <a href="newIndent" class="goButton">GO</a>
    </div>
  </div>
  </td>
  <td width="15px"></td>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="/UseCases/logo.png" alt="Card image" style="width:100%"> -->
    <div class="card-body">
      <h4 class="card-title">Order Acknowledgement</h4>
      <!-- <p class="card-text">Approval</p>-->
      <a href="newOrderAcknow" class="goButton">GO</a>
    </div>
  </div>
  </td>
  </tr>
  <tr height="20px"></tr>
  <tr>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
   <!--  <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%"> -->
    <div class="card-body">
      <h4 class="card-title">Asset Installation</h4>
        <a href="newAssetInstallation" class="goButton">GO</a>
    </div>
  </div>
	</td>
	<td width="15px"></td>
	<td align="center" >
   <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Equipment Installation</h4>
        <a href="newEquipInstallation" class="goButton">GO</a>
    </div>
  </div>
	</td>
	</tr>
	</table>
	  <% }%>  
   
	
	 <% if (s.equals("warehouseAdmin")) { %> 
	
	<legend align="center">Warehouse Admin Display</legend>
	<table align="center">
	<br/><br/><br/>
	<tr>
	<td align="center" >
	 <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<c:url value="/resources/images/logo.png" />" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Items</h4>
         <a href="newItem" class="goButton">GO</a>
    </div>
  </div>
  </td>
  <td width="15px"></td>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
   <!--  <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%"> -->
    <div class="card-body">
      <h4 class="card-title">Vendors</h4>
      <!-- <p class="card-text">Approval</p>-->
      <a href="newVendor" class="goButton">GO</a>
    </div>
  </div>
  </td>
  </tr>
  <tr height="30px"></tr>
  <tr>
  <td align="center" >
   <div class="card" style="width:400px;height: 200px;">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Vendor Supplier</h4>
        <a href="newVendorSupplier" class="goButton">GO</a>
    </div>
  </div>
	</td>
	<td width="15px"></td>
	<td align="center" >
   <div class="card" style="width:400px;height: 200px;">
  <!--   <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Purchase Order</h4>
        <a href="newOrder" class="goButton">GO</a>
    </div>
  </div>
	</td>
	</tr>
	<tr height="30px"></tr>
	<tr>
	<td></td>
	<td align="center" >
	 <div class="card" style="width:400px;;height: 200px;align:center">
    <!-- <img class="card-img-top" src="<%=request.getContextPath()%>/UseCases/logo.png" alt="Card image" style="width:100%">-->
    <div class="card-body">
      <h4 class="card-title">Delivery Challan</h4>
         <a href="newDeliveryChallan" class="goButton">GO</a>
    </div>
  </div>
  </td>
  	</tr>
	</table>
	
	  <% }%> 

	  
	   <% if (s.equals("OperationsAdmin")) { %> 
	
	<div align="center">
<legend>Operations Approval</legend>
		
		<table border="1">
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
		</table>

</div>
	
	  <% }%> 

	  
	  
	  
	  <!-- ending-->
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
  
          </div>
          
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2018 <a href="https://www.urbanui.com/" target="_blank">Urbanui</a>. All rights reserved.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="mdi mdi-heart text-danger"></i></span>
          </div>
        </footer>
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
