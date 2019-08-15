<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>库存流水选择器</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
	    	$('#contentTable thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
	    		$('#contentTable tbody tr td input.i-checks').iCheck('check');
	    	});
	    	$('#contentTable thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
	    		$('#contentTable tbody tr td input.i-checks').iCheck('uncheck');
	    	});
		});		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }		
		function getSelectedItem(){
			var size = $("#contentTable tbody tr td input.i-checks:checked").size();
			if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}

			if(size > 1 ){
				top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
				return "-1";
			}
			var id =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
			var label = $("#contentTable tbody tr td input.i-checks:checkbox:checked").parent().parent().parent().find(".codelabel").html();
			return id+"_item_"+label;
		}
	</script>
</head>
<body class="gray-bg">
<div class="wrapper-content">
		<div class="ibox">
			
			<div class="ibox-content">
			<sys:message content="${message}"/>
				
				<!-- 查询条件 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" modelAttribute="wmsStockJournal" action="${ctx}/wms/wmsStockJournal/selectList" method="post" class="form-inline">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
								<div class="form-group"><span>产品：</span>
									<form:input path="product.id" htmlEscape="false" maxlength="30" class="form-control input-medium"/>
								</div>
								<div class="form-group"><span>操作类型：</span>
									<form:select path="dealType" class="form-control input-medium">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('deal_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
								<div class="form-group"><span>仓库：</span>
									<form:input path="warehouse.id" htmlEscape="false" maxlength="30" class="form-control input-medium"/>
								</div>
								<div class="form-group"><span>操作人：</span>
									<sys:treeselect id="createBy" name="createBy.id" value="${wmsStockJournal.createBy.id}" labelName="createBy.name" labelValue="${wmsStockJournal.createBy.name}"
										title="用户" url="/sys/office/treeData?type=3" cssClass="form-control input-medium" allowClear="true" notAllowSelectParent="true"/>
								</div>
								<div class="form-group"><span>操作日期：</span>
									<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="laydate-icon form-control input-medium"
										value="<fmt:formatDate value="${wmsStockJournal.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
									<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="laydate-icon form-control input-medium"
										value="<fmt:formatDate value="${wmsStockJournal.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
								</div>
						</form:form>
						<br>
					</div>
				</div>
				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
					       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
						</div>
						<div class="pull-right">
							<button  class="btn btn-success btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
							<button  class="btn btn-success btn-rounded btn-outline btn-sm " onclick="resetSearch()" ><i class="fa fa-refresh"></i> 重置</button>
						</div>
					</div>
				</div>
					
				<!-- 表格 -->
				<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
					<thead>
						<tr>
							<th><input type="checkbox" class="i-checks"></th>
							<th class="sort-column product_id">产品</th>
							<th class="sort-column deal_type">操作类型</th>
							<th class="sort-column num">数量</th>
							<th class="sort-column notes">摘要</th>
							<th class="sort-column warehouse_id">仓库</th>
							<th class="sort-column create_by">操作人</th>
							<th class="sort-column create_date">操作日期</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="wmsStockJournal">
						<tr>
							<td><input type="checkbox" id="${wmsStockJournal.id}" class="i-checks"></td>
							<td><a href="#" onclick="openDialogView('查看库存流水', '${ctx}/wms/wmsStockJournal/view?id=${wmsStockJournal.id}','800px', '500px')">${wmsStockJournal.product.id}</a></td>
							<td class="codelabel">${fns:getDictLabel(wmsStockJournal.dealType, 'deal_type', '')}</td>
							<td>${wmsStockJournal.num}</td>
							<td>${wmsStockJournal.notes}</td>
							<td>${wmsStockJournal.warehouse.id}</td>
							<td>${wmsStockJournal.createBy.name}</td>
							<td><fmt:formatDate value="${wmsStockJournal.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>
								<shiro:hasPermission name="wms:wmsStockJournal:view">
									<a href="#" onclick="openDialogView('查看库存流水', '${ctx}/wms/wmsStockJournal/view?id=${wmsStockJournal.id}','800px', '500px')" class="btn btn-info btn-xs" title="查看"><i class="fa fa-search-plus"></i> 查看</a>
								</shiro:hasPermission>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<table:page page="${page}"></table:page>
				<br/>
			</div>
		</div>
	</div>
</body>
</html>