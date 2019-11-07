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

public interface AssetDAO {

	//Inserting Data into Forms

	/*@Transactional
	public String addUser(User user,String uname);*/
	
	@Transactional
	public String addUser(User user);

	@Transactional
	public void addDevice(Device device);

	@Transactional
	public void addPurchaseRequest(PurchaseRequest pr);

	@Transactional
	public String addVendor(VendorReg vendor);

	@Transactional
	public String updateVendor(VendorReg vendor);

	@Transactional
	public String addItem(Item item);

	@Transactional
	public String saveVendor(VendorSupplier vendor);

	@Transactional
	public void addPurchaseOrder(PurchaseOrder po);

	@Transactional
	public void addSite(Site site);

	@Transactional
	public String saveAssetStock(AssetStock assetStock);

	@Transactional
	public void saveEquipStock(EquipStock equipStock);

	@Transactional
	public String savePurchaseOrder(PurchaseOrder po);

	@Transactional
	public void saveAssetsOrder(PurchaseOrderAssets poAssets);

	@Transactional
	public void saveEquipsOrder(PurchaseOrderEquips poEquips);

	@Transactional
	public String saveDeliveryChallan(DeliveryChallan dc);
	
	@Transactional
	public String saveWarehouseDC(waerhouseDeliveryChallan dc);

	@Transactional
	public String saveOrderAcknow(OrderAcknowledgement orderAck);

	@Transactional
	public void saveIndent(Indent indent, IndentData indentData);

	@Transactional			
	public String addAssetInstallation(AssetInstallation assetInstall);			

	@Transactional			
	public String addEquipInstallation(EquipInstallation equipInstall);

	@Transactional			
	public void addIndentApproval(IndentApproval inApp);

	@Transactional		
	public String addItemTracker(ItemTracker itemTrack);

	@Transactional
	public List<User> getAllUsersOnCriteria(String username,String password);

	//Getting the last ID 
	@Transactional
	public List<PurchaseOrder> getLastPurchaseId();

	@Transactional
	public List<VendorReg> getLastVendorId();

	@Transactional
	public List<Item> getLastItemId();

	@Transactional
	public List<Site> getLastSiteId();

	@Transactional
	public List<DeliveryChallan> getLastChallanId();
	
	@Transactional
	public List<waerhouseDeliveryChallan> getWSLastChallanId();

	@Transactional
	public List<IndentData> getLastIndentId();

	@Transactional
	public String getLastRequestID();

	@Transactional
	public List<Device> getAllDevices();

	@Transactional
	public void deleteDevice(Integer deviceId);

	@Transactional
	public Device updateDevice(Device device);

	@Transactional
	public List<Device> getDevice(Integer deviceId);

	@Transactional
	public List<PurchaseRequest> getAllRequests();

	@Transactional
	public PurchaseRequest updatePurchaseRequest(PurchaseRequest pr);

	@Transactional
	public Device getDeviceData(int deviceId);

	@Transactional
	public List<IndentApproval> getIndentItems(String indentId);
	
	@Transactional
	public List<Item> getCategoryItems(String category);

	@Transactional
	public List<VendorReg> getVendors();
	
	@Transactional
	public List<IndentData> getIndents();
	
	@Transactional
	public List<IndentApproval> getApprovedIndentIds();

	@Transactional
	public List<VendorReg> getVendorData(String vendorName);

	@Transactional
	public List<Item> getCategoryClasses(String category);

	@Transactional
	public List<Item> getClassItems(String selectedClass,String selectedCategory);
	
	@Transactional
	public List<VendorSupplier> getClassVendorItems(String selectedClass,String selectedCategory,String selectedVendor);
	
	@Transactional
	public List<Item> getCategoryTypes(String selectedCategory,String selectedClass,String selectedType);

	@Transactional
	public List<Item> getModelTypes(String selectedCategory,String selectedClass,String selectedType,String selectedModel);

	@Transactional
	public List<Item> getStockinhand(String selectequipAsset,String selectedClass,String selectedAsset,String selectedassetName,String selectedModel);

