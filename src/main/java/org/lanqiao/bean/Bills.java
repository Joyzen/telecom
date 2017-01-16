package org.lanqiao.bean;

public class Bills {

	private int billId;
	private int customerId;
	private Customer customer;
	private double cost;
	private String months;
	private String payWay;
	private String payStatus;
	
	public int getBillId() {
		return billId;
	}

	public void setBillId(int billId) {
		this.billId = billId;
	}

	@Override
	public String toString() {
		return "Bills [billId=" + billId + ", customerId=" + customerId + ", customer=" + customer + ", cost=" + cost
				+ ", months=" + months + ", payWay=" + payWay + ", payStatus=" + payStatus + "]";
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

	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	public String getMonths() {
		return months;
	}

	public void setMonths(String months) {
		this.months = months;
	}

	public String getPayWay() {
		return payWay;
	}

	public void setPayWay(String payWay) {
		this.payWay = payWay;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	
	public Bills() {
		// TODO Auto-generated constructor stub
	}

}
