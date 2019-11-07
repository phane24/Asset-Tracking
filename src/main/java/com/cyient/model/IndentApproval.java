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
@Table(name = "indent_approval")
public class IndentApproval implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String userName;
	
	@Column
	private String assetName;
	
	@Column
	private String classType;
	
	@Column
	private String equipAsset;
	
	@Column
	private String equipName;
	
	@Column
	private String quantity;
	
	@Column
	private String replacementType;
	
	@Column
	private String reqDate;
	
	@Column 
	private String requestFor;
	
	@Column
	private String requestType;
	
	@Column
	private String shelterId;
	
	@Column
	private String siteId;
	
	@Column
	private int stockInHand;
	
	@Column
	private String assetId;
	
	@Column
	private String indentId;	

	@Column
	private String status;	
	
	@Column
	private String approvedBy;
	
	@Column
	private String itemName;
	
	@Column
	private String modelNum;
		
	 @Column
	// @Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private String CreatedDate;
	
	 @Column
	 @Temporal(TemporalType.DATE)
	// @DateTimeFormat(pattern = "yyyy/mm/dd")  
	 private Date approvedDate;
	
	
	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	public String getClassType() {
		return classType;
	}

	public void setClassType(String classType) {
		this.classType = classType;
	}

	public String getEquipAsset() {
		return equipAsset;
	}

	public void setEquipAsset(String equipAsset) {
		this.equipAsset = equipAsset;
	}

	public String getEquipName() {
		return equipName;
	}

	public void setEquipName(String equipName) {
		this.equipName = equipName;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getReplacementType() {
		return replacementType;
	}

	public void setReplacementType(String replacementType) {
		this.replacementType = replacementType;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public String getRequestFor() {
		return requestFor;
	}

	public void setRequestFor(String requestFor) {
		this.requestFor = requestFor;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}

	public String getShelterId() {
		return shelterId;
	}

	public void setShelterId(String shelterId) {
		this.shelterId = shelterId;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getIndentId() {
		return indentId;
	}

	public void setIndentId(String indentId) {
		this.indentId = indentId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getApprovedBy() {
		return approvedBy;
	}

	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getCreatedDate() {
		return CreatedDate;
	}

	public void setCreatedDate(String reqDate) {
		CreatedDate = reqDate;
	}

	public Date getApprovedDate() {
		return approvedDate;
	}

	public void setApprovedDate(Date todayDate) {
		this.approvedDate = todayDate;
	}

	public int getStockInHand() {
		return stockInHand;
	}

	public void setStockInHand(int stockInHand) {
		this.stockInHand = stockInHand;
	}

	public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}
	
}