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

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "AssetInstallation")
public class AssetInstallation implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String siteId;
	
	@Column
	private String latitude;	
	
	@Column
	private String longitude;
	
	@Column
	private String class_Type;
	
    @Column
    private String asset;
	
	@Column
	private String asset_Name;
	
	@Column
	 private String asset_Id;
	
	 @Column
	 private String modelNum;
	
	 public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}

	@Column
	 //@Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private String manufacturedDate;
	
	 @Column
	// @Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private String expiryDate;
	
	 @Column
	 //@Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private String installedDate;
	 
	 @Column
	 private String sNo;
	
	@Column
	 private String installed;
	
	@Column
	 private String working;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getClass_Type() {
		return class_Type;
	}

	public void setClass_Type(String class_Type) {
		this.class_Type = class_Type;
	}

	public String getAsset() {
		return asset;
	}

	public void setAsset(String asset) {
		this.asset = asset;
	}

	public String getAsset_Name() {
		return asset_Name;
	}

	public void setAsset_Name(String asset_Name) {
		this.asset_Name = asset_Name;
	}

	public String getAsset_Id() {
		return asset_Id;
	}

	public void setAsset_Id(String asset_Id) {
		this.asset_Id = asset_Id;
	}

	public String getManufacturedDate() {
		return manufacturedDate;
	}

	public void setManufacturedDate(String manufacturedDate) {
		this.manufacturedDate = manufacturedDate;
	}

	public String getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}

	public String getInstalledDate() {
		return installedDate;
	}

	public void setInstalledDate(String installedDate) {
		this.installedDate = installedDate;
	}

	public String getsNo() {
		return sNo;
	}

	public void setsNo(String sNo) {
		this.sNo = sNo;
	}

	public String getInstalled() {
		return installed;
	}

	public void setInstalled(String installed) {
		this.installed = installed;
	}

	public String getWorking() {
		return working;
	}

	public void setWorking(String working) {
		this.working = working;
	}
	
	
}