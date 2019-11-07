package com.cyient.test;
import org.apache.log4j.Logger;

import com.cyient.model.AssetStock;

import java.io.*;
import java.sql.SQLException;
import java.util.*;

public class logger_test {
	   /* Get actual class name to be printed on */
	   static Logger log = Logger.getLogger(AssetStock.class.getName());
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		

		   

		      log.debug("Hello this is a debug message");
		      log.info("Hello this is an info message");
		   }
	
	}


