package View.scene.page
{
	import com.Lance.dll.Dll;
	
	import flash.display.Sprite;
	
	public class About extends Sprite
	{
		private var contacts:Sprite;
		public function About()
		{
			super();
			contacts=Dll.getInstance().getDisplayObjectByName("About") as Sprite;
			addChild(contacts);mouseEnabled=false;
		}
	}
}