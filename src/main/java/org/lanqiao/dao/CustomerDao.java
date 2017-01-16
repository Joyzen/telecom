/**
 * 
 */
package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.lanqiao.bean.Customer;

/**
 * @author Joyzen
 *
 */
@Mapper
public interface CustomerDao
{
	/**
	 * 根据条件查询
	 * @param map
	 * @return
	 */
	public List<Customer> selectCustomerByCondition(Map map);
	
	/**
	 * 插入账务账号
	 * @return
	 */
	public int insertCustomer(Customer customer);
	
	/**
	 * 根据customerId查询账务账号
	 * @param customerId
	 * @return
	 */
	public int delCustomer(int customerId);
	
	/**
	 * 更新customer记录
	 * @param customer
	 * @return
	 */
	public int updateCustomer(Customer customer);
	
	/**
	 * 根据条件查询总记录条数
	 * @param map
	 * @return
	 */
	public int countCustomer(Map map);
	
	/**
	 * 根据customerId搜索customer
	 * @param customerId
	 * @return
	 */
	public Customer selectCustomerByCustomerId(int customerId);
	
}
