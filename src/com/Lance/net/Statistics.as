package com.Lance.net
{
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;

    public class Statistics extends EventDispatcher
    {
        private var uid:int;
        private var sampling:Boolean = false;
        private var samplingProportion:Number = 1;
        private var clockInterval:uint = 0;
        private var timer:Timer;
        protected var clocking:Boolean = false;
        private var _httpUrl:String = "";
        private var urlRequest:URLRequest;
        private var urlLoader:URLLoader;
        private var urlRequestList:Array;
        private var lastRequestCompleted:Boolean = true;

        public function Statistics()
        {
            this.urlRequest = new URLRequest();
            this.urlLoader = new URLLoader();
            this.urlRequestList = [];
            return;
        }// end function

        public function setProperty(param1:String, sampling:Boolean = false, clocking:Boolean = false, samplingProportion:Number = 1, clockInterval:uint = 0) : void
        {
            this.uid = this.cal(param1);
            this.sampling = sampling;
            this.samplingProportion = samplingProportion;
            this.clocking = clocking;
            this.clockInterval = clockInterval;
            if (clocking)
            {
                this.clockStart();
                this.timer = new Timer(clockInterval);
                this.timer.addEventListener(TimerEvent.TIMER, this.clockIntervalHandler);
                this.timer.start();
            }
            return;
        }// end function

        private function cal(param1:String) : uint
        {
            var _loc_2:* = int(param1.substr(param1.length - 5, 5));
            return _loc_2;
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

        protected function clockStart() : void
        {
            return;
        }// end function

        protected function clockIntervalHandler(event:TimerEvent) : void
        {
            return;
        }// end function

        protected function sendStat(param1:String, param2:Object = null) : void
        {
            if (this.sampling)
            {
            }
            if (this.samplingProportion < 1)
            {
                if (this.uid % (1 / this.samplingProportion) != 0)
                {
                    return;
                }
            }
            else
            {
                this.sendStatHandler(param1, param2);
            }
            return;
        }// end function

        private function sendStatHandler(param1:String, param2:Object = null) : void
        {
            var _postData:Object;
            var isHandler:Boolean;
            var ioerrorHandler:Function;
            var httpStatusHandler:Function;
            var loadCompHandler:Function;
            var _uv:URLVariables;
            var _name:String;
            var dataObj:Object;
            var _loc_4:int;
            var _loc_5:*;
            var param1:* = param1;
            var param2:* = param2;
            var StatType:* = param1;
            var data:* = param2;
            if (!this.lastRequestCompleted)
            {
                this.urlRequestList.push({StatType:StatType, data:data});
                return;
            }
            var dataJson:* = JSON.encode(data);
            if (dataObj is String)
            {
                _postData = dataObj;
            }
            else if (dataObj is URLVariables)
            {
                _postData = dataObj;
            }
            else
            {
                _uv = new URLVariables();
                _loc_4;
                _loc_5 = dataObj;
                while (_loc_5 in _loc_4)
                {
                    
                    _name = _loc_5[_loc_4];
                    _uv[_name] = dataObj[_name];
                }
                _postData = _uv;
            }
            this.urlRequest.url = this._httpUrl + StatType;
            this.urlRequest.method = URLRequestMethod.POST;
            this.urlRequest.data = _postData;
            ioerrorHandler = function (event:IOErrorEvent) : void
            {
                if (!isHandler)
                {
                    isHandler = true;
                }
                return;
            }// end function
            ;
            httpStatusHandler = function (event:HTTPStatusEvent) : void
            {
                if (!isHandler)
                {
                    isHandler = true;
                }
                return;
            }// end function
            ;
            loadCompHandler = function (event:Event) : void
            {
                if (!isHandler)
                {
                    isHandler = true;
                }
                lastRequestCompleted = true;
                clearAll();
                if (urlRequestList != null)
                {
                }
                if (urlRequestList.length > 0)
                {
                    sendStatHandler(urlRequestList[0]["StatType"], urlRequestList[0]["data"]);
                    urlRequestList.shift();
                }
                return;
            }// end function
            ;
            var clearAll:* = function () : void
            {
                urlLoader.close();
                urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioerrorHandler);
                urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
                urlLoader.removeEventListener(Event.COMPLETE, loadCompHandler);
                return;
            }// end function
            ;
            this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioerrorHandler);
            this.urlLoader.addEventListener(Event.COMPLETE, loadCompHandler);
            this.urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            this.urlLoader.dataFormat = "text";
            this.lastRequestCompleted = false;
            this.urlLoader.load(this.urlRequest);
            return;
        }// end function

    }
}