	@Transactional
	public List<Item> fetchStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel);

	@Transactional
	public List<Item> fetchEquipmentStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel);

	@Transactional
	public String updateStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel,String selectedassetDesc,String selectedvendorName,String selecteditemPrice,String selecteddelNorms,String selectedorgStock,String selectedstockInHand,String selectedstockInHandDate,String selectedmanufactureDate,String selectedexpiryDate,String selectedId,int tracker_status,int selectedreorderLevel);

	@Transactional
	public String updateEquipmentStocksData(String selectedClass,String selectedAsset,String selectedassetName,String selectedModel,String selectedassetDesc,String selectedvendorName,String selecteditemPrice,String selecteddelNorms,String selectedorgStock,String selectedstockInHand,String selectedstockInHandDate,String selectedmanufactureDate,String selectedexpiryDate,String selectedId,int tracker_status);

	@Transactional
	public String indent_save(JSONArray jsonarray);
	
	@Transactional
	public String save_DCWS(JSONArray jsonarray);
	
	@Transactional
	public String save_DCVW(JSONArray jsonarray);
	
	@Transactional
	public int get_orgstock(int id);
	
	@Transactional
	public int get_orgstock_equipment(int id);
	
	@Transactional
	public List<PurchaseOrder> getPOs();
	
	@Transactional
	public List<DeliveryChallan> getPOIdsInDC();
	
	@Transactional
	public List<waerhouseDeliveryChallan> getIndentIdsInDC();
	
	@Transactional
	public List<PurchaseOrder> getIndentIdsInPO();
	
	@Transactional
	public List<Site> getSites();

	@Transactional
	public List<PurchaseOrder> getPoData(String poId);

	@Transactional
	public List<VendorReg> getVenId(String vendorName);

	@Transactional		
	public List<Item> getAssetName(String selectedClass,String selectedAsset);		

	@Transactional		
	public List<Item> getEquipName(String selectedClass,String selectedEquip);

	@Transactional		
	public List<AssetInstallation> getAssetId(String assetName);		

	@Transactional		
	public	List<Site> getSiteIdData();	

	@Transactional		
	public	List<IndentData> getIndentdata();
	
	@Transactional
	public List<IndentData> getIndentDataInDC(String indentId);
	
	@Transactional
	public String getIndentData(String IndentId);
	
	@Transactional
	public String getSiteData(String siteId);
	
	@Transactional		
	public List<Site> getLatLong(String siteId);

	@Transactional
	public List<IndentData> getLastIndentData();

	@Transactional
	public List<Indent> getAllIndents();

	@Transactional
	public List<Indent> getIndentList(String indentId);

	@Transactional
	public List<PurchaseOrderAssets> getPurchaseAssetDetails(String selectedPoId);

	@Transactional
	public List<PurchaseOrderEquips> getPurchaseEquipsDetails(String selectedPoId);
	
	@Transactional
	public List<Item> getAllItems();

	@Transactional
	public List<VendorSupplier> getAllVendors();

	@Transactional
	public List<VendorReg> getVendorId(String vendorName);

	@Transactional
	public void deleteIndent(Indent indentDel) throws NoFieldException;

	/*@Transactional
		public void deleteIndent(List<Indent> indentData);
	 */
	//kiran delettion installation tracker and adding indent tracker
	@Transactional
	public String update_indent_tracker(List<IndentApproval> object);
	
	@Transactional
	public String delete_installation_trackerdata(int id);
	
	@Transactional
	public String reset_warehouse();
	
	@Transactional
	public List<Item> getAssetIdfromIndent(String siteId,String selectequipAsset,String selectedClass,String selectedAsset,String selectedassetName,String selectedModel);
	
	@Transactional
    public void addStoreDetails(Store_Details storeDetails);

	@Transactional
	public String custom_logger(String msg);	

	@Transactional
	public List<IndentData> fetchsiteIds();

	@Transactional
	public List<IndentTracker> getSiteItemList(String s);
	
	@Transactional
	public List<InstallationTracker> getwarehouseItemList();
	
	@Transactional
	public List<InstallationTracker> getdetailwarehouseItemList(String type);
	
	@Transactional
	public List fetchsiteIdsByUsername(String name);
	
	
	
	@Transactional
	public List fetchIndentIdBySiteId(String s);
	
	
}
