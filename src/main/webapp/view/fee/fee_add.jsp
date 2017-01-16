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
            //保存结果的提示
            function showResult() {
            	showResultDiv(false)
            	if(validata()){
	            	$.ajax({
	            		url:"${pageContext.request.contextPath }/tariff/doAdd.do",
	            		data:$(".main_form").serialize(),
	            		success:function(data){
	            			if(data=="success"){
	            				showResultDiv(true);
	            				setTimeout("showResultDiv(false)",3000)
	            			}else if(data=='tariffNameFail'){
	            				$("#tariffNameMsg").attr("class","validate_msg_medium error_msg");
	            				$("#tariffNameMsg").html("资费名重复！");
	            			}
	            		}
	            	})
            	}
            }
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }

            //切换资费类型
            function feeTypeChange(type) {
                var inputArray = document.getElementById("main").getElementsByTagName("input");
                if (type == 1) {
                	$("#timeLong").attr("disabled","disabled");
                	$("#tariff").removeAttr("disabled");
                	$("#timeTariff").attr("disabled","disabled");
                    inputArray[4].value = "";
                    inputArray[4].className += "readonly";
                    inputArray[5].className = "width100";
                    inputArray[6].className += " readonly";
                    inputArray[6].value = "";
                }
                else if (type == 2) {
                	$("#timeLong").removeAttr("disabled");
                	$("#tariff").removeAttr("disabled");
                	$("#timeTariff").removeAttr("disabled");
                    inputArray[4].className = "width100";
                    inputArray[5].className = "width100";
                    inputArray[6].className = "width100";
                }
                else if (type == 3) {
                	$("#timeLong").attr("disabled","disabled");
                	$("#tariff").attr("disabled","disabled");
                	$("#timeTariff").removeAttr("disabled");
                    inputArray[4].value = "";
                    inputArray[4].className += " readonly";
                    inputArray[5].value = "";
                    inputArray[5].className += " readonly";
                    inputArray[6].className = "width100";
                }
            }
            
            //表单验证
            function validata(){
            	/*  初始化信息显示框  */
				$("#tariffNameMsg").attr("class","validate_msg_medium");
				$("#timeLongMsg").attr("class","validate_msg_medium");
				$("#tariffMsg").attr("class","validate_msg_medium");
				$("#timeTariffMsg").attr("class","validate_msg_medium");
				$("#tariffExplainMsg").attr("class","validate_msg_medium");
        		$("#tariffNameMsg").html("");
        		$("#timeLongMsg").html("");
        		$("#tariffMsg").html("");
        		$("#timeTariffMsg").html("");
        		$("#tariffExplainMsg").html("");
        		
				var regTariffName=/^([\u4e00-\u9fa5A-Za-z0-9]{4,50})$/;//2到50为的汉字或字母
				var regTimeLong=/^([1-5]\d{0,2}|600)$/; //1-600之间的整数
				var regTariff=/^\d{1,5}(\.\d{1,2})?$/;  //0-99999.99之间的数值
				var regTimeTariff=/^\d{1,5}(\.\d{1,2})?$/;  //0-99999.99之间的数值
				var regTariffExplain=/^([\u4e00-\u9fa5A-Za-z0-9]{4,100})$/;//4到100为的汉字或字母
				
        		/* 校验资费名 */
		    	if($("#tariffName").val()==""){
		    		$("#tariffNameMsg").attr("class","validate_msg_medium error_msg");
		    		$("#tariffNameMsg").html("资费名不能为空");
		    		return false;
		    	}
		    	if(!regTariffName.test($("#tariffName").val())){
		    		$("#tariffNameMsg").attr("class","validate_msg_medium error_msg");
		    		$("#tariffNameMsg").html("资费名格式不正确，50长度的字母、数字、汉字和下划线的组合");
		    		return false;
		    	}
		    	
		    	/* 校验时长 */
		    	if($("input:checked").val()==2){
			    	if($("#timeLong").val()==""){
			    		$("#timeLongMsg").attr("class","validate_msg_medium error_msg");
			    		$("#timeLongMsg").html("时长不能为空");
			    		return false;
			    	}
			    	if(!regTimeLong.test($("#timeLong").val())){
			    		$("#timeLongMsg").attr("class","validate_msg_medium error_msg");
			    		$("#timeLongMsg").html("时长格式不正确，请重新输入！");
			    		return false;
			    	}
		    	}
		    		
		    	
		    	/* 校验基本费用 */
		    	if($("input:checked").val()!=3){
			    	if($("#tariff").val()==""){
			    		$("#tariffMsg").attr("class","validate_msg_medium error_msg");
			    		$("#tariffMsg").html("基本费用不能为空！");
			    		return false;
			    	}
			    	if(!regTariff.test($("#tariff").val())){
			    		$("#tariffMsg").attr("class","validate_msg_medium error_msg");
			    		$("#tariffMsg").html("基本费用格式不正确，请重新输入！");
			    		return false;
			    	}
		    	}
		    	/* 校验单位费用 */
		    	if($("input:checked").val()!=1){
			    	if($("#timeTariff").val()==""){
			    		$("#timeTariffMsg").attr("class","validate_msg_medium error_msg");
			    		$("#timeTariffMsg").html("单位费用不能为空！");
			    		return false;
			    	}
			    	if(!regTimeTariff.test($("#timeTariff").val())){
			    		$("#timeTariffMsg").attr("class","validate_msg_medium error_msg");
			    		$("#timeTariffMsg").html("单位费用格式不正确，请重新输入！");
			    		return false;
			    	}
		    	}
		    	
		    	/* 校验资费说明 */
		    	if($("#tariffExplain").val()==""){
		    		$("#tariffExplainMsg").attr("class","validate_msg_medium error_msg");
		    		$("#tariffExplainMsg").html("资费说明不能为空");
		    		return false;
		    	}
		    	if(!regTariffExplain.test($("#tariffExplain").val())){
		    		$("#tariffExplainMsg").attr("class","validate_msg_medium error_msg");
		    		$("#tariffExplainMsg").html("资费说明格式不正确，50长度的字母、数字、汉字和下划线的组合");
		    		return false;
		    	}
		    	return true;
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
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form action="" method="" class="main_form">
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info">
                    <input id="tariffName" name="tariffName" type="text" class="width300" value=""/>
                    <span class="required">*</span>
                    <div id="tariffNameMsg" class="validate_msg_short">50长度的字母、数字、汉字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info fee_type">
                    <input  type="radio" name="tariffType" value="1" id="monthly" onclick="feeTypeChange(1);" />
                    <label for="monthly">包月</label>
                    <input type="radio" name="tariffType" value="2" checked="checked" id="package" onclick="feeTypeChange(2);" />
                    <label for="package">套餐</label>
                    <input type="radio" name="tariffType" value="3" id="timeBased" onclick="feeTypeChange(3);" />
                    <label for="timeBased">计时</label>
                </div>
                <div class="text_info clearfix"><span>基本时长：</span></div>
                <div class="input_info">
                    <input type="text" id="timeLong" name="timeLong" value="" class="width100" />
                    <span class="info">小时</span>
                    <span class="required">*</span>
                    <div id="timeLongMsg" class="validate_msg_long">1-600之间的整数</div>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input type="text" id="tariff" name="tariff" value="" class="width100" />
                    <span class="info">元</span>
                    <span class="required">*</span>
                    <div id="tariffMsg" class="validate_msg_long">0-99999.99之间的数值</div>
                </div>
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input type="text" id="timeTariff" name="timeTariff" value="" class="width100" />
                    <span class="info">元/小时</span>
                    <span class="required">*</span>
                    <div id="timeTariffMsg" class="validate_msg_long">0-99999.99之间的数值</div>
                </div>
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea id="tariffExplain" name="tariffExplain" class="width300 height70"></textarea>
                    <div id="tariffExplainMsg" class="validate_msg_short">100长度的字母、数字、汉字和下划线的组合</div>
                </div>                    
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save"  onclick="showResult();" />
                    <input type="button" value="取消" class="btn_save" />
                </div>
            </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
          
        </div>
    </body>
</html>
