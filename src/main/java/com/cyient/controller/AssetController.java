package com.cyient.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.HttpMethodConstraint;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.Query;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpRequest;
import org.springframework.http.MediaType;
import org.springframework.http.client.support.HttpRequestWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.model.AssetInstallation;
import com.cyient.model.AssetStock;
import com.cyient.model.DeliveryChallan;
import com.cyient.model.waerhouseDeliveryChallan;
import com.cyient.model.Device;
import com.cyient.model.EquipInstallation;
import com.cyient.model.EquipStock;
import com.cyient.model.Indent;
import com.cyient.model.IndentApproval;
import com.cyient.model.IndentData;
import com.cyient.model.Item;
import com.cyient.model.ItemTracker;
import com.cyient.model.OrderAcknowledgement;
import com.cyient.model.PurchaseOrder;
import com.cyient.model.PurchaseOrderAssets;
import com.cyient.model.PurchaseOrderEquips;
import com.cyient.model.PurchaseRequest;
import com.cyient.model.Site;
import com.cyient.model.User;
import com.cyient.model.VendorReg;
import com.cyient.model.VendorSupplier;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import javassist.compiler.NoFieldException;

import com.cyient.dao.AssetDAO;
import com.cyient.dao.FinanceDAO;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.mail.SimpleMailMessage;

@Controller
@RequestMapping
public class AssetController{

	private static final Logger logger = Logger
			.getLogger(AssetController.class);

	public AssetController() {
		System.out.println("AssetController()");

	}

	@Autowired
	private AssetDAO assetDAO;
	
	@Autowired
	private FinanceDAO financeDAO;
	
	@Autowired
	private JavaMailSender mailSender;
	
	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	Date date = new Date();
	//System.out.println(dateFormat.format(date)); 

	@RequestMapping(value = "/")
	public ModelAndView listEmployee(ModelAndView model) throws IOException {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("home");
		return model;
	}

	@RequestMapping("favicon.ico")
	String favicon() {
		return "forward:/resources/images/favicon.ico";
	}

	@RequestMapping(value = "/newUser", method = RequestMethod.GET)
	public ModelAndView newContact(ModelAndView model) {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("Register");
		return model;
	}

	@RequestMapping(value = "/newOrderAcknow", method = RequestMethod.GET)
	public ModelAndView redirectOrderAcknow(ModelAndView model,HttpSession session) {
		OrderAcknowledgement orderAcknow = new OrderAcknowledgement();
		
		String name=(String) session.getAttribute("userName");
	      System.out.println(" username->>>>>>>>>>>>>>>>>>>>>>........"+name);
	     List siteIds= assetDAO.fetchsiteIdsByUsername(name);
		
		model.addObject("siteId",siteIds);
		model.addObject("OrderAck", orderAcknow);
		model.setViewName("orderAcknowledgement");
		return model;
	}
	@RequestMapping(value= "getIndentIdBySiteId", method = RequestMethod.GET)		
	@ResponseBody		
	public String getIndentIdbySite(@RequestParam("") String sid,HttpServletRequest request) {		
		System.out.println("sid>>>>>>>>>>>>>>>>>>>>>>>>>>>"+sid);
		List<IndentApproval> indentDataList = assetDAO.fetchIndentIdBySiteId(sid);	
		System.out.println(indentDataList);		
		Gson gsonBuilder = new GsonBuilder().create();		
		String siteJson = gsonBuilder.toJson(indentDataList);		
		return siteJson.toString();		
	}
	@RequestMapping(value = "/homePage", method = RequestMethod.GET)
	public ModelAndView newhomepage(ModelAndView model) {
		List<Indent> listIndent = assetDAO.getAllIndents();
		System.out.println("Idennt List "+listIndent);
		model.addObject("listIndent", listIndent);
		model.setViewName("displayDevices");
		return model;
	}
/*
	@RequestMapping(value = "/validateUser", method = RequestMethod.POST)
	public ModelAndView checkUser(@ModelAttribute User user,ModelAndView model, HttpSession session,HttpServletRequest request) {
		List <User>resp = assetDAO.getAllUsersOnCriteria(user.getUsername(),user.getPassword());        
		if(resp==null)
		{
			assetDAO.custom_logger(dateFormat.format(date)+" ==> "+"Sorry, something wrong with username and password!");
			//logger.error("Sorry, something wrong with username and password!");
			return new ModelAndView("redirect:/");
		}
		else
		{      
			session=request.getSession();
			
			session.setAttribute("userName",user.getUsername());
			assetDAO.custom_logger(dateFormat.format(date)+" ==> "+"User "+user.getUsername()+" Logged.");

			System.out.println(user.getUsername());
			if(user.getUsername().equalsIgnoreCase("OperationsAdmin")||user.getUsername().equalsIgnoreCase("financeAdmin"))
			{
				List<Indent> listIndent = assetDAO.getAllIndents();
				System.out.println("Idnent List "+listIndent);
				model.addObject("listIndent", listIndent);
			}
			List<Device> listDevice = assetDAO.getAllDevices();
			model.addObject("listDevice", listDevice);
			List<PurchaseRequest> purReq = assetDAO.getAllRequests();
			model.addObject("RequestNumber", purReq);        	   
			model.setViewName("displayDevices");
			return model;
		}

	}*/

