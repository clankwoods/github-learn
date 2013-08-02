package controller
{
	import com.MVC.Model.IController;
	
	import flash.events.EventDispatcher;
	
	public final class EventController implements IController
	{
		public var eventdispatcher:EventDispatcher;
		
		public function EventController()
		{
			eventdispatcher = new EventDispatcher();
		}
	}
}