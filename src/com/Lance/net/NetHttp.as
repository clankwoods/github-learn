package com.Lance.net
{
	import com.Lance.utils.StatusValue;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
  

    public class NetHttp extends Object
    {
        private var _httpUrl:String;
        private var _dataFormat:String;

        public function NetHttp()
        {
            return;
        }// end function

        public function reuqestServer(_methodName:String, _param:Object, _result:Function, _resultParams:Array = null, 
									  _showLoading:Boolean = true, _reload:Boolean = true, _timeOut:Number = 60000):void
        {
            var callBack:Function;
            var timeInt:int;
            var requestTime:int;
            var urlLoader:URLLoader;
            var urlRequest:URLRequest;
            var compHandle:Function;
            var statusHandle:Function;
            var ioErrorHandle:Function;
            var timeOutHandle:Function;
			var methodName:String = _methodName;
			var param:Object = _param;
			var result:Function = _result;
			var resultParams:Array = _resultParams;
			var showLoading:Boolean = _showLoading;
			var reload:Boolean = _reload;
			var timeOut:Number = _timeOut;
            callBack = result;
            requestTime;
            var method:Array = methodName.split(".");
            urlLoader = new URLLoader();
            urlLoader.dataFormat = this.dataFormat;
            var urlVars:URLVariables = new URLVariables();
            urlVars.classname = method[0];
            urlVars.func = method[1];
            urlVars.param = param ? (JSON.encode(param)) : (param);
            urlRequest = new URLRequest(this.httpUrl);
            urlRequest.data = urlVars;
            urlRequest.method = URLRequestMethod.POST;
            if (reload)
            {
                timeInt = setTimeout(timeOutHandle, timeOut);
            }
            var clearAll:* = function () : void
            {
                urlLoader.close();
                clearTimeout(timeInt);
                urlLoader.removeEventListener(Event.COMPLETE, compHandle);
                urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandle);
                urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandle);
                return;
            }// end function
            ;
            compHandle = function (event:Event) : void
            {
                var _loc_4:String = null;
                var _loc_2:* = methodName + " ";
                if (param)
                {
                    for (_loc_4 in param)
                    {
                        
                        _loc_2 = _loc_2 + (_loc_4 + "=>" + param[_loc_4] + " ");
                    }
                }
//                Debug.print(_loc_2);
                var _loc_3:* = JSON.decode(event.currentTarget.data);
//                Debug.print(_loc_3);
                if (_loc_3.value && "leveltask" in _loc_3.value)
                {
                    if (_loc_3.value.task != "")
                    {
                    }
                    delete _loc_3.value.leveltask;
                }
                if (_loc_3.value && "feed" in _loc_3.value)
                {
                    Platform.getInstance().sendFeed(_loc_3.value.feed);
                    delete _loc_3.value.feed;
                }
                if (resultParams != null)
                {
                    resultParams.unshift(_loc_3);
                    callBack.apply(null, resultParams);
                }
                else
                {
                    callBack(_loc_3);
                }
                clearAll();
                return;
            }// end function
            ;
            statusHandle = function (event:HTTPStatusEvent) : void
            {
                if (event.status != 0 && event.status != 200)
                {
                    callBack({state:StatusValue.HTTP_STATUS_ERROR, message:event.status});
                }
                return;
            }// end function
            ;
            ioErrorHandle = function (event:IOErrorEvent) : void
            {
                callBack({state:StatusValue.IO_ERROR, message:event.text});
                clearAll();
                return;
            }// end function
            ;
            timeOutHandle = function () : void
            {
                if (requestTime == 0)
                {
                    urlLoader.load(urlRequest);
                    var _loc_2:* = requestTime + 1;
                    requestTime = _loc_2;
                }
                else
                {
                    clearAll();
                    callBack({state:StatusValue.TIME_OUT, message:"time out"});
                }
                return;
            }// end function
            ;
            urlLoader.addEventListener(Event.COMPLETE, compHandle);
            urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandle);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandle);
            urlLoader.load(urlRequest);
            return;
        }// end function

        public function get httpUrl() : String
        {
            return this._httpUrl;
        }// end function

        public function set httpUrl(param1:String) : void
        {
            this._httpUrl = param1;
            return;
        }// end function

        public function get dataFormat() : String
        {
            return this._dataFormat;
        }// end function

        public function set dataFormat(param1:String) : void
        {
            this._dataFormat = param1;
            return;
        }// end function

    }
}
