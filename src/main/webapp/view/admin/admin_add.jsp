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
        	function setPowers(){
        		var c=$("input:checked");
                var i=0;
                var powers="";
            	for(;i<c.length;i++){
            		powers+=","+c[i].value
            	}
            	$("#powers").val(powers);
        	}
            //保存成功的提示消息
            function showResult() {
            	setPowers();
            	showResultDiv(false);
            	if(validata()){
            		$.ajax({
	        			url		:"${pageContext.request.contextPath }/admin/doAdd.do",
	        			data	:$(".main_form").serialize(),
	        			success	:function(data){
	        				if(data=='success'){
	        					showResultDiv(true);
	        					/* 三秒后提示取消 */
	        					setTimeout("showResultDiv(false);",3000)
	        				}else{
	        					alert("添加失败")
	        				}
	        			}
	        		})
            	}
                //$(".main_form").submit();
            }
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }
            
            //表单验证方法
            function validata(){
            	/*  初始化信息显示框  */
				$("#adminNameMsg").attr("class","validate_msg_medium");
        		$("#adminNameMsg").html("");
				$("#adminAccountMsg").attr("class","validate_msg_medium");
        		$("#adminAccountMsg").html("");
				$("#passwordMsg").attr("class","validate_msg_medium");
        		$("#passwordMsg").html("");
				$("#rePasswordMsg").attr("class","validate_msg_medium");
        		$("#rePasswordMsg").html("");
				$("#phoneMsg").attr("class","validate_msg_medium");
        		$("#phoneMsg").html("");
				$("#emailMsg").attr("class","validate_msg_medium");
        		$("#emailMsg").html("");
				$("#powersMsg").attr("class","validate_msg_medium");
        		$("#powersMsg").html("");
        		
        		/* 校验姓名 */
		    	if($("#adminName").val()==""){
		    		$("#adminNameMsg").attr("class","validate_msg_medium error_msg");
		    		$("#adminNameMsg").html("姓名不能为空");
		    		return false;
		    	}
				var regAdminName=/^([\u4e00-\u9fa5A-Za-z0-9]{2,20})$/;//2到50为的汉字或字母
		    	if(!regAdminName.test($("#adminName").val())){
		    		$("#adminNameMsg").attr("class","validate_msg_medium error_msg");
		    		$("#adminNameMsg").html("姓名格式不正确，2-20长度的字母、数字、汉字和下划线的组合");
		    		return false;
		    	}
		    	
		    	/* 管理员账号 */
			    if($("#adminAccount").val()==""){
			    	$("#adminAccountMsg").attr("class","validate_msg_medium error_msg");
			    	$("#adminAccountMsg").html("管理员账号不能为空");
			    	return false;
			    }
				var regAdminAccount=/^([a-zA-Z][0-9a-zA-Z]{2,30})$/;//2到30为的字母数字下划线
			    if(!regAdminAccount.test($("#adminAccount").val())){
			    	$("#adminAccountMsg").attr("class","validate_msg_medium error_msg");
			    	$("#adminAccountMsg").html("管理员账号格式不正确，请重新输入！");
			    	return false;
			    }
		    		
		    	
		    	/* 校验密码 */
			    if($("#password").val()==""){
			    	$("#passwordMsg").attr("class","validate_msg_medium error_msg");
			    	$("#passwordMsg").html("密码用不能为空！");
			    	return false;
			    }
				var regPassword=/^[A-Za-z0-9_]{3,10}$/;
			    if(!regPassword.test($("#password").val())){
			    	$("#passwordMsg").attr("class","validate_msg_medium error_msg");
			    	$("#passwordMsg").html("密码格式不正确，请重新输入！");
			    	return false;
			    }
		    	/* 校验重复密码 */
			    if($("#rePassword").val()==""){
			    	$("#rePasswordMsg").attr("class","validate_msg_medium error_msg");
			    	$("#rePasswordMsg").html("密码不能为空！");
			    	return false;
			    }
			    if($("#rePassword").val()!=$("#password").val()){
			    	$("#rePasswordMsg").attr("class","validate_msg_medium error_msg");
			    	$("#rePasswordMsg").html("两次输入的密码不一致，请重新输入！");
			    	return false;
			    }
		    	
		    	/* 校验电话号码 */
		    	if($("#phone").val()==""){
		    		$("#phoneMsg").attr("class","validate_msg_medium error_msg");
		    		$("#phoneMsg").html("电话不能为空");
		    		return false;
		    	}
				var regPhone=/^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/; //固话或手机号码
		    	if(!regPhone.test($("#phone").val())){
		    		$("#phoneMsg").attr("class","validate_msg_medium error_msg");
		    		$("#phoneMsg").html("电话格式不正确");
		    		return false;
		    	}
		    	/* 校验电子邮箱 */
		    	if($("#email").val()==""){
		    		$("#emailMsg").attr("class","validate_msg_medium error_msg");
		    		$("#emailMsg").html("邮箱不能为空");
		    		return false;
		    	}
				var regEmail=/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;  //电子邮箱校验
		    	if(!regEmail.test($("#email").val())){
		    		$("#emailMsg").attr("class","validate_msg_medium error_msg");
		    		$("#emailMsg").html("邮箱格式不正确");
		    		return false;
		    	}
				/* 校验权限  */
		    	var c=$("input:checked");
				if(c.length<1){
					$("#powersMsg").attr("class","validate_msg_medium error_msg");
		    		$("#powersMsg").html("请至少选择一个权限");
		    		return false;
				}
		    	return true;
            }
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="2" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">            
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form action="${pageContext.request.contextPath }/admin/doAdd.do" method="post" class="main_form">
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input id="adminName" name="adminName" type="text" />
                        <span class="required">*</span>
                        <div id="adminNameMsg" class="validate_msg_medium">20长度以内的汉字、字母、数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info">
                        <input id="adminAccount" name="adminAccount" type="text"  />
                        <span class="required">*</span>
                        <div id="adminAccountMsg" class="validate_msg_medium">30长度以内的字母、数字和下划线的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>密码：</span></div>
                    <div class="input_info">
                        <input id="password" name="password" type="password"  />
                        <span class="required">*</span>
                        <div id="passwordMsg" class="validate_msg_medium">30长度以内的字母、数字和下划线的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>重复密码：</span></div>
                    <div class="input_info">
                        <input id="rePassword" type="password"  />
                        <span class="required">*</span>
                        <div id="rePasswordMsg" class="validate_msg_medium">两次密码必须相同</div>
                    </div>      
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input id="phone" name="phone" type="text" class="width200"/>
                        <span class="required">*</span>
                        <div id="phoneMsg" class="validate_msg_medium">正确的电话号码格式：手机或固话</div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input id="email" name="email" type="text" class="width200"/>
                        <span class="required">*</span>
                        <div id="emailMsg" class="validate_msg_medium">50长度以内，正确的 email 格式</div>
                    </div>
                    <div class="text_info clearfix"><span>权限：</span></div>
                    <div class="input_info_high">
                        <div class="input_info_scroll">
                            <ul>
                                <li><input value="2" type="checkbox" />管理员管理</li>
                                <li><input value="3" type="checkbox" />资费管理</li>
                                <li><input value="4" type="checkbox" />账务账号管理</li>
                                <li><input value="5" type="checkbox" />业务账号管理</li>
                                <li><input value="6" type="checkbox" />账单管理</li>
                                <li><input value="7" type="checkbox" />报表管理</li>
                            </ul>
                        </div>
                        <span class="required">*</span>
                        <div id="powersMsg" class="validate_msg_tiny">至少选择一个</div>
                    </div>
                    <input id="powers" name="powers" type="hidden" value=""/>
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" onclick="showResult();" />
                        <input type="button" value="取消" class="btn_save" onclick="location.href='${pageContext.request.contextPath}/admin/list.do';"/>
                    </div>
                </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
           
        </div>
    </body>
</html>
