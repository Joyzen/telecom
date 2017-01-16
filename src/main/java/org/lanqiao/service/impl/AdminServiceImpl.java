/**
 * 
 */
package org.lanqiao.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.Admin;
import org.lanqiao.dao.AdminDao;
import org.lanqiao.dao.AdminPowerDao;
import org.lanqiao.service.AdminService;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 * @author Joyzen
 *
 */
@Service
public class AdminServiceImpl implements AdminService
{
	@Resource
	AdminDao ad;
	@Resource
	AdminPowerDao apd;
	
	/**
	 * 验证用户登录
	 */
	/* (non-Javadoc)
	 * @see org.lanqiao.service.AdminService#verifyAdmin(org.lanqiao.bean.Admin)
	 */
	@Override
	public Map verifyAdmin(Admin a) {
		// TODO Auto-generated method stub
		Map m = new HashMap();
		Map map = new HashMap();
		map.put("adminAccount", a.getAdminAccount());
		map.put("password", a.getPassword());
		List<Admin> la = ad.selectAdminByCondition(map);
		if(la.isEmpty()) {
			m.put("result", false);
		}else {
			m.put("result", true);
			m.put("admin", la.get(0));
		}
		return m;
	}
	
	public boolean modiPassword(Model model,Admin admin) {
		int i = ad.updateAdmin(admin);
		if(i>0) {
			return true;
		}
		return false;
	}
	
	public Admin selectAdminByAdminId(int adminId) {
		Map map = new HashMap();
		map.put("adminId", adminId);
		List<Admin> la = ad.selectAdminByCondition(map);
		return la.get(0);
	}
	
	public boolean modiInfo(Admin admin) {
		int i = ad.updateAdmin(admin);
		if(i>0) {
			return true;
		}
		return false;
	}
	
	public Map showAdminList(Map map) {
		List<Admin> la = ad.selectAdminByCondition(map);
		int countAdmin = ad.countAdmin(map);
		Map m = new HashMap();
		m.put("la", la);
		m.put("countAdmin", countAdmin);
		return m;
	}
	
	public boolean delAdmin(int adminId) {
		int i = ad.delAdmin(adminId);
		if(i>0) {
			return true;
		}
		return false;
	}
	
	public boolean updateAdmin(Admin admin) {
		int i = ad.updateAdmin(admin);
		if(i>0) {
			return true;
		}
		return false;
	}
	
	public boolean insertAdmin(Admin admin) {
		int i = ad.insertAdmin(admin);
		if(i>0) {
			return true;
		}
		return false;
	}
	
	public boolean setPower(List list) {
		int i = apd.insertAdminPower(list);
		if(i>0) {
			return true;
		}
		return false;
	}
	
	public void delPowerByAdminId(int adminId) {
		apd.delAdminPowerByAdminId(adminId);
	}
	
}
