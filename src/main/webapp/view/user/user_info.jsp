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
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/themes/default/easyui.css"></link>
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/themes/icon.css"></link>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
        <script language="javascript" type="text/javascript">
            //保存成功的提示信息
            function showResult() {
                showResultDiv(false);
                var form = new FormData(document.getElementById("tf"));
                /*if($("input[name='img']").val()==''){
                	alert("请选择一个图像文件！")
                }*/
            	if(validata()){
	        		$("#tf").ajaxSubmit({
	        			success	:function(data){
	        				if(data=='success'){
	        					showResultDiv(true);
	        					setTimeout("showResultDiv(false);",3000)
	        					window.location.reload();
	        				}
	        			}
	        		});
        		}
            }
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }
            /* 表单校验方法 */
            function validata(){
            	/*  初始化信息显示框  */
				$("#nameMsg").attr("class","validate_msg_medium");
				$("#phoneMsg").attr("class","validate_msg_medium");
				$("#emailMsg").attr("class","validate_msg_medium");
        		$("#nameMsg").html("");
        		$("#phoneMsg").html("");
        		$("#emailMsg").html("");
        		
				var regName=/^([A-Za-z\u4e00-\u9fa5]{2,20})$/;//2到20为的汉字或字母
				var regPhone=/^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/; //固话或手机号码
				var regEmail=/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;  //电子邮箱校验
				
        		/* 校验姓名 */
		    	if($("#name").val()==""){
		    		$("#nameMsg").attr("class","validate_msg_medium error_msg");
		    		$("#nameMsg").html("姓名不能为空");
		    		return false;
		    	}
		    	if(!regName.test($("#name").val())){
		    		$("#nameMsg").attr("class","validate_msg_medium error_msg");
		    		$("#nameMsg").html("姓名格式不正确，请输入2-20位汉字或字母");
		    		return false;
		    	}
		    	
		    	/* 校验电话 */
		    	if($("#phone").val()==""){
		    		$("#phoneMsg").attr("class","validate_msg_medium error_msg");
		    		$("#phoneMsg").html("电话号码不能为空");
		    		return false;
		    	}
		    	if(!regPhone.test($("#phone").val())){
		    		$("#phoneMsg").attr("class","validate_msg_medium error_msg");
		    		$("#phoneMsg").html("电话号码格式不正确，请重新输入！");
		    		return false;
		    	}
		    	
		    	/* 校验电子邮箱 */
		    	if($("#email").val()==""){
		    		$("#emailMsg").attr("class","validate_msg_medium error_msg");
		    		$("#emailMsg").html("电子邮箱不能为空！");
		    		return false;
		    	}
		    	if(!regEmail.test($("#email").val())){
		    		$("#emailMsg").attr("class","validate_msg_medium error_msg");
		    		$("#emailMsg").html("邮箱格式不正确，请重新输入！");
		    		return false;
		    	}
		    	return true;
            }
            function cancel(){
            	window.location.href="${pageContext.request.contextPath }/admin/index.do";
            }
            function previewImg(obj){
            	var img = obj.files[0];
            	var reader = new FileReader();   
                reader.readAsDataURL(img);
            	reader.onload = function(e){  
            		$("img[alt='账号头像预览']").attr("src",this.result);
            	}
            }
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <!--导航区域开始-->
        <c:set var="pagePower" value="8" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--主要区域开始-->
        <div id="main">            
            <!--保存操作后的提示信息：成功或者失败-->
            <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，数据并发错误！-->
            <form id="tf" action="${pageContext.request.contextPath }/admin/doInfo.do" method="post" class="main_form" enctype="multipart/form-data" >
                <div class="text_info clearfix"><span>管理员账号：</span></div>
                <div class="input_info"><input type="text" readonly="readonly" class="readonly" value="${sessionScope.admin.adminId }" /></div>
                <div class="text_info clearfix"><span>权限：</span></div>
                <div class="input_info">
                    <input id="powers" type="text" readonly="readonly" class="readonly width400" value="${powerStr }" />
                </div>
                <div class="text_info clearfix"><span>姓名：</span></div>
                <div class="input_info">
                    <input id="name" name="adminName" type="text" value="${sessionScope.admin.adminName }" />
                    <span class="required">*</span>
                    <div id="nameMsg" class="validate_msg_medium"></div>
                </div>
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info">
                    <input id="phone" name="phone" type="text" class="width200" value="${sessionScope.admin.phone }" />
                    <div id="phoneMsg" class="validate_msg_medium"></div>
                </div>
                <div class="text_info clearfix"><span>Email：</span></div>
                <div class="input_info">
                    <input id="email" name="email" type="text" class="width200" value="${sessionScope.admin.email }" />
                    <div id="emailMsg" class="validate_msg_medium"></div>
                </div>
                <div class="text_info clearfix"><span>创建时间：</span></div>
                <div class="input_info"><input readonly="readonly" id="dd" type="text" value="${sessionScope.admin.createTime }"/></div>
                <div class="text_info clearfix"><span>账号头像预览：</span></div>
                <div class="input_info">
                	<img src="${sessionScope.admin.imgURL }" alt="账号头像预览"  height="50px" width="50px"/>
                </div>
                <div class="text_info clearfix"><span>更改头像：</span></div>
                <div class="input_info">
                    <!-- <input id="img" name="img" type="file" class="width200" value="" /> -->
                    <input type="file" name="img" id="img" style="WIDTH: 173PX;padding: 0px;height:21px;margin-top:10px" onchange="previewImg(this)">
                </div>
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="showResult();" />
                    <input type="button" value="取消" class="btn_save" onclick="cancel();"/>
                </div>
            </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
          
        </div>
    </body>
</html>
