package controller
{
	import com.Lance.net.NetProxy;
	
	public final class Method
	{
		
		/**
		 *page		int	当前页</br>
		　　pageCount	int	每页个数</br>
		　　type 		int  1 官方 2 私人 4 自己</br>
		　　order 		int 1/时间 2人气 3价格</br>
		　　filter 		int 1/desc 降序 2 asc 升序</br>
		　　uid 			string 默认为null</br>
		 * */
		public static const GET_DIY_LIST:String = "Watch.getDiyList";
		
		/**初始化DIY列表*/
		public static function initDiyList(comFun:Function):void
		{
			NetProxy.getInstance().execute(GET_DIY_LIST,[0,8,1,1,1],function(param:Object):void
			{
				comFun( param);
			});
		}
		/**DIY列表按照时间排序 1降序,2升序*/
		public static function orderByTime(filter:int,comFun:Function):void
		{
			_order = 1;
			_filter = filter;
			NetProxy.getInstance().execute(GET_DIY_LIST,[0,8,_order,_filter,1],function(param:Object):void
			{
				comFun( param);
			});
		}
		/**DIY列表按照人气排序 1降序,2升序*/
		public static function orderBypop(filter:int,comFun:Function):void
		{
			_order = 2;
			_filter = filter;
			NetProxy.getInstance().execute(GET_DIY_LIST,[0,8,_order,_filter,1],function(param:Object):void
			{
				comFun( param);
			});
		}
		/**DIY列表按照价格排序 1降序,2升序*/
		public static function orderByPrice(filter:int,comFun:Function):void
		{
			_order = 3;
			_filter = filter;
			NetProxy.getInstance().execute(GET_DIY_LIST,[0,8,_order,_filter,1],function(param:Object):void
			{
				comFun( param);
			});
		}
		private static var _order:int = 1;
		private static var _filter:int = 1;
		/**DIY列表翻页下一页*/
		public static function nextPage(page:int,comFun:Function):void
		{
			NetProxy.getInstance().execute(GET_DIY_LIST,[page,8,_order,_filter,1],function(param:Object):void
			{
				comFun( param);
			});
		}
		
		public static const  User_Login:String = "User.login";
		public static function userLogin(id:String, psw:String,comFun:Function):void
		{
			NetProxy.getInstance().execute(User_Login,[id,psw],function(param:Object):void
			{
				comFun( param);
			});
		}
		public static const  User_Register:String = "User.register";
		public static function register(id:String, psw:String,comFun:Function):void
		{
			NetProxy.getInstance().execute(User_Register,[id,psw],function(param:Object):void
			{
				comFun( param);
			});
		}
		
		
//		public static const var Zan:String = "zan";
//		
//		public static function zanyixia(comFun:Function):void
//		{
//			
//		}
		
//		public function login(name:String,psw:String):void
//		{
//			NetProxy.getInstance().execute("login",[name,psw]);
//		}
//		public function register(name:String,psw:String):void
//		{
//			NetProxy.getInstance().execute("register",[name,psw]);
//		}
//		public function message(msg:String,contend:String):void
//		{
//			NetProxy.getInstance().execute("login",[msg,contend]);
//		}
//		public function getDiyList(pagecount:int, type:int, order:int, fiflter:int,uid:String):void
//		{
//			NetProxy.getInstance().execute("login",[pagecount,type,order,fiflter,uid]);
//		}
		//感觉有嗲不科学, 回头再改   7-6;
//		public function Login(name:String,psw:String):void
//		{
//			NetProxy.getInstance().execute("login",[name,psw]);
//		}
//		public function Login(name:String,psw:String):void
//		{
//			NetProxy.getInstance().execute("login",[name,psw]);
//		}
	}
}