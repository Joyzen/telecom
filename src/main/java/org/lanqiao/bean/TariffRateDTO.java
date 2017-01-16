package org.lanqiao.bean;

public class TariffRateDTO {

	private int tariffId;  //资费ID
	private String tariffName;  //资费名称
	private String tariffType;  //资费类型
	private int times; //资费使用次数
	
	
	
	@Override
	public String toString() {
		return "TariffRateDTO [tariffId=" + tariffId + ", tariffName=" + tariffName + ", tariffType=" + tariffType
				+ ", times=" + times + "]";
	}
	public int getTariffId() {
		return tariffId;
	}
	public void setTariffId(int tariffId) {
		this.tariffId = tariffId;
	}
	public String getTariffName() {
		return tariffName;
	}
	public void setTariffName(String tariffName) {
		this.tariffName = tariffName;
	}
	public String getTariffType() {
		return tariffType;
	}
	public void setTariffType(String tariffType) {
		this.tariffType = tariffType;
	}
	public int getTimes() {
		return times;
	}
	public void setTimes(int times) {
		this.times = times;
	}

}
