<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
	
	long times = new Date().getTime();
	pageContext.setAttribute("times", times);
%>
<html>
<head>
</head>
<body>
	<script type="text/javascript" src="${basePath}/js/common/common.js?u=${times}"></script>
	<script type="text/javascript" src="${basePath}/js/dept/dept.js?u=${times}"></script>
    <div style="margin:20px 0;"></div>
    <div class="easyui-panel" style="padding:5px">
        <ul class="easyui-tree" data-options="url:'${basePath}/dept/getDeptTree.do',method:'get',loadFilter:myLoadFilter,animate:true,checkbox:false"></ul>
    </div>
    <script>
        function myLoadFilter(data, parent){
            var state = $.data(this, 'tree');
            
            function setData(){
                var serno = 1;
                var todo = [];
                for(var i=0; i<data.length; i++){
                    todo.push(data[i]);
                }
                while(todo.length){
                    var node = todo.shift();
                    if (node.id == undefined){
                        node.id = '_node_' + (serno++);
                    }
                    if (node.children){
                        node.state = 'closed';
                        node.children1 = node.children;
                        node.children = undefined;
                        todo = todo.concat(node.children1);
                    }
                }
                state.tdata = data;
            }
            function find(id){
                var data = state.tdata;
                var cc = [data];
                while(cc.length){
                    var c = cc.shift();
                    for(var i=0; i<c.length; i++){
                        var node = c[i];
                        if (node.id == id){
                            return node;
                        } else if (node.children1){
                            cc.push(node.children1);
                        }
                    }
                }
                return null;
            }
            
            setData();
            
            var t = $(this);
            var opts = t.tree('options');
            opts.onBeforeExpand = function(node){
                var n = find(node.id);
                if (n.children && n.children.length){return}
                if (n.children1){
                    var filter = opts.loadFilter;
                    opts.loadFilter = function(data){return data;};
                    t.tree('append',{
                        parent:node.target,
                        data:n.children1
                    });
                    opts.loadFilter = filter;
                    n.children = n.children1;
                }
            };
            return data;
        }
    </script>
</body>
</html>