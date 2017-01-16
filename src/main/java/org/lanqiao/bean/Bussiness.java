package org.lanqiao.bean;

public class Bussiness {

	private int bussinessId;
	private int osId;
	private String createTime; //创建时间
	private String openTime;   //开通时间
	private String deletTime;  //删除时间
	private String pauseTime;  //暂停时间
	private Os os;

	
	@Override
	public String toString() {
		return "Bussiness [bussinessId=" + bussinessId + ", osId=" + osId
				+ ", createTime=" + createTime + ", openTime=" + openTime
				+ ", deletTime=" + deletTime + ", pauseTime=" + pauseTime
				+ ", os=" + os + "]";
	}




	public Os getOs() {
		return os;
	}


	public void setOs(Os os) {
		this.os = os;
	}


	public Bussiness() {
		super();
	}


	public int getBussinessId() {
		return bussinessId;
	}
	


	public Bussiness(int bussinessId, int osId) {
		super();
		this.bussinessId = bussinessId;
		this.osId = osId;
	}


	public Bussiness(int osId) {
		super();
		this.osId = osId;
	}


	public void setBussinessId(int bussinessId) {
		this.bussinessId = bussinessId;
	}
	public String getCreateTime() {
		return createTime;
	}


	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}


	public int getOsId() {
		return osId;
	}
	public void setOsId(int osId) {
		this.osId = osId;
	}


	public String getOpenTime() {
		return openTime;
	}


	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}


	public String getDeletTime() {
		return deletTime;
	}


	public void setDeletTime(String deletTime) {
		this.deletTime = deletTime;
	}


	public String getPauseTime() {
		return pauseTime;
	}


	public void setPauseTime(String pauseTime) {
		this.pauseTime = pauseTime;
	}

	
	
}
