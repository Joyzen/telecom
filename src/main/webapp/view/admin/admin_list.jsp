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
            function showDetail(flag, a) {
                var detailDiv = a.parentNode.getElementsByTagName("div")[0];
                if (flag) {
                    detailDiv.style.display = "block";
                }
                else
                    detailDiv.style.display = "none";
            }
            //重置密码
            function resetPwd() {
            	var a=new Array()
            	var c = $("input:checked");
            	if(c.length<1){
            		alert("请至少选择一条记录！")
            		return;
            	}
            	var i = 0;
            	for(;i<c.length;i++){
            		$.ajax({
            			url		: "${pageContext.request.contextPath }/admin/reset.do",
            			data	: {'adminId':c[i].value,'currentPage': ${currentPage} },
            			success	: function (data){
            				if(data=='success'){
            					alert("重置密码成功！")
            				}
            				else{
            					alert("重置密码失败！")
            				}
            			}
            		})
            	}
            	//window.location.href="${pageContext.request.contextPath }/admin/delAdmin.do";
            }
            //删除
            function deleteAdmin(adminId) {
                var r = window.confirm("确定要删除此管理员吗？");
                if(r){
                	window.location.href="${pageContext.request.contextPath }/admin/delAdmin.do?adminId="
                			+adminId+"&currentPage=${currentPage}";
                }
                $("#operate_result_info").html("删除成功！")
                document.getElementById("operate_result_info").style.display = "block";
            }
            //全选
            function selectAdmins(inputObj) {
                var inputArray = document.getElementById("datalist").getElementsByTagName("input");
                for (var i = 1; i < inputArray.length; i++) {
                    if (inputArray[i].type == "checkbox") {
                        inputArray[i].checked = inputObj.checked;
                    }
                }
            }
            function search() {
				window.location.href="${pageContext.request.contextPath }/admin/list.do"
									 +"?powerId="+$("#selModules").val();
			}
        </script>       
    </head>
    <body>
        <!--Logo区域开始-->
        <!--导航区域开始-->
        <c:set var="pagePower" value="2" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--主要区域开始-->
        <div id="main">
            <form action="" method="">
                <!--查询-->
                <div class="search_add">
                    <div>
                        模块：
                        <select id="selModules" class="select_search" name="powerId">
                            <option ${powerId==-1?"selected":"" } value="-1">全部</option>
                            <option ${powerId==2?"selected":"" } value="2">管理员管理</option>
                            <option ${powerId==3?"selected":"" } value="3">资费管理</option>
                            <option ${powerId==4?"selected":"" } value="4">账务账号</option>
                            <option ${powerId==5?"selected":"" } value="5">业务账号</option>
                            <option ${powerId==6?"selected":"" } value="6">账单管理</option>
                            <option ${powerId==7?"selected":"" } value="7">报表</option>
                        </select>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="search()"/></div>
                    <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();" />
                    <input type="button" value="增加" class="btn_add" onclick="location.href='${pageContext.request.contextPath }/admin/toAdd.do';" />
                </div>
                <!--删除和密码重置的操作提示-->
                <div id="operate_result_info" class="operate_fail">
                    <img src="${pageContext.request.contextPath }/view/images/close.png" onclick="this.parentNode.style.display='none';" alt="图片"/>
                    <span ></span>
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th class="th_select_all">
                                <input type="checkbox" onclick="selectAdmins(this);" />
                                <span>全选</span>
                            </th>
                            <th>管理员ID</th>
                            <th>姓名</th>
                            <th>登录名</th>
                            <th>电话</th>
                            <th>电子邮件</th>
                            <th>授权日期</th>
                            <th class="width100">拥有权限</th>
                            <th></th>
                        </tr>                      
                        <c:forEach items="${la }" var="a">
                        	<tr>
                            <td><input value="${a.adminId }" type="checkbox" /></td>
                            <td>${a.adminId }</td>
                            <td>${a.adminName }</td>
                            <td>${a.adminAccount }</td>
                            <td>${a.phone }</td>
                            <td>${a.email }</td>
                            <td>${a.createTime }</td>
                            <td>
                                <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">拥有权限</a>
                                <!--浮动的详细信息-->
                                <div class="detail_info">
                                    <c:forEach items="${a.powers }" var="p">
                                    
                                    		<c:if test="${p==2 }">管理员管理&nbsp</c:if>
                                    		<c:if test="${p==3 }">资费管理&nbsp</c:if>
                                    		<c:if test="${p==4 }">账务账号管理&nbsp</c:if>
                                    		<c:if test="${p==5 }">业务账号管理管理&nbsp</c:if>
                                    		<c:if test="${p==6 }">账单管理&nbsp</c:if>
                                    		<c:if test="${p==7 }">报表管理&nbsp</c:if>
                                    </c:forEach>
                                </div>
                            </td>
                            <td class="td_modi">
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='${pageContext.request.contextPath }/admin/toModi.do?adminId=${a.adminId }';" />
                                <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin(${a.adminId });" />
                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
                <c:if test="${currentPage>1 }">
        	        <a href="${pageContext.request.contextPath }/admin/list.do?currentPage=${currentPage-1 }&powerId=${powerId}">上一页</a>
        	    </c:if>
                    <a href="#" class="current_page">第${currentPage }页/共${countPage }页</a>
                <c:if test="${currentPage<countPage }">
                    <a href="${pageContext.request.contextPath }/admin/list.do?currentPage=${currentPage+1 }&powerId=${powerId}">下一页</a>
                </c:if>
                </div>                    
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
          
        </div>
    </body>
</html>
