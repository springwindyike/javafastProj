<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品分类管理</title>
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
			$("#name").focus();
			validateForm =$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
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
	<form:form id="inputForm" modelAttribute="wmsProductType" action="${ctx}/wms/wmsProductType/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>		
	<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		<tbody>
			<tr>
				<td class="width-15 active"><label class="pull-right">上级分类:</label></td>
					
				<td class="width-35"><sys:treeselect id="parent" name="parent.id" value="${wmsProductType.parent.id}" labelName="parent.name" labelValue="${wmsProductType.parent.name}"
							title="上级分类" url="/wms/wmsProductType/treeData" extId="${wmsProductType.id}" cssClass="form-control" allowClear="true"/>
				</td>
			
			
				<td class="width-15 active"><label class="pull-right"><font color="red">*</font> 分类名称：</label></td>
				<td class="width-35">
							<form:input path="name" htmlEscape="false" maxlength="50" class="form-control input-xlarge required"/>
				</td>
			</tr>
			<tr>
				<td class="width-15 active"><label class="pull-right">排序：</label></td>
				<td class="width-35">
							<form:input path="sort" htmlEscape="false" maxlength="11" class="form-control  input-xlarge  digits"/>
				</td>
			
			
			
			
			
				<td class="width-15 active"><label class="pull-right">备注：</label></td>
				<td class="width-35">
							<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="50" class="form-control  input-xlarge "/>
				</td>
			</tr>
		</tbody>
		</table>
	</form:form>
</body>
</html>