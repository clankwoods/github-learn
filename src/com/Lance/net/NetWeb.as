package com.Lance.net
	
{
    import Model.AppData;
    
    import com.adobe.serialization.json.JSON;
    
    import flash.events.*;
    import flash.net.*;

    public class NetWeb extends Object
    {
        private var _url:String  ;
        private var _encoding:uint;

        public function NetWeb()
        {
            return;
        }// end function

        public function reuqestServer(_methodName:String, _param:Array, _result:Function, _resultParams:Array = null, 
									  _showLoading:Boolean = true, _reload:Boolean = true, _timeOut:Number = 60000) : void
        {
            var onNetStatus:Function;
            var onResult:Function;
            var onError:Function;
            var methodName:String = _methodName;
            var param:Array = _param;
            var result:Function = _result;
            var resultParams:Array = _resultParams;
            var showLoading:Boolean = _showLoading;
            var reload:Boolean = _reload;
            var timeOut:Number = _timeOut;
            onNetStatus = function (event:NetStatusEvent) : void
            {
                return;
            }// end function
            ;
            onResult = function (param1:Object) : void
            {
				
//                if (resultParams)
//                {
//                    resultParams.unshift(JSON.decode(param1));
//                    result.apply(null, resultParams);
//                }
//                else
//                {
//                    result.apply(null, [JSON.decode(param1)]);
//                }
				result.apply(null, [param1]);
                return;
            }// end function
            ;
            onError = function (param1:Object) : void
            {
                var _loc_2:Object = null;
                for each (_loc_2 in param1)
                {
                    
                }
                return;
            }// end function
            ;
            var netCon:NetConnection = new NetConnection();
            netCon.objectEncoding = this.encoding;
            netCon.connect(this.url);
            netCon.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
            var rsp:Responder = new Responder(onResult, onError);
            if (!param)
            {
                var _loc_9:* = [];
                param;
            }
            param.unshift(methodName, rsp);
			trace(param);
            netCon.call.apply(null, param);
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function set url(param1:String) : void
        {
            var _loc_2:* = param1;
            this._url = param1;
            return;
        }// end function

        public function get encoding() : uint
        {
            return this._encoding;
        }// end function

        public function set encoding(param1:uint) : void
        {
            var _loc_2:* = param1;
            this._encoding = param1;
            return;
        }// end function

    }
}
