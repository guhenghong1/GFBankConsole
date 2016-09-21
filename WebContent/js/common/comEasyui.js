var ComEasyUI = {
	_this : this,
	init : function() {
		_this.initDeptCombotree();
	},
	initDeptCombotree : function() {
		$('#deptTree').combotree({
		    url: '../dept/getDeptTree.do',
		    required: true
		});
	}
}

$(function() {
//	init();
});

function fmt(date){  
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
    var d = date.getDate();  
    var h = date.getHours();  
    var min = date.getMinutes();  
    var sec = date.getSeconds();  
    var str = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d)+''+' '+(h<10?('0'+h):h)+':'+(min<10?('0'+min):min)+':'+(sec<10?('0'+sec):sec);  
    return str;  
}  
function pas(s){  
    if (!s) return new Date();  
    var y = s.substring(0,4);  
    var m =s.substring(5,7);  
    var d = s.substring(8,10);  
    var h = s.substring(11,14);  
    var min = s.substring(15,17);  
    var sec = s.substring(18,20);  
    if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(min) && !isNaN(sec)){  
        return new Date(y,m-1,d,h,min,sec);  
    } else {  
        return new Date();  
    }  
}  