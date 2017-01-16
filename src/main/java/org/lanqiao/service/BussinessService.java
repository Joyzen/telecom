/**
 * 
 */
package org.lanqiao.service;

import java.util.List;
import java.util.Map;

import org.lanqiao.bean.Bussiness;
import org.lanqiao.bean.Os;
import org.lanqiao.bean.PageUtil;
import org.lanqiao.dao.BussinessDao;
import org.springframework.stereotype.Service;

/**
 * @author Joyzen
 *
 */
@Service
public interface BussinessService
{
	
	/**
	 * 查询页面显示数据
	 * @param PageUtil
	 * @return
	 */
	public PageUtil getShowData(PageUtil pageUtil);
	
	/**
	 * 更改状态
	 * @param bussinessId
	 * @param status
	 * @return
	 */
	public boolean updateStatus(int bussinessId,String status);
	
	/**
	 * 添加bussiness记录
	 * @param os
	 * @return
	 */
	public boolean addBussiness(Os os);
	
	/**
	 * 返回表格显示的map
	 * @param pageUtil
	 * @return
	 */
	public Map<String, Object> getJsonData(PageUtil pageUtil);
	
	/**
	 * 修改os表记录
	 * @param os
	 * @return
	 */
	public boolean updateTariff(Os os);
	
}
