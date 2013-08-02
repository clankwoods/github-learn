package com.Lance.dll
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;

	public class FileObject extends EventDispatcher
	{
		public var url:String;
		public var name:String;
		public var size:uint;
		public var result:Object;
		
		public function FileObject($url:String = "", $name:String = "", $size:uint = 0)
		{
			this.url = $url;
			this.name = $name;
			this.size = $size;
			return;
		}// end function
		public function get urlRequest() : URLRequest
		{
			return new URLRequest(this.url);
		}// end function
	}
}