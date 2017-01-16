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
            //显示角色详细信息
            function showDetail(flag,a) {
                var detailDiv = a.parentNode.getElementsByTagName("div")[0];
                if (flag) {
                    detailDiv.style.display = "block";
                }
                else
                    detailDiv.style.display = "none";
            }
            //删除
            function deleteAccount() {
                var r = window.confirm("确定要删除此业务账号吗？删除后将不能恢复。");
                document.getElementById("operate_result_info").style.display = "block";
            }
            //开通或暂停
            function setState() {
                var r = window.confirm("确定要开通此业务账号吗？");
                document.getElementById("operate_result_info").style.display = "block";
            }
            //跳转页面，搜索通用方法
            function toPage(currentPage){
            	$("#page").val(currentPage);
            	$("form").submit();
            }
            //设置状态
            function setStatus(bussinessId,status){
            	$.post({
            		url		:"${pageContext.request.contextPath}/bussiness/updateStatus.do",
            		data	:{
            					"bussinessId":bussinessId,
            					"status":status,
            		},
            		success:function(data){
            			if(data=="success"){
            				if(status==0){
            					$("#operate_result_info").html("暂停成功")
            				}
            				if(status==1){
            					$("#operate_result_info").html("开通成功")
            				}
            				if(status==2){
            					$("#operate_result_info").html("删除成功")
            				}
            				$("#operate_result_info").css("display","block");
            				setTimeout("toPage(${bussinessPage.page})",1000);
            			}
            		}
            	})
            }
            
            $(function(){
            	$(".select_search").val(${bussinessPage.queryObj.status });
            })
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="5" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="${pageContext.request.contextPath}/bussiness/showDataList.do" method="post">
            	<input id="page" name="currentPage" type="hidden" value=""/>
                <!--查询-->
                <div class="search_add">                        
                    <div>OS 账号：<input name="osAccount" type="text" value="${bussinessPage.queryObj.osAccount }" class="width100 text_search" /></div>                            
                    <!-- <div>服务器 IP：<input type="text" value="" class="width100 text_search" /></div> -->
                    <div>身份证：<input name="idNumber" type="text"  value="${bussinessPage.queryObj.idNumber }" class="text_search" /></div>
                    <div>状态：
                        <select name="status" class="select_search">
                            <option value="-1">全部</option>
                            <option value="1">开通</option>
                            <option value="0">暂停</option>
                            <option value="2">删除</option>
                        </select>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="toPage(1)"/></div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='${pageContext.request.contextPath}/bussiness/toAdd.do';" />
                </div>  
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="${pageContext.request.contextPath}/view/images/close.png" onclick="this.parentNode.style.display='none';" />
                </div>   
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th class="width50">业务ID</th>
                        <th class="width70">账务账号ID</th>
                        <th class="width150">身份证</th>
                        <th class="width70">姓名</th>
                        <th>OS 账号</th>
                        <th class="width50">状态</th>
                        <th class="width100">资费</th>                                                        
                        <th class="width200"></th>
                    </tr>
                    <c:forEach items="${bussinessPage.data }" var="b">
                    <tr>
                        <td><a href="service_detail.html" title="查看明细">${b.bussinessId }</a></td>
                        <td>${b.os.customer.customerId }</td>
                        <td>${b.os.customer.idNumber }</td>
                        <td>${b.os.customer.customerName }</td>
                        <td>${b.os.osAccount }</td>
                        <td>
                        <c:choose>
                        	<c:when test="${b.os.status=='0'}">暂停</c:when>
                        	<c:when test="${b.os.status=='1'}">开通</c:when>
                        	<c:when test="${b.os.status=='2'}">删除</c:when>
                        </c:choose>
                        </td>
                        <td>
                            <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">${b.os.tariff.tariffName }</a>
                            <!--浮动的详细信息-->
                            <div class="detail_info">
                                ${b.os.tariff.tariffExplain }
                            </div>
                        </td>                            
                        <td class="td_modi">
                        <c:if test="${b.os.status!='2'}">
                            <input type="button" value="${b.os.status!='1'?'开通':'暂停'}" class="btn_pause" 
                            onclick="setStatus(${b.bussinessId },${b.os.status!='1'?'1':'0'});" />
                            <input type="button" value="修改" class="btn_modify" onclick="location.href='service_modi.html';" />
                            <input type="button" value="删除" class="btn_delete" 
                            onclick="setStatus(${b.bussinessId },2);" />
                        </c:if>
                        </td>
                    </tr>
                    </c:forEach>
                </table>                
                <p>业务说明：<br />
                1、创建即开通，记载创建时间；<br />
                2、暂停后，记载暂停时间；<br />
                3、重新开通后，删除暂停时间；<br />
                4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                5、业务账号不设计修改密码功能，由用户自服务功能实现；<br />
                6、暂停和删除状态的账务账号下属的业务账号不能被开通。</p>
                </div>                    
                <!--分页-->
                <div id="pages">
                <c:if test="${bussinessPage.page>1}">
                    <a href="#" onclick="toPage(1)">首页</a>
        	        <a href="#" onclick="toPage(${bussinessPage.page-1})">上一页</a>
                </c:if>
                    <a href="#" class="current_page">第${bussinessPage.page}页/共${bussinessPage.total}页</a>
                <c:if test="${bussinessPage.page<bussinessPage.total}">
                    <a href="#" onclick="toPage(${bussinessPage.page+1})">下一页</a>
                    <a href="#" onclick="toPage(${bussinessPage.total})">末页</a>
                </c:if>
                </div>                    
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
           
        </div>
    </body>
</html>
