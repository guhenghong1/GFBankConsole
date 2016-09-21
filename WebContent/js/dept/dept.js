var Dept = {
}

//获取选中的节点数据
function getChecked(){
	var nodes = $('#tt').tree('getChecked');
    var s = '';
    for(var i=0; i<nodes.length; i++){
		if (s != '') s += ',';
            s += nodes[i].text;
        }
    alert(s);
 }
 
 $(function() {
 });