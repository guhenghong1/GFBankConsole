var Common = {
	//弹窗提示
	showMsg : function(msg) {
		$.messager.alert('提示框', msg);
	},
	
	//时间格式化
	formatDate : function(time, fmt) {
		var datetime = new Date();
		console.log("time=  "+typeof(time)+"  datetime= "+datetime);
		datetime.setTime(time);
		var o = {
			"M+" : datetime.getMonth() + 1, //月份  
			"d+" : datetime.getDate(), //日  
			"h+" : datetime.getHours(), //小时  
			"m+" : datetime.getMinutes(), //分  
			"s+" : datetime.getSeconds(), //秒  
			"q+" : Math.floor((datetime.getMonth() + 3) / 3), //季度  
			"S" : datetime.getMilliseconds()	//毫秒  
		};
		if (/(y+)/.test(fmt))
			fmt = fmt.replace(RegExp.$1, (datetime.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
						: (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	},

    getDate : function(strDate) {
    	 
        var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,

         function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');

        return date;

    },
    
}