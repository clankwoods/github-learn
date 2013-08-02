package com.Lance.net
{
	import controller.Method;
	
	import flash.net.ObjectEncoding;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.Dictionary;

    public class NetProxy
    {
		private var _protocol:String = "webservice";
		private var _serversUrl:String;
		private var _httpDataFormat:String = "text";
		private var _netHttp:NetHttp;
		private var _netSocket:NetSocket;
		private var _netWeb:NetWeb;
		private static var np:NetProxy;
		public static const HTTP:String = "http";
		public static const SOCKET:String = "socket";
		public static const WEBSERVICE:String = "webservice";
		private static var instance:NetProxy;

        public function NetProxy()
        {
			this._netHttp = new NetHttp();
			this._netSocket = new NetSocket();
			this._netWeb = new NetWeb();
        }// end function

		public function execute(param1:String, param2:Object, param3:Function, param4:Array = null, param5:Boolean = true, param6:Boolean = true, param7:Number = 60000) : void
		{
			if (this.protocol == NetProxy.HTTP)
			{
				this._netHttp.httpUrl = this.serversUrl;
				this._netHttp.dataFormat = this.httpDataFormat;
				this._netHttp.reuqestServer(param1, param2, param3, param4, param5, param6, param7);
			}
			else if (this.protocol == NetProxy.WEBSERVICE)
			{
				this._netWeb.encoding = ObjectEncoding.AMF3;
				this._netWeb.url = "http://173.201.37.191/Watch/Amfphp/index.php";
				this._netWeb.reuqestServer(param1, param2 as Array, param3, param4, param5, param6, param7);
			}
			return;
		}
		

        public function get protocol() : String
        {
            return this._protocol;
        }// end function

        public function set protocol(param1:String) : void
        {
            this._protocol = param1;
            return;
        }// end function

		public function get serversUrl() : String
		{
			return this._serversUrl;
		}// end function
		
		public function set serversUrl(param1:String) : void
		{
			this._serversUrl = param1;
			return;
		}// end function
		
		public function get httpDataFormat() : String
		{
			return this._httpDataFormat;
		}// end function
		
		public function set httpDataFormat(param1:String) : void
		{
			this._httpDataFormat = param1;
			return;
		}// end function
        public static function getInstance() : NetProxy
        {
            return instance ||= new NetProxy();
        }// end function

    }
}
