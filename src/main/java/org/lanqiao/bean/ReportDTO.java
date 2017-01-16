package org.lanqiao.bean;

import java.sql.Time;
import java.util.Date;

public class ReportDTO {

	private int customerId;
	private String customerAccount;
	private String customerName;
	private String idNumber;
	private String months;
	private String phone;
	private Customer customer;
	private long timeLong;
	
	@Override
	public String toString() {
		return "ReportDTO [customerId=" + customerId + ", customer=" + customer + ", timeLong=" + timeLong + "]";
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public long getTimeLong() {
		return timeLong;
	}
	public void setTimeLong(long timeLong) {
		this.timeLong = timeLong;
	}
	public String getCustomerAccount() {
		return customerAccount;
	}
	public void setCustomerAccount(String customerAccount) {
		this.customerAccount = customerAccount;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getIdNumber() {
		return idNumber;
	}
	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}
	public String getMonths() {
		return months;
	}
	public void setMonths(String months) {
		this.months = months;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

}
