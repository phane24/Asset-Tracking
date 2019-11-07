package com.cyient.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.json.JSONArray;

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

import javassist.compiler.NoFieldException;

public interface FinanceDAO {

	//Inserting Data into Forms

	/*@Transactional
	public String addUser(User user,String uname);*/
	
	@Transactional
	public List<Indent> getAllIndents();

	
	@Transactional
	public List<IndentApproval> fetchApprovalsList();
	
	
	
	@Transactional
	public List<IndentApproval> fetchDetailApprovedIndent(String id);
	
	@Transactional
	public String saveVendor(VendorSupplier vendor);
	
	@Transactional
	public List<IndentApproval> fetchRejectedList();
	
}
