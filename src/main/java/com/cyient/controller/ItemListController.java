package com.cyient.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.AssetDAO;
import com.cyient.model.IndentData;
import com.cyient.model.IndentTracker;
import com.cyient.model.InstallationTracker;

import java.util.*;

@Controller
@RequestMapping("/")
public class ItemListController {
	@Autowired
	private AssetDAO assetDAO;
			
	@RequestMapping(value="/fetchSiteIds" , method = RequestMethod.GET)
	public ModelAndView ModelAndView(@RequestParam  String siteId,ModelAndView model,RedirectAttributes redirectAttributes){
	IndentTracker it=new IndentTracker();

		System.out.println("selecte site id.............."+siteId);
		model.addObject("siteids",siteId);
		String s=siteId;
		model.addObject("indentTracker",it);
		
		java.util.List<IndentTracker> siteitemList=assetDAO.getSiteItemList(s);
		System.out.println("site iem list ..................."+siteitemList.get(0));
		model.addObject("itemList", siteitemList);
		model.setViewName("siteItemList");			
		return model;
	}
		
	@ModelAttribute("siteIds")
	public List getIndentIds() {
		Map<String, String> indentsMap = new HashMap<String, String>();
		List<IndentData> siteids = assetDAO.fetchsiteIds();
//		for(IndentData indent : indents)
//		{
//			indentsMap.put(indent.getIndentId(), indent.getIndentId());
//		}
		return siteids;
	}

	@RequestMapping("/newSiteItemList")
	public ModelAndView siteItemList(ModelAndView model){
		IndentTracker it=new IndentTracker();
		model.addObject("indentTracker",it);
		//model.addObject("itemList", siteitemList);
		model.setViewName("siteItemList");
		return model;
		
	}
	@RequestMapping("/newWarehouseItemList")
	public ModelAndView warehouseItemList(ModelAndView model){
		
 		List<InstallationTracker> warehouseitemList=assetDAO.getwarehouseItemList();
		//System.out.println("site iem list ..................."+warehouseitemList.get(0));
		if(warehouseitemList.isEmpty())
		{
			model.addObject("emptyList","No data");
		}
		else
		{
			model.addObject("itemList", warehouseitemList);
		
		}
		//model.addObject("itemList", siteitemList);
		model.setViewName("warehouseItemList");
		return model;
		
	}
	@RequestMapping(value="/detailwarehouselist",method = RequestMethod.GET)
	public ModelAndView detailwarehouseList(@RequestParam("type")  String itemType,ModelAndView model,RedirectAttributes redirectAttributes){
		
		System.out.println("selecte tyoe.............."+itemType);
		
		String type=itemType;
		List<InstallationTracker> detailwarehouseitemList=assetDAO.getdetailwarehouseItemList(type);
		model.addObject("itemList", detailwarehouseitemList);
		model.setViewName("detailwarehouseItemList");


		
		
		return model;
		
	}
	
	
	
	
	
	

}
