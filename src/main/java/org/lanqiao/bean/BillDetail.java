package org.lanqiao.bean;

import java.sql.Time;
import java.util.Date;

public class BillDetail {

	private int billDetailId;
	private int osId;
	private Os os;
	private int tariffId;
	private Tariff tariff;
	private Time timeLong;
	private double cost;
	private String months;
	
	
	@Override
	public String toString() {
		return "BillDetail [billDetailId=" + billDetailId + ", osId=" + osId + ", os=" + os + ", tariffId=" + tariffId
				+ ", tariff=" + tariff + ", timeLong=" + timeLong + ", cost=" + cost + ", months=" + months + "]";
	}


	public int getBillDetailId() {
		return billDetailId;
	}


	public void setBillDetailId(int billDetailId) {
		this.billDetailId = billDetailId;
	}


	public int getOsId() {
		return osId;
	}


	public void setOsId(int osId) {
		this.osId = osId;
	}


	public Os getOs() {
		return os;
	}


	public void setOs(Os os) {
		this.os = os;
	}


	public int getTariffId() {
		return tariffId;
	}


	public void setTariffId(int tariffId) {
		this.tariffId = tariffId;
	}


	public Tariff getTariff() {
		return tariff;
	}


	public void setTariff(Tariff tariff) {
		this.tariff = tariff;
	}


	public Date getTimeLong() {
		return timeLong;
	}


	public void setTimeLong(Time timeLong) {
		this.timeLong = timeLong;
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


	public BillDetail() {
		// TODO Auto-generated constructor stub
	}

}
