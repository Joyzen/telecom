/**
 * 
 */
package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.lanqiao.bean.Admin;

/**
 * @author Joyzen
 *
 */
@Mapper
public interface AdminDao
{
	/**
	 * 通用搜索admin账号方法，通过Map传值;参数可以为(adminAccount,adminId,power,password)
	 * @param map
	 * @return List<Admin>
	 */
	public List<Admin> selectAdminByCondition(Map map);
	
	/**
	 * 添加管理员账号
	 */
	public int insertAdmin(Admin admin);
	
	/**
	 * 根据ID删除管理员账号
	 */
	public int delAdmin(int adminId);
	
	/**
	 * 修改管理员信息
	 */
	public int updateAdmin(Admin admin);
	
	/**
	 * 搜索所有记录条数，计算分页
	 */
	public int countAdmin(Map map);
	
}
