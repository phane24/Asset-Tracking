
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
</head>
<script type="text/javascript">

function validatePassword()
{
	if(document.getElementById('pwd').value==document.getElementById('cpwd').value)
		{}
	else {
		alert("Please Check");
		$('#cpwd').val('');
	}

}

$(document).ready(function(){	
	dateFun();
	$("#userName,#emailId,#mobileNum,#pwd,#cpwd").attr('required', '');  
});

function dateFun()
{
	var today = new Date();
// 	var dd = today.getDate();
// 	var mm = today.getMonth() + 1;
// 	var yyyy = today.getFullYear();

// 	if (dd < 10) {
// 	  dd = '0' + dd;
// 	}

// 	if (mm < 10) {
// 	  mm = '0' + mm;
// 	}

// 	today = dd + '/' + mm + '/' + yyyy;
	document.getElementById('createdDate').value=today;
}

</script>
<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo">
                <img src='<c:url value="/resources/images/logo.svg" />' alt="logo">
              </div>
              <h4>New here?</h4>
              <h6 class="font-weight-light">Signing up is easy. It only takes a few steps</h6>
                      <form:form action="saveUser" method="post" modelAttribute="User" class="pt-3">
              <form:hidden path="id"/>
              <form:hidden path="createdDate"/>
                <div class="form-group">
                 <!--   <input type="text" class="form-control form-control-lg" id="exampleInputUsername1" placeholder="Username">-->
                  <form:input id="userName" path="username" class="form-control form-control-lg" placeholder="Username"/>
                  <span id="errmsg" style="color:red" >${errMsg}</span>
                </div>
                <div class="form-group">
               
                  <form:input id="emailId" path="emailId" onchange="validateEmailId(this.value,this.id)" class="form-control form-control-lg" placeholder="Email" />
                </div>
                <div class="form-group">
      			 <form:input id="mobileNum" path="mobileNumber" onkeypress="return isNumber(event);" onchange="ValidateNumber(this.id)" class="form-control form-control-lg" placeholder="Mobile Number"/>
                </div>
                  <div class="form-group">
                  <form:select path="role"  class="form-control form-control-lg" >
		                <form:option value="SiteAdmin"/>
		                <form:option value="WarehouseAdmin"/>
		                <form:option value="FinanceAdmin"/>
		                <form:option value="OperationsAdmin"/>
		            </form:select>
                </div>
                <div class="form-group">
               <!--   <input type="password" class="form-control form-control-lg" id="exampleInputPassword1" placeholder="Password"> --> 
                  <form:password id="pwd" path="password" class="form-control form-control-lg" placeholder="Password"/>
                </div>
               <div class="form-group">
                  <form:password id="cpwd" path="" onchange="validatePassword()" class="form-control form-control-lg" placeholder="Re-Password"/>
                </div>
                 <div class="form-group">
                  <form:select path="team"  class="form-control form-control-lg" >
		                <form:option value="Warehouse"/>
		                <form:option value="Site"/>
		                <form:option value="Finance"/>
		                <form:option value="Operations"/>
		            </form:select>
                </div>
                
                
                
                
                <div class="mb-4">
                  <div class="form-check">
                    <label class="form-check-label text-muted">
                      <input type="checkbox" class="form-check-input">
                      I agree to all Terms & Conditions
                    </label>
                  </div>
                </div>
                <div class="mt-3">
                      <input id="submit" type="submit" value="SIGN UP" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">
                  
                </div>
                        </form:form>
                
                <div class="text-center mt-4 font-weight-light">
                  Already have an account? <a href="./" class="text-primary">Login</a>
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
