<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath }/view/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath }/view/styles/global_color.css" />        
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.0.js"></script>
        <script language="javascript" type="text/javascript">
            //删除
            function deleteAccount() {
                var r = window.confirm("确定要删除此账务账号吗？\r\n删除后将不能恢复，且会删除其下属的所有业务账号。");
                document.getElementById("operate_result_info").style.display = "block";
            }
            //开通或暂停
            function setState(customerId,status) {
                var r = window.confirm("确定要更改此账务账号吗？");
                if(r){
                	document.getElementById("operate_result_info").style.display = "block";
                	window.location.href=
                		"${pageContext.request.contextPath }/customer/doStatus.do"
                		+"?customerId="+customerId+"&status="+status+
                		"&currentPage=${customerPage.page }";
                }
            }
            function sub(currentPage){
            	$("#page").val(currentPage);
            	$("#form").submit();
            }
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="4" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form id="form" action=
            "${pageContext.request.contextPath }/customer/showDataList.do" method="post">
            <input name="currentPage" id="page" type="hidden" value=""/>
                <!--查询-->
                <div class="search_add">                        
                    <div>身份证：<input type="text" name="idNumber" value="${customerPage.queryObj.idNumber }" class="text_search" /></div>                            
                    <div>姓名：<input type="text" name="customerName" class="width70 text_search" value="${customerPage.queryObj.customerName }" /></div>
                    <div>登录名：<input type="text" name="customerAccount"  value="${customerPage.queryObj.customerAccount }" class="text_search" /></div>
                    <div>
                        状态：
                        <select name="status" class="select_search">
                            <option value="-1">全部</option>
                            <option value="1">开通</option>
                            <option value="0">暂停</option>
                            <option value="2">删除</option>
                        </select>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="sub(1)" /></div>
                    <input type="button" value="增加" class="btn_add" onclick=
                    	"location.href='${pageContext.request.contextPath }/customer/toAdd.do';" />
                </div>  
                <!--删除等的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                    	操作成功！
                </div>   
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th>账号ID</th>
                        <th>姓名</th>
                        <th class="width150">身份证</th>
                        <th>登录名</th>
                        <th>状态</th>
                        <th class="width100">创建日期</th>
                        <th class="width150">上次登录时间</th>                                                        
                        <th class="width200"></th>
                    </tr>
                    <c:forEach items="${customerPage.data }" var="c">
                    <tr>
                        <td>${c.customerId }</td>
                        <td><a href=
                        "${pageContext.request.contextPath }/customer/showDetail.do?customerId=${c.customerId }">${c.customerName }</a></td>
                        <td>${c.idNumber }</td>
                        <td>${c.customerAccount }</td>
                        <td>
                        <c:choose>
                        	<c:when test="${c.status=='0' }">暂停</c:when>
                        	<c:when test="${c.status=='1' }">开通</c:when>
                        	<c:when test="${c.status=='2' }">删除</c:when>
                        </c:choose>
                        </td>
                        <td>${c.createTime }</td>
                        <td>${c.lastLoginTime }</td>                            
                        <td class="td_modi">
                        <c:if test="${c.status!='2' }">
                            <input type="button" value="${c.status!='0'?'暂停':'开通' }" class="btn_pause" onclick="setState(${c.customerId},${c.status!='0'?'0':'1' });" />
                            <input type="button" value="修改" class="btn_modify" onclick=
                            	"location.href='${pageContext.request.contextPath }/customer/toModi.do?customerId=${c.customerId }';" />
                            <input type="button" value="删除" class="btn_delete" onclick="setState(${c.customerId},2);" />
                        </c:if>
                        </td>
                    </tr>
                    </c:forEach>
                                      
                </table>
                <p>业务说明：<br />
                1、创建则开通，记载创建时间；<br />
                2、暂停后，记载暂停时间；<br />
                3、重新开通后，删除暂停时间；<br />
                4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                5、暂停账务账号，同时暂停下属的所有业务账号；<br />                
                6、暂停后重新开通账务账号，并不同时开启下属的所有业务账号，需要在业务账号管理中单独开启；<br />
                7、删除账务账号，同时删除下属的所有业务账号。</p>
                </div>                   
                <!--分页-->
                <div id="pages">
                <c:if test="${customerPage.page>1}">
                    <a onclick="sub(1)" href="#">首页</a>
        	        <a onclick="sub(${customerPage.page-1 })" href="#">上一页</a>
                </c:if>
                    <a class="current_page">第${customerPage.page}页/共${customerPage.total}页</a>
                <c:if test="${customerPage.page<customerPage.total }">
                    <a onclick="sub(${customerPage.page+1 })" href="#">下一页</a>
                    <a href="#" onclick="sub(${customerPage.total})">末页</a>
                </c:if>
                </div>                    
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            
        </div>
    </body>
</html>
