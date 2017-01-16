/**
 * 
 */
package org.lanqiao.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.Bussiness;
import org.lanqiao.bean.Customer;
import org.lanqiao.bean.Os;
import org.lanqiao.bean.PageUtil;
import org.lanqiao.bean.Tariff;
import org.lanqiao.service.BussinessService;
import org.lanqiao.service.CustomerService;
import org.lanqiao.service.TariffService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author Joyzen
 *
 */
@Controller
@RequestMapping("/bussiness")
public class BussinessAction
{
	int pageSize = 5;
	@Resource
	BussinessService bs;
	@Resource
	TariffService ts;
	@Resource
	CustomerService cs;
	
	/**
	 * 显示页面数据
	 * @param model
	 * @param idNumber
	 * @param osAccount
	 * @param status
	 * @param currentPage
	 * @return
	 */
	@RequestMapping("/showDataList")
	public String showList(Model model,
			                                 @RequestParam(value="idNumber",defaultValue="")String idNumber,
			                                 @RequestParam(value="osAccount",defaultValue="")String osAccount,
			                                 @RequestParam(value="status",defaultValue="-1")String status,
			                                 @RequestParam(value="currentPage",defaultValue="1")int currentPage
											 ) {
		int startPage = (currentPage-1)*pageSize;
		PageUtil bussinessPage = new PageUtil();
		Map map = new HashMap();
		map.put("startPage", startPage);
		map.put("pageSize", pageSize);
		map.put("idNumber", idNumber);
		map.put("osAccount", osAccount);
		map.put("status", status);
		bussinessPage.setQueryObj(map);
		bussinessPage.setPage(currentPage);
		bussinessPage.setRows(pageSize);
		bs.getShowData(bussinessPage);
		model.addAttribute("bussinessPage", bussinessPage);
		return "service/service_list";
	}
	
	@RequestMapping("/updateStatus")
	public void updateStatus(@RequestParam("bussinessId")int bussinessId,
			    							       @RequestParam("status")String status,
												   PrintWriter out) {
		boolean b = bs.updateStatus(bussinessId, status);
		if (b)
		{
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	@RequestMapping("/updateTariff")
	public void updatTariff(Os os,PrintWriter out) {
		out.flush();
		boolean b = bs.updateTariff(os);
		if (b)
		{
			out.print("success");
		}else {
			out.print("fail");
		}
		out.close();
	}
	
	/**
	 * 指向添加页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/toAdd")
	public String toAdd(Model model) {
		Map map = new HashMap<>();
		map.put("status", "1");
		List<Tariff>lt = ts.getOpenedTariff(map);
		model.addAttribute("tariffList", lt);
		return "service/service_add";
	}
	
	/**
	 * 查询身份证账号
	 * @param idNumber
	 * @param out
	 */
	@RequestMapping("/checkIdNumber")
	@ResponseBody
	public Map<String, Object> checkIdNumber(String idNumber) {
		Map map = new HashMap<>();
		map.put("idNumber", idNumber);
		System.out.println(idNumber);
		List<Customer> ls = cs.getPageData(map).getData();
		if(!ls.isEmpty()) {
			Customer customer = ls.get(0);
			Map m = new HashMap<>();
			m.put("customerId", customer.getCustomerId());
			m.put("customerAccount", customer.getCustomerAccount());
			return m;
		}
		return null;
	}
	
	/**
	 * 处理添加操作
	 * @param customerId
	 * @param tariffId
	 * @param serverIp
	 * @param osAccount
	 * @param osPassword
	 * @param out
	 */
	@RequestMapping("/add")
	public void addBussiness(@RequestParam("customerId")int customerId,
													 @RequestParam("tariffId")int tariffId,
													 @RequestParam("osAccount")String osAccount,
													 @RequestParam("osPassword")String osPassword,
													 PrintWriter out
													 ) {
		Os os = new Os();
		os.setCustomerId(customerId);
		os.setTariffId(tariffId);
		os.setOsPassword(osPassword);
		os.setOsAccount(osAccount);
		os.setStatus("1");
		boolean b = bs.addBussiness(os);
		if (b)
		{
			out.print("success");
		}else {
			out.println("fail");
		}
	}
	
	/*  使用easyUI重写部分  */
	@RequestMapping("/toDataGrid")
	public String toDataGrid() {
		return "service/service_list_easyui";
	}
	
	@RequestMapping("/getJson")
	@ResponseBody
	public Map<String, Object> getJsonData(@RequestParam(value="page",defaultValue="1")int page,
																			 @RequestParam(value="rows",defaultValue="5")int rows,
																			 @RequestParam(value="idNumber",defaultValue="")String idNumber,
											                                 @RequestParam(value="osAccount",defaultValue="")String osAccount,
											                                 @RequestParam(value="status",defaultValue="-1")String status){
		int startPage = (page-1)*rows;
		PageUtil pageUtil  = new PageUtil();
		Map map = new HashMap();
		map.put("startPage", startPage);
		map.put("pageSize", rows);
		map.put("idNumber", idNumber);
		map.put("osAccount", osAccount);
		map.put("status", status);
		pageUtil.setQueryObj(map);
		pageUtil.setPage(page);
		pageUtil.setRows(rows);
		Map m = bs.getJsonData(pageUtil);
		return m;
	}
	
	@RequestMapping("/getTariff")
	@ResponseBody
	public Map<String, Object> getOpenedTariff() {
		Map map = new HashMap<>();
		map.put("status", "1");
		List<Tariff>lt = ts.getOpenedTariff(map);
		map.put("tariffList", lt);
		return map;
	}
	
	
}
