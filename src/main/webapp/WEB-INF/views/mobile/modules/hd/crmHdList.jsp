<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
  <head>
  	<title>活动推广</title>
    <%@ include file="/WEB-INF/views/include/weuihead.jsp"%>
    <script type="text/javascript">
    	function toSearch(){
    		window.location.href = "${ctx}/mobile/crm/crmMarket/search";
    	}
    	var page_no = 1;//当前页
    	var is_all = false;//已加载全部
    	$(document).ready(function() {
    		
    		loadData();
    		
    		//滚动条到底自动加载下一页
    		$(window).scroll(function() {
    			if ($(document).scrollTop() >= $(document).height() - $(window).height()) {
    				if(is_all == false){
    					loadData();
    				}                    
                }
    		});
    		
    		//监听返回事件
    		pushHistory();
    		window.addEventListener("popstate", function(e) {
    			location.href = "${ctx}/mobile/menu";
    		}, false);
    	});
    	function loadData(){	
    		
    	    $.ajax({
        		url:"${ctx}/wechat/hd/listData",
        		data: {pageNo:page_no, name:'${crmMarket.name}', status:'${crmMarket.status}'},
        		type:"POST",
        		async:true,    //或false,是否异步
        		dataType:'json',
        		success:function(data){	    			
        			if(data != null){	    				
        				setData(data.list);
        				
        				if(data.count == 0){
        					$(".weui-loadmore").hide();
        					$("#loadmore-panel").append("<div class=\"weui-loadmore weui-loadmore_line\"><span class=\"weui-loadmore__tips\">未查询到任何数据</span></div>");
        					is_all = true;
        				}
        				if(data.count >0 && data.count <= page_no*20){
        					$(".weui-loadmore").hide();
        					$("#loadmore-panel").append("<div class=\"weui-loadmore weui-loadmore_line\"><span class=\"weui-loadmore__tips\">已加载全部</span></div>");
        					is_all = true;
        				}
        				page_no++;
        			}
        		},
        		error:function(){
        			alert("服务器未响应");
        		}
        	});
        }
    	function setData(data){
    		var html = "";
    		for(var i=0;i<data.length;i++){
    			
    			var status = getDictLabel(data[i].status, "market_status");
    			var ownByName = data[i].ownBy.name;
    			if(ownByName==null || ownByName == "null"){
    				ownByName = "";
    			}else{
    				ownByName = " | "+data[i].ownBy.name;
    			}
    			
    			html += "<div class=\"weui-media-box weui-media-box_text\" onclick=\"viewData('"+ data[i].id +"','"+ data[i].name +"')\" >";
    			html += "<span class=\"weui-body-box_right\"><a href=\"javascript:viewData('"+ data[i].id +"','"+ data[i].name +"');\" class=\"weui-btn weui-btn_mini weui-btn_default\">分享</a></span>";
    			html += "<h4 class=\"weui-media-box__title\">"+ data[i].name +"</h4>";
    			html += "<p class=\"weui-media-box__desc\">"+status + ownByName +"</p>";
    			html += "</div>";
    		}
    		$("#list-panel").append(html);
    	}
    	function viewData(id, name){
    		window.location.href="${ctx}/wechat/hd/form?id="+id;
    	}
    	function getDictLabel(val, type){
    		
    		
    		if(type == "market_status"){
    			if(val == "0"){
        			return "已计划";
        		}
        		if(val == "1"){
        			return "进行中";
        		}
        		if(val == "2"){
        			return "已结束";
        		}
    		}
    	}
    </script>
  </head>
  <body ontouchstart>
  	<div class="page">
      <div class="page__bd">
        <mobile:searchBar modelName="crmMarket" url="${ctx}/wechat/hd"></mobile:searchBar>
    
		<div class="weui-panel weui-panel_access margin-top0" id="list-panel">
	        <div class="weui-panel__bd">
	        </div>
	    </div>
	    <div id="loadmore-panel"></div>
	    <div class="weui-loadmore">
	      <i class="weui-loading"></i>
	      <span class="weui-loadmore__tips">正在加载</span>
	    </div>
     </div>
    </div> 
    
    
    
     <div class="weui-tabbar">
     	
		
	 </div>
  </body>
</html>
