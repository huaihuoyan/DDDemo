/**
 * 传入时间戳  开始  结束
 * 
 * timesToHMS(3000,1000) -->00:00:02
 * 返回  x天x时x分x秒
 */

function timesToHMS(times1,times2){
	var date3=times1-times2  //时间差的毫秒数
   	//计算出相差天数
   	var days=Math.floor(date3/(24*3600*1000));
   	 
   	//计算出小时数
   	var leave1=date3%(24*3600*1000);    //计算天数后剩余的毫秒数
   	var hours=Math.floor(leave1/(3600*1000));
   	//计算相差分钟数
   	var leave2=leave1%(3600*1000) ;       //计算小时数后剩余的毫秒数
   	var minutes=Math.floor(leave2/(60*1000));
   	//计算相差秒数
   	var leave3=leave2%(60*1000);      //计算分钟数后剩余的毫秒数
   	var seconds=Math.round(leave3/1000);
   	//alert(" 相差 "+days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒")
   	var result = '';
   	if(days > 0){
   		result +=days+' ';
   	}
   	if(hours > 0 && hours>10){
   		result +=hours+':';
   	}else if(hours<10){
   		result +='0'+hours+':';
   	}else{
   		result +='00:';
   	}
	if(minutes > 0 && minutes>10){
   		result +=minutes+':';
   	}else if(minutes<10){
   		result +='0'+minutes+':';
   	}else{
   		result +='00:';
   	}
	if(seconds > 0 && seconds>10){
   		result +=seconds;
   	}else if(seconds<10){
   		result +='0'+seconds+':';
   	}else{
   		result +='00';
   	}
	return result;
}
 
/**       
 * 对Date的扩展，将 Date 转化为指定格式的String       
 * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符       
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)       
 * eg:       
 * (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423       
 * (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04       
 * (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04       
 * (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04       
 * (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18       
 */          
Date.prototype.pattern=function(fmt) {           
    var o = {           
    "M+" : this.getMonth()+1, //月份           
    "d+" : this.getDate(), //日           
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时           
    "H+" : this.getHours(), //小时           
    "m+" : this.getMinutes(), //分           
    "s+" : this.getSeconds(), //秒           
    "q+" : Math.floor((this.getMonth()+3)/3), //季度           
    "S" : this.getMilliseconds() //毫秒           
    };           
    var week = {           
    "0" : "/u65e5",           
    "1" : "/u4e00",           
    "2" : "/u4e8c",           
    "3" : "/u4e09",           
    "4" : "/u56db",           
    "5" : "/u4e94",           
    "6" : "/u516d"          
    };           
    if(/(y+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));           
    }           
    if(/(E+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);           
    }           
    for(var k in o){           
        if(new RegExp("("+ k +")").test(fmt)){           
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));           
        }           
    }           
    return fmt;           
}  