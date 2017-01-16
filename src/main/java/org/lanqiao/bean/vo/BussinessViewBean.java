/**
 * 
 */
package org.lanqiao.bean.vo;

/**
 * @author Administrator
 *
 */
public class BussinessViewBean
{
	private int bussinessId;
	private int customerId;
	private String idNumber;
	private String customerName;
	private String osAccount;
	private String status;
	private String tariffName;
	private String tariffExplain;
	
	@Override
	public String toString() {
		return "BussinessViewBean [bussinessId=" + bussinessId + ", customerId="
				+ customerId + ", idNumber=" + idNumber + ", customerName="
				+ customerName + ", osAccount=" + osAccount + ", status="
				+ status + ", tariffName=" + tariffName + ", tariffExplain="
				+ tariffExplain + "]";
	}
	public int getBussinessId() {
		return bussinessId;
	}
	public void setBussinessId(int bussinessId) {
		this.bussinessId = bussinessId;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getIdNumber() {
		return idNumber;
	}
	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getOsAccount() {
		return osAccount;
	}
	public void setOsAccount(String osAccount) {
		this.osAccount = osAccount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTariffName() {
		return tariffName;
	}
	public void setTariffName(String tariffName) {
		this.tariffName = tariffName;
	}
	public String getTariffExplain() {
		return tariffExplain;
	}
	public void setTariffExplain(String tariffExplain) {
		this.tariffExplain = tariffExplain;
	}
	
}
