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
@Table(name = "order_Ack")
public class OrderAcknowledgement implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String indentId;
	
	@Column
	private String verName;
	
	@Column
	private String verDesignation;
	
	@Column
	private String verMobNum;
	
	@Column
	private String verEmailId;
	
	@Column
	private String receivedOrNot;
	
	 @Column
    //@Temporal(TemporalType.DATE)
	 @DateTimeFormat(pattern = "yyyy/mm/dd")  
	private String receivedDate;

	
	@Column
	private String comments;
	
	@Column
	private String siteId;
	
   
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public int getId() {
		return id;
	}

	public String getIndentId() {
		return indentId;
	}

	public void setIndentId(String indentId) {
		this.indentId = indentId;
	}

	public String getVerName() {
		return verName;
	}

	public void setVerName(String verName) {
		this.verName = verName;
	}

	public String getVerDesignation() {
		return verDesignation;
	}

	public void setVerDesignation(String verDesignation) {
		this.verDesignation = verDesignation;
	}

	public String getVerMobNum() {
		return verMobNum;
	}

	public void setVerMobNum(String verMobNum) {
		this.verMobNum = verMobNum;
	}

	public String getVerEmailId() {
		return verEmailId;
	}

	public void setVerEmailId(String verEmailId) {
		this.verEmailId = verEmailId;
	}

	public String getReceivedOrNot() {
		return receivedOrNot;
	}

	public void setReceivedOrNot(String receivedOrNot) {
		this.receivedOrNot = receivedOrNot;
	}

	public String getReceivedDate() {
		return receivedDate;
	}

	public void setReceivedDate(String receivedDate) {
		this.receivedDate = receivedDate;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
	
}