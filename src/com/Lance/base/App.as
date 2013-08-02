package com.Lance.base
{
	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	import flash.utils.getTimer;
	
	public final class App
	{
		public static var appDomain:ApplicationDomain;
		public static var appStage:Stage;
		public static var appLang:String = "en";
		public static var maxWidth:Number = 2800;
		public static var maxHeight:Number = 1600;
		public static var baseWidth:Number = 760;
		public static var baseHeight:Number = 600;
		private static var _stime:Number = 0;
		private static var _ctimer:Number = 0;
		
		public function App()
		{
			return;
		}
		
		public static function get stime() : Number
		{
			if (_stime == 0)
			{
				stime = Math.floor(new Date().time / 1000);
			}
			return _stime + Math.floor((getTimer() - _ctimer) / 1000);
		}
		
		public static function set stime(value:Number) : void
		{
			_stime = value;
			_ctimer = getTimer();
			return;
		}
		
	}
}