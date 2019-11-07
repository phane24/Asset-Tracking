<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <title>Inventory Management</title>
  <!-- plugins:css -->
  
      <link href='<c:url value="/resources/vendors/mdi/css/materialdesignicons.min.css" />' rel="stylesheet">
      <link href='<c:url value="/resources/vendors/base/vendor.bundle.base.css" />' rel="stylesheet">
 
  <!-- endinject -->
  <!-- plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->

 <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
 <link href='<c:url value="/resources/css/main.css" />' rel="stylesheet">
  <!-- endinject -->
   <link href='<c:url value="/resources/images/favicon.png" />' rel="stylesheet">
   <style>
    .error
    {
        color: #ff0000;
        font-weight: bold;
    }
    </style>
   
</head>

<script>

$(document).ready(function(){
    $(".isa_success").fadeOut(3000);
});

</script>
<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo">
                 <link href='<c:url value="/resources/images/favicon.png" />' rel="stylesheet">
              
                <img style="width:180px;height:45px;" src='<c:url value="/resources/images/logo.svg" />' alt="logo">
              </div>
              <h4>Hello! let's get started</h4>
              <h6 class="font-weight-light">Sign in to continue.
              <div align="center"><span class="isa_success">${status}</span>
              	<span class="isa_failure" style="color:red">${errMsg}</span>
              </div>
              <!--<form class="pt-3">-->
                      <form:form action="validateUser" method="post" modelAttribute="User" class="pt-3">
              
                <div class="form-group">
                  <!--  <input type="email" class="form-control form-control-lg" id="exampleInputEmail1" placeholder="Username">-->
                  <form:input class="form-control form-control-lg" path="username" placeholder="Username"/>
<%--                    <td><span class="isa_failure" style="color:red">${username}</span></td> --%>
					<td><form:errors path="username" cssClass="error" /></td>
                </div>
                <div class="form-group">
                <form:password path="password" class="form-control form-control-lg" placeholder="Password" />
<%--                                    <td><span class="isa_failure" style="color:red">${password}</span></td> --%>
                	<td><form:errors path="password" cssClass="error" /></td>
                <!--    <input type="password" class="form-control form-control-lg" id="exampleInputPassword1" placeholder="Password">-->
                </div>
                <div class="mt-3">
            <!--       <a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" href="../../index.html">SIGN IN</a>--> 
                  
                  <input id="submit" type="submit" value="SIGN IN" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">
                </div>
                        </form:form>
                
               <!--  <div class="my-2 d-flex justify-content-between align-items-center">
                  <div class="form-check">
                    <label class="form-check-label text-muted">
                      <input type="checkbox" class="form-check-input">
                      Keep me signed in
                    </label>
                  </div>
                  <a href="#" class="auth-link text-black">Forgot password?</a>
                </div>
               <div class="mb-2">
                  <button type="button" class="btn btn-block btn-facebook auth-form-btn">
                    <i class="mdi mdi-facebook mr-2"></i>Connect using facebook
                  </button>
                </div>-->
                <div class="text-center mt-4 font-weight-light">
                  Don't have an account? <a href="newUser" class="text-primary">Create</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="../../vendors/base/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- inject:js -->
  <script src="../../js/off-canvas.js"></script>
  <script src="../../js/hoverable-collapse.js"></script>
  <script src="../../js/template.js"></script>
  <!-- endinject -->
</body>

</html>
