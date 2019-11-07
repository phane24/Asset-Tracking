package com.cyient.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PurchaseOrder_Equips")
public class PurchaseOrderEquips implements Serializable{

	private static final long serialVersionUID = -3465813074586302847L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int equipsId;
	
	@Column
	private String equipsPoId;
	
	@Column
	 private String equipsVendorId;
	
	@Column
	 private String equipsVendorName;
	
	@Column
	private String equipsType;
	
	@Column
	 private String equipsName;
	
	@Column
	 private String equipsCategory;
	
	@Column
	 private String equipsCategoryClass;
	
	@Column
	 private int equipsQuantity;
	
	@Column
	 private int equipsPrice;
	
	@Column
	 private int equipsTotalPrice;

	public int getEquipsId() {
		return equipsId;
	}

	public void setEquipsId(int equipsId) {
		this.equipsId = equipsId;
	}

	public String getEquipsPoId() {
		return equipsPoId;
	}

	public void setEquipsPoId(String equipsPoId) {
		this.equipsPoId = equipsPoId;
	}

	public String getEquipsVendorId() {
		return equipsVendorId;
	}

	public void setEquipsVendorId(String equipsVendorId) {
		this.equipsVendorId = equipsVendorId;
	}

	public String getEquipsVendorName() {
		return equipsVendorName;
	}

	public void setEquipsVendorName(String equipsVendorName) {
		this.equipsVendorName = equipsVendorName;
	}

	public String getEquipsType() {
		return equipsType;
	}

	public void setEquipsType(String equipsType) {
		this.equipsType = equipsType;
	}

	public String getEquipsName() {
		return equipsName;
	}

	public void setEquipsName(String equipsName) {
		this.equipsName = equipsName;
	}

	public String getEquipsCategory() {
		return equipsCategory;
	}

	public void setEquipsCategory(String equipsCategory) {
		this.equipsCategory = equipsCategory;
	}

	public String getEquipsCategoryClass() {
		return equipsCategoryClass;
	}

	public void setEquipsCategoryClass(String equipsCategoryClass) {
		this.equipsCategoryClass = equipsCategoryClass;
	}

	public int getEquipsQuantity() {
		return equipsQuantity;
	}

	public void setEquipsQuantity(int equipsQuantity) {
		this.equipsQuantity = equipsQuantity;
	}

	public int getEquipsPrice() {
		return equipsPrice;
	}

	public void setEquipsPrice(int equipsPrice) {
		this.equipsPrice = equipsPrice;
	}

	public int getEquipsTotalPrice() {
		return equipsTotalPrice;
	}

	public void setEquipsTotalPrice(int equipsTotalPrice) {
		this.equipsTotalPrice = equipsTotalPrice;
	}	
	

}