/**
 * 
 */
package org.lanqiao.service;

import java.util.List;
import java.util.Map;

import org.lanqiao.bean.Admin;
import org.springframework.ui.Model;

/**
 * @author Joyzen
 *
 */
public interface AdminService
{
	
	/**
	 * 验证登陆账号密码
	 * @param a
	 * @return
	 */
	public Map verifyAdmin(Admin a) ;
		
	/**
	 * 修改管理员账号密码
	 * @param model
	 * @param admin
	 * @return
	 */
	public boolean modiPassword(Model model,Admin admin) ;
	
	/**
	 * 根据adminId查找Admin
	 * @param adminId
	 * @return
	 */
	public Admin selectAdminByAdminId(int adminId);
	
	/**
	 * 修改管理员账号信息
	 * @param admin
	 * @return
	 */
	public boolean modiInfo(Admin admin);
	
	/**
	 * 获取管理员管理显示数据
	 * @param map
	 * @return
	 */
	public Map showAdminList(Map map);
	
	/**
	 * 删除管理员
	 * @param adminId
	 * @return
	 */
	public boolean delAdmin(int adminId);
	
	/**
	 * 修改管理员信息
	 * @param admin
	 * @return
	 */
	public boolean updateAdmin(Admin admin) ;
	
	/**
	 * 添加管理员
	 * @param admin
	 * @return
	 */
	public boolean insertAdmin(Admin admin);
	
	/**
	 * 设置管理员账号权限
	 * @param list
	 * @return
	 */
	public boolean setPower(List list);
	
	/**
	 * 删除权限
	 * @param adminId
	 */
	public void delPowerByAdminId(int adminId) ;
	
}
