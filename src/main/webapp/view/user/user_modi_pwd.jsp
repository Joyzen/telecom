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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/themes/metro/easyui.css"></link>
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/themes/icon.css"></link>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

        
        <script type="text/javascript">
        	function showResult() {
        		showResultDiv(false);
        		if(check()){
	        		$.ajax({
	        			url		:"${pageContext.request.contextPath }/admin/doModi.do",
	        			data	:$(".main_form").serialize(),
	        			success	:function(data){
	        				if(data=='success'){
	        					/* $.messager.alert('提示信息','密码修改成功！','info');
	        					window.location.href="${pageContext.request.contextPath }/" */
	        					showResultDiv(true);
	        					/* 三秒后跳转到登录页面 */
	        					setTimeout("window.location.href='${pageContext.request.contextPath }/'",3000)
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
        	
        	function check(){
        		/*  初始化信息显示框  */
				$("#passwordMsg").attr("class","validate_msg_medium");
				$("#oldPasswordMsg").attr("class","validate_msg_medium");
				$("#rePasswordMsg").attr("class","validate_msg_medium");
        		$("#passwordMsg").html("");
        		$("#oldPasswordMsg").html("");
        		$("#rePasswordMsg").html("");
        		
		    	var nowPassword=${sessionScope.admin.password};
				var regOldPassword=/^[A-Za-z0-9_]{3,10}$/;
				var regNewPassword=/^[A-Za-z0-9_]{3,10}$/;
		    	if($("#oldPassword").val()==""){
		    		$("#oldPasswordMsg").attr("class","validate_msg_medium error_msg");
		    		$("#oldPasswordMsg").html("请输入旧密码！");
		    		return false;
		    	}
		    	if($("#oldPassword").val()!=nowPassword){
		    		$("#oldPasswordMsg").attr("class","validate_msg_medium error_msg");
		    		$("#oldPasswordMsg").html("旧密码输入错误！");
		    		return false;
		    	}
		    	
		    	if($("#password").val()==""){
		    		$("#passwordMsg").attr("class","validate_msg_medium error_msg");
		    		$("#passwordMsg").html("请输入新密码！");
		    		return false;
		    	}
		    	if(regNewPassword.test($("#password").val())==false){
		    		$("#passwordMsg").attr("class","validate_msg_medium error_msg");
		    		$("#passwordMsg").html("新密码格式不正确，请重新输入！");
		    		return false;
		    	}
		    	
		    	if($("#rePassword").val()==""){
		    		$("#rePasswordMsg").attr("class","validate_msg_medium error_msg");
		    		$("#rePasswordMsg").html("请再次输入新密码！");
		    		return false;
		    	}
		    	if(regNewPassword.test($("#rePassword").val())==false){
		    		$("#rePasswordMsg").attr("class","validate_msg_medium error_msg");
		    		$("#rePasswordMsg").html("新密码格式不正确，请重新输入！");
		    		return false;
		    	}
		    	if($("#password").val()!=$("#rePassword").val()){
		    		$("#rePasswordMsg").attr("class","validate_msg_medium error_msg");
		    		$("#rePasswordMsg").html("两次密码不一致，请重新输入！");
		    		return false;
		    	}
		    	return true;
        	}
        	
        	function cancel(){
            	window.location.href="${pageContext.request.contextPath }/admin/index.do";
            }
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <!--导航区域开始-->
        <c:set var="pagePower" value="9" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <div id="main">      
            <!--保存操作后的提示信息：成功或者失败-->      
            <div id="save_result_info" class="save_success">修改密码成功！</div><!--保存失败，旧密码错误！-->
            <form action="${pageContext.request.contextPath }/admin/doModi.do" method="post" class="main_form">
                <div class="text_info clearfix"><span>旧密码：</span></div>
                <div class="input_info">
                    <input id="oldPassword" type="password" class="width200"  /><span class="required">*</span>
                    <div id="oldPasswordMsg" class="validate_msg_medium"></div>
                </div>
                <div class="text_info clearfix"><span>新密码：</span></div>
                <div class="input_info">
                    <input id="password" name="password" type="password"  class="width200" /><span class="required">*</span>
                    <div id="passwordMsg" class="validate_msg_medium"></div>
                </div>
                <div class="text_info clearfix"><span>重复新密码：</span></div>
                <div class="input_info">
                    <input id="rePassword" type="password" class="width200"  /><span class="required">*</span>
                    <div id="rePasswordMsg" class="validate_msg_medium"></div>
                </div>
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="showResult()" />
                    <input type="button" value="取消" class="btn_save" onclick="cancel()"/>
                </div>
            </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
           
        </div>
    </body>
</html>
