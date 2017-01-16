/**
 * 
 */
package org.lanqiao.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.lanqiao.bean.Customer;
import org.lanqiao.bean.PageUtil;
import org.lanqiao.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author Joyzen
 *
 */
@Controller
@RequestMapping("/customer")
public class CustomerAction
{
	
	@Resource
	CustomerService cs;
	int pageSize = 5;
	
	/**
	 * 返回显示账务账号数据
	 * @return
	 */
	@RequestMapping("/showDataList")
	public String showDataList(@RequestParam(value="currentPage",defaultValue="1")int currentPage,
												      @RequestParam(value="idNumber",defaultValue="")String idNumber,
												      @RequestParam(value="customerName",defaultValue="")String customerName,
												      @RequestParam(value="customerAccount",defaultValue="")String customerAccount,
												      @RequestParam(value="status",defaultValue="-1")String status,
													  Model model) {
		Map map = new  HashMap();
		int startPage = (currentPage-1)*pageSize;
		map.put("startPage", startPage);
		map.put("pageSize", pageSize);
		map.put("idNumber", idNumber);
		map.put("customerName", customerName);
		map.put("customerAccount", customerAccount);
		map.put("status", status);
		PageUtil customerPage = cs.getPageData(map);
		customerPage.setQueryObj(map);
		customerPage.setPage(currentPage);
		model.addAttribute("customerPage", customerPage);
		model.addAttribute("idNumber", idNumber);
		model.addAttribute("status", status);
		model.addAttribute("customerName", customerName);
		model.addAttribute("customerAccount", customerAccount);
		return "account/account_list";
	}
	
	/**
	 * 处理开通/暂停/删除请求
	 * @param status
	 * @param currentPage
	 * @param customerId
	 * @return
	 */
	@RequestMapping("/doStatus")
	public String update(@RequestParam("status")String status,
							             @RequestParam("currentPage")int currentPage,
							             @RequestParam("customerId")int customerId
										 ) {
		Customer customer = new Customer();
		customer.setCustomerId(customerId);
		customer.setStatus(status);
		if("0".equals(status)) {
			customer.setPauseTime(
					new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
		}else if ("1".equals(status))
		{
			customer.setPauseTime("--");
		}else if ("2".equals(status)) {
			customer .setDelTime(
					new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
		}
		cs.updateCustomer(customer);
		return "redirect:showDataList.do";
	}
	
	
	/**
	 * 指向修改页面
	 * @param customerId
	 * @param model
	 * @return
	 */
	@RequestMapping("/toModi")
	public String toModi(@RequestParam("customerId")int customerId,Model model) {
		Map map = new HashMap();
		map.put("customerId", customerId);
		List<Customer> lc = cs.getPageData(map).getData();
		Customer customer = new Customer();
		if(!lc.isEmpty()) {
			customer = lc.get(0);
		}
		model.addAttribute("modiCustomer", customer);
		return "account/account_modi";
	}
	
	@RequestMapping("/doModi")
	public void doModi(Customer customer,PrintWriter out) {
		boolean b = cs.updateCustomer(customer);
		if (b)
		{
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	@RequestMapping("/toAdd")
	public String toAdd() {
		return "account/account_add";
	}
	
	@RequestMapping("/doAdd")
	public void doAdd(Customer customer,PrintWriter out) {
		customer.setCreateTime(
				new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		customer.setStatus("1");
		boolean b = cs.addCustomer(customer);
		if (b)
		{
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	@RequestMapping("/showDetail")
	public String showDetail(@RequestParam("customerId")int customerId,Model model) {
		Customer customer = cs.getCustomerById(customerId);
		model.addAttribute("customerDetail", customer);
		return "account/account_detail";
	}
	
}
