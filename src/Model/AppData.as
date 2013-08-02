package Model
{
	import com.Lance.net.NetProxy;

	public final class AppData
	{
		
		private static var instance:AppData;
		
		public var minWidth:int = 1280;
		public var minHeight:int = 800;
		private var _flashValue:Object;
		public var myuid:String = "";
		public var platform_lang:String = "";
		public var data:Object;
		
		public function AppData()
		{
		}
		
		public static function getInstance():AppData
		{
			return instance ||= new AppData();
		}
		public function setValue(param1:Object) : void
		{
			this._flashValue = param1;
			if( param1.hasOwnProperty( "UserId"))
			{
				this.myuid = param1["UserId"];
			}
			
			if( param1.hasOwnProperty( "lang"))
			{
				this.platform_lang = param1["lang"];
			}
			
			
//			if ("UserId" in param1)
//			{
//				this.myuid = param1["UserId"];
//			}
//			if ("lang" in param1)
//			{
//				this.platform_lang = param1["lang"];
//			}
			NetProxy.getInstance().serversUrl = param1["domainRoot"] + param1["postUrl"];
			return;
		}// end function
	}
}