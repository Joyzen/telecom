/**
 * 
 */
package org.lanqiao.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.Customer;
import org.lanqiao.bean.PageUtil;
import org.lanqiao.dao.CustomerDao;
import org.lanqiao.service.CustomerService;
import org.springframework.stereotype.Service;

/**
 * @author Joyzen
 *
 */
@Service
public class CustomerServiceImpl implements CustomerService
{
	@Resource
	CustomerDao cd;
	/* (non-Javadoc)
	 * @see org.lanqiao.service.CustomerService#getPageData(java.util.Map)
	 */
	@Override
	public PageUtil getPageData(Map map) {
		// TODO Auto-generated method stub
		List<Customer> lc = cd.selectCustomerByCondition(map);
		int countCustomer = cd.countCustomer(map);
		int pageSize = -1;
		if(map.get("pageSize")!=null) {
			pageSize = (int)map.get("pageSize");
		}
		int countPage = countCustomer%pageSize==0?countCustomer/pageSize:countCustomer/pageSize+1;
		PageUtil customerPage = new PageUtil();
		customerPage.setData(lc);
		customerPage.setTotal(countPage);
		return customerPage;
	}
	
	/* (non-Javadoc)
	 * @see org.lanqiao.service.CustomerService#addCustomer(org.lanqiao.bean.Customer)
	 */
	@Override
	public boolean addCustomer(Customer customer) {
		// TODO Auto-generated method stub
		int i = cd.insertCustomer(customer);
		return i>0?true:false;
	}
	
	/* (non-Javadoc)
	 * @see org.lanqiao.service.CustomerService#updateCustomer(org.lanqiao.bean.Customer)
	 */
	@Override
	public boolean updateCustomer(Customer customer) {
		// TODO Auto-generated method stub
		int i = cd.updateCustomer(customer);
		return i>0?true:false;
	}
	
	public Customer getCustomerById(int customerId) {
		return cd.selectCustomerByCustomerId(customerId);
	}
	
}
