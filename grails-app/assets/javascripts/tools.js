var tools = {};
//("yyyy-MM-dd")格式时间比较
tools.compareDate = function (a, b) {
    var arr = a.split("-");
    var starttime = new Date(arr[0], arr[1], arr[2]);
    var starttimes = starttime.getTime();

    var arrs = b.split("-");
    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
    var lktimes = lktime.getTime();
    if (starttimes >= lktimes) {
        return false;
    }
    else
        return true;
};
//yyyy-MM-dd hh:mm:ss比较
tools.compareStartEndDate = function(startDate,endDate){
	var flag = true;
    if(startDate.length>0&&endDate.length>0){
    	var startDateTemp = startDate.split(" ");
      	var endDateTemp = endDate.split(" ");
      	var arrStartDate = startDateTemp[0].split("-");
      	var arrEndDate = endDateTemp[0].split("-");
      	var arrStartTime = startDateTemp[1].split(":");
      	var arrEndTime = endDateTemp[1].split(":");
      	var allStartDate = new Date(arrStartDate[0],(arrStartDate[1]-1),arrStartDate[2],arrStartTime[0],arrStartTime[1],arrStartTime[2]);  
      	var allEndDate = new Date(arrEndDate[0],(arrEndDate[1]-1),arrEndDate[2],arrEndTime[0],arrEndTime[1],arrEndTime[2]); 
      	if(allStartDate.getTime()>allEndDate.getTime()){
      		flag = false;   
      	}
    }
    return flag;   
};

/*
	将json对象转换为字符串
	使用方法:
	var json = {id=3,name="abc"};
	var str = tools.j2s(json);
 */
tools.j2s = function(O) {
	var S = [];
	var J = "";
	if (Object.prototype.toString.apply(O) === '[object Array]') {
		for ( var i = 0; i < O.length; i++) {
			S.push(this.j2s(O[i]));
		}
		J = '[' + S.join(',') + ']';
	} else if (Object.prototype.toString.apply(O) === '[object Date]') {
		J = "new Date(" + O.getTime() + ")";
	} else if (Object.prototype.toString.apply(O) === '[object RegExp]' || Object.prototype.toString.apply(O) === '[object Function]') {
		J = O.toString();
	} else if (Object.prototype.toString.apply(O) === '[object Object]') {
		for ( var i in O) {
			var tempObj = "";
			if(typeof (O[i]) == 'string') {
				tempObj = '"' + O[i] + '"';
			} else if(typeof (O[i]) === 'object') {
				tempObj = this.j2s(O[i]);
			} else {
				tempObj = O[i];
			}
			S.push('"' + i + '":' + tempObj);
		}
		J = '{' + S.join(',') + '}';
	} else if (Object.prototype.toString.apply(O) === '[object String]') {
		J = '"' + O + '"';
	} else {
		J = O;
	}
	return J;
};

/*
	Cookie工具
	使用方法:
		//存值
		var value = "7天";
		tools.cookie("day",value, {expires:7});	//将字符串:"7天" 以 "day"这个key保存到cookie中5天
		//取值
		var v = tools.cookie("day");			//用 "day" 这个key从cookie取出值
*/
tools.cookie = function(name, value, options) {
	if (typeof value != 'undefined') { // name and value given, set cookie
		options = options || {};
		if (value === null) {
			value = '';
			options.expires = -1;
		}
		var expires = '';
		if (options.expires
				&& (typeof options.expires == 'number' || options.expires.toGMTString)) {
			var date;
			if (typeof options.expires == 'number') {
				date = new Date();
				date.setTime(date.getTime()
						+ (options.expires * 24 * 60 * 60 * 1000));
			} else {
				date = options.expires;
			}
			expires = '; expires=' + date.toGMTString(); // use expires
			// attribute,
			// max-age is not
			// supported by IE
		}
		var path = options.path ? '; path=' + options.path : '';
		var domain = options.domain ? '; domain=' + options.domain : '';
		var secure = options.secure ? '; secure' : '';
		document.cookie = [ name, '=', encodeURIComponent(value), expires,
				path, domain, secure ].join('');
	} else { // only name given, get cookie
		var cookieValue = null;
		if (document.cookie && document.cookie != '') {
			var cookies = document.cookie.split(';');
			for ( var i = 0; i < cookies.length; i++) {
				var cookie = jQuery.trim(cookies[i]);
				// Does this cookie string begin with the name we want?
				if (cookie.substring(0, name.length + 1) == (name + '=')) {
					cookieValue = decodeURIComponent(cookie
							.substring(name.length + 1));
					break;
				}
			}
		}
		return cookieValue;
	}
};