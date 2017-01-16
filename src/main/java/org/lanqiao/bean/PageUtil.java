/**
 * 
 */
package org.lanqiao.bean;

import java.util.List;

/**
 * @author Administrator
 *
 */
public class PageUtil
{
	
	/**
	 * 每页限制的记录条数
	 */
	private int rows;  
    
	/**
	 * 总记录条数
	 */
    private int total;  
      
    /**
     * 当前页
     */
    private int page;
      
    private String orderStr;  
    
    private String sort;  
    
    private String order; //排序条件
    
    private Object queryObj;  //查询条件
    
    private List data;  //查询到的数据
    public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}

      
    public String getOrderStr() {  
        orderStr = "";  
        if (!org.springframework.util.StringUtils.isEmpty(order)) {  
            String[] orders = order.split(",");  
            String[] sorts = sort.split(",");  
            for (int i = 0; i < sorts.length; i++) {  
                orderStr += sorts[i] + " " + orders[i] + ", ";  
            }  
            orderStr = orderStr.endsWith(", ") ? orderStr.substring(0, orderStr.length() - 2) : orderStr;  
        }  
        return orderStr;  
    }  
      
    public int getPageSize() {  
        return rows;  
    }  
      
    public List<?> getRows(){  
        return data;  
    }  
      
    public void setRows(int rows) {  
        this.rows = rows;  
    }  
  
    public int getTotal() {  
        return total;  
    }  
  
    public void setTotal(int total) {  
        this.total = total;  
    }  
  
    public int getPage() {  
        return page;  
    }  
  
    public void setPage(int page) {  
        this.page = page;  
    }  
  
    public String getSort() {  
        return sort;  
    }  
  
    public void setSort(String sort) {  
        this.sort = sort;  
    }  
  
    public String getOrder() {  
        return order;  
    }  
  
    public void setOrder(String order) {  
        this.order = order;  
    }  
  
    public Object getQueryObj() {  
        return queryObj;  
    }  
  
    public void setQueryObj(Object queryObj) {  
        this.queryObj = queryObj;  
    }  
  
    public void setOrderStr(String orderStr) {  
        this.orderStr = orderStr;  
    }  
  
    
  
    @Override  
    public String toString() {  
        return "PageUtil [rows=" + rows + ", total=" + total + ", page=" + page  
                + ", orderStr=" + orderStr + ", sort=" + sort + ", order="  
                + order + ", queryObj=" + queryObj + ", data=" + data + "]";  
    }  
}
