<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>登录页面</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	</head>
	<!-- <s:head /> -->
	<script type="text/javascript">

</script>
	<body>
	<iframe frameborder="0"></iframe>
	<center>
		<h2>用户登陆</h2>
		<s:actionerror/>
		<s:form name="form1" action="loginAction" method="post">
			<s:textfield name="username" label="用户名" cssStyle="width:120px"/>
			<s:password name="password" label="密   码" cssStyle="width:120px"/>
			<tr>
				<td colspan="2" align="center">
					<s:submit value="提 交" theme="simple"/>
				</td>
			</tr>
		</s:form>
	</center>
	</body>
</html>

