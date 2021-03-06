<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>跟进记录查看</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }	
		  return false;
		}
		$(document).ready(function() {
			//$("#name").focus();
			validateForm=$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="crmContactRecord" action="${ctx}/crm/crmContactRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		<tbody>
			<tr>
				<td class="width-15 active" width="10%"><label class="pull-right">业务名称：</label></td>
				<td class="width-35" colspan="3">
					${crmContactRecord.targetName}
				</td>
			</tr>
			
			<tr>
				<td class="width-15 active"><label class="pull-right">跟进内容：</label></td>
				<td class="width-35" colspan="3">
					${crmContactRecord.content}
				</td>
			</tr>
			<tr>
				<td class="width-15 active" width="10%"><label class="pull-right">跟进主题：</label></td>
				<td class="width-35" width="40%">
					${fns:getDictLabel(crmContactRecord.contactType, 'contact_type', '')}
				</td>
			
				<td class="width-15 active" width="10%"><label class="pull-right">跟进日期：</label></td>
				<td class="width-35" width="40%">
					<fmt:formatDate value="${crmContactRecord.contactDate}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		
			<tr>
				<td class="width-15 active"><label class="pull-right">创建人：</label></td>
				<td class="width-35">
					${crmContactRecord.createBy.name}
				</td>
				<td class="width-15 active"><label class="pull-right">创建时间：</label></td>
				<td class="width-35">
					<fmt:formatDate value="${crmContactRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</tbody>
		</table>
	</form:form>
</body>
</html>