package View.scene.page
{
	import com.Lance.dll.Dll;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.Dictionary;

	public class Upload
	{
		private static var ul:Dictionary;
		
		public function Upload()
		{
		}
		public static function show(container:Sprite):void{
			if(!ul){
				ul=new Dictionary();
				ul["btnsumint"]=Dll.getInstance().getDisplayObjectByName("btnsubmit");
				ul["btnupload"]=Dll.getInstance().getDisplayObjectByName("btnsubmit");
				ul["textarea"]=new TextField();
				ul["textarea"].border=true;
				ul["textarea"].borderColor=0xcccccc;
				ul["img"]=new Sprite();
				with(ul["img"].graphics){
					lineStyle(0,0xcccccc);
					drawRect(0,0,195,195);
					endFill();
				}
				ul["img"].x=205;
				ul["textarea"].width=400;
				ul["textarea"].height=160;
				ul["textarea"].y=210;
				ul["textarea"].wordWrap=true;
				ul["textarea"].type=TextFieldType.INPUT;
				ul["btnupload"].buttonMode=ul["btnsumint"].buttonMode=true;
				ul["btnupload"].mouseChildren=ul["btnsumint"].mouseChildren=false;
				ul["btnupload"].txt.text="upload";
				ul["btnupload"].x=123;
				ul["btnupload"].y=169;
				ul["btnsumint"].x=341;
				ul["btnsumint"].y=381;
				
			}
			for each(var dis:DisplayObject in ul){
				container.addChild(dis);
			}
		}
		public static function handler(event:Event):void{
			trace(event.target);
		}
	}
}