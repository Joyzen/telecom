package org.lanqiao.bean;

import java.util.Date;

public class OsLogin {
	private  int osLoginId; 
	private  String loginIp;
	private  Date loginInTime;
	private  Date loginOutTime;
	private  long timeLong;
	private  Os  os;
	private  double cost;
	
	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	public OsLogin(){
		super();
	}
	
	public int getOsLoginId() {
		return osLoginId;
	}

	public void setOsLoginId(int osLoginId) {
		this.osLoginId = osLoginId;
	}

	public String getLoginIp() {
		return loginIp;
	}
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	public Date getLoginInTime() {
		return loginInTime;
	}
	public void setLoginInTime(Date loginInTime) {
		this.loginInTime = loginInTime;
	}
	public Date getLoginOutTime() {
		return loginOutTime;
	}
	public void setLoginOutTime(Date loginOutTime) {
		this.loginOutTime = loginOutTime;
	}
	public long getTimeLong() {
		return timeLong;
	}
	public void setTimeLong(long timeLong) {
		this.timeLong = timeLong;
	}
	public Os getOs() {
		return os;
	}
	public void setOs(Os os) {
		this.os = os;
	}

	@Override
	public String toString() {
		return "OsLogin [osLoginId=" + osLoginId + ", loginIp=" + loginIp + ", loginInTime=" + loginInTime
				+ ", loginOutTime=" + loginOutTime + ", timeLong=" + timeLong + ", os=" + os + "]";
	}

}
