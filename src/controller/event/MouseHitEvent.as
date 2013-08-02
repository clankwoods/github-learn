package controller.event
{
	import flash.events.Event;
	
	public final class MouseHitEvent extends Event
	{
		public static const CLICK:String = "mouse_hit_click";
		
		
		public var data:Object;
		public function MouseHitEvent(type:String, _data:Object)
		{
			super(type);
			this.data = _data
		}
	}
}