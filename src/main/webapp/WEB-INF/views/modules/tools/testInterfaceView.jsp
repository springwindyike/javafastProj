<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>接口管理</title>
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
			validateForm = $("#inputForm").validate({
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
		<form:form id="inputForm" modelAttribute="testInterface" action="${ctx}/tools/testInterface/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">接口名称：</label></td>
					<td class="width-35">
						${testInterface.name }
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">接口类型：</label></td>
					<td class="width-35">
						${fns:getDictLabel(testInterface.type, 'interface_type', '')}
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">请求URL：</label></td>
					<td class="width-35">
						${testInterface.url }
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">请求body：</label></td>
					<td class="width-35">
						${testInterface.body }
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">成功返回：</label></td>
					<td class="width-35">
						${testInterface.successmsg }
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">失败返回：</label></td>
					<td class="width-35">
						${testInterface.errormsg }
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">说明：</label></td>
					<td class="width-35">
						${testInterface.contents }
					</td>
				</tr>
				
		 	</tbody>
		</table>
	</form:form>
</body>
</html>