	@RequestMapping(value = "/validateUser", method = RequestMethod.POST)
	public ModelAndView checkUser(@Valid @ModelAttribute("User") User user,BindingResult result,ModelAndView model, SessionStatus status,HttpSession session,HttpServletRequest request,RedirectAttributes redirectAttributes)
	{
		
		System.out.println("user>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+user.getUsername());
		System.out.println("user>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+result);

		if(result.hasErrors()){
			
			redirectAttributes.addFlashAttribute("errMsg", " Username or Password Cannot be empty ");

			return new ModelAndView("redirect:/");
		}else{
		/*boolean error=false;
		
		System.out.println(user);
		if(user.getUsername().isEmpty()){
			result.rejectValue("username","username cannot be empty");
			error=true;
		}
		if(user.getPassword().isEmpty()){
			result.rejectValue("password", "Password cannot be empty");
			System.out.println("login validation.......................................................");
			error=true;
		}
		if(error){*/
		
		List <User> resp = assetDAO.getAllUsersOnCriteria(user.getUsername(),user.getPassword());        
		System.out.println("response login 1 ------------------>"+resp);
		if(resp.isEmpty())
		{			
			System.out.println("response login 2------------------>"+resp);
			redirectAttributes.addFlashAttribute("errMsg", "Invalid Username or Password");
			assetDAO.custom_logger(dateFormat.format(date)+" ==> "+"Sorry, something wrong with username and password!");

			return new ModelAndView("redirect:/");
		}
		else
		{      
			assetDAO.custom_logger(dateFormat.format(date)+" ==> "+"User "+user.getUsername()+" Logged.");

			session=request.getSession();
			session.setAttribute("role",resp.get(0).getRole());
			session.setAttribute("userName",resp.get(0).getUsername());

			
			System.out.println("phaneeeeeeeeeee ---------------------"+resp.get(0).getRole()+".........."+user.getUsername());
			/*if(user.getUsername().equalsIgnoreCase("OperationsAdmin")||user.getUsername().equalsIgnoreCase("financeAdmin"))
			{
				List<Indent> listIndent = assetDAO.getAllIndents();
				System.out.println("Idnent List "+listIndent);
				model.addObject("listIndent", listIndent);
			}
			List<Device> listDevice = assetDAO.getAllDevices();
			model.addObject("listDevice", listDevice);
			List<PurchaseRequest> purReq = assetDAO.getAllRequests();
			model.addObject("RequestNumber", purReq); */       	   
			model.setViewName("displayDevices");
			return model;
		}
		
		}
		/*}
		return model;*/
		
	}



	/*	@RequestMapping(value = "/validateUser", method = RequestMethod.POST)
    public ModelAndView checkUser(@ModelAttribute User user,ModelAndView model, HttpSession session,HttpServletRequest request) {
           User resp = assetDAO.getAllUsersOnCriteria(user.getUsername(),user.getPassword());        
           if(resp==null)
           {   	  
                  return new ModelAndView("redirect:/");
           }
           else
           {      
        	  session=request.getSession();
        	  session.setAttribute("userName",user.getUsername());
        	  System.out.println(user.getUsername());
        	  List<Indent> listIndent = assetDAO.getAllIndents();
    		  System.out.println("Indent List "+listIndent);
       	   	  model.addObject("listIndent", listIndent);
        	  if(user.getUsername().equals("OperationsAdmin"))
        	  {
        		  model.setViewName("OperationsAdmin");
        	  }
        	  else if(user.getUsername().equals("financeAdmin"))
        	  {
        		  model.setViewName("financeAdmin");
        	  }
        	  else if(user.getUsername().equals("siteAdmin"))
        	  {
        		  //model.setViewName("siteAdmin");
        		  model.setViewName("displayDevices");
        	  }
        	  else if(user.getUsername().equals("warehouseAdmin"))
        	  {
        		  //model.setViewName("warehouseAdmin");
        		  model.setViewName("displayDevices");

        	  }
        	   List<Device> listDevice = assetDAO.getAllDevices();
        	   model.addObject("listDevice", listDevice);
        	   List<PurchaseRequest> purReq = assetDAO.getAllRequests();
        	   model.addObject("RequestNumber", purReq);        	   
	           //model.setViewName("displayDevices");
	           return model;
           }
    }*/

	@RequestMapping("validUser")
	@ResponseBody
	public String  validUser(@ModelAttribute User user,ModelAndView model) {
		List<PurchaseRequest> purReq = assetDAO.getAllRequests();
		Gson gsonBuilder = new GsonBuilder().create();
		String requestsJson = gsonBuilder.toJson(purReq);
		return requestsJson.toString();
	}

	@RequestMapping("validUser1")
	@ResponseBody
	public String  validUser1(@ModelAttribute User user,ModelAndView model) {
		List<Device> listDevice = assetDAO.getAllDevices();
		Gson gsonBuilder = new GsonBuilder().create();
		String devicesJson = gsonBuilder.toJson(listDevice);
		return devicesJson.toString();
	}


	@RequestMapping(value = "/newDevice", method = RequestMethod.GET)
	public ModelAndView deviceRedirect(ModelAndView model) {
		Device device = new Device();
		model.addObject("Device", device);
		model.setViewName("AddNewDevice");
		return model;
	}


	@RequestMapping(value = "/addDevice", method = RequestMethod.POST)
	public ModelAndView addDevice(@ModelAttribute Device device) {
		if (device.getId() == 0) { 
			assetDAO.addDevice(device);
		} 
		else {
			assetDAO.updateDevice(device);
		}
		return new ModelAndView("redirect:/displaydevice");
	}

	@RequestMapping(value = "/displaydevice", method = RequestMethod.GET)
	public ModelAndView devicesRedirect(ModelAndView model) {
		List<Device> listDevice = assetDAO.getAllDevices();
		model.addObject("listDevice", listDevice);
		List<PurchaseRequest> purReq = assetDAO.getAllRequests();
		model.addObject("RequestNumber", purReq);
		model.setViewName("displayDevices");
		return model;
	}


	@RequestMapping(value = "/displaydevicestatus", method = RequestMethod.GET)
	public ModelAndView devicesStatusRedirect(ModelAndView model) {
		List<Device> listDevice = assetDAO.getAllDevices();
		model.addObject("listDevice", listDevice);
		List<PurchaseRequest> purReq = assetDAO.getAllRequests();
		model.addObject("RequestNumber", purReq);

		List<Indent> listIndent = assetDAO.getAllIndents();
		System.out.println("Idnent List "+listIndent);
		model.addObject("listIndent", listIndent);

		model.setViewName("displayDevices");
		return model;
	}


		@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
    public ModelAndView saveUser(@ModelAttribute("User") User user,RedirectAttributes redirectAttributes) {
        ModelAndView modelAndView= new ModelAndView();
        String s=null;
        String uName=user.getUsername();
        System.out.println("username>........................."+uName);
        if (user.getId() == 0) {
           
        	//s=assetDAO.addUser(user,uName);
        	s=assetDAO.addUser(user);
        	System.out.println("..................>>>>>>."+s);
            if(s=="Exist")
            {
                redirectAttributes.addFlashAttribute("errMsg", "UserName is already Exist,Please choose different one ");
                return new ModelAndView("redirect:/newUser");
                //modelAndView.addObject("errMsg", "UserName is already Exist,Please choose different one ");
                //return "";
            }
            
            modelAndView.addObject("succMsg", s);
            
        }
        modelAndView.setViewName("home");
        
        return modelAndView;
		}

	/*	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
    public String saveUser(@ModelAttribute("User") User user,Model model) {
        if (user.getId() == 0) { 
            assetDAO.addUser(user);
            model.addAttribute("succMsg","Added Successfully");
        } 
        //return new ModelAndView("redirect:/");
        return "home";
    }*/

	@RequestMapping(value = "/deleteDevice", method = RequestMethod.GET)
	public ModelAndView deleteDevice(HttpServletRequest request) {
		int deviceId = Integer.parseInt(request.getParameter("id"));
		assetDAO.deleteDevice(deviceId);
		return new ModelAndView("redirect:/displaydevice");
	}

	@RequestMapping(value = "/editDevice", method = RequestMethod.GET)
	public ModelAndView editDevice(HttpServletRequest request) {
		int deviceId = Integer.parseInt(request.getParameter("id"));
		Device device = assetDAO.getDeviceData(deviceId);
		ModelAndView model = new ModelAndView("AddNewDevice");
		model.addObject("Device", device);
		return model;
	}

	@RequestMapping(value = "/viewDevice", method = RequestMethod.GET)
	public ModelAndView viewDevice(HttpServletRequest request) {
		int deviceId = Integer.parseInt(request.getParameter("id"));
		System.out.println(deviceId);
		Device device = assetDAO.getDeviceData(deviceId);
		ModelAndView model = new ModelAndView("viewDeviceDetails");
		System.out.println(device);
		model.addObject("Device", device);
		//System.out.println(device.getId());
		return model;
	}

	@SuppressWarnings("unused")
	@RequestMapping(value="getIndentItems", method=RequestMethod.GET)
	@ResponseBody
	public String getIndentItems(HttpServletRequest request){
		String indentId=request.getParameter("indentId");
		List<IndentApproval> itemList=assetDAO.getIndentItems(indentId);
		Gson gsonBuilder =new GsonBuilder().create();
		String itemJson=gsonBuilder.toJson(itemList);
		return itemJson.toString();
		
	}

	@RequestMapping(value= "getCategoryItems", method = RequestMethod.GET)
	@ResponseBody
	public String getCategoryItems(HttpServletRequest request) {
		String category = request.getParameter("category");
		List<Item> itemList = assetDAO.getCategoryItems(category);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemList);
		return itemsJson.toString();
	}

	@RequestMapping(value= "getCategoryClasses", method = RequestMethod.GET)
	@ResponseBody
	public String getCategoryClasses(HttpServletRequest request) {
		String category = request.getParameter("category");
		List<Item> itemList = assetDAO.getCategoryClasses(category);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemList);
		return itemsJson.toString();
	}

	@RequestMapping(value= "getClassItems", method = RequestMethod.GET)
	@ResponseBody
	public String getClassItems(HttpServletRequest request) {
		String selectedClass = request.getParameter("classSelected");
		String selectedCategory = request.getParameter("categorySelected");
		List<Item> classItemList = assetDAO.getClassItems(selectedClass,selectedCategory);
		Gson gsonBuilder = new GsonBuilder().create();
		String classItemJson = gsonBuilder.toJson(classItemList);
		return classItemJson.toString();
	}

	@RequestMapping(value= "getClassVendorItems", method = RequestMethod.GET)
	@ResponseBody
	public String getClassVendorItems(HttpServletRequest request) {
		String selectedClass = request.getParameter("classSelected");
		String selectedCategory = request.getParameter("categorySelected");
		String selectedVendor = request.getParameter("vendorSelected");
		List<VendorSupplier> classItemList = assetDAO.getClassVendorItems(selectedClass,selectedCategory,selectedVendor);
		Gson gsonBuilder = new GsonBuilder().create();
		String classItemJson = gsonBuilder.toJson(classItemList);
		return classItemJson.toString();
	}


	@RequestMapping(value= "getLastVendorId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastVendorId(HttpServletRequest request) {
		List<VendorReg> vendorList = assetDAO.getLastVendorId();
		Gson gsonBuilder = new GsonBuilder().create();
		String vendorJson = gsonBuilder.toJson(vendorList);
		return vendorJson.toString();
	}

	@RequestMapping(value= "getLastChallanId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastChallanId(HttpServletRequest request) {
		List<DeliveryChallan> dcList = assetDAO.getLastChallanId();
		Gson gsonBuilder = new GsonBuilder().create();
		String dcJson = gsonBuilder.toJson(dcList); 
		return dcJson.toString();
	}
	
