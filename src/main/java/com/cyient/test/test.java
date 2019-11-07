package com.cyient.test;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.cyient.model.AssetStock;
import com.cyient.model.InstallationTracker;

public class test {

	public static void main(String[] args) {
		 SessionFactory sessionFactory = null;

		// TODO Auto-generated method stub
		/*String temp_id;
		int length = 0;
    	  for(int i=0;i<=100;i++)
    	  {
    		  int demo = 0;
    		if(length==0)
  	      {
  	    	  temp_id = "_" +"_"+""+"_"+"001";
  	    	  System.out.println("1");
  	      }
  	      else
  	      {
  	    	  if(length<9)
  	    	  {
  	    		  demo = length+1;
      	    	  temp_id = "_" +"_"+"_"+"_"+"00"+demo;
      	    	  System.out.println("2");

      	    	  
  	    	  }
  	    	  else if(length>=9 && length<99)
  	    	  {
  	    		  demo = length+1;
      	    	  temp_id = "_" +"_"+"-"+"_"+"0"+demo;
      	    	  System.out.println("3");
      	    	  System.out.println(temp_id);



  	    	  }
  	    	  else
  	    	  {
  	    		  demo = length+1;
      	    	  temp_id = "_" +"_"+"_"+"_"+demo;
      	    	  System.out.println("4");


      	    	  

  	    	  }	  
  	      }
      		System.out.println(temp_id);
    		length = length + 1;
    	  }

	}*/

	@SuppressWarnings("null")
	Criteria c = sessionFactory.getCurrentSession().createCriteria(AssetStock.class);
    c.add(Restrictions.eq("id",12));

    List tracker_list = c.list();
    System.out.println(tracker_list);
}
}
	


