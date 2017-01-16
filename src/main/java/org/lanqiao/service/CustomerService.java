/**
 * 
 */
package org.lanqiao.service;

import java.util.Map;

import org.lanqiao.bean.Customer;
import org.lanqiao.bean.PageUtil;

/**
 * @author Joyzen
 *
 */
public interface CustomerService
{
	
	/**
	 * map传入条件查询页面显示数据
	 * @param map
	 * @return
	 */
	public PageUtil getPageData(Map map) ;
	
	/**
	 * 添加customer记录
	 * @param customer
	 * @return
	 */
	public boolean addCustomer(Customer customer);
	
	/**
	 * 修改customer记录
	 * @param customer
	 * @return
	 */
	public boolean updateCustomer(Customer customer);
	
	/**
	 * 根据ID查询Customer
	 * @param customerId
	 * @return
	 */
	public Customer getCustomerById(int customerId);
	
}