	@RequestMapping(value="getWSLastChallanId", method=RequestMethod.GET)
	@ResponseBody
	public String getLastWSChallanId(HttpServletRequest request){
		List<waerhouseDeliveryChallan> dcList=assetDAO.getWSLastChallanId();
		Gson gsonBuilder= new GsonBuilder().create();
		String dcJson= gsonBuilder.toJson(dcList);
		return dcJson.toString();
		
	}


	@RequestMapping(value= "getLastPurchaseId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastPurchaseId(HttpServletRequest request) {
		List<PurchaseOrder> purchaseList = assetDAO.getLastPurchaseId();
		Gson gsonBuilder = new GsonBuilder().create();
		String purchaseJson = gsonBuilder.toJson(purchaseList);
		return purchaseJson.toString();
	}

	@RequestMapping(value= "getLastItemId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastItemId(HttpServletRequest request) {
		List<Item> vendorList = assetDAO.getLastItemId();
		Gson gsonBuilder = new GsonBuilder().create();
		String itemJson = gsonBuilder.toJson(vendorList);
		return itemJson.toString();
	}
	
	@RequestMapping(value= "getLastSiteId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastSiteId(HttpServletRequest request) {
		List<Site> siteList = assetDAO.getLastSiteId();
		Gson gsonBuilder = new GsonBuilder().create();
		String siteJson = gsonBuilder.toJson(siteList);
		return siteJson.toString();
	}

	@RequestMapping(value= "getLastIndentId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastIndentId(HttpServletRequest request) {
		List<IndentData> indentList = assetDAO.getLastIndentId();
		Gson gsonBuilder = new GsonBuilder().create();
		String indentJson = gsonBuilder.toJson(indentList);
		return indentJson.toString();
	}

	@RequestMapping(value = "/newPurchaseRequest")
	public ModelAndView purchaseRedirect(ModelAndView model) {
		PurchaseRequest pr=new PurchaseRequest();
		model.addObject("purchaseRequest", pr);
		model.setViewName("PurchaseRequestForm");
		return model;
	}

	@RequestMapping(value = "/newVendor")
	public ModelAndView VendorRedirect(ModelAndView model) {
		VendorReg vendor=new VendorReg();		      
		model.addObject("VendorReg", vendor);
		model.setViewName("vendorRegForm");
		return model;
	}

	@RequestMapping(value="/vendorDesc")
	public ModelAndView VendorDesc(ModelAndView model){
		model.setViewName("vendorDesc");
		return model;
	}

	@RequestMapping(value="/deliveryChallanDesc")
	public ModelAndView deliveryChallanDesc(ModelAndView model){
		model.setViewName("deliveryChallanDesc");
		return model;
	}

