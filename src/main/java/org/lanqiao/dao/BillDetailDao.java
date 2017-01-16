package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.lanqiao.bean.BillDetail;
import org.lanqiao.bean.ReportDTO;
import org.lanqiao.bean.TariffRateDTO;
@Mapper
public interface BillDetailDao {

	/**
	 * 查询详单记录
	 * @param map
	 * @return
	 */
	public List<BillDetail> selectBillDetailByCondition(Map map);
	
	/**
	 * 插入一条详单记录
	 * @param billDetail
	 * @return
	 */
	public int insertBillDetail(BillDetail billDetail);
	
	/**
	 * 查询总记录条数
	 * @param map
	 * @return
	 */
	public int countBillDetail(Map map);
	
	/**
	 * 查询账单排序
	 * @param order
	 * @return
	 */
	public List<ReportDTO> getReport(Map map);
	
	/**
	 * 查询总记录条数
	 * @param map
	 * @return
	 */
	public int countReport(Map map);
	
	/**
	 * 查询资费排序
	 * @param map
	 * @return
	 */
	public List<TariffRateDTO> getTariffRate(Map map);
	
	/**
	 * 统计总记录条数
	 * @param map
	 * @return
	 */
	public int countTariffRate(Map map);
	
}
