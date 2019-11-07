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
@Table(name = "PurchaseOrder")
public class PurchaseOrder implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String poId;
	
	@Column 
	private String indentId;
	
	@Column
	private String vendorName;
	
	public String getVendorId() {
		return vendorId;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}

	@Column
	private String vendorId;	
	
	@Column
	@DateTimeFormat(pattern = "yyyy/mm/dd") 
	private String poDate;

	@Column
	 private String category;
	
	@Column
	 private String categoryClass;	
	
	@Column
	 private String [] classAAssets;
	
	@Column
	 private String [] classBAssets;
	
	@Column
	 private String [] classCAssets;
	
	@Column
	 private String [] classAEquips;
	
	@Column
	 private String [] classBEquips;
	
	@Column
	 private String [] classCEquips;	

	public String getCategoryClass() {
		return categoryClass;
	}

	public String[] getClassAAssets() {
		return classAAssets;
	}

	public void setClassAAssets(String[] classAAssets) {
		this.classAAssets = classAAssets;
	}

	public String[] getClassBAssets() {
		return classBAssets;
	}

	public void setClassBAssets(String[] classBAssets) {
		this.classBAssets = classBAssets;
	}

	public String[] getClassCAssets() {
		return classCAssets;
	}

	public void setClassCAssets(String[] classCAssets) {
		this.classCAssets = classCAssets;
	}

	public String[] getClassAEquips() {
		return classAEquips;
	}

	public void setClassAEquips(String[] classAEquips) {
		this.classAEquips = classAEquips;
	}

	public String[] getClassBEquips() {
		return classBEquips;
	}

	public void setClassBEquips(String[] classBEquips) {
		this.classBEquips = classBEquips;
	}

	public String[] getClassCEquips() {
		return classCEquips;
	}

	public void setClassCEquips(String[] classCEquips) {
		this.classCEquips = classCEquips;
	}

	public void setCategoryClass(String categoryClass) {
		this.categoryClass = categoryClass;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPoDate() {
		return poDate;
	}

	public void setPoDate(String poDate) {
		this.poDate = poDate;
	}

	public String getPoId() {
		return poId;
	}

	public void setPoId(String poId) {
		this.poId = poId;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getIndentId() {
		return indentId;
	}

	public void setIndentId(String indentId) {
		this.indentId = indentId;
	}
	
	
}