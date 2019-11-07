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
@Table(name = "equip_stock")
public class EquipStock implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String updationType;	
	
	@Column
	private String classType;	
	
	@Column
	private String equipment;	
	
	@Column
	private String equipName;	
	
	@Column
	private String equipDesc;	
	
	@Column
	private String vendorName;	
	
	@Column
	private int itemPrice;	
	
	@Column
	private int delNorms;	
	
	@Column
	private int orgStock;
	
	@Column
	private int sno;	
	
	 @Column
	 private String modelNum;
	
   public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}


	
	@Column
	private int stockInHand;	
	
	@Column
   // @Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy/mm/dd")
	private String stockInHandDate;
	
	@Column
    //@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy/mm/dd")  
	private String manufactureDate;
	
	@Column
   // @Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy/mm/dd")  
	private String expiryDate;
	
	
	public String getEquipDesc() {
		return equipDesc;
	}

	public void setEquipDesc(String equipDesc) {
		this.equipDesc = equipDesc;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUpdationType() {
		return updationType;
	}

	public void setUpdationType(String updationType) {
		this.updationType = updationType;
	}

	public String getClassType() {
		return classType;
	}

	public void setClassType(String classType) {
		this.classType = classType;
	}

	public String getEquipment() {
		return equipment;
	}

	public void setEquipment(String equipment) {
		this.equipment = equipment;
	}

	public String getEquipName() {
		return equipName;
	}

	public void setEquipName(String equipName) {
		this.equipName = equipName;
	}



	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}

	public int getDelNorms() {
		return delNorms;
	}

	public void setDelNorms(int delNorms) {
		this.delNorms = delNorms;
	}

	public int getOrgStock() {
		return orgStock;
	}

	public void setOrgStock(int orgStock) {
		this.orgStock = orgStock;
	}



	public int getStockInHand() {
		return stockInHand;
	}

	public void setStockInHand(int stockInHand) {
		this.stockInHand = stockInHand;
	}

	public String getStockInHandDate() {
		return stockInHandDate;
	}

	public void setStockInHandDate(String stockInHandDate) {
		this.stockInHandDate = stockInHandDate;
	}

	public String getManufactureDate() {
		return manufactureDate;
	}

	public void setManufactureDate(String manufactureDate) {
		this.manufactureDate = manufactureDate;
	}

	public String getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}

	public int getSno() {
		return sno;
	}

	public void setSno(int sno) {
		this.sno = sno;
	}

}