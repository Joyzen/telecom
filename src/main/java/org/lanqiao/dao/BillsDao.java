package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.lanqiao.bean.Bills;
@Mapper
public interface BillsDao {

	/**
	 * 查询账单记录
	 * @param map
	 * @return
	 */
	public List<Bills> selectBills(Map map);
	
	/**
	 * 插入一条账单记录
	 * @param bills
	 * @return
	 */
	public int insertBills(Bills bills);
	
	/**
	 * 更新账单记录
	 * @param bills
	 * @return
	 */
	public int updateBills(Bills bills);
	
	/**
	 * 统计总记录条数
	 * @param map
	 * @return
	 */
	public int countBills(Map map);
	
}
