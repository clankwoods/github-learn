package View
{
	
	import controller.ControllerList;
	import controller.SceneController;
	
	import flash.display.Sprite;
	
	
	public final class SceneView extends Sprite
	{
		public function SceneView()
		{
		}
		

		public function show():void
		{
			//ControllerList.getInstance().sceneController.changeScene(SceneController.Main);
			ControllerList.getInstance().sceneController.changeScene(SceneController.Index);
		}
		
	}
}