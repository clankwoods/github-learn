package controller
{
	import com.MVC.Model.IController;
	
	import flash.geom.Point;
	
	import View.BaseWorld;
	import View.interfaces.IScene;
	import View.scene.IndexScene;
	import View.scene.MainScene;
	import View.scene.WatchListScene;
	
	public final class SceneController implements IController
	{
		
		private var _currentScene:IScene;
		private var _oldScene:IScene;
		
		
		
		public static const WatchList:String = "watchList";
		public static const Main:String = "main";
		public static const Index:String="index";
		
		private var wlScene:WatchListScene;
		private var main:MainScene;
		private var indexScene:IndexScene;
		
		public function get isAnimationing():Boolean{
			return indexScene.isAnimationing;
		}
		public function showMyInfo(page:int):void{
			if(indexScene.isShowMyInfo){
				indexScene.showMyInfo(page);
			}else{
				indexScene.clearscreen(indexScene.showMyInfo,[page]);
			}
		}
		public function closeMyInfo():void{
			indexScene.closeMyInfo(null,[]);
		}
		public function SceneController()
		{
		}
		public function clear():void{
			if(indexScene.isIndex){return;}
			indexScene.clearscreen(indexScene.showIndexItem,[]);
		}
		public function changeScene(sceneName:String):void
		{
			_oldScene = currentScene;
			
			switch(sceneName)
			{
				case "watchList":
				{
					if( ! wlScene) wlScene = new WatchListScene();
					_currentScene = wlScene;
					break;
				}
				case "main":
				{
					if( ! main) main = new MainScene();
					_currentScene = main;
					break;
				}
				case "index":
				{
					if( ! indexScene) indexScene = new IndexScene();
					_currentScene = indexScene;
					break;
				}
					
			}
			if( _oldScene)
			{
				_oldScene.onExit();
				_oldScene.onExitTransformDie();
			}
			
			BaseWorld.getInstance().changeScene(_oldScene,_currentScene);
			_currentScene.onEnter();
			
			
			_currentScene.onEnterTransformDie();
			
			
			
		}
		public function getSceneSize():Point
		{
			return _currentScene.getSceneSize();
		}
		
		public function get currentScene():IScene
		{
			return _currentScene;
		}
		
	}
}