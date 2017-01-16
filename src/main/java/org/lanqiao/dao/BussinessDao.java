/**
 * 
 */
package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.lanqiao.bean.Bussiness;

/**
 * @author Joyzen
 *
 */
@Mapper
public interface BussinessDao
{
	
	/**
	 * 根据条件搜索bussiness表
	 * @param map
	 * @return List<Bussiness>
	 */
	public List<Bussiness> selectBussinessByCondition(Map map);
	
	
	/**
	 * 添加一条bussiness记录
	 * @param bussiness
	 * @return int
	 */
	public int insertBussiness(Bussiness bussiness);
	
	
	/**
	 * 按条件查询总记录数
	 * @param map
	 * @return
	 */
	public int countBussiness(Map map);
	
	/**
	 * 更新bussiness表字段
	 */
	public int updateBussiness(Bussiness bussiness);
	
}
