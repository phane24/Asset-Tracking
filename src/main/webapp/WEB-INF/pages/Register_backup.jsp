
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<spring:url value="resources/css/styling.css" var="mainCss" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Register</title>
	<link href="${mainCss}" rel="stylesheet" />
	
	
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

.goButton{

 background-color: #00b1bf; 
  border-radius: 25px;
  border: 2px solid white;
  color: white;
  padding: 6px 26px;
  text-align: center;
 
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

<spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
<spring:url value="/resources/js/jquery.min.js" var="jqueryJs" />
	<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryuiJs" />
		<spring:url value="/resources/js/validations.js" var="validationsJs" />
		
		<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
	
	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
     <script src="${validationsJs}"></script>

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
    <div align="center">
    <feildset>
        <legend>Registration</legend>
        <form:form action="saveUser" method="post" modelAttribute="User">
        <table width="450px">
            <form:hidden path="id"/>
            <tr height="25">
                <td>User Name:</td>
                <td><form:input id="userName" path="username"/></td>
            </tr>
            <tr height="25">
                <td>Email:</td>
                <td><form:input id="emailId" path="emailId" onchange="validateEmailId(this.value,this.id)" /></td>
            </tr>           
            <tr height="25">
                <td>Mobile Number:</td>
                <td><form:input id="mobileNum" path="mobileNumber" onkeypress="return isNumber(event);" onchange="ValidateNumber(this.id)" /></td>
            </tr>
             <tr height="25">
                <td>Password:</td>
                <td><form:password id="pwd" path="password" /></td>
            </tr>
            <tr height="25">
                <td>Confirm Password:</td>
                <td><form:password id="cpwd" path="" onchange="validatePassword()" /></td>
            </tr>
             <tr height="25">
                <td>Team:</td>
                <td>
                	<form:select path="team"  style="width: 174px;" >
		                <form:option value="Communications"/>
		                <form:option value="Utilities"/>
		            </form:select>
                </td>
            </tr>             
                <form:hidden path="createdDate" id="createdDate" value="" />
                <tr height="10"></tr>       
	            <tr align="right">
	                <td><input id="submit" type="submit" value="Register"></td>
	            </tr>
        </table>
        </form:form>
        </feildset>
    </div>
</body>
</html>