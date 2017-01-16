/**
 * 
 */
package org.lanqiao.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.Bussiness;
import org.lanqiao.bean.Os;
import org.lanqiao.bean.PageUtil;
import org.lanqiao.bean.vo.BussinessViewBean;
import org.lanqiao.dao.BussinessDao;
import org.lanqiao.dao.OsDao;
import org.lanqiao.service.BussinessService;
import org.springframework.stereotype.Service;

/**
 * @author Joyzen
 *
 */
@Service
public class BussinessServiceImpl implements BussinessService
{
	@Resource
	BussinessDao bd;
	@Resource
	OsDao od;
	
	/* (non-Javadoc)
	 * @see org.lanqiao.service.BussinessService#getShowData(org.lanqiao.bean.PageUtil)
	 */
	@Override
	public PageUtil getShowData(PageUtil pageUtil) {
		// TODO Auto-generated method stub
		Map map = (Map)pageUtil.getQueryObj();
		int count = bd.countBussiness(map);
		int total = count%pageUtil.getPageSize()==0?count/pageUtil.getPageSize():(count/pageUtil.getPageSize()+1);
		List<Bussiness> lb = bd.selectBussinessByCondition(map);
		pageUtil.setData(lb);
		pageUtil.setTotal(total);
		return pageUtil;
	}
	
	/**
	 * 更新os表status字段
	 * @param bussinessId
	 * @param status
	 * @return
	 */
	public boolean updateStatus(int bussinessId,String status) {
		Map map = new HashMap();
		map.put("bussinessId", bussinessId);
		List<Bussiness> lb = bd.selectBussinessByCondition(map);
		Os os = new Os();
		os.setStatus(status);
		if(!lb.isEmpty()) {
			os.setOsId(lb.get(0).getOs().getOsId());
			int i = od.updateOs(os);
			if(i>0){
				Bussiness bussiness = new Bussiness();
				bussiness.setBussinessId(bussinessId);
				if ("0".equals(os.getStatus()))
				{
					//暂停时
					bussiness.setPauseTime(
							new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
				}else if ("1".equals(os.getStatus()))
				{
					//开通时
					bussiness.setOpenTime(
							new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
				}else if ("2".equals(os.getStatus()))
				{
					//删除时
					bussiness.setPauseTime(
							new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
				}
				bd.updateBussiness(bussiness);
				return true ;
			}
		}
		return false;
	}
	
	/**
	 * 添加os账号
	 * @param os
	 * @return
	 */
	public boolean addBussiness(Os os) {
		int osId = od.insertOs(os);
		Bussiness bussiness = new Bussiness();
		bussiness.setOsId(os.getOsId());
		bussiness.setCreateTime(
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
		int i = bd.insertBussiness(bussiness);
		if(i>0) return true;
		return false;
	}
	
	/*  用于返回json数据 */
	public Map<String, Object> getJsonData(PageUtil pageUtil){
		Map map = (Map)pageUtil.getQueryObj();
		int count = bd.countBussiness(map);
		List<Bussiness> lb = bd.selectBussinessByCondition(map);
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("total", count);
		m.put("rows", lb);
		return m;
	}
	
	public boolean updateTariff(Os os) {
		int i = od.updateOs(os);
		if(i>0) {
			return true;
		}
		return false;
	}
	
}
