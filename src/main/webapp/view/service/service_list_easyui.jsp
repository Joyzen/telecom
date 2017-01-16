<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath }/view/styles/globaleasyUI.css" />
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath }/view/styles/global_color.css" />        
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath }/css/themes/material/easyui.css" />        
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/themes/icon.css"></link>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
        <script language="javascript" type="text/javascript" 
        src="${pageContext.request.contextPath}/js/service_easyui.js"></script>
        <script type="text/javascript" language="javascript">
        	var rootPath="${pageContext.request.contextPath}";
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="5" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
                <!--查询-->
                <div id="search" class="search_add">                        
                    <div>OS 账号：<input id="osAccount" name="osAccount" type="text" value="${bussinessPage.queryObj.osAccount }" class="width100 text_search" /></div>                            
                    <!-- <div>服务器 IP：<input type="text" value="" class="width100 text_search" /></div> -->
                    <div>身份证：<input id="idNumber" name="idNumber" type="text"  value="${bussinessPage.queryObj.idNumber }" class="text_search" /></div>
                    <div>状态：
                        <select id="status" name="status" class="select_search">
                            <option value="-1">全部</option>
                            <option value="1">开通</option>
                            <option value="0">暂停</option>
                            <option value="2">删除</option>
                        </select>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="doSearch()"/></div>
                    <div><input type="button" value="搜索全部" class="btn_search_large" onclick="doSearch('none')"/></div>
                    <input type="button" value="增加" class="btn_add" onclick="oprWin('open')" />
                </div>  
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="${pageContext.request.contextPath}/view/images/close.png" onclick="this.parentNode.style.display='none';" />
                </div>   
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="dl" class="easyui-datagrid">
                    <thead>
	                	<tr>
	                        <th field="bussinessId" width="70px">业务ID</th>
	                        <th field="customerId" width="70px" formatter="formatCustomerId">账务账号ID</th>
	                        <th field="idNumber" width="150px" formatter="formatIdNumber">身份证</th>
	                        <th field="customerName" width="70px" formatter="formatCustomerName">姓名</th>
	                        <th field="osAccount" width="70px" formatter="formatOsAccount">OS 账号</th>
	                        <th field="status" width="70px" formatter="formatStatus">状态</th>
	                        <th field="tariffName" width="100px" formatter="formatTariffName" >资费</th>                                                        
	                        <th field="opr" width="200px" formatter="formatOpr">操作</th>
	                    </tr>
                    </thead>
                	</table>
                	<!-- ----------------------添加对话窗口开始--------------------------- -->  
          <div id="addDialog" class="easyui-dialog">
            <form id="addForm" action="" method="post" class="main_form">
                <!--内容项-->
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                    <input name="idNumber" type="text" value="查询出的结果写入账务账号" class="easyui-validatebox width180"
                     required="true"/>
                    <input type="button" value="查询账务账号" class="btn_search_large" onclick="searchAccounts()" />
                    <input name="customerId"type="hidden" value=""/>
                    <span id="idNumberMsg" class="required">*</span>
                    <div class="validate_msg_short"></div>
                </div>
                <div class="text_info clearfix"><span>账务账号：</span></div>
                <div class="input_info">
                    <input name="customerAccount" class="easyui-validatebox" type="text" value="" onkeyup="searchAccounts(this);" 
                    required="true"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long"></div>
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info">
                    <select name="tariffId">
                    </select>                        
                </div> 
                <div class="text_info clearfix"><span>登录 OS 账号：</span></div>
                <div class="input_info">
                    <input class="easyui-validatebox" name="osAccount" type="text" 
                    data-options="required:true,validType:'osAccount'"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long"></div>
                </div>
                <div class="text_info clearfix"><span>密码：</span></div>
                <div class="input_info">
                    <input id="osPassword" name="osPassword" type="password" class="easyui-validatebox"
                    data-options="required:true,validType:'password'" />
                    <span class="required">*</span>
                    <div class="validate_msg_long"></div>
                </div>
                <div class="text_info clearfix"><span>重复密码：</span></div>
                <div class="input_info">
                    <input class="easyui-validatebox" type="password" 
                    data-options="required:true" validType="equals['#osPassword']"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long"></div>
                </div>     
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="sub();" />
                    <input type="button" value="取消" class="btn_save" onclick="$('#addDialog').dialog('close')"/>
                </div>
            </form>
        </div> 
        <!-- ----------------------添加对话窗口结束--------------------------- -->   
        
        
        <!-- ----------------------修改对话窗口开始--------------------------- -->   
        <div id="modiDialog" class="easyui-dialog">
            <form id="modiForm" action="" method="" class="main_form">
                <!--必填项-->
                <div class="text_info clearfix"><span>业务账号ID：</span></div>
                <div class="input_info">
                    <input name="bussinessId" type="text" value="" readonly class="readonly" />
                </div>
                <div class="text_info clearfix"><span>OS 账号：</span></div>
                <div class="input_info">
                    <input name="osAccount" type="text" value="" readonly class="readonly" />
                    <input name="osId" type="hidden"/>
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info">
                    <select name="tariffId" class="width150">
                    </select>
                    <div class="validate_msg_long">请修改资费类型，或者取消修改操作。</div>                      
                </div>
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="subModi();" />
                    <input type="button" value="取消" class="btn_save" onclick="$('#modiDialog').dialog('close')"/>
                </div>
            </form>  
        </div> 
        <!-- ----------------------修改对话窗口结束--------------------------- -->  
        
                   
        <!-- ----------------------详情显示对话窗口开始--------------------------- -->  
         <div id="detailDialog" class="easyui-dialog">            
                <div class="text_info clearfix"><span>业务账号ID：</span></div>
                <div class="input_info"><input id="bussinessId" type="text" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>账务账号ID：</span></div>
                <div class="input_info"><input id="customerId" type="text" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>客户姓名：</span></div>
                <div class="input_info"><input id="customerName" type="text" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>身份证号码：</span></div>
                <div class="input_info"><input id="idNum" type="text" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>OS 账号：</span></div>
                <div class="input_info"><input id="osAcc" type="text" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>状态：</span></div>
                <div class="input_info">
                    <select id="state" disabled>
                        <option value="1">开通</option>
                        <option value="0">暂停</option>
                        <option value="2">删除</option>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>开通时间：</span></div>
                <div class="input_info"><input id="createTime" type="text" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>资费 ID：</span></div>
                <div class="input_info"><input id="tariffId" type="text" class="readonly" readonly /></div>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info"><input id="tariffName" type="text" readonly class="width200 readonly" /></div>
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea id="tariffExplain" class="width300 height70 readonly" readonly></textarea>
                </div>  
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="关闭" class="btn_save" onclick="$('#detailDialog').dialog('close')" />
                </div>
        </div>
        <!-- ----------------------详情显示对话窗口结束--------------------------- -->  
                <p><span class="required">**双击姓名查看详细信息**</span><br />
               	业务说明：<br />
                1、创建即开通，记载创建时间；<br />
                2、暂停后，记载暂停时间；<br />
                3、重新开通后，删除暂停时间；<br />
                4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                5、业务账号不设计修改密码功能，由用户自服务功能实现；<br />
                6、暂停和删除状态的账务账号下属的业务账号不能被开通。</p>
                </div>                    
        </div>
        <!--主要区域结束-->
        <div id="footer">
           
        </div>
    </body>
</html>
