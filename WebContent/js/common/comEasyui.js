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

/**时间控件datetimebox格式化*/
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
	console.log("ss===  "+s);
/*	2016-09-19 08:58:54*/
    if (!s) return new Date();  
    var y = s.substring(0,4);  
    var m =s.substring(5,7);  
    var d = s.substring(8,10);  
    var h = s.substring(11,13);  
    var min = s.substring(14,16);  
    var sec = s.substring(17);  
//    console.log("h="+h+" min="+min+" sec="+sec);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(min) && !isNaN(sec)){  
        return new Date(y,m-1,d,h,min,sec);  
    } else {  
        return new Date();  
    }
} 

/**日期控件datebox格式化  */
function myformatter(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}

function myparser(s){
    if (!s) return new Date();
    var ss = (s.split('-'));
    var y = parseInt(ss[0],10);
    var m = parseInt(ss[1],10);
    var d = parseInt(ss[2],10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
        return new Date(y,m-1,d);
    } else {
        return new Date();
    }
}