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
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/Highcharts/highcharts.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/Highcharts/data.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/Highcharts/drilldown.js"></script>
        <script language="javascript" type="text/javascript">
        	var rootPath="${pageContext.request.contextPath}";
	        function changeTab(e,ulObj) {                
	            var obj = e.srcElement || e.target;
	            if (obj.nodeName == "A") {
	                var links = ulObj.getElementsByTagName("a");
	                for (var i = 0; i < links.length; i++) {
	                    if (links[i].innerHTML == obj.innerHTML) {
	                        links[i].className = "tab_on";
	                        var order='';
	                        if(i==0){
	                        	order='timeLong';
	                        }else if(i==1){
	                        	order='customer'
	                        }else if(i==2){
	                        	order='tariff'
	                        }
	                        initTable(i);
	                        $("#datalist").datagrid("load",{
	                        	order:order,
	                        })
	                    }
	                    else {
	                        links[i].className = "tab_out";
	                    }
	                }
	            }
	        }
            $(function(){
            	$("#datalist").datagrid({
            		title:'报表显示', 
                    iconCls:'icon-show',//图标 
                    width: 950, 
                    height: 300, 
                    nowrap: false, 
                    striped: true, 
                    border: true, 
                    collapsible:false,//是否可折叠的 
                    fit: false,//自动大小 
                    url:rootPath+'/bill/showReport.do', 
                    //sortName: 'code', 
                    //sortOrder: 'desc', 
                    pageSize: 5,//每页显示的记录条数，默认为10 
        	        pageList: [3,5,10],//可以设置每页记录条数的列表 
                    remoteSort:false,  
                    idField:'billId', 
                    singleSelect:true,//是否单选 
                    pagination:true,//分页控件 
                    rownumbers:false,//行号 
                    toolbar:"#tabs"
            	})
            	var p = $('#datalist').datagrid('getPager'); 
        	    $(p).pagination({
        	        beforePageText: '第',//页数文本框前显示的汉字 
        	        afterPageText: '页  /  共 {pages} 页', 
        	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
        	    });
        	    initTable(0);
        	    $("#container").dialog({
        	    	title:'用户时长排序',
        	    	closed:true,
        	    	modal:true,
        	    	//onBeforeOpen:initTariff()
        	    })
            })
            function formatTimeLong(val,row){
            	var timeLong=row.timeLong;
            	h=Math.floor(timeLong/(60*60));
            	m=Math.floor((timeLong-h*60*60)/60);
            	s=timeLong%60;
            	return h+'小时'+m+'分'+s+'秒'
            }
            function formatTariffType(val,row){
            	if(row.tariffType=='1'){
            		return '包月'
            	}else if(row.tariffType=='2'){
            		return '套餐'
            	}else if(row.tariffType=='3'){
            		return '计时'
            	}
            	return '无'
            }
            function initTable(i){
            	if(i==0){
            		init0(true);
            		init1(true);
            		init2(false);
            	}else if(i==1){
            		init0(true);
            		init1(false);
            		init2(false);
            	}else if(i==2){
            		init0(false);
            		init1(false);
            		init2(true);
            	}
            }
            function init0(flag){
            	if(flag){
            		$("#datalist").datagrid("showColumn","customerId")
            		$("#datalist").datagrid("showColumn","customerAccount")
            		$("#datalist").datagrid("showColumn","customerName")
            		$("#datalist").datagrid("showColumn","idNumber")
            		$("#datalist").datagrid("showColumn","phone")
            		$("#datalist").datagrid("showColumn","timeLong")
            	}else{
            		$("#datalist").datagrid("hideColumn","customerId")
            		$("#datalist").datagrid("hideColumn","customerAccount")
            		$("#datalist").datagrid("hideColumn","customerName")
            		$("#datalist").datagrid("hideColumn","idNumber")
            		$("#datalist").datagrid("hideColumn","phone")
            		$("#datalist").datagrid("hideColumn","timeLong")
            	}
            }
            function init1(flag){
            	if(flag){
            		$("#datalist").datagrid("showColumn","months")
            	}else{
            		$("#datalist").datagrid("hideColumn","months")
            	}
            }
            function init2(flag){
            	if(flag){
            		$("#datalist").datagrid("showColumn","tariffId")
            		$("#datalist").datagrid("showColumn","tariffName")
            		$("#datalist").datagrid("showColumn","tariffType")
            		$("#datalist").datagrid("showColumn","times")
            	}else{
            		$("#datalist").datagrid("hideColumn","tariffId")
            		$("#datalist").datagrid("hideColumn","tariffName")
            		$("#datalist").datagrid("hideColumn","tariffType")
            		$("#datalist").datagrid("hideColumn","times")
            	}
            }
            /*************************************************************/
            	var url=rootPath+'/bill/getHighcharts.do';
            	$(function () {
            		$.getJSON(url, function (data) {
            	        // Create the chart
            			$('#container').highcharts({
        	                chart: {
        	                    type: 'column'
        	                },
        	                title: {
        	                    text: '用户时长情况'
        	                },
        	                subtitle: {
        	                    text: '点击柱状图查看详细'
        	                },
        	                xAxis: {
        	                    type: 'category'
        	                },
        	                yAxis: {
        	                    title: {
        	                        text: '用户已使用时长（秒）'
        	                    }
        	                },
        	                legend: {
        	                    enabled: false
        	                },
        	                plotOptions: {
        	                    series: {
        	                        borderWidth: 0,
        	                        dataLabels: {
        	                            enabled: true,
        	                            format: '{point.y:.1f}'
        	                        }
        	                    }
        	                },
        	                tooltip: {
        	                    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        	                    pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}</b><br/>'
        	                },
        	                series: [{
        	                    name: 'Brands',
        	                    colorByPoint: true,
        	                    data: data.lm
        	                }],
        	                drilldown: {
        	                    series: data.lmd
        	                },
        	            }); 
            		})
            	            
            	});
        /********************************************************************/
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="7" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->        
        <div id="report_main">
        	<div id="tabs" class="tabs">
    	        <ul onclick="changeTab(event,this);">
        	        <li><a href="#" class="tab_on" title="每位客户每月的累计时长">客户使用时长</a></li>
                    <li><a href="#" class="tab_out" title="系统上累计时长最高的前三名客户">时长排行榜</a></li>
                    <li><a href="#" class="tab_out" title="每种资费标准的使用次数">资费使用率</a></li>
                </ul>
                <div><input type="button" value="查看柱状图" class="btn_search_large right" onclick="$('#container').dialog('open')"/></div>
            </div>            
            <div class="report_box">
                <!--数据区域：用表格展示数据-->
                <div id="report_data">
                    <table id="datalist">
                    <thead>
                        <tr>                            
                            <th field="customerId" width="70">账号 ID</th>
                            <th field="customerAccount" width="100">账务帐号</th>
                            <th field="customerName" width="100">客户姓名</th>
                            <th field="idNumber" width="150">身份证号码</th>
                            <th field="phone" width="120">电话</th>
                            <th field="months" width="110">月份</th>
                            <th field="timeLong" width="120" formatter="formatTimeLong">累积时长</th>
                            <th field="tariffId" width="70">资费ID</th>
                            <th field="tariffName" width="120">资费名称</th>
                            <th field="tariffType" width="70" formatter="formatTariffType">资费类型</th>
                            <th field="times">资费使用率（次）</th>
                        </tr>                      
                    </thead>
                    </table>
                </div>
            </div>
        </div>
        <!-- Highcharts图表显示窗口 -->
        <div id="container" style="min-width: 1000px; height: 500px; margin: 0 auto"></div>
        <!--主要区域结束-->
        <div id="footer"></div>
    </body>
</html>
