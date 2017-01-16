/**
 * 
 */
package org.lanqiao.service;

import java.util.List;
import java.util.Map;

import org.lanqiao.bean.PageUtil;
import org.lanqiao.bean.Tariff;

/**
 * @author Administrator
 *
 */
public interface TariffService
{
	/**
	 * 用于根据传入的排序规则返回资费页面显示数据
	 * @param tariffPage
	 * @return
	 */
	public PageUtil showDataList(PageUtil tariffPage);
	
	/**
	 * 添加资费套餐
	 * @param tariff
	 * @return
	 */
	public boolean addTariff(Tariff tariff);
	
	/**
	 * 修改资费套餐数据
	 * @param tariff
	 * @return
	 */
	public boolean updateTariff(Tariff tariff);
	
	/**
	 * 根据ID搜索资费
	 * @param tariffId
	 * @return
	 */
	public Tariff selectTariffById(int tariffId);
	
	/**
	 * 根据条件搜索资费
	 * @param map
	 * @return
	 */
	public List<Tariff> selectTariffByCondition(Map map) ;
	
	/**
	 * 根据条件查询Tariff
	 * @param map
	 * @return
	 */
	public List<Tariff> getOpenedTariff(Map map);
	
}
