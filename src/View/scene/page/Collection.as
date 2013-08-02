package View.scene.page
{
	import com.Lance.dll.Dll;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;

	public class Collection
	{
		private static var ds:Dictionary; 
		public function Collection()
		{
		}
		public static function show(container:Sprite):void{
			if(!ds){
				ds=new Dictionary();
				ds["sortbtns"]=Dll.getInstance().getDisplayObjectByName("Sortbtns");
				var mc:*;
				var arr:Array=["Time","Popularity","Price"];
				for(var i:int=0;i<ds["sortbtns"].numChildren;i++){
					mc=ds["sortbtns"].getChildAt(i);
					if(mc.hasOwnProperty("txt")){
						with(mc.txt){
							text=arr[i-1];
							autoSize=TextFieldAutoSize.RIGHT;
						}
						mc.mouseChildren=false;
						mc.buttonMode=true;
					}
				}
			}
			ds["sortbtns"].x=353;
			ds["sortbtns"].alpha=0;
			TweenMax.to(ds["sortbtns"],.3,{x:-17,alpha:1});
			container.addChild(ds["sortbtns"]);
		}
		public static function handler(event:Event):void{
			trace(event.target);
		}
	}
}