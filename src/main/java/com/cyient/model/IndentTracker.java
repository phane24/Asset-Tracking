package com.cyient.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "indent_tracker")
public class IndentTracker implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
    @Column
    private String indentId;
	
	public String getIndentId() {
		return indentId;
	}

	public void setIndentId(String indentId) {
		this.indentId = indentId;
	}

	@Column
	private String equipAssetId;
	
	@Column
	private String equipAsset;	
	
	@Column
	private String itemType;
	
	@Column
	private String itemName;
	
	@Column
	 private String className;
	
    @Column
    private String vendor;
    
    @Column
	 private String modelNum;
    
    @Column
	 private String siteId;

  
		
	 public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}

	@Column
	 @Temporal(TemporalType.DATE)
	 private Date manufacturedDate;
	
	 @Column
	 @Temporal(TemporalType.DATE)
	 private Date expiryDate;
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEquipAssetId() {
		return equipAssetId;
	}

	public void setEquipAssetId(String equipAssetId) {
		this.equipAssetId = equipAssetId;
	}

	public String getEquipAsset() {
		return equipAsset;
	}

	public void setEquipAsset(String equipAsset) {
		this.equipAsset = equipAsset;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public Date getManufacturedDate() {
		return manufacturedDate;
	}

	public void setManufacturedDate(Date manufacturedDate) {
		this.manufacturedDate = manufacturedDate;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}
	
	


	
	
}