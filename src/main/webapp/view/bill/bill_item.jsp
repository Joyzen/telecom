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
        <script type="text/javascript">
        	var rootPath="${pageContext.request.contextPath}";
        	$(function(){
        		$("#datalist").datagrid({
        			title:'详单表',
        				iconCls:'icon-show',//图标 
                        width: 950, 
                        height: 300, 
                        nowrap: false, 
                        striped: true, 
                        border: true, 
                        collapsible:false,//是否可折叠的 
                        fit: false,//自动大小 
                        queryParams:{
                        	customerId:'${customerId}',
                        	months:'${months}',
                        	cost:'${cost}'
                        },
                        url:rootPath+'/bill/showDetailBill.do', 
                        //sortName: 'code', 
                        //sortOrder: 'desc', 
                        pageSize: 5,//每页显示的记录条数，默认为10 
            	        pageList: [3,5,10],//可以设置每页记录条数的列表 
                        remoteSort:false,  
                        idField:'osLoginId', 
                        singleSelect:true,//是否单选 
                        pagination:true,//分页控件 
                        rownumbers:false,//行号 
                        /* frozenColumns:[[ 
                            {field:'ck',checkbox:true} 
                        ]], */ 
                        /* onDblClickRow:function(row,index){
                        	detail();
                        }, */
                        toolbar:"#show"
        		})
        		var p = $('#datalist').datagrid('getPager'); 
        	    $(p).pagination({
        	        beforePageText: '第',//页数文本框前显示的汉字 
        	        afterPageText: '页  /  共 {pages} 页', 
        	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
        	    });
        	})
        	function formatOsAccount(val,row){
        		return row.os.osAccount;
        	}
        	function formatCustomerId(val,row){
        		return '${customerId}';
        	}
        	function formatTariffName(val,row){
        		return row.os.tariff.tariffName;
        	}
        	function formatOpr(val,row){
        		var url=rootPath+"/bill/toLoginDetail.do?customerAccount=${customerAccount }"+
        				"&osAccount="+row.os.osAccount+"&osId="+row.os.osId+
        				"&cost="+row.cost+"&months="+row.months+"&idNumber=${idNumber}";
        		return "<a href=\'"+url+"\'>详情</a>";
        	}
        	function formatTimeLong(val,row){
        		console.log(typeof row.timeLong)
        		console.log(row.timeLong)
        		return row.timeLong;
        	}
        	function back(){
        		window.location.href=rootPath+'/bill/toBills.do'
        	}
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="6" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="" method="">
                <!--查询-->
                <div class="search_add">                        
                    <div>账务账号：<span class="readonly width70">${customerAccount }</span></div>                            
                    <div>身份证：<span class="readonly width150">${idNumber }</span></div>
                    <div>姓名：<span class="readonly width70">${customerName }</span></div>
                    <div>计费时间：<span class="readonly width70">${cost }</span></div>
                    <div>总费用：<span class="readonly width70">${months }</span></div>
                    <input type="button" value="返回" class="btn_add" onclick="back()" />
                </div>  
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <thead>
                        <tr>
                            <th width="70" field="billDetailId">账单明细ID</th>
                            <th width="150" field="osAccount" formatter="formatOsAccount">OS 账号</th>
                            <th width="70" field="customerId" formatter="formatCustomerId">账务账号ID</th>
                            <th width="150" field="timeLong" formatter="formatTimeLong">时长</th>
                            <th width="150" field="cost">费用</th>
                            <th width="150" field="tariffName" formatter="formatTariffName">资费</th>
                            <th width="50" field="opr" formatter="formatOpr"></th>
                        </tr>
                    </thead>
                    </table>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
          
        </div>
    </body>
</html>
