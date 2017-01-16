package org.lanqiao.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.Customer;
import org.lanqiao.bean.PageUtil;
import org.lanqiao.service.BillService;
import org.lanqiao.service.BussinessService;
import org.lanqiao.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/bill")
public class BillAction {

	@Resource
	BillService bs;
	@Resource
	BussinessService bus;
	@Resource
	CustomerService cs;
	
	@RequestMapping("/toBills")
	public String toBills(){
		return "bill/bill_list";
	}
	
	/**
	 * 返回账单查询json数据
	 * @param idNumber
	 * @param customerAccount
	 * @param customerName
	 * @param year
	 * @param month
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/getBills")
	@ResponseBody
	public Map showBills(@RequestParam(value="idNumber",defaultValue="")String idNumber,
			        	  @RequestParam(value="customerAccount",defaultValue="")String customerAccount,
			        	  @RequestParam(value="customerName",defaultValue="")String customerName,
			        	  @RequestParam(value="year",defaultValue="")String year,
			        	  @RequestParam(value="month",defaultValue="")String month,
			        	  @RequestParam(value="page",defaultValue="1")int page,
			        	  @RequestParam(value="rows",defaultValue="5")int rows){
		PageUtil billsPage = new PageUtil();
		Map map = new HashMap();
		int start = (page-1)*rows;
		map.put("idNumber", idNumber);
		map.put("customerAccount", customerAccount);
		map.put("customerName", customerName);
		map.put("year", year);
		map.put("month", month);
		map.put("start",start);
		map.put("rows",rows);
		billsPage.setQueryObj(map);
		billsPage.setPage(page);
		billsPage.setRows(rows);
		billsPage = bs.getBills(billsPage);
		map.put("rows", billsPage.getRows());
		map.put("total", billsPage.getTotal());
		return map;
	}
	
	/**
	 * 指向详细页面
	 * @return
	 */
	@RequestMapping("/toDetail")
	public String toBillDetail(String idNumber,
								 double cost,
								 String months,
								 Model model){
		if(months.substring(4, 5).equals("0")){
			months=months.subSequence(0, 4)+"年"+months.subSequence(5, 6)+"月";
		}else{
			months=months.subSequence(0, 4)+"年"+months.subSequence(4, 6)+"月";
		}
		
		Map map = new HashMap<>();
		map.put("idNumber", idNumber);
		List<Customer> ls = cs.getPageData(map).getData();
		Customer customer = new Customer();
		if(!ls.isEmpty()) {
			customer = ls.get(0);
		}
		
		model.addAttribute("customerAccount",customer.getCustomerAccount());
		model.addAttribute("customerName", customer.getCustomerName());
		model.addAttribute("idNumber", idNumber);
		model.addAttribute("cost", cost);
		model.addAttribute("months", months);
		model.addAttribute("customerId", customer.getCustomerId());
		return "bill/bill_item";
	}
	
	@RequestMapping("/showDetailBill")
	@ResponseBody
	public Map<String,Object> getDetailBill(@RequestParam("customerId")int customerId,
											  @RequestParam("months")String months,
											  @RequestParam("cost")double cost,
											  @RequestParam("page")int page,
											  @RequestParam("rows")int rows){
		int start = (page-1)*rows;
		if(months.length()==8){
			months = months.substring(0, 4)+months.substring(5,7);
		}
		if(months.length()==7){
			months = months.substring(0, 4)+"0"+months.substring(5,6);
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("rows", rows);
		map.put("months", months);
		map.put("customerId", customerId);
		Map<String,Object> m = bs.getBillDetail(map);
		m.put("cost", cost);
		m.put("months", months);
		return m;
	}
	
	/**
	 * 指向登陆信息页面
	 * @param customerAccount
	 * @param osAccount
	 * @param cost
	 * @param months
	 * @param model
	 * @return
	 */
	@RequestMapping("/toLoginDetail")
	public String toLoginDetail(@RequestParam("customerAccount")String customerAccount,
		    					  @RequestParam("osAccount")String osAccount,
		    					  @RequestParam("osId")int osId,
		                          @RequestParam("cost")double cost,
		                          @RequestParam("months")String months,
		                          @RequestParam("idNumber")String idNumber,
		                          Model model){
		String oMonths = months;
		if(months.substring(4, 5).equals("0")){
			months=months.subSequence(0, 4)+"年"+months.subSequence(5, 6)+"月";
		}else{
			months=months.subSequence(0, 4)+"年"+months.subSequence(4, 6)+"月";
		}
		model.addAttribute("customerAccount", customerAccount);
		model.addAttribute("osAccount", osAccount);
		model.addAttribute("cost", cost);
		model.addAttribute("months", oMonths);
		model.addAttribute("osId", osId);
		model.addAttribute("idNumber", idNumber);
		return "bill/bill_service_detail";
	}
	
	/**
	 * 详细登录信息页面获取数据处理方法
	 * @param customerAccount
	 * @param osAccount
	 * @param osId
	 * @param cost
	 * @param months
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/showLoginDetail")
	@ResponseBody
	public Map getLoginDetail(@RequestParam("osId")int osId,
							    @RequestParam("page")int page,
							    @RequestParam("rows")int rows){
		int start = (page-1)*rows;
		Map map = new HashMap();
		map.put("osId", osId);
		map.put("start", start);
		map.put("rows", rows);
		Map m = bs.getOsLogin(map);
		return m;
	}
	
	/**
	 * 指向账单页面
	 * @return
	 */
	@RequestMapping("/toReport")
	public String toReport(){
		return "report/report_list";
	}
	
	/**
	 * 处理报表数据请求
	 * @return
	 */
	@RequestMapping("/showReport")
	@ResponseBody
	public Map<String,Object> showReport(@RequestParam("page")int page,
										   @RequestParam("rows")int rows,
										   @RequestParam(value="order",defaultValue="")String order){
		int start = (page-1)*rows;	
		Map<String,Object> map = new HashMap();
		if(!"customer".equals(order)){	
			map.put("start", start);
			map.put("rows", rows);			
		}else if("customer".equals(order)){
			map.put("start", 0);
			map.put("rows", 3);	
		}
		map.put("order", order);	
		Map<String,Object> m = bs.getReport(map);
		if("customer".equals(order)){
			m.put("total", 3);
		}
		return m;		
	}
	
	/**
	 * 处理highcharts获取数据的方法
	 * @param dataType
	 * @return
	 */
	@RequestMapping("/getHighcharts")
	@ResponseBody
	public Map<String,Object> getHighcharts(){
		//dataType为series或drilldown，分表示不同数据
		Map<String,Object> m = bs.getHighcharts();
		return m;
	}
	
}
