<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/view/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/view/styles/global_color.css" /> 
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script type="text/javascript">
        	function doLogin() {
				$.ajax({
					url		: "${pageContext.request.contextPath}/admin/verifyAdmin.do",
					data	: {
						"adminAccount":$("#adminAccount").val(),
						"password"	  :$("#password").val()
					},
					success	: function (data) {
						if(data == "true"){
							window.location.href="${pageContext.request.contextPath}/admin/index.do";
						}else{
							$("#tips").html("用户名或密码错误，请重新输入");
						}
					}
				});
			}
        	function enterKey(e){
        		if(e.keyCode==13){
        			doLogin();
        		}
        	}
        </script>
    </head>
    <body class="index" onkeydown="enterKey(event)">
        <div class="login_box">
            <table>
                <tr>
                    <td class="login_info">账号：</td>
                    <td colspan="2"><input id="adminAccount" name="adminAccount" type="text"  class="width150"
                    onkeydown="enterKey(event)" /></td>
                    <td class="login_error_info"><span class="required"></span></td>
                </tr>
                <tr>
                    <td class="login_info">密码：</td>
                    <td colspan="2"><input name="password" id="password" type="password" class="width150"
                    onkeydown="enterKey(event)" /></td>
                    <td><span class="required"></span></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="login_button" colspan="2">
                        <input type="image" src="${pageContext.request.contextPath}/view/images/login_btn.png" onclick="doLogin()"/>
                    </td>    
                    <td><span class="required" id="tips"></span></td>                
                </tr>
            </table>
        </div>
    </body>
</html>
