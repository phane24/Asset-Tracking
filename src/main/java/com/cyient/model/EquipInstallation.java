package com.cyient.model;

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
@Table(name="EquipInstallation")

public class EquipInstallation {
	
	private static final long serialVersionUID = -3465813074586302847L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int Id;
	
	@Column
	private String SiteId;
	
	@Column
	private String Latitude;
	
	@Column
	private String Longitude;
	
	@Column
	private String Class_Type;
	
    public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	@Column
    private String Equipment;
	
	@Column
	private String Equip_Name;
	
	@Column
	private String Equip_Id;
	
	 @Column
	 //@Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private String ManufacturedDate;
	
	 @Column
	 //@Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private String ExpiryDate;
	
	 @Column
	// @Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private String InstalledDate;
	 
	 @Column
	 private String SNo;
	
	@Column
	 private String Installed;
	
	@Column
	 private String Working;
	 
    @Column
	 private String modelNum;
    
	public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}

	public String getSNo() {
		return SNo;
	}

	public void setSNo(String sNo) {
		SNo = sNo;
	}

	public String getInstalled() {
		return Installed;
	}

	public void setInstalled(String installed) {
		Installed = installed;
	}

	public String getWorking() {
		return Working;
	}

	public void setWorking(String working) {
		Working = working;
	}

	public String getSiteId() {
		return SiteId;
	}

	public void setSiteId(String siteId) {
		SiteId = siteId;
	}

	public String getLatitude() {
		return Latitude;
	}

	public void setLatitude(String latitude) {
		Latitude = latitude;
	}

	public String getLongitude() {
		return Longitude;
	}

	public void setLongitude(String longitude) {
		Longitude = longitude;
	}

	public String getClass_Type() {
		return Class_Type;
	}

	public void setClass_Type(String class_Type) {
		Class_Type = class_Type;
	}

	public String getEquipment() {
		return Equipment;
	}

	public void setEquipment(String equipment) {
		Equipment = equipment;
	}

	public String getEquip_Name() {
		return Equip_Name;
	}

	public void setEquip_Name(String equip_Name) {
		Equip_Name = equip_Name;
	}

	public String getEquip_Id() {
		return Equip_Id;
	}

	public void setEquip_Id(String equip_Id) {
		Equip_Id = equip_Id;
	}

	public String getManufacturedDate() {
		return ManufacturedDate;
	}

	public void setManufacturedDate(String manufacturedDate) {
		ManufacturedDate = manufacturedDate;
	}

	public String getExpiryDate() {
		return ExpiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		ExpiryDate = expiryDate;
	}

	public String getInstalledDate() {
		return InstalledDate;
	}

	public void setInstalledDate(String installedDate) {
		InstalledDate = installedDate;
	}

}
