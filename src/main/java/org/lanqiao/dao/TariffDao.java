/**
 * 
 */
package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.lanqiao.bean.Tariff;

import com.sun.org.apache.bcel.internal.generic.Select;

/**
 * @author Administrator
 *
 */
@Mapper
public interface TariffDao
{
	/**
	 * 根据条件搜索资费表
	 * @param map
	 * @return
	 */
	public List<Tariff> selectTariffByCondition(Map map);
	
	/**
	 * 添加资费
	 * @param tariff
	 * @return
	 */
	public int inserTariff(Tariff tariff);
	
	/**
	 * 通过资费ID删除
	 * @param tariffId
	 * @return
	 */
	public int delTariff(int tariffId);
	
	/**
	 * 修改资费
	 * @param tariff
	 * @return
	 */
	public int updateTariff(Tariff tariff);
	
	/**
	 * 按条件查询记录总数
	 * @param map
	 * @return
	 */
	public int countTariff(Map map);
	
	/**
	 * 根据ID搜索资费纪录
	 * @param tariffId
	 * @return
	 */
	public Tariff selectTariffById(int tariffId);
	
}
