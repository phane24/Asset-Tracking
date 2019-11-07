package com.cyient.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.AssetDAO;
import com.cyient.model.Item;
import com.cyient.model.Store_Details;

@Controller
@RequestMapping
public class SubWarehouseController {
	@Autowired
	private AssetDAO assetDAO;
	
	@RequestMapping(value="storeDet")
	  public ModelAndView storeDetailsForm(ModelAndView model){
		
		  model.addObject("Store_Details",new Store_Details());
		  model.setViewName("storeDetails");
		  return model;
	  }
	
	@RequestMapping(value="/saveStoreDetails", method = RequestMethod.POST)
	public ModelAndView saveStoreDetail(@ModelAttribute("Store_Details") Store_Details storeDetails,RedirectAttributes redirectAttributes){
	
		
			//StoreDetails sDetails= new StoreDetails();
		assetDAO.addStoreDetails(storeDetails);
		
		redirectAttributes.addFlashAttribute("succMsg","Added Successfully");
		
		return new ModelAndView("redirect:/storeDet");
	}
	
}
