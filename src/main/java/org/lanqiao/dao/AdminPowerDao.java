/**
 * 
 */
package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/**
 * @author Joyzen
 *
 */
@Mapper
public interface AdminPowerDao
{
	/**
	 * 根据adminId查找power
	 * @param adminId
	 * @return
	 */
	public List<Integer> selectPowerByAdminId(int adminId);
	
	/**
	 * 根据adminId删除adminPower
	 * @param adminId
	 * @return
	 */
	public int delAdminPowerByAdminId(int adminId);
	
	
	/**
	 * 添加管理员账号权限,通过map传值，分别传入adminId和powerId
	 * @param map
	 * @return
	 */
	public int insertAdminPower(List list);
}
