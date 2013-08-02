package com.Lance.dll
{
	import flash.events.Event;
	
	public class MultiLoaderEvent extends Event
	{
		private var _data:Object;
		public static const COMPLETE:String = "multiLoaderEvent_complete";
		public static const IO_ERROR:String = "io_error";
		public static const PROGRESS:String = "progress";
		public static const SINGLECOMPLETE:String = "singlecomplete";
		
		public function MultiLoaderEvent(type:String, data:Object)
		{
			super(type);
			this._data = data;
			return;
		}// end function
		
		public function get data() : Object
		{
			return this._data;
		}// end function
		
		public function set data(value:Object) : void
		{
			this._data = value;
			return;
		}// end function
	}
}