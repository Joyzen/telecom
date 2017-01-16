<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty sessionScope.admin }">
		<script type="text/javascript">
	  		window.location.href="${pageContext.request.contextPath }/admin/nopower.do";
	  	</script>
</c:if>
<!-- 权限验证 -->
<!-- 每个页面都有相应的pagePower参数表示当前页面权限ID，以此来判断用户是否可以访问当前页面  -->
<!-- 当pagePower小于1或大于7时，该页面不进行权限验证 ，即主页，个人信息，修改密码不进行验证-->
<c:if test="pagePower>0 and pagePower<8">
	<c:forEach items="${sessionScope.admin.powers }" var="power">
		<c:if test="power==pagePower">
			<c:set var="hasPower" value="true"></c:set>
		</c:if>
	</c:forEach>
	<!-- 没有该页面权限时跳转到提示页面 -->
	<c:if test="${empty hasPower } or ${hasPower=!true }">
		<script type="text/javascript">
	  		window.location.href="${pageContext.request.contextPath }/admin/nopower.do";
	  	</script>
	</c:if>
</c:if>
<c:if test="pagePower<1 and pagePower>7">
	<c:if test="${empty sessionScope.admin }">
		<script type="text/javascript">
	  		window.location.href="${pageContext.request.contextPath }/admin/nopower.do";
	  	</script>
	</c:if>
</c:if>
<!-- logo区 -->
<c:if test="${pagePower!=0 }">
	<div id="header">
         <img src="${sessionScope.admin.imgURL }" alt="账号头像"  height="50px" width="50px"/>
         <spn>${sessionScope.admin.adminName }</spn><a href="${pageContext.request.contextPath }/admin/login.do">[退出]</a>            
    </div>
</c:if>
<!-- 菜单导航区域 -->
<div id="${pagePower==0?'index_':'' }navi">                        
            <ul id="menu">
            	
                <li><a href="${pageContext.request.contextPath }/admin/index.do" class="index_${pagePower==0?'on':'off' }"></a></li>
                <c:forEach items="${sessionScope.admin.powers }" var="power">
            		<c:if test="${power==2 }">
                		<li><a href="${pageContext.request.contextPath }/admin/list.do" class="admin_${pagePower==2?'on':'off' }"></a></li>
                	</c:if>
            	</c:forEach>
            	<c:forEach items="${sessionScope.admin.powers }" var="power">
            		<c:if test="${power==3 }">
                <li><a href="${pageContext.request.contextPath }/tariff/showDataList.do" class="fee_${pagePower==3?'on':'off' }"></a></li>
                	</c:if>
            	</c:forEach>
            	<c:forEach items="${sessionScope.admin.powers }" var="power">
            		<c:if test="${power==4 }">
                <li><a href="${pageContext.request.contextPath }/customer/showDataList.do" class="account_${pagePower==4?'on':'off' }"></a></li>
                	</c:if>
            	</c:forEach>
            	<c:forEach items="${sessionScope.admin.powers }" var="power">
            		<c:if test="${power==5 }">
                <li><a href="${pageContext.request.contextPath }/bussiness/toDataGrid.do" class="service_${pagePower==5?'on':'off' }"></a></li>
                	</c:if>
            	</c:forEach>
            	<c:forEach items="${sessionScope.admin.powers }" var="power">
            		<c:if test="${power==6 }">
                <li><a href="${pageContext.request.contextPath }/bill/toBills.do" class="bill_${pagePower==6?'on':'off' }"></a></li>
                	</c:if>
            	</c:forEach>
            	<c:forEach items="${sessionScope.admin.powers }" var="power">
            		<c:if test="${power==7 }">
                <li><a href="${pageContext.request.contextPath }/bill/toReport.do" class="report_${pagePower==7?'on':'off' }"></a></li>
                	</c:if>
            	</c:forEach>
                <li><a href="${pageContext.request.contextPath }/admin/info.do" class="information_${pagePower==8?'on':'off' }"></a></li>
                <li><a href="${pageContext.request.contextPath }/admin/modi.do" class="password_${pagePower==9?'on':'off' }"></a></li>
            </ul>            
</div>
