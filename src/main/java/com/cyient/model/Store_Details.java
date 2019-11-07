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


	
	@Entity
	@Table(name = "StoreDetails")
	
	public class Store_Details implements Serializable {
		
		private static final long serialVersionUID = -3465813074586302847L;
		@Id
		@GeneratedValue(strategy = GenerationType.AUTO)
		private int storeId;

		@Column
		private String storeName;
		
		public String getStoreName() {
			return storeName;
		}

		public void setStoreName(String storeName) {
			this.storeName = storeName;
		}

		public String getStoreAddress() {
			return storeAddress;
		}

		public void setStoreAddress(String storeAddress) {
			this.storeAddress = storeAddress;
		}

		public String getInchargerEmail() {
			return inchargerEmail;
		}

		public void setInchargerEmail(String inchargerEmail) {
			this.inchargerEmail = inchargerEmail;
		}

		public String getInchargerNumber() {
			return inchargerNumber;
		}

		public void setInchargerNumber(String inchargerNumber) {
			this.inchargerNumber = inchargerNumber;
		}

		@Column
		private String storeAddress;
		
		@Column
		private String inchargerName;

		public int getStoreId() {
			return storeId;
		}

		public void setStoreId(int storeId) {
			this.storeId = storeId;
		}

		public String getInchargerName() {
			return inchargerName;
		}

		public void setInchargerName(String inchargerName) {
			this.inchargerName = inchargerName;
		}

		@Column
		private String inchargerEmail;

		@Column
		private String inchargerNumber;
		
		
		
		
		
		


}
