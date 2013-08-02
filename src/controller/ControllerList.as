package controller
{

	public final class ControllerList
	{
		private static var instance:ControllerList;
		
		public var sceneController:SceneController;
		public var eventController:EventController;
		
		
		
		public function ControllerList()
		{
			sceneController = new SceneController();
			eventController = new EventController();
		}
		
		public static function getInstance():ControllerList
		{
			return instance||= new ControllerList();
		}
		
	}
}