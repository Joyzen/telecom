/**
 * 
 */
package org.lanqiao.test;

import static org.junit.Assert.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.lanqiao.bean.Admin;
import org.lanqiao.dao.AdminDao;
import org.lanqiao.util.SqlSessionUtil;


/**
 * @author Joyzen
 *
 */
public class test
{
	private static Logger logger = Logger.getLogger(test.class);
	/**
	 * @throws java.lang.Exception
	 */
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}
	
	/**
	 * @throws java.lang.Exception
	 */
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}
	
	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
	}
	
	/**
	 * @throws java.lang.Exception
	 */
	@After
	public void tearDown() throws Exception {
	}
	
	@Test
	public void test() {
		Map map = new HashMap<>();
		map.put("adminAccount", "doctor");
		map.put("password", "123");
		try
		{
			SqlSession ss = SqlSessionUtil.getSqlSession();
			AdminDao am = ss.getMapper(AdminDao.class);
			List<Admin> la = am.selectAdminByCondition(map);
			for(Admin aa:la) {
				System.out.println(aa);
			}
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
