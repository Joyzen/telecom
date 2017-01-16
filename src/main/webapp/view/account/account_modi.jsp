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
            //保存成功的提示信息
            function showResult() {
				$.post({
					url		:"${pageContext.request.contextPath}/customer/doModi.do",
					data    :$(".main_form").serialize(),
					success :function(data){
						if(data=='success'){
							alert("修改成功")
						}
					}
				})
            }
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }

            //显示修改密码的信息项
            function showPwd(chkObj) {
                if (chkObj.checked)
                    document.getElementById("divPwds").style.display = "block";
                else
                    document.getElementById("divPwds").style.display = "none";
            }
            $(function (){
        		var idCard18=$("#idNumber").val();
        		var year=idCard18.substring(6,10);   
        	    var month=idCard18.substring(10,12);   
        	    var day=idCard18.substring(12,14); 
        	    $("#birth").val(year+"年"+month+"月"+day+"日");
        	})
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <c:set var="pagePower" value="4" />
        <%@include file= "/view/common/powerCheckPageAndHead.jsp" %>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">  
            <!--保存成功或者失败的提示消息-->          
            <div id="save_result_info" class="save_fail">保存失败，旧密码错误！</div>
            <form action="${pageContext.request.contextPath }/customer/doModi.do" method="post" class="main_form">
                    <!--必填项-->
                    <div class="text_info clearfix"><span>账务账号ID：</span></div>
                    <div class="input_info">
                        <input name="customerId" type="text" value="${modiCustomer.customerId }" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input name="customerName" type="text" value="${modiCustomer.customerName }" />
                        <span class="required">*</span>
                        <div class="validate_msg_long">20长度以内的汉字、字母和数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>身份证：</span></div>
                    <div class="input_info">
                        <input type="text" id="idNumber" value="${modiCustomer.idNumber }" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>登录账号：</span></div>
                    <div class="input_info">
                        <input type="text" value="${modiCustomer.customerAccount }" readonly class="readonly"  />                        
                    </div>
                    <div class="change_pwd">
                        <input id="chkModiPwd" type="checkbox" onclick="showPwd(this);" />
                        <label for="chkModiPwd">修改密码</label>
                    </div>
                    <!--修改密码部分-->
                    <div id="divPwds">
                        <div class="text_info clearfix"><span>旧密码：</span></div>
                        <div class="input_info">
                            <input type="password"  />
                            <span class="required">*</span>
                            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>新密码：</span></div>
                        <div class="input_info">
                            <input name="password" type="password"  />
                            <span class="required">*</span>
                            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>重复新密码：</span></div>
                        <div class="input_info">
                            <input type="password"  />
                            <span class="required">*</span>
                            <div class="validate_msg_long">两次密码必须相同</div>
                        </div>  
                    </div>                   
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input name="phone" value="${modiCustomer.phone }" type="text" class="width200"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium">正确的电话号码格式：手机或固话</div>
                    </div>
                    <!-- <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                    <div class="input_info">
                        <input type="text"/>
                        <div class="validate_msg_long error_msgs">正确的身份证号码格式</div>
                    </div> -->
                    <div class="text_info clearfix"><span>生日：</span></div>
                    <div class="input_info">
                        <input id="birth" type="text" value="" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input name="email" type="text" value="${modiCustomer.email }" class="width200"/>
                        <div class="validate_msg_medium">50长度以内，合法的 Email 格式</div>
                    </div> 
                    <div class="text_info clearfix"><span>职业：</span></div>
                    <div class="input_info">
                        <select name="job">
                            <option value="干部" ${modiCustomer.job=='干部'?'selected':'' }>干部</option>
                            <option value="学生" ${modiCustomer.job=='学生'?'selected':'' }>学生</option>
                            <option value="技术人员" ${modiCustomer.job=='技术人员'?'selected':'' }>技术人员</option>
                            <option value="其他" ${modiCustomer.job=='其他'?'selected':'' }>其他</option>
                        </select>                        
                    </div>
                    <div class="text_info clearfix"><span>性别：</span></div>
                    <div class="input_info fee_type">
                        <input ${modiCustomer.sex=='2'?'checked':'' } type="radio" name="sex" checked="checked" id="female" value="2"/>
                        <label for="female">女</label>
                        <input ${modiCustomer.sex=='1'?'checked':'' } type="radio" name="sex" id="male" value="1"/>
                        <label for="male">男</label>
                    </div> 
                    <!-- <div class="text_info clearfix"><span>通信地址：</span></div>
                    <div class="input_info">
                        <input type="text" class="width350"/>
                        <div class="validate_msg_tiny">50长度以内</div>
                    </div> 
                    <div class="text_info clearfix"><span>邮编：</span></div>
                    <div class="input_info">
                        <input type="text"/>
                        <div class="validate_msg_long">6位数字</div>
                    </div> 
                    <div class="text_info clearfix"><span>QQ：</span></div>
                    <div class="input_info">
                        <input type="text"/>
                        <div class="validate_msg_long">5到13位数字</div>
                    </div>                 -->
                    <!--操作按钮-->
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" onclick="showResult();" />
                        <input type="button" value="取消" class="btn_save" onclick=
                        "location.href='${pageContext.request.contextPath }/customer/showDataList.do';"/>
                    </div>
                </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
           
        </div>
    </body>
</html>
