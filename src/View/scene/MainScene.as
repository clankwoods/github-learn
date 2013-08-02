package View.scene
{
	import View.interfaces.IScene;
	
	import com.Lance.dll.Dll;
	import com.greensock.TweenMax;
	
	import controller.Method;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public final class MainScene extends Sprite implements IScene
	{
		
		private var bg:Sprite;
		private var login:Sprite;
		
		
		public function MainScene()
		{
			super();
		}
		
		
		
		private function initEvent():void
		{
			if( bg)
			{
				bg.addEventListener(MouseEvent.CLICK, onclick);
			}
		}
		
		
		private function loginIn():void
		{
			if(  login )
			{
				with( login)
				{
					visible = true;
					alpha = 0;
				}
			TweenMax.to(login,0.2,{alpha:1});
			}
		}
		
		public var isLogin:Boolean = false;
		protected function onclick(event:MouseEvent):void
		{
			switch(event.target.name)
			{
				case "btnLogin":
				{
					isLogin = true;
					loginIn();
					break;
				}
				case "btnReg":
				{
					isLogin = false;
					loginIn();
					break;
				}
				case "lodinBut":
				{
					if( isLogin)
					{
						Method.userLogin( (login.getChildByName("txtID") as TextField).text, (login.getChildByName("txtPassword") as TextField).text,function(param:Object):void
						{
							
							if( param.Status == 101)
							{
								login.visible = false;
								loginSucceed();
							}
						});
					}
					else
					{
						Method.register( (login.getChildByName("txtID") as TextField).text, (login.getChildByName("txtPassword") as TextField).text,function(param:Object):void
						{
							if( param.Status == 101)
							{
								login.visible = false;
								loginSucceed();
							}
						});
					}
					break;
				}
				case "pic1":
				{
					targetName = event.target.name;
					exitMain(initAbout);
					break;
				}
				case "pic3":
				{
					targetName = event.target.name;
					exitMain(function(){});
					break;
				}
				case "pic6":
				{
					targetName = event.target.name;
					exitMain(function(){});
					break;
				}
				case "pic8":
				{
					targetName = event.target.name;
					exitMain(function(){});
					break;
				}
			}
		}
		
		public function initGraphics():void
		{
			bg = Dll.getInstance().getDisplayObjectByName("LoginBG") as Sprite;
			addChild( bg);
			for (var i:int = 1; i <= 8; i++) 
			{
				with( bg.getChildByName("pic"+i))
				{
					if( i==1 ||i==3||i==6||i==8)
						buttonMode = true;
				}
				
			}
			login = bg.getChildByName("loginMC") as Sprite;
			login.visible = false;
			
			with( bg.getChildByName("btnLogout"))
			{
				visible = false;
			}
			with( bg.getChildByName("userID"))
			{
				visible = false;
			}
			
		}
		
		
		public function loginSucceed():void
		{
			with( bg.getChildByName("btnLogin"))
			{
				visible = false;
			}
			with( bg.getChildByName("btnReg"))
			{
				visible = false;
			}
			with( bg.getChildByName("btnLogout"))
			{
				visible = true;
			}
			with( bg.getChildByName("userID"))
			{
				visible = true;
				text = (login.getChildByName("txtID") as TextField).text;
			}
		}
		
		public function showAs(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
		}
		
		public function removeFrom(parent:DisplayObjectContainer):void
		{
			parent.removeChild(this);
		}
		
		public function getSceneSize():Point
		{
			return null;
		}
		
		public function onEnter():void
		{
			initGraphics();
			initEvent();
		}
		
		private var exitMovCount:uint = 0;
		private var targetName:String = "";
		
		private function exitMain(compFun:Function):void
		{
			bg.getChildByName("pic2").visible= false;
			bg.getChildByName("pic4").visible= false;
			bg.getChildByName("pic5").visible= false;
			bg.getChildByName("pic7").visible= false;
			TweenMax.to(bg.getChildByName("pic1"), 0.3,{y:93,onComplete:function():void{comp(compFun)}});
			TweenMax.to(bg.getChildByName("pic3"), 0.3,{y:93,onComplete:function():void{comp(compFun)}});
			TweenMax.to(bg.getChildByName("pic6"), 0.3,{y:93,onComplete:function():void{comp(compFun)}});
			TweenMax.to(bg.getChildByName("pic8"), 0.3,{y:93,onComplete:function():void{comp(compFun)}});
			
		}
		
		private var childDsp:Sprite;
		private function initAbout():void
		{
			var tmp:Sprite = Dll.getInstance().getDisplayObjectByName("TXTMC") as Sprite;
			childDsp.addChild(tmp);
		}
		
		public function onEnterTransformDie():void
		{
			
		}
		
		private function comp(compFun:Function):void
		{
			exitMovCount++;
			if( exitMovCount >=3)
			{
				exitMovCount = 0;
				bg.getChildByName("pic1").y = 93;
				bg.getChildByName("pic3").y = 93;
				bg.getChildByName("pic6").y = 93;
				bg.getChildByName("pic8").y = 93;
				TweenMax.killAll();
				
				if( !childDsp)
				{
					childDsp = new Sprite();
					with(addChild(childDsp))
					{
						graphics.beginFill(0,0.2);
						graphics.drawRect(0,0,648,360);
						graphics.endFill();
						x = 157;
						y = 252;
					}
					
				}
				else
				{
					while(childDsp.numChildren)
					{
						childDsp.removeChildAt(0);
					}
				}
				compFun();
			}
		}
		
		
		public function onExit():void
		{
		}
		
		public function onExitTransformDie():void
		{
		}
	}
}