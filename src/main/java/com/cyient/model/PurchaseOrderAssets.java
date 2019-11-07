package com.cyient.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PurchaseOrder_Assets")
public class PurchaseOrderAssets implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int assetsId;
	
	public int getAssetsId() {
		return assetsId;
	}

	public void setAssetsId(int assetsId) {
		this.assetsId = assetsId;
	}

	@Column
	private String assetsPoId;
	
	@Column
	 private String assetsVendorId;
	
	@Column
	 private String assetsVendorName;
	
	@Column
	private String assetsType;
	
	@Column
	 private String assetsName;
	
	@Column
	 private String assetsCategory;
	
	@Column
	 private String assetsCategoryClass;
	
	@Column
	 private int assetsQuantity;
	
	@Column
	 private int assetsPrice;
	
	@Column
	 private int assetsTotalPrice;

//	public int getAssetsId() {
//		return id;
//	}
//
//	public void setAssetsId(int assetsId) {
//		this.id = id;
//	}


	public String getAssetsPoId() {
		return assetsPoId;
	}

	public void setAssetsPoId(String assetsPoId) {
		this.assetsPoId = assetsPoId;
	}

	public String getAssetsVendorId() {
		return assetsVendorId;
	}

	public void setAssetsVendorId(String assetsVendorId) {
		this.assetsVendorId = assetsVendorId;
	}

	public String getAssetsVendorName() {
		return assetsVendorName;
	}

	public void setAssetsVendorName(String assetsVendorName) {
		this.assetsVendorName = assetsVendorName;
	}

	public String getAssetsType() {
		return assetsType;
	}

	public void setAssetsType(String assetsType) {
		this.assetsType = assetsType;
	}

	public String getAssetsName() {
		return assetsName;
	}

	public void setAssetsName(String assetsName) {
		this.assetsName = assetsName;
	}

	public String getAssetsCategory() {
		return assetsCategory;
	}

	public void setAssetsCategory(String assetsCategory) {
		this.assetsCategory = assetsCategory;
	}

	public String getAssetsCategoryClass() {
		return assetsCategoryClass;
	}

	public void setAssetsCategoryClass(String assetsCategoryClass) {
		this.assetsCategoryClass = assetsCategoryClass;
	}

	public int getAssetsQuantity() {
		return assetsQuantity;
	}

	public void setAssetsQuantity(int assetsQuantity) {
		this.assetsQuantity = assetsQuantity;
	}

	public int getAssetsPrice() {
		return assetsPrice;
	}

	public void setAssetsPrice(int assetsPrice) {
		this.assetsPrice = assetsPrice;
	}

	public int getAssetsTotalPrice() {
		return assetsTotalPrice;
	}

	public void setAssetsTotalPrice(int assetsTotalPrice) {
		this.assetsTotalPrice = assetsTotalPrice;
	}	

}