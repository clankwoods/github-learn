package com.Lance.dll
{
	import flash.events.Event;
	
	public class DLLEvent extends Event
	{
		private var _data:Object;
		public static const SINGLECOMPLETE:String = "singlecomplete";
		public static const COMPLETE:String = "complete";
		public static const IO_ERROR:String = "io_error";
		public static const PROGRESS:String = "progress";
		public static const PROGRESSNUM:String = "progressnum";
		public static const LIST_COMPLETE:String = "list_complete";
		public static const LOADING_COMPLETE:String = "loadingComplete";
		public static const SWFURL_COMPLETE:String = "loaded";
		public static const ANALYZE_COMP:String = "analyzeComp";
		
		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		public function DLLEvent(type:String, data:Object = null)
		{
			super(type, false, false);
			this.data = data;
			return;
		}// end function
	}
}