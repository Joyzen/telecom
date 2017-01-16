/**
 * service_easyui页面js代码
 */
//显示角色详细信息
            function showDetail(flag,a) {
                var detailDiv = a.parentNode.getElementsByTagName("div")[0];
                if (flag) {
                    detailDiv.style.display = "block";
                }
                else
                    detailDiv.style.display = "none";
            }
            
            //提示信息显示
            function showMsg(flag,msg){
            	$("#operate_result_info").html('');
            	if(msg!=null&&msg!=''){
	            	$("#operate_result_info").html(msg);
            	}
            	if(flag){
					$("#operate_result_info").css("display","block");
            	}else{
					$("#operate_result_info").css("display","none");
            	}
            }
            //删除
            function deleteAccount() {
                var r = window.confirm("确定要删除此业务账号吗？删除后将不能恢复。");
                document.getElementById("operate_result_info").style.display = "block";
            }
            //开通或暂停
            function setState() {
                var r = window.confirm("确定要开通此业务账号吗？");
                document.getElementById("operate_result_info").style.display = "block";
            }
            $(function(){
            	//初始化数据表格
            	$('#dl').datagrid({ 
                    title:'业务账号信息显示', 
                    iconCls:'icon-show',//图标 
                    width: 950, 
                    height: 300, 
                    nowrap: false, 
                    striped: true, 
                    border: true, 
                    collapsible:false,//是否可折叠的 
                    fit: false,//自动大小 
                    url:rootPath+'/bussiness/getJson.do', 
                    //sortName: 'code', 
                    //sortOrder: 'desc', 
                    pageSize: 5,//每页显示的记录条数，默认为10 
        	        pageList: [3,5,10],//可以设置每页记录条数的列表 
                    remoteSort:false,  
                    idField:'bussinessId', 
                    singleSelect:true,//是否单选 
                    pagination:true,//分页控件 
                    rownumbers:false,//行号 
                    /* frozenColumns:[[ 
                        {field:'ck',checkbox:true} 
                    ]], */ 
                    /*onDblClickRow:function(row,index){
                    	detail();
                    },*/
                    onDblClickCell:function(index,field,value){
                    	if(field=='customerName'){
                    		detail();
                    	}
                    },
                    toolbar:"#search",
                    //行样式编辑器
                    /*rowStyler:function(index,row){
            			if (row.os.status=='2'){
            				return 'background-color:white;color:gray;font-weight:bold;';
            			}else{
            				return 'background-color:pink;color:black;font-color:black;';
            			}
            		},*/
                }); 
        		var p = $('#dl').datagrid('getPager'); 
        	    $(p).pagination({
        	    	pageSize: 5,//每页显示的记录条数，默认为10 
        	        pageList: [3,5,10],//可以设置每页记录条数的列表 
        	        beforePageText: '第',//页数文本框前显示的汉字 
        	        afterPageText: '页  /  共 {pages} 页', 
        	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
        	    });
        	    
        	    //初始化添加窗口
        	    $("#addDialog").dialog({
        	    	title:'增加业务账号',
        	    	closed:true,
        	    	modal:true,
        	    	//onBeforeOpen:initTariff()
        	    })
        	    
        	    //初始化修改窗口
        	    $("#modiDialog").dialog({
        	    	title:'修改业务账号',
        	    	closed:true,
        	    	modal:true,
        	    	//onBeforeOpen:initTariff()
        	    })

        	    //初始化详情显示页面
        	    $("#detailDialog").dialog({
        	    	title:'详情显示',
        	    	closed:true,
        	    	modal:true,
        	    })
        	    initTariff();
        	}) 
			//打开或关闭增加面板
        	function oprWin(opr){
            	if(opr=='open'){
            		$("#addDialog").dialog("open");
            	}else if(opr=='close'){
            		$("#addDialog").dialog("close");
            	}
            }
        	//操作修改面板
        	function oprModiWin(opr){
            	if(opr=='open'){
            		$("#modiDialog").dialog("open");
            	}else if(opr=='close'){
            		$("#modiDialog").dialog("close");
            	}
            }
            //根据身份证查询账务账号
            function searchAccounts() {
            	$("#idNumberMsg").html('');
				$.ajax({
					url:rootPath+"/bussiness/checkIdNumber.do",
					data:{"idNumber":$("input[name='idNumber']:eq(1)").val()},
					success:function(data){
						if(data!=null&&data!=''){
							$("input[name='customerId']").val(data.customerId)
							$("input[name='customerAccount']").val(data.customerAccount)
						}else if(data==null||data==''){
							$("input[name='customerAccount']").val('')
							$("#idNumberMsg").html('此身份证没有账务账号，请重新输入')
						}
						
					}
				})
            }
            
            //初始化资费列表
            function initTariff(){
            	$.ajax({
            		url:rootPath+"/bussiness/getTariff.do",
            		success:function(data){
            			$(data.tariffList).each(function(){
            				var o="<option value='"+this.tariffId+"'>"+this.tariffName+"</option>";
            				$("select[name='tariffId']:eq(0)").append(o);
            				$("select[name='tariffId']:eq(1)").append(o);
            			})
            		}
            	})
            }
            //增加表单ajax处理
            function sub(){
                    $("#addForm").form("submit",{
                        url     :rootPath+"/bussiness/add.do",
                        onSubmit:function(){
                            return $(this).form('validate');
                        },
                        success :function(result){
                            if(result=='success'){
                                oprWin("close");
                                showMsg(true,"添加成功")
                                setTimeout("showMsg(false)",3000);
                                $("#dl").datagrid("reload");
                            }
                        }
                    })
            }
            
            //easyUI表格数据显示格式化
            function formatCustomerId(val,row){
        		return row.os.customer.customerId;
        	}
        	function formatIdNumber(val,row){
        		return row.os.customer.idNumber;
        	}
        	function formatCustomerName(val,row){
        		return row.os.customer.customerName;
        	}
        	function formatOsAccount(val,row){
        		return row.os.osAccount;
        	}
        	function formatTariffName(val,row){
        		return row.os.tariff.tariffName;
        	}
        	function formatStatus(val,row){
        		if(row.os.status=='0'){
        			return '暂停';
        		}else if(row.os.status=='1'){
        			return '开通';
        		}else if(row.os.status=='2'){
        			return '删除';
        		}
        		return '空';
        	}
        	function formatOpr(val,row){
        		var paramsStr=""+row.bussinessId+",\""+row.os.osAccount+"\","+row.os.osId+","+row.os.tariff.tariffId;
        		var openBtn="<input type='button' class='btn_start' value='开通' onclick='setStus(1,"+row.bussinessId+")'/>";
        		var pauseBtn="<input type='button' class='btn_pause' value='暂停' onclick='setStus(0,"+row.bussinessId+")'/>";
        		var delBtn="<input type='button' class='btn_delete' value='删除' onclick='setStus(2,"+row.bussinessId+")'/>";
        		var modiBtn="<input type='button' class='btn_modify' value='修改' onclick='modi("+paramsStr+")'/>";
        		
        		if(row.os.status!='2'){
        			if(row.os.status=='1'){
        				return pauseBtn+modiBtn+delBtn;
        			}
        			if(row.os.status=='0'){
        				return openBtn+modiBtn+delBtn;
        			}
        		}
        		return '';
        	}
        	function setStus(status,bussinessId){
                if(status==0){
                    var r = window.confirm("确定要暂停此业务账号吗？");
                }else if (status==1) {
                    var r = window.confirm("确定要启用此此业务账号吗？");
                }else if (status==2) {
                    var r = window.confirm("确定要删除此业务账号吗？删除后将不能恢复。");
                }
                
                if(r){
        		$.ajax({
            		url		:rootPath+"/bussiness/updateStatus.do",
            		data	:{
            					"bussinessId":bussinessId,
            					"status":status,
            		},
            		success:function(data){
            			if(data=="success"){
            				if(status==0){
            					$("#operate_result_info").html("暂停成功")
            				}
            				if(status==1){
            					$("#operate_result_info").html("开通成功")
            				}
            				if(status==2){
            					$("#operate_result_info").html("删除成功")
            				}
            				$("#operate_result_info").css("display","block");
            				setTimeout("$('#operate_result_info').css('display','none')",1000);
            				setTimeout("$('#dl').datagrid('reload')",1000);
            			}
            		}
            	})
                }
        	}
        	//修改操作
        	function modi(bussinessId,osAccount,osId,tariffId){
                //初始化输入框数据
        		if(bussinessId==''||bussinessId==null){
        			var row = $("#dl").datagrid("getSelected");
        			bussinessId=row.bussinesssId
        			osAccount=row.os.osAccount
        			osId=row.os.osId;
        			tariffId=row.os.tariff.tariffId
        		}
        		$("#modiDialog").dialog("open");                
                $("input[name='bussinessId']").val(bussinessId);
                $("input[name='osAccount']:eq(2)").val(osAccount);
                $("input[name='osId']").val(osId);
                $("select[name='tariffId']:eq(1)").val(tariffId)
            }

            //修改提交处理方法
            function subModi(){
                $("#modiForm").form("submit",{
                    url:rootPath+"/bussiness/updateTariff.do",
                    onSubmit:function(){

                    },
                    success:function(data){
                        if(data=='success'){
                            $("#modiDialog").dialog("close");
                            showMsg(true,"修改成功！");
                            setTimeout("showMsg(false)",2000);
                            $("#dl").datagrid("reload")
                        }else{
                            showMsg(true,"修改失败！");
                            setTimeout("showMsg(false)",2000);
                            $("#modiDialog").dialog("close");
                        }
                        
                    }
                })
            }

            //详情显示页面方法
            function detail(){
            	$("#detailDialog").dialog("open")
                var row = $("#dl").datagrid("getSelected");
                if (row==null) {
                    alert("请至少选择一行")
                    return false
                }
                $("#bussinessId").val(row.bussinessId)
                $("#customerId").val(row.os.customer.customerId)
                $("#customerName").val(row.os.customer.customerName)
                $("#idNum").val(row.os.customer.idNumber)
                $("#osAcc").val(row.os.osAccount)
                $("#state").val(row.os.status)
                $("#createTime").val(row.createTime)
                $("#tariffId").val(row.os.tariff.tariffId)
                $("#tariffName").val(row.os.tariff.tariffName)
                $("#tariffExplain").val(row.os.tariff.tariffExplain)

            }

        	//搜索方法
        	function doSearch(opr){
        		if(opr=='none'){
        			$('#osAccount').val('');
        			$('#idNumber').val('');
        			$('#status').val('-1');
        			$('#dl').datagrid('load',{
	        			osAccount: $('#osAccount').val(),
	        			idNumber: $('#idNumber').val(),
	        			status:$('#status').val(),
	        		});
        		}
        		else{
	        		$('#dl').datagrid('load',{
	        			osAccount: $('#osAccount').val(),
	        			idNumber: $('#idNumber').val(),
	        			status:$('#status').val(),
	        		});
        		}
        	}

            //自定义重写验证函数
            $.extend($.fn.validatebox.defaults.rules, {
                osAccount: {
                    validator: function(value, param){
                        var regOsAccount=/^([\u4e00-\u9fa5A-Za-z0-9]{1,8})$/;//1到8为的汉字或字母
                        var b = regOsAccount.test(value)
                        return b;
                    },
                    message:'请输入8长度以内的字母、数字和下划线的组合'
                },
                password: {
                    validator: function(value, param){
                        var regPassword=/^[A-Za-z0-9_]{3,30}$/;//3到30长度，字母数字下划线组合
                        var b = regPassword.test(value)
                        return b;
                    },
                    message:'密码格式不正确，请重新输入！'
                },
                equals: {    
                    validator: function(value,param){    
                        return value == $(param[0]).val();    
                    },    
                    message: '两次输入的密码不一致，请重新输入.'   
                } , 
            });

