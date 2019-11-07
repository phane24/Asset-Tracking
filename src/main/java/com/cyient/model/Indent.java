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
@Table(name = "Indent")
public class Indent implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String equipName;
	
	@Column
	private String quantity;
	
	@Column
	private int stockInHand;
	
	@Column
	//@Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	private String reqDate;
	
    @Column
    private String assetName;
    
    @Column
    private String eqiupAsset;

    @Column
    private String itemName;
    
    @Column
    private String siteId;
    
    @Column
    private String shelterId;
    
    @Column
    private String classType;
    
    @Column
    private String indentId;
    
    @Column
    private String assetId;
    
   
    @Column
    private String requestType;
    
    @Column
    private String replacementType;
    
	 @Column
	 private String modelNum;
    
	public String getShelterId() {
		return shelterId;
	}

	public void setShelterId(String shelterId) {
		this.shelterId = shelterId;
	}

	public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}

	public String getReplacementType() {
		return replacementType;
	}

	public void setReplacementType(String replacementType) {
		this.replacementType = replacementType;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public int getStockInHand() {
		return stockInHand;
	}

	public void setStockInHand(int stockInHand) {
		this.stockInHand = stockInHand;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	public String getEqiupAsset() {
		return eqiupAsset;
	}

	public void setEqiupAsset(String eqiupAsset) {
		this.eqiupAsset = eqiupAsset;
	}
	
	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getEquipName() {
		return equipName;
	}
	
	public void setEquipName(String equipName) {
		this.equipName = equipName;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
			
	public String getClassType() {
		return classType;
	}

	public void setClassType(String classType) {
		this.classType = classType;
	}

	public String getIndentId() {
		return indentId;
	}

	public void setIndentId(String indentId) {
		this.indentId = indentId;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	
    
}