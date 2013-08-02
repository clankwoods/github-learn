package ViewI
{
	import com.Lance.base.App;
	import com.Lance.dll.Dll;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import View.interfaces.IScene;
	
	public final class BaseWorld extends Sprite
	{
		private var baseLayer:Sprite;
		private var sceneLayer:SceneView;
		public var uiLayer:UIView;
		public var modeLayer:Sprite;
		public var popLayer:Sprite;
		public var tipsLayer:Sprite;
		
		private static var instance:BaseWorld;
		
		public function BaseWorld()
		{
			
		}
		
		public function initWorld():void
		{
			baseLayer = new Sprite();
			
			with(addChild(baseLayer))
			{
			}
			sceneLayer = new SceneView();
			with(addChild(sceneLayer))
			{
				tabChildren=true;
			}
			
			uiLayer = new UIView();
			with(addChild(uiLayer))
			{
				tabChildren=false;
			}
			
			modeLayer =  new Sprite();
			with(addChild(modeLayer))
			{
				graphics.beginFill(0,.1);
				graphics.drawRect(0,0,1,1);
				graphics.endFill();
				visible=false;
				name="modeLayer";
			}
			popLayer =  new Sprite();
			with(addChild(popLayer))
			{
				tabChildren=true;
			}
			tipsLayer =  new Sprite();
			with(addChild(tipsLayer))
			{
				
			}
			var back:Bitmap=new Bitmap(Dll.getInstance().getDisplayObjectByName("background-main.jpg") as BitmapData);
			baseLayer.addChild(back);
//			test
//			back.bitmapData=new BitmapData(1,1,false,0);
			App.appStage..tabChildren = true;
			App.appStage.addEventListener(Event.RESIZE,resize);
			resize(null);
			function resize(event:Event):void{
				back.width=App.appStage.stageWidth;
				back.height=App.appStage.stageHeight;
				modeLayer.width=App.appStage.stageWidth;
				modeLayer.height=App.appStage.stageHeight;
				sceneLayer.x=App.appStage.stageWidth>>1;
				sceneLayer.y=App.appStage.stageHeight>>1;
				popLayer.x=App.appStage.stageWidth>>1;
				popLayer.y=App.appStage.stageHeight>>1;
				uiLayer.x=(App.appStage.stageWidth-uiLayer.width)>>1;
				uiLayer.y=(App.appStage.stageHeight-uiLayer.height)>>1;
			}
			sceneLayer.show();
		}
		
		public static function getInstance():BaseWorld
		{
			return instance ||= new BaseWorld();
		}
		
		public function changeScene(old:IScene,scene:IScene):void
		{
			if( old)old.removeFrom(sceneLayer);
			scene.showAs(sceneLayer);
			
		}
		
		public function showMovieOnScene(mov:MovieClip):void
		{
			sceneLayer.addChild(mov);
			mov.gotoAndPlay(1);
			mov.addFrameScript(mov.totalFrames-1,function():void
			{
				mov.stop();
				mov.parent.removeChild(mov);
			});
		}

		
	}
}
