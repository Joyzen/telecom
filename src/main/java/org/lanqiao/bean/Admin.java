package org.lanqiao.bean;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Admin {
	/**
	 * 管理员ID
	 */
	private int adminId;
	/**
	 * 管理员账号
	 */
	private String adminAccount;
	/**
	 * 管理员密码
	 */
	private String password;
	/**
	 * 管理员姓名
	 */
	private String adminName;
	/**
	 * 管理员身份证号
	 */
	private String idNumber;
	/**
	 * 管理员电话
	 */
	private String phone;
	/**
	 * 管理员邮箱
	 */
	private String email;
	/**
	 * 管理员创建时间
	 */
	private String createTime;
	
	/**
	 * 账号状态
	 */
	private String status;
	
	/**
	 * 权限
	 */
	private List<Integer> powers;
	
	//private MultipartFile img;  //头像
	
	/**
	 * 头像文件地址
	 */
	private String imgURL;
	
//	public MultipartFile getImg() {
//		return img;
//	}
//
//	public void setImg(MultipartFile img) {
//		this.img = img;
//	}

	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<Integer> getPowers() {
		return powers;
	}

	public void setPowers(List<Integer> powers) {
		this.powers = powers;
	}


	/**
	 * 管理员拥有的权限
	 */
	
	public Admin(){}

	public Admin(String adminAccount, String password, String adminName, String idNumber, String phone, String email) {
		super();
		this.adminAccount = adminAccount;
		this.password = password;
		this.adminName = adminName;
		this.idNumber = idNumber;
		this.phone = phone;
		this.email = email;
	}
	

	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public String getAdminAccount() {
		return adminAccount;
	}

	public void setAdminAccount(String adminAccount) {
		this.adminAccount = adminAccount;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}


	@Override
	public String toString() {
		return "Admin [adminId=" + adminId + ", adminAccount=" + adminAccount
				+ ", password=" + password + ", adminName=" + adminName
				+ ", idNumber=" + idNumber + ", phone=" + phone + ", email="
				+ email + ", createTime=" + createTime + ", status=" + status
				+ ", powers=" + powers + "]";
	}
}
