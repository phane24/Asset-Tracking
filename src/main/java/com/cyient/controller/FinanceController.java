package com.cyient.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.AssetDAO;
import com.cyient.dao.FinanceDAO;
import com.cyient.model.Indent;
import com.cyient.model.IndentApproval;
import com.cyient.model.IndentTracker;
import com.cyient.model.InstallationTracker;

@Controller
@RequestMapping("/")
public class FinanceController {

	
	@Autowired
	private FinanceDAO financeDAO;
	
	@RequestMapping("/financeapprovals")
	public ModelAndView siteItemList(ModelAndView model){
		IndentTracker it=new IndentTracker();
		List<Indent> listIndent = financeDAO.getAllIndents();
		System.out.println("Indnent List "+listIndent);
		model.addObject("listIndent", listIndent);
		//model.addObject("indentTracker",it);
		//model.addObject("itemList", siteitemList);
		model.setViewName("financeApprovalList");
		return model;
		
	}
	
	@RequestMapping(value="/indenthistory")
	public ModelAndView IndentHistory(ModelAndView model){	
		model.setViewName("indenthistory");
		return model;
	}
	
	
	@RequestMapping(value="/approvedIndents")
	public ModelAndView ApprovedIndents(ModelAndView model){
		
		IndentApproval indentApproval= new IndentApproval();
		List <IndentApproval> approvalList=financeDAO.fetchApprovalsList();
		model.addObject("approvedIndent",approvalList);
		model.setViewName("indentApprovedList");
		
		return model;
	}
	@RequestMapping(value="/detailapprovedindent",method = RequestMethod.GET)
	public ModelAndView detailwarehouseList(@RequestParam("id")  String id,ModelAndView model,RedirectAttributes redirectAttributes){
		
		System.out.println("selecte id.............."+id);
		
		//String ID=id;
		List<IndentApproval> detailapprovedindentList=financeDAO.fetchDetailApprovedIndent(id);
		model.addObject("detailIndent", detailapprovedindentList);
		model.setViewName("detailApprovedIndent");

		
		return model;
		
	}
	
	@RequestMapping(value="/rejectedIndents")
	public ModelAndView RejectedIndents(ModelAndView model){
		
		IndentApproval indentApproval= new IndentApproval();
		List <IndentApproval> rejectedlList=financeDAO.fetchRejectedList();
		model.addObject("rejectedIndent",rejectedlList);
		model.setViewName("indentRejectedList");
		
		return model;
	}
	
}
