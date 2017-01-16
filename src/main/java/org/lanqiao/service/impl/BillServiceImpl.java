package org.lanqiao.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.BillDetail;
import org.lanqiao.bean.Bills;
import org.lanqiao.bean.Customer;
import org.lanqiao.bean.OsLogin;
import org.lanqiao.bean.PageUtil;
import org.lanqiao.bean.ReportDTO;
import org.lanqiao.bean.TariffRateDTO;
import org.lanqiao.dao.BillDetailDao;
import org.lanqiao.dao.BillsDao;
import org.lanqiao.dao.CustomerDao;
import org.lanqiao.dao.OsDao;
import org.lanqiao.dao.OsLoginDao;
import org.lanqiao.service.BillService;
import org.springframework.stereotype.Service;
@Service
public class BillServiceImpl implements BillService {

	@Resource
	BillsDao bd;
	@Resource
	BillDetailDao bdd;
	@Resource
	OsLoginDao od;
	@Resource
	CustomerDao cd;
	@Resource
	OsDao osDao;
	
	@Override
	public PageUtil getBills(PageUtil billsPage) {
		// TODO Auto-generated method stub
		List<Bills> lb = bd.selectBills((Map)billsPage.getQueryObj());
		Map m = (Map)billsPage.getQueryObj();
		System.out.println(m.get("start")+"----"+m.get("rows"));
		int count = bd.countBills((Map)billsPage.getQueryObj());
		billsPage.setData(lb);
		billsPage.setTotal(count);
		return billsPage;
	}

	@Override
	public Map<String,Object> getBillDetail(Map<String,Object> map) {
		int customerId = (int)map.get("customerId");
		Customer customer = cd.selectCustomerByCustomerId(customerId);
		List<BillDetail> lbd = bdd.selectBillDetailByCondition(map);
		int total = bdd.countBillDetail(map);
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("rows", lbd);
		m.put("total", total);
		m.put("customer", customer);
		return m;
	}

	@Override
	public Map<String,Object> getOsLogin(Map<String,Object> map) {
		// TODO Auto-generated method stub
		List<OsLogin> lol = od.selectOsLoginByCondition(map);
		for(OsLogin o:lol){
			//计算时间差
			try
			{
			    long diff = o.getLoginOutTime().getTime() - o.getLoginInTime().getTime();
			    long seconds = diff / (1000);
			    o.setTimeLong(seconds);
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		int total = od.countOsLogin(map);
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("rows", lol);
		m.put("total", total);
		return m;
	}
	
	@Override
	public Map<String,Object> getReport(Map<String,Object> map){
		String order = (String)map.get("order");
		if("tariff".equals(order)){
			int total = bdd.countTariffRate(map);
			List<TariffRateDTO> lt = bdd.getTariffRate(map);
			Map<String,Object> tm = new HashMap<String,Object>();
			tm.put("rows", lt);
			tm.put("total", total);
			return tm;
		}else{
			List<ReportDTO> lr = bdd.getReport(map);
			int total = bdd.countReport(map);
			Map<String,Object> m = new HashMap<String,Object>();
			m.put("rows", lr);
			m.put("total", total);
			return m;
		}
	}
	
	public Map<String,Object> getHighcharts(){
		Map<String,Object> map = new HashMap<>();
		map.put("order", "customer");
		List<ReportDTO> lr = bdd.getReport(map);
		List<Map<String,Object>> lm = new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> lmd = new ArrayList<Map<String,Object>>();
		for(ReportDTO r:lr){
			Map<String,Object> m = new HashMap<>();
			m.put("name", r.getCustomerName());
			m.put("y", r.getTimeLong());
			m.put("drilldown", r.getCustomerName());
			lm.add(m);
			lmd.add(getDrill(r.getCustomerName()));
		}
		map.put("lm", lm);
		map.put("lmd", lmd);
		return map;
	}
	
	public Map<String,Object> getDrill(String customerName){
		Map<String,Object> map = new HashMap<>();
		map.put("customerName", customerName);
		List<ReportDTO> lr = bdd.getReport(map);
		Map<String,Object> m = new HashMap<>();
		List<List> ll = new ArrayList<List>();
		m.put("name", customerName);
		m.put("id", customerName);
		for(ReportDTO r:lr){
			List l = new ArrayList<>();
			l.add(r.getMonths());
			l.add(r.getTimeLong());
			ll.add(l);
		}
		m.put("data", ll);
		return m;
	}

}
