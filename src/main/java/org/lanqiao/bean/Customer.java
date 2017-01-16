package org.lanqiao.bean;

public class Customer {

	private int customerId;  //账务账号ID
	private String customerName; //姓名
	private String idNumber;  //身份证号码
	private String phone;  //电话号码
	private String customerAccount;  //登陆名
	private String password;  //密码
	private String createTime;  //创建时间
	private String status;  //状态
	private String lastLoginTime;  //上次登录时间
	private String pauseTime;  //暂停时间
	private String delTime;  //删除时间
	private String email;  //电子邮箱
	private String sex;  //性别
	private String job;  //职业
	private Os os;
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Customer(int customerId, String customerName, String idNumber, String phone, String customerAccount,
			String password, String createTime, String status, String lastLoginTime, String pauseTime, String delTime) {
		super();
		this.customerId = customerId;
		this.customerName = customerName;
		this.idNumber = idNumber;
		this.phone = phone;
		this.customerAccount = customerAccount;
		this.password = password;
		this.createTime = createTime;
		this.status = status;
		this.lastLoginTime = lastLoginTime;
		this.pauseTime = pauseTime;
		this.delTime = delTime;
	}
	public String getPauseTime() {
		return pauseTime;
	}
	public void setPauseTime(String pauseTime) {
		this.pauseTime = pauseTime;
	}
	public String getDelTime() {
		return delTime;
	}
	public void setDelTime(String delTime) {
		this.delTime = delTime;
	}
	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", customerName=" + customerName + ", idNumber=" + idNumber
				+ ", phone=" + phone + ", customerAccount=" + customerAccount + ", password=" + password
				+ ", createTime=" + createTime + ", status=" + status + ", lastLoginTime=" + lastLoginTime + "]";
	}
	public Customer(String customerName, String idNumber, String phone, String customerAccount, String password,
			String createTime, String status, String lastLoginTime) {
		super();
		this.customerName = customerName;
		this.idNumber = idNumber;
		this.phone = phone;
		this.customerAccount = customerAccount;
		this.password = password;
		this.createTime = createTime;
		this.status = status;
		this.lastLoginTime = lastLoginTime;
	}
	public Customer(int customerId, String customerName, String idNumber, String phone, String customerAccount,
			String password, String createTime, String status, String lastLoginTime) {
		super();
		this.customerId = customerId;
		this.customerName = customerName;
		this.idNumber = idNumber;
		this.phone = phone;
		this.customerAccount = customerAccount;
		this.password = password;
		this.createTime = createTime;
		this.status = status;
		this.lastLoginTime = lastLoginTime;
	}
	public Customer() {
		super();
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCustomerAccount() {
		return customerAccount;
	}
	public void setCustomerAccount(String customerAccount) {
		this.customerAccount = customerAccount;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	
	
	
}