	@RequestMapping(value = "/newItemList")
	public ModelAndView checkItemList(ModelAndView model) {
		List<Item> listItem = assetDAO.getAllItems();
		System.out.println("Item List "+listItem);
		model.addObject("itemsList", listItem);
		model.setViewName("itemList");
		return model;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/newVendorsList")
	public ModelAndView checkVendorList(ModelAndView model){
		List<VendorSupplier> listVendors=assetDAO.getAllVendors();
		//ArrayList<Comparable> vendorList = new ArrayList<Comparable>();
		List<String[]> vendorList=new ArrayList<String[]>();
		for(VendorSupplier vendor: listVendors)
		{
			/*vendorList.add(vendor.getVendorId());
			vendorList.add(vendor.getVendorName());
			vendorList.add(vendor.getCategory());
			vendorList.add(vendor.getCategoryClass());*/
			vendorList.add(vendor.getClassAAssets());
		}
		model.addObject("vendorsList",listVendors);
		model.setViewName("vendorsList");
		return model;
		
	}

	@RequestMapping(value="/newIndentList")
	public ModelAndView IndentList(ModelAndView model){
		List<IndentApproval> listIndents=assetDAO.getApprovedIndentIds();
		model.addObject("IndentsList",listIndents);
		model.setViewName("indentList");
		return model;
	}

	@RequestMapping(value="/itemDesc")
	public ModelAndView ItemDesc(ModelAndView model){	
		model.setViewName("itemDesc");
		return model;
	}

	@RequestMapping(value = "/newSite")
	public ModelAndView SiteRedirect(ModelAndView model) {
		Site site=new Site();		      
		model.addObject("Site", site);
		model.setViewName("addSite");
		return model;
	}

	@RequestMapping(value = "/newItem")
	public ModelAndView ItemMasterRedirect(ModelAndView model) {
		Item item=new Item();
		model.addObject("Item", item);
		model.setViewName("itemMaster");
		return model;
	}

	@RequestMapping(value = "/newIndent_redirect")
	public ModelAndView IndentRedirect(ModelAndView model,HttpSession session) {
		Indent indent=new Indent();
	 
	//	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	//	User user = (User)authentication.getPrincipal();
		
		String name=(String) session.getAttribute("userName");
	      System.out.println(" username->>>>>>>>>>>>>>>>>>>>>>........"+name);
	     List siteIds= assetDAO.fetchsiteIdsByUsername(name);
	     System.out.println("siteids by username.................."+siteIds);
		model.addObject("Indent", indent);
		model.addObject("siteId",siteIds);
		
		model.setViewName("addIndent");
		return model;
	}

	/*@RequestMapping(value= "newIndent", method = RequestMethod.POST)
	@ResponseBody
	public String newIndent(HttpServletRequest request) {
		JSONObject json;
		String status = "";
		try {
			
			json = new JSONObject(request.getParameter("input"));
			String assets = json.getString("items");   
			JSONArray jsonarray = new JSONArray(assets);
			status = assetDAO.indent_save(jsonarray);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(status);		
		return status;
	}*/

	@RequestMapping(value= "newIndent", method = RequestMethod.POST)
	@ResponseBody
	public String newIndent(HttpServletRequest request,RedirectAttributes redirectAttributes) {
		JSONObject json;
		String status = "Indent Added Successfully";
		try {
			
			json = new JSONObject(request.getParameter("input"));
			String assets = json.getString("items");   
			JSONArray jsonarray = new JSONArray(assets);
			status = assetDAO.indent_save(jsonarray);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(status);		
		redirectAttributes.addFlashAttribute("status", status);
		//return "forward:/sendEmail";
		send_IndentEmail();
		return status;
	}

	@RequestMapping(value = "/newWarehouseDC")
	public ModelAndView WarehouseDCRedirect(ModelAndView model) {
		waerhouseDeliveryChallan dc=new waerhouseDeliveryChallan();
		model.addObject("warehouse_DC", dc);
		model.setViewName("warehouseDeliveryChallan");
		return model;
	}

	@RequestMapping(value="/newVendorDC")
	public ModelAndView VendorDCRedirect(ModelAndView model){
		DeliveryChallan dc=new DeliveryChallan();
		model.addObject("DelChallan",dc);
		model.setViewName("vendorDeliveryChallan");
		return model;
	}

	@RequestMapping(value = "/newAssetStocks")
	public ModelAndView AssetsStockRedirect(ModelAndView model) {
		AssetStock assetStock=new AssetStock();
		model.addObject("AssetStock", assetStock);
		model.setViewName("assetStocks");
		return model;
	}

	@RequestMapping(value = "/newEquipStocks")
	public ModelAndView EquipStocksRedirect(ModelAndView model) {
		EquipStock equipStock=new EquipStock();
		model.addObject("EquipStock", equipStock);
		model.setViewName("equipStock");
		return model;
	}
	
	

	@RequestMapping(value= "getvendorData", method = RequestMethod.GET)
	@ResponseBody
	public String getVendorData(HttpServletRequest request) {
		String poId = request.getParameter("PoId");
		List<String> vendorList = new ArrayList<String>();
		List<PurchaseOrder> purchaseList = assetDAO.getPoData(poId);		
		System.out.println(purchaseList);
		for (PurchaseOrder temp : purchaseList) {
			vendorList.add(temp.getVendorId());
			vendorList.add(temp.getVendorName());		
		}
		System.out.println(vendorList);
		Gson gsonBuilder = new GsonBuilder().create();
		String purchaseJson = gsonBuilder.toJson(vendorList);
		return purchaseJson.toString();
	}
	
	@RequestMapping(value= "getSiteName", method = RequestMethod.GET)
	@ResponseBody
	public String getSiteName(HttpServletRequest request) {
		String IndentId=null,resultId=null,siteId=null,resultName=null,siteName=null;
		IndentId = request.getParameter("IndentId");
		List<String> siteList = new ArrayList<String>();
		resultId= assetDAO.getIndentData(IndentId);
		siteId=resultId.substring(1, resultId.length()-1);
		resultName = assetDAO.getSiteData(siteId);	
		siteName=resultName.substring(1, resultName.length()-1);
		siteList.add(siteId);
		siteList.add(siteName);
		Gson gsonBuilder = new GsonBuilder().create();
		String siteIdNameJson = gsonBuilder.toJson(siteList);
		return siteIdNameJson.toString();
	}

	@RequestMapping(value = "/savePurchaseRequest", method = RequestMethod.POST)
	public ModelAndView addPurchaseRequest(@ModelAttribute PurchaseRequest pr) {
		if (pr.getId() == 0) { 
			assetDAO.addPurchaseRequest(pr);
		} 
		else {
			assetDAO.updatePurchaseRequest(pr);
		}
		//ModelAndView model = new ModelAndView("PurchaseRequestForm");
		//		String pr1=assetDAO.getLastRequestID();
		//		model.addObject("LastRequestNumber",pr1);	
		//		return model;
		return new ModelAndView("redirect:/displaydevice");
	}

	@RequestMapping(value = "/saveItem", method = RequestMethod.POST)
	public ModelAndView addItem(@ModelAttribute Item item, RedirectAttributes redirectAttributes) {
		String status=null;
		if (item.getId() == 0) { 
			status=assetDAO.addItem(item);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newItem");
	}

	@RequestMapping(value = "/saveDeliveryChallan", method = RequestMethod.POST)
	public ModelAndView addDeliveryChallan(@ModelAttribute DeliveryChallan dc, RedirectAttributes redirectAttributes) {
		String status=null;
		if (dc.getId() == 0) { 
			status=assetDAO.saveDeliveryChallan(dc);
		} 

		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newVendorDC");
	}
	
	/*@RequestMapping(value = "/saveWarehouseDC", method = RequestMethod.POST)
	public ModelAndView addWarehouseDC(@ModelAttribute waerhouseDeliveryChallan dc, RedirectAttributes redirectAttributes) {
		String status=null;
		if (dc.getId() == 0) { 
			status=assetDAO.saveWarehouseDC(dc);
		} 

		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newWarehouseDC");
	}*/

	@RequestMapping(value = "/saveIndent", method = RequestMethod.POST)
	public String addIndent(@ModelAttribute Indent indent,@ModelAttribute IndentData indentData, RedirectAttributes redirectAttributes) {
		if (indent.getId() == 0) { 
			assetDAO.saveIndent(indent,indentData);
		} 
		String status="Added Successfully";
		redirectAttributes.addFlashAttribute("status", status);
		return "forward:/sendEmail";
	}

	@RequestMapping(value = "/addAssetStock", method = RequestMethod.POST)
	public ModelAndView addAssetStock(@ModelAttribute AssetStock assetStock , RedirectAttributes redirectAttributes) {
		String status=null;
		if (assetStock.getId() == 0) { 
			status=assetDAO.saveAssetStock(assetStock);
		}
		redirectAttributes.addFlashAttribute("status", status);		
		return new ModelAndView("redirect:/newAssetStocks");
	}

	@RequestMapping(value = "/addEquipStock", method = RequestMethod.POST)
	public ModelAndView addEquipStock(@ModelAttribute EquipStock equipStock, RedirectAttributes redirectAttributes) {
		String status=null;
		if (equipStock.getId() == 0) { 
			assetDAO.saveEquipStock(equipStock);

			for(int i=1;i<=equipStock.getOrgStock();i++)
			{
				ItemTracker itemTrack=new ItemTracker();
				itemTrack.setEquipAssetId(equipStock.getEquipment()+"_"+equipStock.getEquipName()+"_00"+i);
				itemTrack.setEquipAsset("Equipment");
				itemTrack.setClassName(equipStock.getClassType());
				itemTrack.setItemType(equipStock.getEquipment());
				itemTrack.setItemName(equipStock.getEquipName());
				itemTrack.setVendor(equipStock.getVendorName());
				Date manufactureDate = null;
				Date expiryDate = null;
				
				try {
					manufactureDate = new SimpleDateFormat("yyyy/mm/dd").parse(equipStock.getManufactureDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
				itemTrack.setManufacturedDate(manufactureDate);
				try {
					expiryDate=new SimpleDateFormat("yyyy/mm/dd").parse(equipStock.getExpiryDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  

				itemTrack.setExpiryDate(expiryDate);		
				status=assetDAO.addItemTracker(itemTrack);
			}
		} 

		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newEquipStocks");
	}

	@RequestMapping(value = "/addOrderAck", method = RequestMethod.POST)
	public ModelAndView addOrderAcknow(@ModelAttribute OrderAcknowledgement orderAck, RedirectAttributes redirectAttributes) {
		String status=null;
		if (orderAck.getId() == 0) { 
			status=assetDAO.saveOrderAcknow(orderAck);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newOrderAcknow");
	}


	@RequestMapping(value = "/saveSite", method = RequestMethod.POST)
	public ModelAndView add(@ModelAttribute Site site) {
		if (site.getId() == 0) { 
			assetDAO.addSite(site);
		} 
		return new ModelAndView("redirect:/displaydevice");
	}

	@RequestMapping(value = "/addVendor", method = RequestMethod.POST)
	public ModelAndView addVendor(@ModelAttribute VendorReg vendor, RedirectAttributes redirectAttributes) {

		String vendorName = vendor.getVendorName();
		List<VendorReg> vendorList = assetDAO.getVendorData(vendorName);
		String status=null;

		if(vendorList.isEmpty())
		{
			status=assetDAO.addVendor(vendor);
		}
		else
		{
			status=assetDAO.updateVendor(vendor);
		}

		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newVendor");
	}

	@RequestMapping(value = "/saveVendor", method = RequestMethod.POST)
	public ModelAndView saveVendor(@ModelAttribute VendorSupplier vendor,ModelAndView model, RedirectAttributes redirectAttributes) {
		String status=null;
		if (vendor.getId() == 0) { 
			status=financeDAO.saveVendor(vendor);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newVendorSupplier");

	}

	@RequestMapping(value = "/savePurchaseOrder", method = RequestMethod.POST)
	public ModelAndView savePurchaseOrder(@ModelAttribute PurchaseOrder po,ModelAndView model,RedirectAttributes redirectAttributes) {
		String status=null;
		if (po.getId() == 0) { 
			status=assetDAO.savePurchaseOrder(po);
		} 

		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newOrder");

	}

	@RequestMapping(value="/saveAssetsOrder", method = RequestMethod.POST)
	@ResponseBody
	public String  submittedAssetsFormData(@RequestBody PurchaseOrderAssets poAssets, HttpServletRequest request) {	
		if (poAssets.getAssetsId() == 0) { 
			assetDAO.saveAssetsOrder(poAssets);
		}
		return "Success";
	}

	@RequestMapping(value = "/saveEquipsOrder", method = RequestMethod.POST)
	@ResponseBody
	public String submittedEquipsFormData(@RequestBody PurchaseOrderEquips poEquips,HttpServletRequest request) {
		if (poEquips.getEquipsId() == 0) { 
			assetDAO.saveEquipsOrder(poEquips);
		} 
		return "Success";
	}

	@RequestMapping(value = "/newOrder")
	public ModelAndView PurchaseOrderRedirect(ModelAndView model) {
		PurchaseOrder po=new PurchaseOrder();
		model.addObject("PurchaseOrder", po);
		PurchaseOrderAssets poAssets=new PurchaseOrderAssets();
		model.addObject("PurchaseOrderAssets",poAssets);
		PurchaseOrderEquips poEquips=new PurchaseOrderEquips();
		model.addObject("PurchaseOrderEquips",poEquips);
		model.setViewName("PurchaseOrderForm");
		return model;
	}

	@ModelAttribute("vendorList")
	public Map<String, String> getVendorList() {
		Map<String, String> vendorsMap = new HashMap<String, String>();
		List<VendorReg> vendors = assetDAO.getVendors();
		for(VendorReg vendor : vendors)
		{
			vendorsMap.put(vendor.getVendorName(), vendor.getVendorName());
		}
		return vendorsMap;
	}

	@ModelAttribute("vendorIds")
	public Map<String, String> getVendorIds() {
		Map<String, String> vendorsMap = new HashMap<String, String>();
		List<VendorReg> vendors = assetDAO.getVendors();
		for(VendorReg vendor : vendors)
		{
			vendorsMap.put(vendor.getVendorId(), vendor.getVendorId());
		}
		return vendorsMap;
	}
	
	@ModelAttribute("vendorNames")
	public Map<String, String> getVendorNames() {
		Map<String, String> vendorsMap = new HashMap<String, String>();
		List<VendorReg> vendors = assetDAO.getVendors();
		for(VendorReg vendor : vendors)
		{
			vendorsMap.put(vendor.getVendorName(), vendor.getVendorName());
		}
		return vendorsMap;
	}

	@ModelAttribute("indentIds")
	public Map<String, String> getIndentIds() {
		Map<String, String> indentsMap = new HashMap<String, String>();
		List<IndentData> indents = assetDAO.getIndents();
		for(IndentData indent : indents)
		{
			indentsMap.put(indent.getIndentId(), indent.getIndentId());
		}
		return indentsMap;
	}
	
	@ModelAttribute("approvedIndentIds")
	public Map<String, String> getApprovedIndentIdsInPO() {
		Map<String, String> indentsMap = new HashMap<String, String>();
		List<IndentApproval> indents = assetDAO.getApprovedIndentIds();
		for(IndentApproval indent : indents)
		{
			indentsMap.put(indent.getIndentId(), indent.getIndentId());
		}
		Map<String,String> poMap=new HashMap<String, String>();
		Map<String,String> newMap=new HashMap<String, String>();
		List<PurchaseOrder> pos=assetDAO.getIndentIdsInPO();
		for(PurchaseOrder dc : pos)
		{
			poMap.put(dc.getIndentId(), dc.getIndentId()); 
		}


		for(String i: indentsMap.keySet())
		{
			for(String j: poMap.keySet())
			{
				if(!(poMap.containsKey((indentsMap.get(i)))))
				{
					newMap.put(indentsMap.get(i), indentsMap.get(i));
					break;
				}
				else
				{

				}
			}
		}

		if(poMap.isEmpty())
			return indentsMap;
		else 
			return newMap;
	}
	
	
	@ModelAttribute("siteIds")
	public Map<String, String> getSiteIds() {
		Map<String, String> siteMap = new HashMap<String, String>();
		List<Site> sites = assetDAO.getSites();
		for(Site site : sites)
		{
			siteMap.put(site.getSiteName(), site.getSiteName());
		}
		return siteMap;
	}

	@ModelAttribute("poIds")
	public Map<String, String> getPoIds() {
		Map<String, String> poMap = new HashMap<String, String>();
		List<PurchaseOrder> pos = assetDAO.getPOs();
		for(PurchaseOrder po : pos)
		{
			poMap.put(po.getPoId(), po.getPoId());
		}
		System.out.println("poMap--------"+poMap);
		return poMap;
	}

	@ModelAttribute("poIdsInDC")
	public Map<String, String> getPoIdsInDC(){

		int count=0;
		Map<String, String> poMap = new HashMap<String, String>();
		List<PurchaseOrder> pos = assetDAO.getPOs();
		for(PurchaseOrder po : pos)
		{
			poMap.put(po.getPoId(), po.getPoId());
		}

		Map<String,String> dcMap=new HashMap<String, String>();
		Map<String,String> newMap=new HashMap<String, String>();
		List<DeliveryChallan> dos=assetDAO.getPOIdsInDC();
		for(DeliveryChallan dc : dos)
		{
			dcMap.put(dc.getPoId(), dc.getPoId()); 
		}


		for(String i: poMap.keySet())
		{
			for(String j: dcMap.keySet())
			{
				if(!(dcMap.containsKey((poMap.get(i)))))
				{
					newMap.put(poMap.get(i), poMap.get(i));
					break;
				}
				else
				{

				}
			}
		}

		if(dcMap.isEmpty())
			return poMap;
		else 
			return newMap;

	}
	
	@ModelAttribute("indentIdsInDC")
	public Map<String, String> getIndentIdsInDC(){

		int count=0;
		Map<String, String> indentMap = new HashMap<String, String>();
		List<IndentApproval> indents = assetDAO.getApprovedIndentIds();
		for(IndentApproval indent : indents)
		{
			indentMap.put(indent.getIndentId(), indent.getIndentId());
		}

		Map<String,String> dcMap=new HashMap<String, String>();
		Map<String,String> newMap=new HashMap<String, String>();
		List<waerhouseDeliveryChallan> dos=assetDAO.getIndentIdsInDC();
		for(waerhouseDeliveryChallan dc : dos)
		{
			dcMap.put(dc.getIndentId(), dc.getIndentId()); 
		}


		for(String i: indentMap.keySet())
		{
			for(String j: dcMap.keySet())
			{
				if(!(dcMap.containsKey((indentMap.get(i)))))
				{
					newMap.put(indentMap.get(i), indentMap.get(i));
					break;
				}
				else
				{

				}
			}
		}

		if(dcMap.isEmpty())
			return indentMap;
		else 
			return newMap;

	}


	@RequestMapping(value= "getVendorId", method = RequestMethod.GET)
	@ResponseBody
	public String getVendorName(HttpServletRequest request) {
		String vendorName = request.getParameter("vendorName");
		List<VendorReg> vendorList = assetDAO.getVendorId(vendorName);
		String vendorId ="";
		for(VendorReg vendor : vendorList)
		{
			vendorId=vendor.getVendorId();
		}
		return vendorId;
	}

/*
	@RequestMapping(value= "getVendorId", method = RequestMethod.GET)
	@ResponseBody
	public String getVendorId(HttpServletRequest request) {
		String vendorName= request.getParameter("vendorName");
		List<VendorReg> vendorList = assetDAO.getVenId(vendorName);
		Gson gsonBuilder = new GsonBuilder().create();
		String vendorJson = gsonBuilder.toJson(vendorList);
		System.out.println(vendorJson);
		return vendorJson;
	}
*/

	@RequestMapping(value= "getCategoryTypes", method = RequestMethod.GET)
	@ResponseBody
	public String getCategoryTypes(HttpServletRequest request) {
		String selectedCategory = request.getParameter("selectedCategory");
		String selectedClass = request.getParameter("selectedClass");			
		String selectedType=request.getParameter("selectedType");
		List<Item> itemsList = assetDAO.getCategoryTypes(selectedCategory,selectedClass,selectedType);
		System.out.println(itemsList);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemsList);
		System.out.println(itemsJson);
		return itemsJson;
	}


	@RequestMapping(value= "getModelTypes", method = RequestMethod.GET)
	@ResponseBody
	public String getModelTypes(HttpServletRequest request) {
		String selectedCategory = request.getParameter("selectedCategory");
		String selectedClass = request.getParameter("selectedClass");			
		String selectedType=request.getParameter("selectedType");
		String selectedModel=request.getParameter("selectedModel");
		List<Item> itemsList = assetDAO.getModelTypes(selectedCategory,selectedClass,selectedType,selectedModel);
		System.out.println("Model"+itemsList);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemsList);
		System.out.println(itemsJson);
		return itemsJson;
	}

	@RequestMapping(value= "getStockinhand", method = RequestMethod.GET)
	@ResponseBody
	public String getStockinhand(HttpServletRequest request) {
		String selectequipasset =  request.getParameter("equipAsset");
		String selectedClass = request.getParameter("selectedClass");
		String selectedCategory = request.getParameter("selectedAsset");						
		String selectedType=request.getParameter("selectedassetName");
		String selectedModel=request.getParameter("selectedModel");
		System.out.println(selectequipasset);		
		System.out.println(selectedClass);		
		System.out.println(selectedCategory);		
		System.out.println(selectedType);		
		System.out.println(selectedModel);		

		List<Item> itemsList = assetDAO.getStockinhand(selectequipasset,selectedClass,selectedCategory,selectedType,selectedModel);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemsList);
		System.out.println(itemsJson);
		return itemsJson;
	}

	@RequestMapping(value= "getAssetIdfromIndent", method = RequestMethod.GET)
	@ResponseBody
	public String s(HttpServletRequest request) {
		String selectequipasset =  request.getParameter("equipAsset");
		String selectedClass = request.getParameter("selectedClass");
		String selectedCategory = request.getParameter("selectedAsset");						
		String selectedType=request.getParameter("selectedassetName");
		String selectedModel=request.getParameter("selectedModel");
		String siteId=request.getParameter("siteId");
		
		System.out.println(selectequipasset);		
		System.out.println(selectedClass);		
		System.out.println(selectedCategory);		
		System.out.println(selectedType);		
		System.out.println(selectedModel);		

		List<Item> itemsList = assetDAO.getAssetIdfromIndent(siteId,selectequipasset,selectedClass,selectedCategory,selectedType,selectedModel);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemsList);
		System.out.println(itemsJson);
		return itemsJson;
	}

	@RequestMapping(value= "fetchStocksData", method = RequestMethod.GET)
	@ResponseBody
	public String fetchStocksData(HttpServletRequest request) {
		String selectedClass = request.getParameter("selectedClass");
		String selectedCategory = request.getParameter("selectedAsset");						
		String selectedType=request.getParameter("selectedassetName");
		String selectedModel=request.getParameter("selectedModel");
		System.out.println(selectedClass);		
		System.out.println(selectedCategory);		
		System.out.println(selectedType);		
		System.out.println(selectedModel);		

		List<Item> itemsList = assetDAO.fetchStocksData(selectedClass,selectedCategory,selectedType,selectedModel);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemsList);
		System.out.println(itemsJson);
		return itemsJson;
	}

	@RequestMapping(value= "fetchEquipmentStocksData", method = RequestMethod.GET)
	@ResponseBody
	public String fetchEquipmentStocksData(HttpServletRequest request) {
		String selectedClass = request.getParameter("selectedClass");
		String selectedCategory = request.getParameter("selectedAsset");						
		String selectedType=request.getParameter("selectedassetName");
		String selectedModel=request.getParameter("selectedModel");
		System.out.println(selectedClass);		
		System.out.println(selectedCategory);		
		System.out.println(selectedType);		
		System.out.println(selectedModel);		

		List<Item> itemsList = assetDAO.fetchEquipmentStocksData(selectedClass,selectedCategory,selectedType,selectedModel);
		Gson gsonBuilder = new GsonBuilder().create();
		String itemsJson = gsonBuilder.toJson(itemsList);
		System.out.println(itemsJson);
		return itemsJson;
	}

	@RequestMapping(value= "updateStocksData", method = RequestMethod.GET)
	@ResponseBody
	public String updateStocksData(HttpServletRequest request) {
		String selectedClass = request.getParameter("selectedClass");
		String selectedCategory = request.getParameter("selectedAsset");						
		String selectedType=request.getParameter("selectedassetName");
		String selectedModel=request.getParameter("selectedModel");
		String selectedassetDesc=request.getParameter("selectedassetDesc");
		String selectedvendorName=request.getParameter("selectedvendorName");
		String selecteditemPrice=request.getParameter("selecteditemPrice");
		String selecteddelNorms=request.getParameter("selecteddelNorms");
		String selectedorgStock=request.getParameter("selectedorgStock");
		String selectedstockInHand=request.getParameter("selectedstockInHand");
		String selectedstockInHandDate=request.getParameter("selectedstockInHandDate");
		String selectedmanufactureDate=request.getParameter("selectedmanufactureDate");
		String selectedexpiryDate=request.getParameter("selectedexpiryDate");
		String selectedId=request.getParameter("selectedId");
		int selectedreorderLevel=Integer.parseInt(request.getParameter("selectedreorderLevel"));
		int tracker_status = assetDAO.get_orgstock(Integer.parseInt(selectedId));


		System.out.println(selectedClass);		
		System.out.println(selectedCategory);		
		System.out.println(selectedType);		
		System.out.println(selectedModel);		

		String status = assetDAO.updateStocksData(selectedClass, selectedCategory, selectedType, selectedModel, selectedassetDesc, selectedvendorName, selecteditemPrice, selecteddelNorms, selectedorgStock, selectedstockInHand, selectedstockInHandDate, selectedmanufactureDate, selectedexpiryDate,selectedId,tracker_status,selectedreorderLevel);

		System.out.println(status);
		return status;
	}

	@RequestMapping(value= "updateEquipmentStocksData", method = RequestMethod.GET)
	@ResponseBody
	public String updateEquipmentStocksData(HttpServletRequest request) {
		String selectedClass = request.getParameter("selectedClass");
		String selectedCategory = request.getParameter("selectedAsset");						
		String selectedType=request.getParameter("selectedassetName");
		String selectedModel=request.getParameter("selectedModel");
		String selectedassetDesc=request.getParameter("selectedassetDesc");
		String selectedvendorName=request.getParameter("selectedvendorName");
		String selecteditemPrice=request.getParameter("selecteditemPrice");
		String selecteddelNorms=request.getParameter("selecteddelNorms");
		String selectedorgStock=request.getParameter("selectedorgStock");
		String selectedstockInHand=request.getParameter("selectedstockInHand");
		String selectedstockInHandDate=request.getParameter("selectedstockInHandDate");
		String selectedmanufactureDate=request.getParameter("selectedmanufactureDate");
		String selectedexpiryDate=request.getParameter("selectedexpiryDate");
		String selectedId=request.getParameter("selectedId");
		int tracker_status = assetDAO.get_orgstock_equipment(Integer.parseInt(selectedId));
		System.out.println(selectedClass);		
		System.out.println(selectedCategory);		
		System.out.println(selectedType);		
		System.out.println(selectedModel);		
		String status = assetDAO.updateEquipmentStocksData(selectedClass, selectedCategory, selectedType, selectedModel, selectedassetDesc, selectedvendorName, selecteditemPrice, selecteddelNorms, selectedorgStock, selectedstockInHand, selectedstockInHandDate, selectedmanufactureDate, selectedexpiryDate,selectedId,tracker_status);
		System.out.println(status);
		return status;
	} 


	@RequestMapping(value = "/addPurchaseOrder", method = RequestMethod.POST)
	public ModelAndView addPurchaseOrder(@ModelAttribute PurchaseOrder po,ModelMap model) {
		if (po.getId() == 0) { 
			assetDAO.addPurchaseOrder(po);
		} 
		return new ModelAndView("redirect:/displaydevice");
	}

	@RequestMapping(value = "/newVendorSupplier")
	public ModelAndView vendorSupplierRedirect(ModelAndView model) {
		VendorSupplier vendorSupplier=new VendorSupplier();
		model.addObject("VendorSupplier", vendorSupplier);
		model.setViewName("vendorSupplier");
		return model;
	}

	@ModelAttribute("skillsList")
	public Map<String, String> getSkillsList() {
		Map<String, String> skillList = new HashMap<String, String>();
		skillList.put("Hibernate", "Hibernate");
		skillList.put("Spring", "Spring");
		skillList.put("Apache Wicket", "Apache Wicket");
		skillList.put("Struts", "Struts");
		return skillList;
	}

	/*  @RequestMapping(params="Cancel")
	    public ModelAndView buttoncheck1()
	    {
		   return new ModelAndView("redirect:/displaydevice");
	    } 
	 */

	@RequestMapping(value = "/downloadFile", method = RequestMethod.GET)
	public ModelAndView downloadFileRedirect(ModelAndView model) {
		model.setViewName("downloadFile");
		return model;
	}
	
	///////////

	@RequestMapping(value= "getAssetName", method = RequestMethod.GET)		
	@ResponseBody		
	public String getAssetName(HttpServletRequest request) {		
		String selectedClass = request.getParameter("classSelected");		
		String selectedAsset = request.getParameter("AssetSelected");		
		List<Item> classItemList = assetDAO.getAssetName(selectedClass,selectedAsset);		
		Gson gsonBuilder = new GsonBuilder().create();		
		String classItemJson = gsonBuilder.toJson(classItemList);		
		return classItemJson.toString();		
	}		

	@RequestMapping(value= "getEquipName", method = RequestMethod.GET)		
	@ResponseBody		
	public String getEquipName(HttpServletRequest request) {		
		String selectedClass = request.getParameter("classSelected");		
		String selectedEquip = request.getParameter("EquipSelected");		
		List<Item> classItemList = assetDAO.getEquipName(selectedClass,selectedEquip);		
		Gson gsonBuilder = new GsonBuilder().create();		
		String classItemJson = gsonBuilder.toJson(classItemList);		
		return classItemJson.toString();		
	}	


	@RequestMapping(value = "/newAssetInstallation")
	public ModelAndView Asset_Installation(ModelAndView model,HttpSession session) {
		AssetInstallation asset_Install=new AssetInstallation();	
		
		
		String name=(String) session.getAttribute("userName");
	      System.out.println(" username->>>>>>>>>>>>>>>>>>>>>>........"+name);
	     List siteIds= assetDAO.fetchsiteIdsByUsername(name);
	     System.out.println("siteids by username.................."+siteIds);
		model.addObject("siteId",siteIds);
		asset_Install.setInstalled("No");
		asset_Install.setWorking("No");
		model.addObject("AssetInstallation", asset_Install);
		model.setViewName("assetInstallation");
		return model;
	}

	@RequestMapping(value = "/addAssetInstallation", method = RequestMethod.POST)
	public ModelAndView addAssetInstallation(@ModelAttribute AssetInstallation assetInstall,ModelMap model, RedirectAttributes redirectAttributes) {
		String status=null;
		if (assetInstall.getId() == 0) { 
			status=assetDAO.addAssetInstallation(assetInstall);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newAssetInstallation");
	}

	@RequestMapping(value = "/newEquipInstallation")
	public ModelAndView Equip_Installation(ModelAndView model) {
		EquipInstallation equip_Install=new EquipInstallation();	
		equip_Install.setInstalled("No");
		equip_Install.setWorking("No");
		model.addObject("EquipInstallation", equip_Install);
		model.setViewName("equipInstallation");
		return model;
	}

	@RequestMapping(value = "/addEquipInstallation", method = RequestMethod.POST)
	public ModelAndView addEquipInstallation(@ModelAttribute EquipInstallation equipInstall,ModelMap model, RedirectAttributes redirectAttributes) {
		String status=null;
		if (equipInstall.getId() == 0) { 
			status=assetDAO.addEquipInstallation(equipInstall);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newEquipInstallation");
	}

	@RequestMapping(value= "getSiteId", method = RequestMethod.GET)		
	@ResponseBody		
	public String getSiteId(HttpServletRequest request) {		
		//String poId = request.getParameter("PoId");		
		List<String> siteList = new ArrayList<String>();		
		List<Site> siteDataList = assetDAO.getSiteIdData();			
		System.out.println(siteDataList);		
		for (Site temp : siteDataList) {		
			siteList.add(temp.getSiteId());		
		}		
		System.out.println(siteList);		
		Gson gsonBuilder = new GsonBuilder().create();		
		String siteJson = gsonBuilder.toJson(siteList);		
		return siteJson.toString();		
	}		

	@RequestMapping(value= "getIndentId", method = RequestMethod.GET)		
	@ResponseBody		
	public String getIndentId(HttpServletRequest request) {		
		//String poId = request.getParameter("PoId");		
		List<String> indentList = new ArrayList<String>();		
		List<IndentData> indentDataList = assetDAO.getIndentdata();			
		System.out.println(indentDataList);		
		for (IndentData temp : indentDataList) {		
			indentList.add(temp.getIndentId());		
		}		
		System.out.println(indentList);		
		Gson gsonBuilder = new GsonBuilder().create();		
		String siteJson = gsonBuilder.toJson(indentList);		
		return siteJson.toString();		
	}


	@RequestMapping(value= "getLatLong", method = RequestMethod.GET)		
	@ResponseBody		
	public String getLatLong(HttpServletRequest request) {		
		String siteId = request.getParameter("siteId");		
		List<Site> LatLongList = new ArrayList<Site>();		
		List<Site> LatLongDataList = assetDAO.getLatLong(siteId);		

		for (int i = 0; i < LatLongDataList.size(); i++)		
		{		
			LatLongList.addAll(i,LatLongDataList);   		
		}		

		Gson gsonBuilder = new GsonBuilder().create();		
		String latlongJson = gsonBuilder.toJson(LatLongList);		
		System.out.println(latlongJson);		
		return latlongJson;		
	}


	@RequestMapping(value= "getAssetId", method = RequestMethod.GET)		
	@ResponseBody		
	public String getAssetId(HttpServletRequest request) {		
		String assetName= request.getParameter("assetName");		
		List<AssetInstallation> assetIdList = assetDAO.getAssetId(assetName);		
		Gson gsonBuilder = new GsonBuilder().create();		
		String assetIdJson = gsonBuilder.toJson(assetIdList);		
		System.out.println(assetIdJson);		
		return assetIdJson;		
	}

	@RequestMapping(value = "/sendEmail")
	public ModelAndView send_IndentEmail() {
		String siteId = null,indentId = null,quan=null,assetsName=null,equipName=null;
		List<IndentData> indentDataList = assetDAO.getLastIndentData();
		for(IndentData inList : indentDataList)
		{
			indentId= inList.getIndentId();
			quan =inList.getQuantity();
			siteId=inList.getSiteId();
			assetsName=inList.getAssetName();
			equipName=inList.getEquipName();
		}

		SimpleMailMessage simpleMsg=new SimpleMailMessage();
		simpleMsg.setTo("neeraja.chaparala@cyient.com");
		simpleMsg.setSubject("Approval For Indent");
		String data="Dear Team,Indent was raised with ID "+indentId+" for Site "+ siteId +" for the Assets " + assetsName;
		simpleMsg.setText(data);
		mailSender.send(simpleMsg);
		return new ModelAndView("redirect:/newIndent");
	}


	//	 @RequestMapping(value = "/sendEmail")
	//		public ModelAndView saveContacts(ModelAndView model) throws MessagingException {
	//		 String siteId = null,indentId = null,quan=null,assetsName=null,equipName=null;
	//	      List<Indent> indentDataList = assetDAO.getLastIndentData();
	//	      for(Indent inList : indentDataList)
	//	      {
	//	    	 indentId= inList.getIndentId();
	//	    	 quan =inList.getQuantity();
	//	    	 siteId=inList.getSiteId();
	//	    	 assetsName=inList.getAssetName();
	//	    	 equipName=inList.getEquipName();
	//	      }
	//	      
	//	      JavaMailSenderImpl sender = new JavaMailSenderImpl();
	//	      sender.setHost("172.17.4.45");
	//
	//	      MimeMessage message = sender.createMimeMessage();
	//
	//	      
	//	      SimpleMailMessage helper = new SimpleMailMessage();
	//	      helper.setText("<html><body>Dear Team, \n \n Indent was raised with <b>ID</b> "+indentId+" for Site "+ siteId +" for the Assets " + assetsName+"</body></html>");
	//	      helper.setTo("lakshmimadhuri.pulavarthy@cyient.com");
	//			helper.setSubject("Approval For Indent");
	//			String data="Dear Team,Indent was raised with ID "+indentId+" for Site "+ siteId +" for the Assets " + assetsName;
	//		      
	//			helper.setText(data);
	//		
	//			
	//			sender.send(helper);
	//			
	//			return new ModelAndView("redirect:/displaydevice");
	//		}


	@RequestMapping(value = "/logout")
	public String logout(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
		session.removeAttribute("userName");
		return "redirect:/";
	}
	
	
	// kiran for updating installation tables;
	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/saveStatus", method = RequestMethod.GET)
	public ModelAndView saveIndentApprovalStatus(HttpServletRequest request, HttpSession session) throws NoFieldException, ParseException {	    	
		IndentApproval indentApp=new IndentApproval();
		Indent indentDel=new Indent();

		//if (indentApp.getId() == 0) { 
		String indentItems=null,reqDate = null,assetId = null,assetName = null, classType = null, equipAsset = null, equipName = null, quantity = null, replacementType = null, requestFor = null, requestType = null, shelterId = null, siteId = null,modelNum=null;
		int stockInHand=0,id=0;
		String Status=request.getParameter("status");
		String statusId=request.getParameter("id");
		
		List<Indent> indentData=assetDAO.getIndentList(request.getParameter("indentId"));

		String username=session.getAttribute("userName").toString();
		for(Indent inList : indentData)
		{
			indentItems=inList.getItemName();
			reqDate=inList.getReqDate();
			assetId=inList.getAssetId();
			assetName=inList.getAssetName();
			classType=inList.getClassType();
			equipAsset=inList.getEqiupAsset();
			equipName=inList.getEquipName();
			quantity=inList.getQuantity();
			replacementType=inList.getReplacementType();
			requestType=inList.getRequestType();
			shelterId=inList.getShelterId();
			siteId=inList.getSiteId();
			stockInHand=inList.getStockInHand();
			id=inList.getId();
			modelNum=inList.getModelNum();

		}
				
		Date todayDate = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String strDate= formatter.format(todayDate);
		Date dt = formatter.parse(strDate);
		indentApp.setApprovedDate(dt);
		indentApp.setApprovedBy(username);
		indentApp.setCreatedDate(reqDate);
		indentApp.setItemName(indentItems);
		indentApp.setUserName(username);
		indentApp.setReqDate(reqDate);
		indentApp.setAssetId(assetId);
		indentApp.setAssetName(assetName);
		indentApp.setClassType(classType);
		indentApp.setEquipAsset(equipAsset);
		indentApp.setAssetName(assetName);
		indentApp.setEquipName(equipName);
		indentApp.setQuantity(quantity);
		indentApp.setReplacementType(replacementType);
		indentApp.setRequestType(requestType);
		indentApp.setShelterId(shelterId);
		indentApp.setSiteId(siteId);
		indentApp.setStockInHand(stockInHand);
		indentApp.setModelNum(modelNum);
		indentApp.setStatus(request.getParameter("status"));
		indentApp.setIndentId(request.getParameter("indentId"));
		assetDAO.addIndentApproval(indentApp);
		
		
		//List<IndentApproval> object =  (List<IndentApproval>) indentApp;
		List<IndentApproval> object =new ArrayList<IndentApproval>();
 		object.add(indentApp);
 		
		/// kiran
		/// deleting installation tracker and adding into indent table.
		System.out.println(" deleting installation tracker and adding into indent table");
		assetDAO.update_indent_tracker(object);	
		indentDel.setId(id);
		assetDAO.deleteIndent(indentDel);
		return new ModelAndView("redirect:/displaydevicestatus?id="+statusId,"Status",Status);
		
	}

	@RequestMapping(value= "getvendorAddress", method = RequestMethod.GET)
	@ResponseBody
	public String getVendorAddress(HttpServletRequest request) {
		String vendorName = request.getParameter("vendorName");
		List<VendorReg> vendorList = assetDAO.getVendorData(vendorName);
		System.out.println(vendorList);
		ArrayList<String> vendorsList = new ArrayList<String>();
		for(VendorReg vendor : vendorList)
		{
			vendorsList.add(vendor.getVendorId());
			vendorsList.add(vendor.getContactPerson());
			vendorsList.add(vendor.getAddress());
			vendorsList.add(vendor.getMobNum());
			vendorsList.add(vendor.getEmailId());
			vendorsList.add(vendor.getPanNo());
			vendorsList.add(vendor.getGstNum());
			vendorsList.add(Integer.toString(vendor.getId()));
		}
		System.out.println(vendorsList);
		Gson gsonBuilder = new GsonBuilder().create();
		String vendorJson = gsonBuilder.toJson(vendorsList);
		System.out.println(vendorJson);
		return vendorJson;
		
		
	}
	

	@RequestMapping(value= "getPurchaseDetails", method = RequestMethod.GET)
	@SuppressWarnings("rawtypes")
	@ResponseBody
	public String getPurchaseOrders(HttpServletRequest request) {
		String selectedPoId = request.getParameter("poId");				
		List<PurchaseOrderAssets> purchaseAssetList = assetDAO.getPurchaseAssetDetails(selectedPoId);
		System.out.println(purchaseAssetList);
		List<PurchaseOrderEquips> purchaseEquipsList = assetDAO.getPurchaseEquipsDetails(selectedPoId);
		ArrayList<Comparable> purchasesList = new ArrayList<Comparable>();
		for(PurchaseOrderAssets po : purchaseAssetList)
		{
			purchasesList.add(po.getAssetsPoId());		
			purchasesList.add("Assets");
			purchasesList.add(po.getAssetsCategoryClass());
			purchasesList.add(po.getAssetsType());
			purchasesList.add(po.getAssetsQuantity());
			purchasesList.add(po.getAssetsPrice());					 
			purchasesList.add(po.getAssetsTotalPrice());	
			purchasesList.add("--");	
		}
		
		for(PurchaseOrderEquips po:purchaseEquipsList)
		{
			purchasesList.add(po.getEquipsPoId());	
			purchasesList.add("Equipments");
			purchasesList.add(po.getEquipsCategoryClass());
			purchasesList.add(po.getEquipsType());
			purchasesList.add(po.getEquipsQuantity());
			purchasesList.add(po.getEquipsPrice());			 
			purchasesList.add(po.getEquipsTotalPrice());	
			purchasesList.add("--");
		}
		Gson gsonBuilder = new GsonBuilder().create();
		String purchasesJson = gsonBuilder.toJson(purchasesList);
		System.out.println(purchasesJson);
		return purchasesJson;
	}  
	
	@RequestMapping(value= "getIndentDetails", method = RequestMethod.GET)
	@SuppressWarnings("rawtypes")
	@ResponseBody
	public String getIndentDetails(HttpServletRequest request) {
		String selectedIndentId = request.getParameter("indentId");				
		List<IndentData> IndentList = assetDAO.getIndentDataInDC(selectedIndentId);
		ArrayList<Comparable> indentList = new ArrayList<Comparable>();
		for(IndentData indent : IndentList)
		{
			indentList.add(indent.getIndentId());
			indentList.add(indent.getEqiupAsset());
			indentList.add(indent.getClassType());
			if(indent.getEqiupAsset().equals("Assets"))
			{
				indentList.add(indent.getAssetName());
			}
			else if(indent.getEqiupAsset().equals("Equipments"))
			{
				indentList.add(indent.getEquipName());
			}
			indentList.add(indent.getModelNum());
			indentList.add(indent.getQuantity());
			indentList.add(indent.getReqDate());
			indentList.add("--");
		}
		
		Gson gsonBuilder = new GsonBuilder().create();
		String indentJson = gsonBuilder.toJson(indentList);
		System.out.println(indentJson);
		return indentJson;
	} 

	
	
    @RequestMapping(value="getDCWSImageAndSave", method=RequestMethod.POST)
    @ResponseBody
    public  String getImageDCWS( HttpServletRequest request, RedirectAttributes redirectAttributes) throws IOException{
		
    	///////
	    
	   JSONObject json;
	   String status = "Warehouse DC Added Successfully";
		try {
			
			json = new JSONObject(request.getParameter("input"));
			String dc = json.getString("items");   
			JSONArray jsonarray = new JSONArray(dc);
			String dcId=jsonarray.getJSONObject(0).getString("dcId");
			status = assetDAO.save_DCWS(jsonarray);
			//
		
			Thread obj=new Thread();
			
				MimeMessage message = mailSender.createMimeMessage();
			    try {
			    	obj.sleep(10000);
			        MimeMessageHelper helper = new MimeMessageHelper(message, true);
			        helper.setFrom("neeraja.chaparala@cyient.com");
			        helper.setTo("neeraja.chaparala@cyient.com");
			        helper.setSubject("DC");
			        helper.setText(" ----- ");
			        helper.addAttachment(dcId,new File("C:/Users/nc42628/Downloads/"+dcId+""));
			        mailSender.send(message);
			    } catch (MessagingException | InterruptedException e) {
			        e.printStackTrace();
			    }
			
			//
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(status);		
		redirectAttributes.addFlashAttribute("status", status);
		
	    
	    ///////
	   
		/*if (dc.getId() == 0) { 
			status=assetDAO.saveWarehouseDC(dc);
		} 

		redirectAttributes.addFlashAttribute("status", status);
	*/
	    
		return "success";
		
		
	}
    
    @RequestMapping(value="getDCVWImageAndSave", method=RequestMethod.POST)
    @ResponseBody
    public  String getImageDCVW( HttpServletRequest request, RedirectAttributes redirectAttributes) throws IOException{
		
    	///////
	    
	   JSONObject json;
	   String status = "Warehouse DC Added Successfully";
		try {
			
			json = new JSONObject(request.getParameter("input"));
			String dc = json.getString("items");   
			JSONArray jsonarray = new JSONArray(dc);
			String dcId=jsonarray.getJSONObject(0).getString("dcId");
			status = assetDAO.save_DCVW(jsonarray);
			//
			Thread obj=new Thread();
			MimeMessage message = mailSender.createMimeMessage();
		    try {
		    	obj.sleep(10000);
		        MimeMessageHelper helper = new MimeMessageHelper(message, true);
		        helper.setFrom("neeraja.chaparala@cyient.com");
		        helper.setTo("neeraja.chaparala@cyient.com");
		        helper.setSubject("DC");
		        helper.setText(" ----- ");
		        helper.addAttachment(dcId,new File("C:/Users/nc42628/Downloads/"+dcId+""));
		        mailSender.send(message);
		    } catch (MessagingException | InterruptedException e) {
		        e.printStackTrace();
		    }
		    
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(status);		
		redirectAttributes.addFlashAttribute("status", status);
		
	    
	    ///////
	   
		/*if (dc.getId() == 0) { 
			status=assetDAO.saveWarehouseDC(dc);
		} 

		redirectAttributes.addFlashAttribute("status", status);
	*/
	    
		return "success";
		
		
	}
	
}