<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>资费页面</title>
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath }/view/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath }/view/styles/global_color.css" />        
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.0.js"></script>
        <script language="javascript" type="text/javascript">
        
            //排序按钮的点击事件
            function sort(btnObj) {
                if (btnObj.className == "sort_desc"){
                    btnObj.className = "sort_asc";
                    switch (btnObj.value) {
					case "月租":
						window.location.href="${pageContext.request.contextPath }/tariff/showDataList.do?orderBy=YuezuASC";
						break;
						
					case "基费":
						window.location.href="${pageContext.request.contextPath }/tariff/showDataList.do?orderBy=tariffASC";
						break;
					case "时长":
						window.location.href="${pageContext.request.contextPath }/tariff/showDataList.do?orderBy=timeLongASC";
						break;
					default:
						break;
					}
                }
                else{
                    btnObj.className = "sort_desc";
                    switch (btnObj.value) {
					case "月租":
						window.location.href="${pageContext.request.contextPath }/tariff/showDataList.do?orderBy=YuezuDESC";
						break;
						
					case "基费":
						window.location.href="${pageContext.request.contextPath }/tariff/showDataList.do?orderBy=tariffDESC";
						break;
					case "时长":
						window.location.href="${pageContext.request.contextPath }/tariff/showDataList.do?orderBy=timeLongDESC";
						break;
					default:
						break;
					}
                }
            }
			
            $(function(){
            	switch ("${tariffPage.order }") {
				case "YuezuDESC":
					$("#yueZu").attr("class","sort_desc");
					break;
				case "tariffDESC":
					$("#tariff").attr("class","sort_desc");
					break;
				case "timeLongDESC":
					$("#timeLong").attr("class","sort_desc");
					break;

				default:
					break;
				}
            })
            
            //启用
            function startFee(tariffId) {
                var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
                if(r){
                	window.location.href="${pageContext.request.contextPath }"
                		+"/tariff/openAndDel.do?orderBy=${tariffPage.order}&tariffId="
                		+tariffId+"&status=1&currentPage=${tariffPage.page }";
                }
            }
            //删除
            function deleteFee(tariffId) {
                var r = window.confirm("确定要删除此资费吗？");
                if(r){
                	window.location.href="${pageContext.request.contextPath }"
                		+"/tariff/openAndDel.do?orderBy=${tariffPage.order}&tariffId="
                		+tariffId+"&status=2&currentPage=${tariffPage.page }";
                }
            }
        </script>        
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="3" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="" method="">
                <!--排序-->
                <div class="search_add">
                    <div>
                        <input type="button" id="yueZu" value="月租" class="sort_asc" onclick="sort(this);" />
                        <input type="button" id="tariff" value="基费" class="sort_asc" onclick="sort(this);" />
                        <input type="button" id="timeLong" value="时长" class="sort_asc" onclick="sort(this);" />
                    </div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='${pageContext.request.contextPath }/tariff/toAdd.do';" />
                </div> 
                <!--启用操作的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="${pageContext.request.contextPath }/view/images/close.png" onclick="this.parentNode.style.display='none';" />
                    删除成功！
                </div>    
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th>资费ID</th>
                            <th class="width100">资费名称</th>
                            <th>基本时长</th>
                            <th>基本费用</th>
                            <th>单位费用</th>
                            <th>创建时间</th>
                            <th>开通时间</th>
                            <th class="width50">状态</th>
                            <th class="width200"></th>
                        </tr>
                        <c:forEach items="${tariffPage.data }" var="t">
                        <tr>
                            <td>${t.tariffId }</td>
                            <td><a href="${pageContext.request.contextPath }/tariff/showDetail.do?tariffId=${t.tariffId }">${t.tariffName }</a></td>
                            <td>${t.timeLong }</td>
                            <td>${t.tariff }</td>
                            <td>${t.timeTariff }</td>
                            <td>${t.createTime }</td>
                            <td>${t.openTime }</td>
                            <c:choose>
                            	<c:when test="${t.status==0 }"><td>暂停</td></c:when>
                            	<c:when test="${t.status==1 }"><td>开通</td></c:when>
                            	<c:when test="${t.status==2 }"><td>删除</td></c:when>
                            	<c:otherwise><td></td></c:otherwise>
                            </c:choose>
                            <td>                                
                            <c:if test="${t.status==0 }">
                                <input type="button" value="启用" class="btn_start" onclick="startFee(${t.tariffId });" />
                                <input type="button" value="修改" class="btn_modify" 
                                onclick="location.href='${pageContext.request.contextPath }/tariff/toModi.do?tariffId=${t.tariffId }';" />
                                <input type="button" value="删除" class="btn_delete" onclick="deleteFee(${t.tariffId });" />
                            </c:if>
                            </td>
                        </tr>
                        </c:forEach>                      
                    </table>
                    <p>业务说明：<br />
                    1、创建资费时，状态为暂停，记载创建时间；<br />
                    2、暂停状态下，可修改，可删除；<br />
                    3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br />
                    4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
                    </p>
                </div>
                <!--分页-->
                <div id="pages">
                	<c:if test="${tariffPage.page>1 }">
        	        <a href="${pageContext.request.contextPath }/tariff/showDataList.do?currentPage=${tariffPage.page-1 }&orderBy=${tariffPage.order }">上一页</a>
                	</c:if>
                    <a href="" class="current_page">第${tariffPage.page }页/共${tariffPage.total }页</a>
                    <c:if test="${tariffPage.page<tariffPage.total }">
                    <a href="${pageContext.request.contextPath }/tariff/showDataList.do?currentPage=${tariffPage.page+1 }&orderBy=${tariffPage.order }">下一页</a>
                    </c:if>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
           
        </div>
    </body>
</html>
