/**
 * 
 */
package org.lanqiao.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.PageUtil;
import org.lanqiao.bean.Tariff;
import org.lanqiao.dao.TariffDao;
import org.lanqiao.service.TariffService;
import org.springframework.stereotype.Service;

/**
 * @author Administrator
 *
 */
@Service
public class TariffServiceImpl implements TariffService
{
	
	@Resource
	TariffDao td;
	
	/* (non-Javadoc)
	 * @see org.lanqiao.service.TariffService#showDataList(org.lanqiao.bean.PageUtil)
	 */
	@Override
	public PageUtil showDataList(PageUtil tariffPage) {
		// TODO Auto-generated method stub
		int startPage = (tariffPage.getPage()-1)*tariffPage.getPageSize();
		int pageSize = tariffPage.getPageSize();
		Map map = new HashMap<>();
		map.put("orderBy", tariffPage.getOrder());
		map.put("startPage", startPage);
		map.put("pageSize", pageSize);
		List<Tariff> tariffs = td.selectTariffByCondition(map);
		int total = td.countTariff(map);
		total = total%pageSize==0?total/pageSize:(total/pageSize+1);
		tariffPage.setData(tariffs);
		tariffPage.setTotal(total);
		return tariffPage;
	}
	
	/* (non-Javadoc)
	 * @see org.lanqiao.service.TariffService#addTariff(org.lanqiao.bean.Tariff)
	 */
	@Override
	public boolean addTariff(Tariff tariff) {
		// TODO Auto-generated method stub
		int i = td.inserTariff(tariff);
		return  i>0?true:false;
	}
	
	/* (non-Javadoc)
	 * @see org.lanqiao.service.TariffService#updateTariff(org.lanqiao.bean.Tariff)
	 */
	@Override
	public boolean updateTariff(Tariff tariff) {
		// TODO Auto-generated method stub
		int i = td.updateTariff(tariff);
		return i>0?true:false;
	}
	
	
	public Tariff selectTariffById(int tariffId) {
		return td.selectTariffById(tariffId);
	}
	
	public List<Tariff> selectTariffByCondition(Map map) {
		return td.selectTariffByCondition(map);
	}
	
	public List<Tariff> getOpenedTariff(Map map) {
		List<Tariff> lt = td.selectTariffByCondition(map);
		return lt;
	}
	
}
