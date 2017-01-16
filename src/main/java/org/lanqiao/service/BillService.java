package org.lanqiao.service;

import java.util.List;
import java.util.Map;

import org.lanqiao.bean.PageUtil;

public interface BillService {

	/**
	 * 获取账单显示数据
	 * @param billsPage
	 * @return
	 */
	public PageUtil getBills(PageUtil billsPage);
	
	/**
	 * 获取详细账单显示数据
	 */
	public Map<String,Object> getBillDetail(Map<String,Object> map);
	
	/**
	 * 获取详细登陆数据
	 */
	public Map<String,Object> getOsLogin(Map<String,Object> map);
	
	/**
	 * 查询报表数据
	 * @param map
	 * @return
	 */
	public Map<String,Object> getReport(Map<String,Object> map);
	
	/**
	 * 获取Highcharts显示数据
	 * @return
	 */
	public Map<String,Object> getHighcharts();
	
}
