/**
 * 
 */
package org.lanqiao.dao;

import org.apache.ibatis.annotations.Mapper;
import org.lanqiao.bean.Os;

/**
 * @author Joyzen
 *
 */
@Mapper
public interface OsDao
{
	/**
	 * 根据osId搜索os
	 * @param osId
	 * @return
	 */
	public Os selectOsById(int osId);
	
	/**
	 * 修改os记录
	 * @param os
	 * @return
	 */
	public int updateOs(Os os);
	
	/**
	 * 添加os账号
	 * @param os
	 * @return
	 */
	public int insertOs(Os os);
	
}
