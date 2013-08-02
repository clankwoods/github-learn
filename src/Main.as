package  
{
	
	
	import Model.AppData;
	
	import View.BaseWorld;
	
	
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends Sprite 
	{ 
		public function Main() 
		{
			if( stage )
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAdd);
			}
		}
		
		protected function onAdd(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void
		{
			AppData.getInstance().setValue(stage.loaderInfo.parameters);
			BaseWorld.getInstance().initWorld();
			addChild(BaseWorld.getInstance());
		}
	}
	
}
