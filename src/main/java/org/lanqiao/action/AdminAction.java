/**
 * 
 */
package org.lanqiao.action;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.lanqiao.bean.Admin;
import org.lanqiao.service.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author Joyzen
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminAction
{
	@Resource
	AdminService as;
	
	
	@RequestMapping("/nopower")
	public String toNopower() {
		return "nopower";
	}
	
	/**
	 * 指向登陆页面
	 * @return
	 */
	@RequestMapping("/login")
	public String toLogin() {
		return "login";
	}
	
	/**
	 * 处理登陆ajax请求的方法
	 * @param admin
	 * @param out
	 */
	@RequestMapping("/verifyAdmin")
	public void verifyAdmin(Admin admin,PrintWriter out,HttpServletRequest request) {
		if(admin.getAdminAccount()==null||"".equals(admin.getAdminAccount())) {
			out.print("false");
			return;
		}
		Map map = as.verifyAdmin(admin);
		boolean b = (boolean)map.get("result");
		if(b) {
			out.print("true");
			request.getSession().setAttribute("admin", (Admin)map.get("admin"));
		}
		else {
			out.print("false");
		}
	}
	
	/**
	 * 指向主页
	 * @return
	 */
	@RequestMapping("/index")
	public String showIndex() {
		return "index";
	}
	
	/**
	 * 指向信息修改页面
	 * @return
	 */
	@RequestMapping("/info")
	public String modifyInfo(HttpServletRequest request,Model model) {
		List<Integer>li = ((Admin)request.getSession().getAttribute("admin")).getPowers();
		String powerStr = "";
		for(int i:li) {
			if(i==2) {
				powerStr += "  管理员管理";
				continue;
			}
			if(i==3) {
				powerStr += "  资费管理";
				continue;
			}
			if(i==4) {
				powerStr += "  账务账号管理";
				continue;
			}
			if(i==5) {
				powerStr += "  业务账号管理";
				continue;
			}
			if(i==6) {
				powerStr += "  账单管理";
				continue;
			}
			if(i==7) {
				powerStr += " 报表管理";
				continue;
			}
		}
		model.addAttribute("powerStr", powerStr);
		return "user/user_info";
	}
	
	/**
	 *处理信息修改页面请求
	 * @return
	 */
	@RequestMapping("/doInfo")
	public void doDodifyInfo(Admin admin,
							   @RequestParam(name="img",required=false)MultipartFile img,
							   HttpServletRequest request,
							   PrintWriter out) {
		/***************头像文件存入目录************************/
		String fileName = "";
		//if(admin.getImg()!=null){
		if(img!=null){
			String path = request.getSession().getServletContext().getRealPath("img");  
			//fileName = admin.getImg().getOriginalFilename();  
			fileName = img.getOriginalFilename();  
			File targetFile = new File(path, fileName);
			/*if(!targetFile.exists()){  
				targetFile.mkdirs();  
			}*/  
			//保存  
			try {  
				//admin.getImg().transferTo(targetFile);  
				//img.transferTo(targetFile);
				BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(targetFile));
				bos.write(img.getBytes()); 
				bos.flush(); 
				bos.close(); 
			} catch (Exception e) {  
				e.printStackTrace();  
			}  
		}
		/*****************************************************/
		int adminId = ((Admin)request.getSession().getAttribute("admin")).getAdminId();
		admin.setAdminId(adminId);
		//if(admin.getImg()==null){
			if(img==null){
			admin.setImgURL("");
		}else{
			admin.setImgURL(request.getContextPath()+"/img/"+fileName);
		}
		boolean b = as.modiInfo(admin);
		if(b) {
			request.getSession().setAttribute("admin", as.selectAdminByAdminId(adminId));
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	/**
	 * 指向密码修改页面
	 * @return
	 */
	@RequestMapping("/modi")
	public String modi() {
		return "user/user_modi_pwd";
	}
	
	/**
	 * 处理密码修改的方法
	 * @return
	 */
	@RequestMapping("/doModi")
	public void modiPassword( HttpServletRequest request,Model model,PrintWriter out) {
		HttpSession session = request.getSession();
		String password = request.getParameter("password");
		Admin admin = (Admin)session.getAttribute("admin");
		admin.setPassword(password);
		boolean b = as.modiPassword(model, admin);
		out.print(b?"success":"fail");
		Admin newAdmin = as.selectAdminByAdminId(admin.getAdminId());
		session.setAttribute("admin", newAdmin);
		//return "forward:login.do";
	}
	
	/**
	 * 指向管理员管理页面
	 * @return
	 */
	@RequestMapping("/list")
	public String showList(@RequestParam(value="currentPage",defaultValue="1")int currentPage,
											 @RequestParam(value="powerId",defaultValue="-1")int powerId,
											 Model model) {
		int pageSize = 5;
		int startPage = (currentPage-1)*pageSize;
		Map m = new HashMap();
		m.put("startPage", startPage);
		m.put("pageSize", pageSize);
		m.put("powerId", powerId);
		Map map = as.showAdminList(m);
		int countAdmin = (int)map.get("countAdmin");
		int countPage = countAdmin%5==0?(countAdmin/5):(countAdmin/5+1);
		model.addAttribute("countPage", countPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("la", map.get("la"));
		model.addAttribute("powerId", powerId);
		return "admin/admin_list";
	}
	
	/**
	 * 删除管理员账号
	 * @param adminId
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping("/delAdmin")
	public String delAdmin(@RequestParam("adminId")int adminId,
			                                  @RequestParam(value="currentPage",defaultValue="1")int currentPage,
											  Model model) {
		as.delAdmin(adminId);
		return "redirect:list.do?currentPage="+currentPage;
	}
	
	/**
	 * 批量重置密码
	 * @param currentPage
	 * @param adminId
	 * @param out
	 */
	@RequestMapping("/reset")
	public void resetPassword(@RequestParam("currentPage")int currentPage,
										               @RequestParam("adminId")int adminId,
													   PrintWriter out
														) {
		Admin admin = new Admin();
		admin.setAdminId(adminId);
		admin.setPassword("123456");
		boolean b = as.updateAdmin(admin);
		if(b) {
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	/**
	 * 指向修改页面
	 * @param adminId
	 * @param model
	 * @return
	 */
	@RequestMapping("/toModi")
	public String modify(@RequestParam("adminId")int adminId,
							             Model model
			                             ){
		Admin admin = as.selectAdminByAdminId(adminId);
		model.addAttribute("modiAdmin", admin);
		return "admin/admin_modi";
	}
	
	/**
	 * 处理修改操作
	 * @param adminName
	 * @param phone
	 * @param email
	 * @param powers
	 */
	@RequestMapping("/doModify")
	public void doModi(@RequestParam("adminName")String adminName,
									     @RequestParam("phone")String phone,
									     @RequestParam("email")String email,
									     @RequestParam("powers")String powers,
									     @RequestParam("adminId")int adminId,
									     PrintWriter out
											) {
		as.delPowerByAdminId(adminId);
		Admin admin = new Admin();
		admin.setAdminId(adminId);
		admin.setAdminName(adminName);
		admin.setPhone(phone);
		admin.setEmail(email);
		boolean b = as.updateAdmin(admin);
		List list = new ArrayList();
		String[] s = powers.split(",");
		for(int i = 0;i<s.length;i++) {
			if(s[i]==null||"".equals(s[i])) {
				continue;
			}
			int powerId = Integer.parseInt(s[i]);
			Map map = new HashMap();
			map.put("adminId", adminId);
			map.put("powerId", powerId);
			list.add(map);
		}
		b = b&&as.setPower(list);
		if(b) {
			out.print("success");
		}else {
			out.print("fail");
		}
	}
	
	@RequestMapping("/toAdd")
	public String toAdd() {
		return "admin/admin_add";
	}
	
	@RequestMapping("/doAdd")
	public void doAdd( @RequestParam("adminName")String adminName,
		                               	 @RequestParam("phone")String phone,
		                                 @RequestParam("email")String email,
		                                 @RequestParam("powers")String powers,
		                                 @RequestParam("password")String password,
		                                 @RequestParam("adminAccount")String adminAccount,
		                                 PrintWriter out
										) {
		Admin admin = new Admin();
		admin.setPassword(password);
		admin.setAdminAccount(adminAccount);
		admin.setAdminName(adminName);
		admin.setEmail(email);
		admin.setPhone(phone);
		admin.setCreateTime(
				new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));
		boolean b = as.insertAdmin(admin);
		int adminId = ((Admin)(as.verifyAdmin(admin).get("admin"))).getAdminId();
		as.delPowerByAdminId(adminId);
		List list = new ArrayList();
		String[] s = powers.split(",");
		for(int i = 0;i<s.length;i++) {
			if(s[i]==null||"".equals(s[i])) {
				continue;
			}
			int powerId = Integer.parseInt(s[i]);
			Map map = new HashMap();
			map.put("adminId", adminId);
			map.put("powerId", powerId);
			list.add(map);
		}
		b = b&&as.setPower(list);
		if(b) {
			out.print("success");
		}else {
			out.print("fail");
		}
		//return "redirect:list.do";
	}
									    
}
