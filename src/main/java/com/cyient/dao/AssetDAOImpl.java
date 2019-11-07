package com.cyient.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.jboss.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.cyient.controller.AssetController;
import com.cyient.controller.ItemListController;
import com.cyient.controller.SubWarehouseController;
import com.cyient.model.AssetInstallation;
import com.cyient.model.AssetStock;
import com.cyient.model.DeliveryChallan;
import com.cyient.model.Device;
import com.cyient.model.EquipInstallation;
import com.cyient.model.EquipStock;
import com.cyient.model.Indent;
import com.cyient.model.IndentApproval;
import com.cyient.model.IndentData;
import com.cyient.model.IndentTracker;
import com.cyient.model.InstallationTracker;
import com.cyient.model.Item;
import com.cyient.model.ItemTracker;
import com.cyient.model.OrderAcknowledgement;
import com.cyient.model.PurchaseOrder;
import com.cyient.model.PurchaseOrderAssets;
import com.cyient.model.PurchaseOrderEquips;
import com.cyient.model.PurchaseRequest;
import com.cyient.model.Site;
import com.cyient.model.Store_Details;
import com.cyient.model.User;
import com.cyient.model.VendorReg;
import com.cyient.model.VendorSupplier;
import com.cyient.model.waerhouseDeliveryChallan;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;  
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
@SuppressWarnings("unused")
@Repository
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class AssetDAOImpl implements AssetDAO {
	private static final Logger logger = Logger
			.getLogger(AssetDAOImpl.class);
	@Autowired
	private SessionFactory sessionFactory;
	
	private static final String FILENAME = "/home/c-toc/Desktop/springlogs";


	/*@Override
	public String addUser(User user,String uname) {

		try
		{
			String getuser=sessionFactory.getCurrentSession().createQuery("select username from User where username='"+uname+"'").toString();
			if (getuser.isEmpty()){
			sessionFactory.getCurrentSession().saveOrUpdate(user);
			return "Success";
			}
			else
			{
				return "Exist";
			}
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}*/
	@Override
	public String addUser(User user) {

		try
		{
			String uname=user.getUsername();
			List userList=sessionFactory.getCurrentSession().createQuery("select username from User where username='"+uname+"'").list();
			System.out.println(userList);
		
			if (userList.isEmpty()){
				sessionFactory.getCurrentSession().saveOrUpdate(user);
				return "Success";
			}
			else
			{
				return "Exist";
			}
		}
		catch(Exception e)
		{
			return "Failure";
		}
		
	}

	@Override
	public void addDevice(Device device) {
		sessionFactory.getCurrentSession().saveOrUpdate(device);		
	}

	@Override
	public void addSite(Site site) {
		sessionFactory.getCurrentSession().saveOrUpdate(site);
	}

	@Override
	public String saveVendor(VendorSupplier vendor) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(vendor);
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}


	@Override
	public String indent_save(JSONArray jsonarray) {
		System.out.println("Indent_save");
		try{
			System.out.println("save indent"+jsonarray);
			for(int z=0;z<jsonarray.length();z++)
			{
				Indent indent_object = new Indent();
				JSONObject rec = jsonarray.getJSONObject(z);

				indent_object.setIndentId(rec.getString("indentId"));
				indent_object.setSiteId( rec.getString("siteId"));
				indent_object.setEqiupAsset(rec.getString("type"));
				indent_object.setClassType(rec.getString("class"));
				System.out.println("class"+rec.getString("requestedDate"));
				String type = rec.getString("type");
				if (type.contains("Assets")) {
					indent_object.setAssetName(rec.getString("Assertname"));
				} else {
					indent_object.setEquipName(rec.getString("equipments"));
				}				

				indent_object.setItemName(rec.getString("name"));
				indent_object.setQuantity(rec.getString("quantity"));
				String Requesttype = rec.getString("request_type");

				indent_object.setRequestType(Requesttype);
				if(Requesttype.contains("New"))
				{
					indent_object.setReplacementType("New");
				}
				else
				{
					indent_object.setReplacementType(rec.getString("repair_retair"));

				}
				indent_object.setReqDate(rec.getString("requestedDate"));
				indent_object.setStockInHand(Integer.parseInt(rec.getString("stockinhand")));
				indent_object.setModelNum(rec.getString("modelnumber"));
				//indent_object.setShelterId(shelterId);
				sessionFactory.getCurrentSession().saveOrUpdate(indent_object);

				//indent data insertion

				IndentData backup_indent = new IndentData();

				backup_indent.setIndentId(rec.getString("indentId"));
				backup_indent.setSiteId( rec.getString("siteId"));
				backup_indent.setEqiupAsset(rec.getString("type"));
				backup_indent.setClassType(rec.getString("class"));
				System.out.println("class"+rec.getString("requestedDate"));				
				if (type.contains("Assets")) {
					backup_indent.setAssetName(rec.getString("Assertname"));
				} else {
					backup_indent.setEquipName(rec.getString("equipments"));
				}				

				backup_indent.setItemName(rec.getString("name"));
				backup_indent.setQuantity(rec.getString("quantity"));

				backup_indent.setRequestType(Requesttype);
				if(Requesttype.contains("New"))
				{
					backup_indent.setReplacementType("New");
				}
				else
				{
					backup_indent.setReplacementType(rec.getString("repair_retair"));

				}
				backup_indent.setReqDate(rec.getString("requestedDate"));
				backup_indent.setStockInHand(Integer.parseInt(rec.getString("stockinhand")));
				backup_indent.setModelNum(rec.getString("modelnumber"));
				sessionFactory.getCurrentSession().saveOrUpdate(backup_indent);


			}

			return "Added Succesfully";

		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	@Override
	public String save_DCWS(JSONArray jsonarray)
	{
		System.out.println("DC_save");
		try{
			System.out.println("save DC"+jsonarray);
			for(int z=0;z<jsonarray.length();z++)
			{	
				waerhouseDeliveryChallan Warehousedc_object = new waerhouseDeliveryChallan();
				JSONObject rec = jsonarray.getJSONObject(z);
				Warehousedc_object.setDcId(rec.getString("dcId"));
				Warehousedc_object.setIndentId(rec.getString("indentId"));
				Warehousedc_object.setSiteName(rec.getString("siteName"));
				Warehousedc_object.setSiteId(rec.getString("siteId"));
				Warehousedc_object.setDcDate(rec.getString("dcDate"));
				sessionFactory.getCurrentSession().saveOrUpdate(Warehousedc_object);
				
				
			}
			return "Added Successfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
		
	}
	
	@Override
	public String save_DCVW(JSONArray jsonarray)
	{
		
		try{
			System.out.println("save DC"+jsonarray);
			for(int z=0;z<jsonarray.length();z++)
			{	
				DeliveryChallan Warehousedc_object = new DeliveryChallan();
				JSONObject rec = jsonarray.getJSONObject(z);
				Warehousedc_object.setDcId(rec.getString("dcId"));
				Warehousedc_object.setPoId(rec.getString("poId"));
				Warehousedc_object.setVendorName(rec.getString("vendorName"));
				Warehousedc_object.setVendorId(rec.getString("vendorId"));
				Warehousedc_object.setDcDate(rec.getString("dcDate"));
				sessionFactory.getCurrentSession().saveOrUpdate(Warehousedc_object);
				
				
			}
			return "Added Successfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}
	
	
	@Override
	public String saveAssetStock(AssetStock assetStock) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(assetStock);	
			Criteria c = sessionFactory.getCurrentSession().createCriteria(InstallationTracker.class);
			c.add(Restrictions.eq("className",assetStock.getClassType()));
			c.add(Restrictions.eq("equipAsset","Assets"));
			c.add(Restrictions.eq("itemType",assetStock.getAsset()));
			c.add(Restrictions.eq("itemName",assetStock.getAssetName()));        
			List tracker_list = c.list();
			String temp_id = null;

			int length = tracker_list.size();
			String assets = assetStock.getAssetName();
			String name = assetStock.getModelNum();
			String Classname = assetStock.getClassType();

			for(int i=0;i<assetStock.getOrgStock();i++)
			{
				int demo = 0;
				if(length==0)
				{
					temp_id = assets +"_"+name+"_"+"001";
				}
				else
				{
					if(length<9)
					{
						demo = length+1;
						temp_id = assets +"_"+name+"_"+"00"+demo;

					}
					else if(length>=9 && length<99)
					{
						demo = length+1;
						temp_id = assets +"_"+name+"_"+"0"+demo;
					}
					else
					{
						demo = length+1;
						temp_id = assets +"_"+name+"_"+demo;

					}	  
				}

				InstallationTracker object = new InstallationTracker();
				object.setClassName(Classname);
				object.setEquipAsset("Assets");
				object.setItemType(assetStock.getAsset());
				object.setItemName(assetStock.getAssetName());
				object.setEquipAssetId(temp_id);
				object.setVendor(assetStock.getVendorName());
				object.setModelNum(assetStock.getModelNum());
				//object.setManufacturedDate(assetStock.getManufactureDate());
				Date manufactureDate = null;
				Date expiryDate = null;
				
				try {
					manufactureDate = new SimpleDateFormat("yyyy/mm/dd").parse(assetStock.getManufactureDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					logger.error(e);
				}  
				object.setManufacturedDate(manufactureDate);
				try {
					expiryDate=new SimpleDateFormat("yyyy/mm/dd").parse(assetStock.getExpiryDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
				object.setExpiryDate(expiryDate);
				
				sessionFactory.getCurrentSession().save(object);

				ItemTracker item_tracker_new =  new ItemTracker();
				item_tracker_new.setClassName(Classname);
				item_tracker_new.setEquipAsset("Assets");
				item_tracker_new.setItemType(assetStock.getAsset());
				item_tracker_new.setItemName(assetStock.getAssetName());
				item_tracker_new.setEquipAssetId(temp_id);
				item_tracker_new.setVendor(assetStock.getVendorName());
				item_tracker_new.setManufacturedDate(manufactureDate);
				item_tracker_new.setExpiryDate(expiryDate);
				item_tracker_new.setModelNum(assetStock.getModelNum());
				sessionFactory.getCurrentSession().save(item_tracker_new);
				length = length + 1;
			}
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "failure";
		}

	}

	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
	public String updateStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel,String selectedassetDesc,String selectedvendorName,String selecteditemPrice,String selecteddelNorms,String selectedorgStock,String selectedstockInHand,String selectedstockInHandDate,String selectedmanufactureDate,String selectedexpiryDate,String selectedId,int tracker_status,int selectedreorderLevel) {

		int counter = 0;
		AssetStock object = new AssetStock();
		object.setId(Integer.parseInt(selectedId));
		object.setClassType(selectedClass);
		object.setAsset(selectedAsset);
		object.setAssetName(selectedassetName);
		object.setModelNum(selectedModel);
		object.setAssetDesc(selectedassetDesc);
		object.setVendorName(selectedvendorName);
		object.setItemPrice(Integer.parseInt(selecteditemPrice));
		object.setDelNorms(Integer.parseInt(selecteddelNorms));
		object.setOrgStock(Integer.parseInt(selectedorgStock));
		object.setStockInHand(Integer.parseInt(selectedstockInHand));
		object.setStockInHandDate(selectedstockInHandDate);
		object.setManufactureDate(selectedmanufactureDate);
		object.setExpiryDate(selectedexpiryDate);
		object.setReorderLevel(selectedreorderLevel);

		System.out.println("Before saving assetobject"+"old_value:"+tracker_status+"new value:"+selectedId);

		sessionFactory.getCurrentSession().update(object);	

		System.out.println("after saving assetobject"+"old_value:"+tracker_status+"new value:"+selectedorgStock);

		if(tracker_status == Integer.parseInt(selectedId))
		{
			System.out.println("Matched"+"old_value:"+tracker_status+"new value:"+selectedorgStock);
		}
		else
		{
			System.out.println("Not Matched"+"old_value:"+tracker_status+"new value:"+selectedorgStock);
			counter = Integer.parseInt(selectedorgStock)-tracker_status;
			Criteria c = sessionFactory.getCurrentSession().createCriteria(InstallationTracker.class);
			c.add(Restrictions.eq("className",selectedClass));
			c.add(Restrictions.eq("equipAsset","Assets"));
			c.add(Restrictions.eq("itemType",selectedAsset));
			c.add(Restrictions.eq("itemName",selectedassetName));        
			List tracker_list = c.list();
			String temp_id = null;

			int length = tracker_list.size();

			for(int i=0;i<counter;i++)
			{
				int demo = 0;
				if(length==0)
				{
					temp_id = selectedassetName +"_"+selectedModel+"_"+"001";
				}
				else
				{
					if(length<9)
					{
						demo = length+1;
						temp_id = selectedassetName +"_"+selectedModel+"_"+"00"+demo;

					}
					else if(length>=9 && length<99)
					{
						demo = length+1;
						temp_id = selectedassetName +"_"+selectedModel+"_"+"0"+demo;
					}
					else
					{
						demo = length+1;
						temp_id = selectedassetName +"_"+selectedModel+"_"+demo;

					}	  
				}
				System.out.println("Id generation");
				
				InstallationTracker installation_object = new InstallationTracker();
				installation_object.setClassName(selectedClass);
				installation_object.setEquipAsset("Assets");
				installation_object.setItemType(selectedAsset);
				installation_object.setItemName(selectedassetName);
				installation_object.setEquipAssetId(temp_id);
				installation_object.setVendor(selectedvendorName);
				installation_object.setModelNum(selectedModel);
				//object.setManufacturedDate(assetStock.getManufactureDate());
				
				
				Date manufactureDate = null;
				Date expiryDate = null;
				
				try {
					manufactureDate = new SimpleDateFormat("yyyy/mm/dd").parse(selectedmanufactureDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
				installation_object.setManufacturedDate(manufactureDate);
				try {
					expiryDate=new SimpleDateFormat("yyyy/mm/dd").parse(selectedexpiryDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
				installation_object.setExpiryDate(expiryDate);
				
				
				
				
				
				
				
				
				
				
				
				sessionFactory.getCurrentSession().save(installation_object);

				ItemTracker item_tracker_update =  new ItemTracker();
				item_tracker_update.setClassName(selectedClass);
				item_tracker_update.setEquipAsset("Assets");
				item_tracker_update.setItemType(selectedAsset);
				item_tracker_update.setItemName(selectedassetName);
				item_tracker_update.setEquipAssetId(temp_id);
				item_tracker_update.setVendor(selectedvendorName);
				//object.setManufacturedDate(assetStock.getManufactureDate());
				item_tracker_update.setManufacturedDate(manufactureDate);
				item_tracker_update.setExpiryDate(expiryDate);
				item_tracker_update.setModelNum(selectedModel);

				sessionFactory.getCurrentSession().save(item_tracker_update);


				length = length + 1;


			}

		}

		return "Updated";
	}


	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
	public String updateEquipmentStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel,String selectedassetDesc,String selectedvendorName,String selecteditemPrice,String selecteddelNorms,String selectedorgStock,String selectedstockInHand,String selectedstockInHandDate,String selectedmanufactureDate,String selectedexpiryDate,String selectedId,int tracker_status) {

		int counter = 0;
		EquipStock object = new EquipStock();
		object.setId(Integer.parseInt(selectedId));
		object.setClassType(selectedClass);
		object.setEquipment(selectedAsset);
		object.setEquipName(selectedassetName);
		object.setModelNum(selectedModel);
		object.setEquipDesc(selectedassetDesc);
		object.setVendorName(selectedvendorName);
		object.setItemPrice(Integer.parseInt(selecteditemPrice));
		object.setDelNorms(Integer.parseInt(selecteddelNorms));
		object.setOrgStock(Integer.parseInt(selectedorgStock));
		object.setStockInHand(Integer.parseInt(selectedstockInHand));
		object.setStockInHandDate(selectedstockInHandDate);
		object.setManufactureDate(selectedmanufactureDate);
		object.setExpiryDate(selectedexpiryDate);

		System.out.println("Before saving assetobject"+"old_value:"+tracker_status+"new value:"+selectedId);

		sessionFactory.getCurrentSession().update(object);	

		System.out.println("after saving assetobject"+"old_value:"+tracker_status+"new value:"+selectedorgStock);

		if(tracker_status == Integer.parseInt(selectedId))
		{
			System.out.println("Matched"+"old_value:"+tracker_status+"new value:"+selectedorgStock);
		}
		else
		{
			System.out.println("Not Matched"+"old_value:"+tracker_status+"new value:"+selectedorgStock);
			counter = Integer.parseInt(selectedorgStock)-tracker_status;
			Criteria c = sessionFactory.getCurrentSession().createCriteria(InstallationTracker.class);
			c.add(Restrictions.eq("className",selectedClass));
			c.add(Restrictions.eq("equipAsset","Equipments"));
			c.add(Restrictions.eq("itemType",selectedAsset));
			c.add(Restrictions.eq("itemName",selectedassetName));        
			List tracker_list = c.list();
			String temp_id = null;

			int length = tracker_list.size();

			for(int i=0;i<counter;i++)
			{
				int demo = 0;
				if(length==0)
				{
					temp_id = selectedassetName +"_"+selectedModel+"_"+"001";
				}
				else
				{
					if(length<9)
					{
						demo = length+1;
						temp_id = selectedassetName +"_"+selectedModel+"_"+"00"+demo;

					}
					else if(length>=9 && length<99)
					{
						demo = length+1;
						temp_id = selectedassetName +"_"+selectedModel+"_"+"0"+demo;
					}
					else
					{
						demo = length+1;
						temp_id = selectedassetName +"_"+selectedModel+"_"+demo;

					}	  
				}
				System.out.println("Id generation");
				InstallationTracker installation_object = new InstallationTracker();
				installation_object.setClassName(selectedClass);
				installation_object.setEquipAsset("Equipments");
				installation_object.setItemType(selectedAsset);
				installation_object.setItemName(selectedassetName);
				installation_object.setEquipAssetId(temp_id);
				installation_object.setVendor(selectedvendorName);
				installation_object.setModelNum(selectedModel);
				Date manufactureDate = null;
				Date expiryDate = null;
				
				try {
					manufactureDate = new SimpleDateFormat("yyyy/mm/dd").parse(selectedmanufactureDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
				installation_object.setManufacturedDate(manufactureDate);
				try {
					expiryDate=new SimpleDateFormat("yyyy/mm/dd").parse(selectedexpiryDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
				installation_object.setExpiryDate(expiryDate);
				
				//object.setManufacturedDate(assetStock.getManufactureDate());
				sessionFactory.getCurrentSession().save(installation_object);

				ItemTracker item_tracker_update =  new ItemTracker();
				item_tracker_update.setClassName(selectedClass);
				item_tracker_update.setEquipAsset("Equipments");
				item_tracker_update.setItemType(selectedAsset);
				item_tracker_update.setItemName(selectedassetName);
				item_tracker_update.setEquipAssetId(temp_id);
				item_tracker_update.setVendor(selectedvendorName);
				item_tracker_update.setManufacturedDate(manufactureDate);
				item_tracker_update.setExpiryDate(expiryDate);
				//object.setManufacturedDate(assetStock.getManufactureDate());
				item_tracker_update.setModelNum(selectedModel);

				sessionFactory.getCurrentSession().save(item_tracker_update);


				length = length + 1;


			}

		}

		return "Updated";
	}

	@Override
	public int get_orgstock(int id) {

		Criteria c = sessionFactory.getCurrentSession().createCriteria(AssetStock.class);
		c.add(Restrictions.eq("id",id));
		int temp = 0;
		List <AssetStock> old_object = (List<AssetStock>) c.list();

		if(old_object!=null)
		{
			for(AssetStock data:old_object)
			{
				temp=data.getOrgStock();
			}
		}
		return temp;
	}


	@Override
	public int get_orgstock_equipment(int id) {

		Criteria c = sessionFactory.getCurrentSession().createCriteria(AssetStock.class);
		c.add(Restrictions.eq("id",id));
		int temp = 0;
		List <EquipStock> old_object = (List<EquipStock>) c.list();

		if(old_object!=null)
		{
			for(EquipStock data:old_object)
			{
				temp=data.getOrgStock();
			}
		}
		return temp;
	}


	@Override
	public void saveEquipStock(EquipStock equipStock) {		
		sessionFactory.getCurrentSession().saveOrUpdate(equipStock);	

		Criteria c = sessionFactory.getCurrentSession().createCriteria(InstallationTracker.class);
		c.add(Restrictions.eq("className",equipStock.getClassType()));
		c.add(Restrictions.eq("equipAsset","Assets"));
		c.add(Restrictions.eq("itemType",equipStock.getEquipment()));
		c.add(Restrictions.eq("itemName",equipStock.getEquipName()));        
		List tracker_list = c.list();
		String temp_id = null;

		int length = tracker_list.size();
		String assets = equipStock.getEquipName();
		String name = equipStock.getModelNum();
		String Classname = equipStock.getClassType();

		for(int i=0;i<equipStock.getOrgStock();i++)
		{
			int demo = 0;
			if(length==0)
			{
				temp_id = assets +"_"+name+"_"+"001";
			}
			else
			{
				if(length<9)
				{
					demo = length+1;
					temp_id = assets +"_"+name+"_"+"00"+demo;

				}
				else if(length>=9 && length<99)
				{
					demo = length+1;
					temp_id = assets +"_"+name+"_"+"0"+demo;
				}
				else
				{
					demo = length+1;
					temp_id = assets +"_"+name+"_"+demo;

				}	  
			}

			InstallationTracker object = new InstallationTracker();
			object.setClassName(Classname);
			object.setEquipAsset("Equipments");
			object.setItemType(equipStock.getEquipment());
			object.setItemName(equipStock.getEquipName());
			object.setEquipAssetId(temp_id);
			object.setVendor(equipStock.getVendorName());
			object.setModelNum(equipStock.getModelNum());
			//object.setManufacturedDate(assetStock.getManufactureDate());
			Date manufactureDate = null;
			Date expiryDate = null;
			
			try {
				manufactureDate = new SimpleDateFormat("yyyy/mm/dd").parse(equipStock.getManufactureDate());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
			object.setManufacturedDate(manufactureDate);
			try {
				expiryDate=new SimpleDateFormat("yyyy/mm/dd").parse(equipStock.getExpiryDate());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
			object.setExpiryDate(expiryDate);
			
			sessionFactory.getCurrentSession().save(object);

			ItemTracker item_tracker_new =  new ItemTracker();
			item_tracker_new.setClassName(Classname);
			item_tracker_new.setEquipAsset("Equipments");
			item_tracker_new.setItemType(equipStock.getEquipment());
			item_tracker_new.setItemName(equipStock.getEquipName());
			item_tracker_new.setEquipAssetId(temp_id);
			item_tracker_new.setVendor(equipStock.getVendorName());
			//object.setManufacturedDate(assetStock.getManufactureDate());
			item_tracker_new.setModelNum(equipStock.getModelNum());
			item_tracker_new.setManufacturedDate(manufactureDate);
			item_tracker_new.setExpiryDate(expiryDate);

			sessionFactory.getCurrentSession().save(item_tracker_new);


			length = length + 1;


		}

	}

	@Override
	public String saveOrderAcknow(OrderAcknowledgement orderAck) {
		try
		{
			sessionFactory.getCurrentSession().saveOrUpdate(orderAck);
			return "Added Successfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	@Override
	public String addItem(Item item) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(item);
			return "Added Successfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	@Override
	public String addVendor(VendorReg vendor) {
		try
		{
			sessionFactory.getCurrentSession().saveOrUpdate(vendor);
			return "Added Successfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	@Override
	public void addPurchaseRequest(PurchaseRequest pr) {
		sessionFactory.getCurrentSession().saveOrUpdate(pr);
	}

	@Override
	public void addPurchaseOrder(PurchaseOrder po) {
		sessionFactory.getCurrentSession().saveOrUpdate(po);
	}

	@Override
	public String savePurchaseOrder(PurchaseOrder po) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(po);
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	@Override
	public void saveAssetsOrder(PurchaseOrderAssets poAssets) {
		sessionFactory.getCurrentSession().saveOrUpdate(poAssets);				
	}

	@Override
	public void saveEquipsOrder(PurchaseOrderEquips poEquips) {
		sessionFactory.getCurrentSession().saveOrUpdate(poEquips);				
	}

	@Override
	public String saveDeliveryChallan(DeliveryChallan dc) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(dc);
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	@Override
	public void saveIndent(Indent indent,IndentData indentData) {

		sessionFactory.getCurrentSession().saveOrUpdate(indent);
		sessionFactory.getCurrentSession().saveOrUpdate(indentData);
	}


	@Override			
	public String addAssetInstallation(AssetInstallation assetInstall) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(assetInstall);
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}

	}		

	@Override		
	public String addEquipInstallation(EquipInstallation equipInstall) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(equipInstall);
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}

	}

	@Override		
	public void addIndentApproval(IndentApproval inApp) {		
		sessionFactory.getCurrentSession().saveOrUpdate(inApp);				
	}

	@Override		
	public String addItemTracker(ItemTracker itemTrack){
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(itemTrack);
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	public List<User> getAllUsersOnCriteria(String username,String password) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(User.class);
		c.add(Restrictions.eq("username",username));
		c.add(Restrictions.eq("password",password));
		return (List<User>)c.list();
	}

	@SuppressWarnings("unchecked")
	public List<Device> getAllDevices() {
		return sessionFactory.getCurrentSession().createQuery("from Device").list();
	}

	@Override
	public void deleteDevice(Integer deviceId) {
		Device device = (Device) sessionFactory.getCurrentSession().load(Device.class, deviceId);
		if (null != device) {
			this.sessionFactory.getCurrentSession().delete(device);
		}

	}

	@SuppressWarnings("unchecked")
	public List<Device> getDevice(Integer deviceId) {
		return sessionFactory.getCurrentSession().createQuery("from Device where id="+deviceId).list();
	}

	@Override
	public Device updateDevice(Device device) {
		sessionFactory.getCurrentSession().update(device);
		return device;
	}

	@SuppressWarnings("unchecked")
	public List<PurchaseRequest> getAllRequests() {
		return sessionFactory.getCurrentSession().createQuery("from PurchaseRequest").list();
	}

	@Override
	public PurchaseRequest updatePurchaseRequest(PurchaseRequest pr) {		
		sessionFactory.getCurrentSession().update(pr);
		return pr;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String getLastRequestID() {
		List<PurchaseRequest> list1= sessionFactory.getCurrentSession().createQuery("select requestnumber from PurchaseRequest where id=(select max(id) from PurchaseRequest)").list();
		return list1.toString();
	}

	@Override
	public Device getDeviceData(int deviceId) {
		return (Device) sessionFactory.getCurrentSession().get(Device.class, deviceId);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<IndentApproval> getIndentItems(String indentId){
		return sessionFactory.getCurrentSession().createQuery("from IndentApproval where status='Approved' AND indentId='"+indentId+"'").list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getCategoryItems(String category) {
		return sessionFactory.getCurrentSession().createQuery("select distinct itemType from Item where category='"+category+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getCategoryClasses(String category) {
		return sessionFactory.getCurrentSession().createQuery("select distinct categoryClasses from Item where category='"+category+"'").list();
	}

	@SuppressWarnings("unchecked")
	public List<VendorReg> getVendors() {
		return sessionFactory.getCurrentSession().createQuery("from VendorReg").list();
	}

	@SuppressWarnings("unchecked")
	public List<IndentData> getIndents(){
		return sessionFactory.getCurrentSession().createQuery("from IndentData").list();
	}
	
	@SuppressWarnings("unchecked")
	public List<IndentApproval> getApprovedIndentIds(){
		
		return sessionFactory.getCurrentSession().createQuery("from IndentApproval where status='Approved'").list();
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<VendorReg> getLastVendorId() {		
		return sessionFactory.getCurrentSession().createQuery("select vendorId from VendorReg where id=(select max(id) from VendorReg)").list();		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getLastItemId() {
		return sessionFactory.getCurrentSession().createQuery("select itemId from Item where id=(select max(id) from Item)").list();		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PurchaseOrder> getLastPurchaseId() {
		return sessionFactory.getCurrentSession().createQuery("select poId from PurchaseOrder where id=(select max(id) from PurchaseOrder)").list();		
	}

	@SuppressWarnings("unchecked")
	public List<VendorReg> getVendorData(String vendorName) {
		return sessionFactory.getCurrentSession().createQuery("from VendorReg where vendorName='"+vendorName+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getClassItems(String selectedClass,String selectedCategory) {
		return sessionFactory.getCurrentSession().createQuery("select distinct itemType from Item where category='"+selectedCategory+"'and categoryClasses='"+selectedClass+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<VendorSupplier> getClassVendorItems(String selectedClass,String selectedCategory,String selectedVendor){
		return sessionFactory.getCurrentSession().createQuery(" from VendorSupplier where category='"+selectedCategory+"'and categoryClass='"+selectedClass+"'and vendorName='"+selectedVendor+"'" ).list();
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getCategoryTypes(String selectedCategory,String selectedClass,String selectedType) {
		return sessionFactory.getCurrentSession().createQuery("select distinct itemName from Item where category='"+selectedCategory+"'and categoryClasses='"+selectedClass+"'and itemType='"+selectedType+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getModelTypes(String selectedCategory,String selectedClass,String selectedType,String selectedModel) {
		return sessionFactory.getCurrentSession().createQuery("select distinct modelNum from Item where category='"+selectedCategory+"'and categoryClasses='"+selectedClass+"'and itemType='"+selectedType+"' and itemName='"+selectedModel+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getStockinhand(String selectequipAsset,String selectedClass,String selectedAsset,String selectedassetName,String selectedModel) {

		Criteria c = sessionFactory.getCurrentSession().createCriteria(InstallationTracker.class);
		c.add(Restrictions.eq("equipAsset",selectequipAsset));
		c.add(Restrictions.eq("className",selectedClass));
		c.add(Restrictions.eq("itemType",selectedAsset));
		c.add(Restrictions.eq("itemName",selectedassetName));      
		c.add(Restrictions.eq("modelNum",selectedModel));      
		

		return  c.list();
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Item> fetchStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel) {
		logger.error("log test");

		Criteria c = sessionFactory.getCurrentSession().createCriteria(AssetStock.class);
		c.add(Restrictions.eq("classType",selectedClass));
		c.add(Restrictions.eq("asset",selectedAsset));
		c.add(Restrictions.eq("assetName",selectedassetName));      
		c.add(Restrictions.eq("modelNum",selectedModel));      

		return  c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> fetchEquipmentStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel) {

		Criteria c = sessionFactory.getCurrentSession().createCriteria(EquipStock.class);
		c.add(Restrictions.eq("classType",selectedClass));
		c.add(Restrictions.eq("equipment",selectedAsset));
		c.add(Restrictions.eq("equipName",selectedassetName));      
		c.add(Restrictions.eq("modelNum",selectedModel));      

		return  c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DeliveryChallan> getLastChallanId() {
		return sessionFactory.getCurrentSession().createQuery("select dcId from DeliveryChallan where id=(select max(id) from DeliveryChallan)").list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<waerhouseDeliveryChallan> getWSLastChallanId(){
		return sessionFactory.getCurrentSession().createQuery("select dcId from waerhouseDeliveryChallan where id=(select max(id) from waerhouseDeliveryChallan)").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PurchaseOrder> getPOs() {
		return sessionFactory.getCurrentSession().createQuery("from PurchaseOrder").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site> getSites() {
		return sessionFactory.getCurrentSession().createQuery("from Site").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PurchaseOrder> getPoData(String poId) {
		return sessionFactory.getCurrentSession().createQuery("from PurchaseOrder where poId='"+poId+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<VendorReg> getVenId(String vendorName) {
		return sessionFactory.getCurrentSession().createQuery("select vendorId from VendorReg where vendorName='"+vendorName+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site> getLastSiteId() {
		return sessionFactory.getCurrentSession().createQuery("select siteId from Site where id=(select max(id) from Site)").list();	
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IndentData> getLastIndentId() {
		return sessionFactory.getCurrentSession().createQuery("select indentId from IndentData where id=(select max(id) from IndentData)").list();	
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site> getLatLong(String siteId) {
		return sessionFactory.getCurrentSession().createQuery("select latitude,longitude from Site where siteId='"+siteId+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getAssetName(String selectedClass, String selectedAsset) {
		return sessionFactory.getCurrentSession().createQuery("select distinct itemName from Item where itemType='"+selectedAsset+"'and categoryClasses='"+selectedClass+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getEquipName(String selectedClass, String selectedEquip) {
		return sessionFactory.getCurrentSession().createQuery("select distinct itemName from Item where itemType='"+selectedEquip+"'and categoryClasses='"+selectedClass+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AssetInstallation> getAssetId(String assetName) {
		return sessionFactory.getCurrentSession().createQuery("select Asset_Id from AssetInstallation where Asset_Name='"+assetName+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site> getSiteIdData() {
		return sessionFactory.getCurrentSession().createQuery("from Site").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IndentData> getLastIndentData() {
		return sessionFactory.getCurrentSession().createQuery("from IndentData where id=(select max(id) from Indent)").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Indent> getAllIndents() {
		return sessionFactory.getCurrentSession().createQuery("from Indent").list();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Indent> getIndentList(String indentId) {
		return sessionFactory.getCurrentSession().createQuery("from Indent where indentId='"+indentId+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PurchaseOrderAssets> getPurchaseAssetDetails(String selectedPoId) {
		return sessionFactory.getCurrentSession().createQuery("from PurchaseOrderAssets where assetsPoId='"+selectedPoId+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PurchaseOrderEquips> getPurchaseEquipsDetails(String selectedPoId){
		return sessionFactory.getCurrentSession().createQuery("from PurchaseOrderEquips where equipsPoId='"+selectedPoId+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getAllItems() {
		return sessionFactory.getCurrentSession().createQuery("from Item").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<VendorSupplier> getAllVendors() {
		return sessionFactory.getCurrentSession().createQuery("from VendorSupplier").list();
	}


	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
	public String updateVendor(VendorReg vendor) {
		try
		{
			sessionFactory.getCurrentSession().update(vendor);
			return "Updated Successfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<VendorReg> getVendorId(String vendorName) {
		return sessionFactory.getCurrentSession().createQuery("from VendorReg where vendorName='"+vendorName+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IndentData> getIndentdata() {
		return sessionFactory.getCurrentSession().createQuery("from IndentData").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IndentData> getIndentDataInDC(String indentId){
		return sessionFactory.getCurrentSession().createQuery("from IndentData where indentId='"+indentId+"'").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public String getIndentData(String IndentId){
		List<IndentData> List= sessionFactory.getCurrentSession().createQuery("select distinct siteId from IndentData where indentId='"+IndentId+"'").list();
		return List.toString();
	}

	@SuppressWarnings("unchecked")
	@Override
	public String getSiteData(String siteId){
		List<Site> List=sessionFactory.getCurrentSession().createQuery("select siteName from Site where siteId='"+siteId+"'").list();
		return List.toString();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DeliveryChallan> getPOIdsInDC() {
		return sessionFactory.getCurrentSession().createQuery("from DeliveryChallan").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<waerhouseDeliveryChallan> getIndentIdsInDC(){
		return sessionFactory.getCurrentSession().createQuery("from waerhouseDeliveryChallan").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PurchaseOrder> getIndentIdsInPO(){
		return sessionFactory.getCurrentSession().createQuery("from PurchaseOrder").list();
	}

	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
	public void deleteIndent(Indent indentDel)  {
		sessionFactory.getCurrentSession().delete(indentDel);

	}

	@Override
	public String saveWarehouseDC(waerhouseDeliveryChallan dc) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(dc);
			return "Added Succesfully";
		}
		catch(Exception e)
		{
			return "Failure";
		}
	}

	//kiran delettion installation tracker and adding indent tracker
	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
	public String update_indent_tracker(List<IndentApproval> object)
	{
		try{


			System.out.println("DAO  deleting installation tracker and adding into indent table");
			for(IndentApproval inList : object)
			{
				Criteria c = sessionFactory.getCurrentSession().createCriteria(InstallationTracker.class);
				c.add(Restrictions.eq("className",inList.getClassType()));
				c.add(Restrictions.eq("equipAsset",inList.getEquipAsset()));
				String equipAsset = inList.getEquipAsset();
				String itemType;
				if(equipAsset.equals("Assets"))
				{
					itemType = inList.getAssetName();
				}
				else
				{
					itemType = inList.getEquipName();
				}
				c.add(Restrictions.eq("itemType",itemType));
				c.add(Restrictions.eq("itemName",inList.getItemName()));
				c.add(Restrictions.eq("modelNum",inList.getModelNum()));



				int quantity = Integer.parseInt(inList.getQuantity());
				@SuppressWarnings("unchecked")
				List <InstallationTracker> InstallationTracker_object = (List<InstallationTracker>) c.list();


				int tempid = 0;
				if(InstallationTracker_object!=null)
				{
					for (int i=0;i<=quantity;i++)
					{

						for(InstallationTracker data:InstallationTracker_object)
						{
							if(quantity!=0 || quantity>0){
								if(inList.getStatus().contains("Approved"))
								{
									IndentTracker indent_object = new IndentTracker();
									indent_object.setClassName(data.getClassName());
									indent_object.setEquipAsset(data.getEquipAsset());
									indent_object.setEquipAssetId(data.getEquipAssetId());
									indent_object.setExpiryDate(data.getExpiryDate());
									indent_object.setIndentId(inList.getIndentId());
									indent_object.setItemName(data.getItemName());
									indent_object.setItemType(data.getItemType());
									indent_object.setManufacturedDate(data.getManufacturedDate());
									indent_object.setModelNum(data.getModelNum());
									indent_object.setVendor(data.getVendor());
									indent_object.setSiteId(inList.getSiteId());

									tempid = data.getId();
									sessionFactory.getCurrentSession().saveOrUpdate(indent_object);
									Session session = sessionFactory.getCurrentSession();
									session.beginTransaction();
									InstallationTracker employee = (InstallationTracker) session.get(InstallationTracker.class, tempid);
									session.delete(employee);
									session.getTransaction().commit();
									//sessionFactory.getCurrentSession().createQuery("delete from InstallationTracker where id='"+tempid+"'");
									quantity = quantity - 1;
								}

							}

						}
					}
				}		
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return "Success";

	}

	@Override
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
	public String delete_installation_trackerdata(int id)
	{
		InstallationTracker object  =  new InstallationTracker();
		object.setId(id);
		sessionFactory.getCurrentSession().delete(object);
		return "Deleted";
	}

	@Override
	public String reset_warehouse() {
		// TODO Auto-generated method stub
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Item> getAssetIdfromIndent(String siteId,String selectequipAsset,String selectedClass,String selectedAsset,String selectedassetName,String selectedModel) {

		Criteria c = sessionFactory.getCurrentSession().createCriteria(IndentTracker.class);
		c.add(Restrictions.eq("siteId",siteId));
		c.add(Restrictions.eq("equipAsset",selectequipAsset));
		c.add(Restrictions.eq("className",selectedClass));
		c.add(Restrictions.eq("itemType",selectedAsset));
		c.add(Restrictions.eq("itemName",selectedassetName));      
		c.add(Restrictions.eq("modelNum",selectedModel));      

		return  c.list();
	}

public void addStoreDetails(Store_Details storeDetails) {
        // TODO Auto-generated method stub
        sessionFactory.getCurrentSession().saveOrUpdate(storeDetails);

        
    }

public String custom_logger(String msg) {
	
	BufferedWriter bw = null;
	FileWriter fw = null;

	try {

		String data = msg;

		File file = new File(FILENAME);

		// if file doesnt exists, then create it
		if (!file.exists()) {
			file.createNewFile();
		}

		// true = append file
		fw = new FileWriter(file.getAbsoluteFile(), true);
		bw = new BufferedWriter(fw);
		bw.newLine();
		bw.write(data);

		System.out.println("Done");

	} catch (IOException e) {

		e.printStackTrace();

	} finally {

		try {

			if (bw != null)
				bw.close();

			if (fw != null)
				fw.close();

		} catch (IOException ex) {

			ex.printStackTrace();

		}
	}
	
	return "Logged";

}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<IndentData> fetchsiteIds() {
		return sessionFactory.getCurrentSession().createQuery(" select Distinct siteId from IndentTracker where siteId!=''").list();
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<IndentTracker> getSiteItemList(String s) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from IndentTracker where siteId='"+s+"'" ).list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<InstallationTracker> getwarehouseItemList() {	
		List list=new ArrayList();
		try
		{
			List data= sessionFactory.getCurrentSession().createQuery("select itemType , count(itemType) as available from InstallationTracker group by itemType").list();
			System.out.println(data);
			return data;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			return list;
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<InstallationTracker> getdetailwarehouseItemList(String type) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from InstallationTracker where itemType='"+type+"'" ).list();
	}

	@Override
	public List fetchsiteIdsByUsername(String name) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery(" select siteId from Site where username='"+name+"'" ).list();
	}

	@Override
	public List fetchIndentIdBySiteId(String name) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery(" select indentId from IndentApproval where siteId='"+name+"'" ).list();
	}

}