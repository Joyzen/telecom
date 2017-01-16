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
        <script language="javascript" type="text/javascript">
        	var rootPath="${pageContext.request.contextPath}";
            //写入下拉框中的年份和月份
            function initialYearAndMonth() {
                //写入最近3年
                var yearObj = document.getElementById("year");
                var year = (new Date()).getFullYear();
                var opObj = new Option("全部", "");
                yearObj.options[0] = opObj;
                yearObj
                for (var i = 1; i <= 3; i++) {
                    var opObj = new Option(year - i+1, year - i+1);
                    yearObj.options[i] = opObj;
                }
                //写入 12 月
                var monthObj = document.getElementById("month");
                var opObj = new Option("全部", "");
                monthObj.options[0] = opObj;
                for (var i = 1; i <= 12; i++) {
                    var opObj = new Option(i, i);
                    monthObj.options[i] = opObj;
                }
            }
            $(function(){
            	$("#datalist").datagrid({
            		title:'账单信息显示', 
                    iconCls:'icon-show',//图标 
                    width: 950, 
                    height: 300, 
                    nowrap: false, 
                    striped: true, 
                    border: true, 
                    collapsible:false,//是否可折叠的 
                    fit: false,//自动大小 
                    url:rootPath+'/bill/getBills.do', 
                    //sortName: 'code', 
                    //sortOrder: 'desc', 
                    pageSize: 5,//每页显示的记录条数，默认为10 
        	        pageList: [3,5,10],//可以设置每页记录条数的列表 
                    remoteSort:false,  
                    idField:'billId', 
                    singleSelect:true,//是否单选 
                    pagination:true,//分页控件 
                    rownumbers:false,//行号 
                    /* frozenColumns:[[ 
                        {field:'ck',checkbox:true} 
                    ]], */ 
                    /* onDblClickRow:function(row,index){
                    	detail();
                    }, */
                    toolbar:"#search"
            	})
            	var p = $('#datalist').datagrid('getPager'); 
        	    $(p).pagination({
        	        beforePageText: '第',//页数文本框前显示的汉字 
        	        afterPageText: '页  /  共 {pages} 页', 
        	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
        	    });
            })
            //搜索方法
        	function doSearch(opr){
        		if(opr=='none'){
        			$('#customerAccount').val('');
        			$('#idNumber').val('');
        			$('#customerName').val('');
        			$("#year").val('')
        			$("#month").val('')
        			$('#datalist').datagrid('load',{
        				customerAccount: $('#customerAccount').val(),
	        			idNumber: $('#idNumber').val(),
	        			customerName:$('#customerName').val(),
	        			month:$("#month").val(),
	        			year:$("#year").val(),
	        		});
        		}
        		else{
        			var month = $("#month").val();
        			if(month.length==1){
        				month='0'+month;
        			}
	        		$('#datalist').datagrid('load',{
	        			customerAccount: $('#customerAccount').val(),
	        			idNumber: $('#idNumber').val(),
	        			customerName:$('#customerName').val(),
	        			month:month,
	        			year:$("#year").val(),
	        		});
        		}
        	}
            
            function formatIdNumber(val,row){
        		return row.customer.idNumber;
        	}
        	function formatCustomerName(val,row){
        		return row.customer.customerName;
        	}
        	function formatCustomerAccount(val,row){
        		return row.customer.customerAccount;
        	}
        	function formatMonths(val,row){
        		var months=row.months;
        		var year=months.substring(0,4)
        		var month='';
        		if(months.substring(4,5)=='0'){
        			month=months.substring(5,6)
        		}else{
        			month=months.substring(4,6)
        		}
        		return year+'年'+month+'月';
        	}
        	function formatPayStatus(val,row){
        		if(row.payStatus=='0'){
        			return '未支付';
        		}else{
        			return '已支付';
        		}
        	}
        	function formatDetail(val,row){
        		var url=rootPath+"/bill/toDetail.do?idNumber="+
        				row.customer.idNumber+"&months="+row.months+"&cost="
        				+row.cost;
        		return "<a href=\'"+url+"\'>详单</a>";
        	}
        </script>
    </head>
    <body onload="initialYearAndMonth();">
        <!--Logo区域开始-->
        <c:set var="pagePower" value="6" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="" method="">
                <!--查询-->
                <div class="search_add" id="search">                        
                    <div>身份证：<input id="idNumber" type="text"  value="" class="text_search" /></div>
                    <div>账务账号：<input id="customerAccount" type="text" value="" class="width100 text_search" /></div>                            
                    <div>姓名：<input id="customerName" type="text" value="" class="width70 text_search" /></div>
                    <div>
                        <select class="select_search" id="year">
                        </select>
                        年
                        <select class="select_search" id="month">
                        </select>
                        月
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="doSearch()"/></div>
					<div><input type="button" value="搜全部" class="btn_search" onclick="doSearch('none')"/></div>
			</div>
			</form>
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist" class="easyui-datagrid">
                    <thead>
                    <tr>
                        <th field="billId" width="100px" >账单ID</th>
                        <th field="customerName" width="100px" formatter="formatCustomerName" >姓名</th>
                        <th field="idNumber" width="150px" formatter="formatIdNumber" >身份证</th>
                        <th field="customerAccount" width="100px" formatter="formatCustomerAccount" >账务账号</th>
                        <th field="cost"  width="70px" >费用</th>
                        <th field="months" width="120px" formatter="formatMonths" >月份</th>
                        <th field="payWay" width="100px" >支付方式</th>
                        <th field="payStatus" width="120px" formatter="formatPayStatus" >支付状态</th>                                                        
                        <th field="detail" width="70px" formatter="formatDetail" ></th>
                    </tr>
                    </thead>
                </table>
                
                <p>业务说明：<br />
                1、设计支付方式和支付状态，为用户自服务中的支付功能预留；<br />
                2、只查询近 3 年的账单，即当前年和前两年，如2013/2012/2011；<br />
                3、年和月的数据由 js 代码自动生成；<br />
                4、由数据库中的ｊｏｂ每月的月底定时计算账单数据。</p>
                </div>                    
        </div>
        <!--主要区域结束-->
        <div id="footer">
            
           
        </div>
    </body>
</html>
