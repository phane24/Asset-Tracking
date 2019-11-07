package com.cyient.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Devices")
public class Device implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column
	private String deviceName;
	
	@Column
	private String vendorName;
	
    public Date getStockReceivedDate() {
		return stockReceivedDate;
	}

	public void setStockReceivedDate(Date stockReceivedDate) {
		this.stockReceivedDate = stockReceivedDate;
	}

	@Column
    @DateTimeFormat(pattern="dd/mm/yyyy")
    private Date stockReceivedDate;
	
	
	@Column
	private int receivedStockNum;
	
	@Column
	private int deliveredStockNum;
	
	@Column
	private String deliveredTo;
	
	@Column
	 private int stockInHand;
	
	@Column
	 private String remarks;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public int getReceivedStockNum() {
		return receivedStockNum;
	}

	public void setReceivedStockNum(int receivedStockNum) {
		this.receivedStockNum = receivedStockNum;
	}

	public int getDeliveredStockNum() {
		return deliveredStockNum;
	}

	public void setDeliveredStockNum(int deliveredStockNum) {
		this.deliveredStockNum = deliveredStockNum;
	}

	public String getDeliveredTo() {
		return deliveredTo;
	}

	public void setDeliveredTo(String deliveredTo) {
		this.deliveredTo = deliveredTo;
	}

	public int getStockInHand() {
		return stockInHand;
	}

	public void setStockInHand(int stockInHand) {
		this.stockInHand = stockInHand;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	
}