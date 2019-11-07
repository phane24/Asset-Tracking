<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<% 

String filePath= "D://webnms/Weekly Project Status Report (28-03-2019).xlsx";

out.println(filePath.lastIndexOf("/"));
String filename=filePath.substring(filePath.lastIndexOf("/"),filePath.length());

  response.setContentType("APPLICATION/OCTET-STREAM");   
  response.setHeader("Content-Disposition", "attachment; filename=\""
				+ filename + "\"");  
  
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filePath);  
           
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
    out.write(i);   
  }   
  fileInputStream.close();   
%> 