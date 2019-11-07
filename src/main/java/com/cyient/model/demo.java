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
@Table(name = "demo")
public class demo implements Serializable {
	private static final long serialVersionUID = -3465813074586302847L;
	
	@Id
	private int test;

	public int getTest() {
		return test;
	}

	public void setTest(int test) {
		this.test = test;
	}

	public String getDemocol() {
		return democol;
	}

	public void setDemocol(String democol) {
		this.democol = democol;
	}

	@Column
	private String democol;
}
