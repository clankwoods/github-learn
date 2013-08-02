package com.Lance.net
{
	import com.Lance.utils.SharedObjectUtil;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

    public class LoginStatistics extends Object
    {
        private var _urlLoader:URLLoader;
        public static var LOGIN_STATISTICS_URL:String = "";
        public static const ACCUMULATOR_LOGINERROR:String = "Accumulator.loginError";
        private static var _instance:LoginStatistics;

        public function LoginStatistics()
        {
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this._urlLoader = new URLLoader();
            this._urlLoader.addEventListener(Event.COMPLETE, this.onstatisticsComplete);
            this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onstatisticsError);
            this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            return;
        }// end function

        private function onSecurityError(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function onstatisticsComplete(event:Event) : void
        {
            return;
        }// end function

        private function onstatisticsError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        public function sendLoginStatistics(statisticsObj:StatisticsObject) : void
        {
            statisticsObj.statisCdnIP = Platform.getInstance().getFileCDN();
            statisticsObj.statisUserIP = Platform.getInstance().getUserIp();
            statisticsObj.statisUserId = Platform.getInstance().userId;
            var _loc_2:* = StatisticsObject.getStatisticsPostData(statisticsObj);
            this.send(ACCUMULATOR_LOGINERROR, _loc_2);
            return;
        }// end function

        private function send($url:String, jsonObj:Object) : void
        {
            var _loc_3:URLRequest = null;
            var _loc_4:* = LOGIN_STATISTICS_URL;
            if (_loc_4 != "")
            {
                _loc_4 = _loc_4 + $url;
                _loc_3 = new URLRequest(_loc_4);
                _loc_3.method = URLRequestMethod.POST;
                _loc_3.data = JSON.encode(jsonObj);
                this._urlLoader.load(_loc_3);
            }
            return;
        }// end function

        private function saveLog(saveObj:Object) : void
        {
            var _loc_2:* = SharedObjectUtil.getSharedObjectData("gameLog")["log"];
            if (_loc_2 == null)
            {
                _loc_2 = new Array();
            }
            _loc_2.push(saveObj);
            SharedObjectUtil.writeSharedObjectData("gameLog", "log", _loc_2);
            return;
        }// end function

        public static function get instance() : LoginStatistics
        {
            if (!_instance)
            {
            }
            var _loc_1:* = new LoginStatistics;
            _instance = new LoginStatistics;
            return _loc_1;
        }// end function

    }
}
