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

import org.lanqiao.bean.PageUtil;
import org.lanqiao.bean.Tariff;
import org.lanqiao.service.TariffService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.annotation.JsonTypeInfo.As;

/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/tariff")
public class TariffAction
{
	
	@Resource
	TariffService ts;
	int rows = 5;
	/**
	 * 显示资费页面
	 * @param model
	 * @param orderBy
	 * @return
	 */
	@RequestMapping("/showDataList")
	public String showTariffPage(Model model,
														  @RequestParam(value="orderBy",defaultValue="")String orderBy,
														  @RequestParam(value="currentPage",defaultValue="1")int currentPage
														  ) {
		PageUtil tariffPage = new PageUtil();
		tariffPage.setPage(currentPage);
		tariffPage.setOrder(orderBy);
		tariffPage.setRows(rows);
		PageUtil pageUtil = ts.showDataList(tariffPage);
		pageUtil.setOrder(orderBy);
		model.addAttribute("tariffPage", pageUtil);
		return "fee/fee_list";
	}
	
	/**
	 * 处理开通和删除业务请求的方法
	 * 开通时向该方法传status="1"，删除时传status="2"
	 * @param curreentPage
	 * @param tariffId
	 * @param status
	 * @return
	 */
	@RequestMapping("/openAndDel")
	public String openAndPause(@RequestParam(value="currentPage",defaultValue="1")int currentPage,
														 @RequestParam("tariffId")int tariffId,
														 @RequestParam("status")String status,
														 @RequestParam(value="orderBy",defaultValue="")String orderBy
			                                             ) {
		Tariff tariff = new Tariff();
		if("1".equals(status)) {
			tariff.setOpenTime(new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		}
		tariff.setTariffId(tariffId);
		tariff.setStatus(status);
		boolean b = ts.updateTariff(tariff);
		return "redirect:showDataList.do?currentPage="+currentPage+"&orderBy="+orderBy;
	}
	
	/**
	 * 指向修改页面
	 * @param model
	 * @param tariffId
	 * @return
	 */
	@RequestMapping("/toModi")
	public String toModi(Model model,
										 @RequestParam("tariffId")int tariffId
			                           ) {
		Tariff modiTariff = ts.selectTariffById(tariffId);
		model.addAttribute("modiTariff", modiTariff);
		return "fee/fee_modi";
	}
	
	/**
	 * 处理修改请求
	 * @param tariff
	 * @param out
	 */
	@RequestMapping("/doModi")
	public void doModi(Tariff tariff, PrintWriter out) {
		//验证资费名是否重复
		Map map = new HashMap();
		map.put("tariffName", tariff.getTariffName());
		List<Tariff> lt = ts.selectTariffByCondition(map);
		if (!lt.isEmpty())
		{
			out.print("tariffNameFail");
			return;
		}
		boolean b = ts.updateTariff(tariff);
		if(b) {
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	/**
	 * 指向添加页面
	 * @return
	 */
	@RequestMapping("/toAdd")
	public String toAdd() {
		return "fee/fee_add";
	}
	
	/**
	 * 处理添加请求方法
	 */
	@RequestMapping("/doAdd")
	public void doAdd(Tariff tariff, PrintWriter out) {
		tariff.setCreateTime(new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		tariff.setStatus("0");
		//验证资费名是否重复
		Map map = new HashMap();
		map.put("tariffName", tariff.getTariffName());
		List<Tariff> lt = ts.selectTariffByCondition(map);
		if (!lt.isEmpty())
		{
			out.print("tariffNameFail");
			return;
		}
		boolean b = ts.addTariff(tariff);
		if(b) {
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	@RequestMapping("/showDetail")
	public String showDetail(Model model,
			                                     @RequestParam("tariffId")int tariffId) {
		Tariff tariff = ts.selectTariffById(tariffId);
		model.addAttribute("tariffDetail", tariff);
		return "fee/fee_detail";
	}
	
}
