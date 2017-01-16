package org.lanqiao.util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
/**
 * 访问数据库类
 *
 */
public class SqlSessionUtil {
	private static InputStream inputStream = null;
	private static SqlSessionFactory sqlSessionFactory = null;
	
	private SqlSessionUtil(){}
	/**
	 * 获取SqlSessionFactory
	 * @return SqlSessionFactory
	 * @throws IOException
	 */
	private static SqlSessionFactory getSqlSessionFactory() throws IOException {
		/**
		 * 通过配置文件获取数据库连接信息
		 * 路径从src的根路径下开始算起
		 */
		if (inputStream == null) {
			inputStream = Resources.getResourceAsStream("org/lanqiao/config/mybatis-config.xml");
		}
		if (sqlSessionFactory == null) {
			/**
			 * 通过配置信息构建SqlSessionFactory
			 */
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}
		return sqlSessionFactory;
	}
	/**
	 * 获取SqlSession
	 * @return SqlSession
	 * @throws IOException 
	 */
	public static SqlSession getSqlSession() throws IOException {
		/**
		 * 通过SqlSessionFactory打开一个数据库会话
		 */
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		return sqlSession;
	}
}
