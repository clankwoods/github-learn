package View.scene
{
	import com.Lance.dll.Dll;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	import View.scene.page.Address;
	import View.scene.page.Changepassword;
	import View.scene.page.Collection;
	import View.scene.page.Desin;
	import View.scene.page.Upload;
	
	
	public class InfoPage extends Sprite
	{
		private var btns:Vector.<MovieClip>;
//		private var sortbtns:Vector.<TextField>;
		private var classes:Vector.<Class>
		private var currentpage:int=-1;
		private var container:Sprite;
		private var cp:Dictionary;
		private var currentTab:Class;
		public function InfoPage()
		{
			super();
			var back:Bitmap=new Bitmap(Dll.getInstance().getDisplayObjectByName("desinBackground.png") as BitmapData);
			back.bitmapData.draw(new BitmapData(1,495,false,0xcccccc),new Matrix(1,0,0,1,152,6));
			addChild(back);
			setUI();
		}
		private function setUI():void{
			var arr:Array=["My Desins","My Collections","Upload","Change Password","Address"];
			var arr2:Array=["Time","Popularity","Price"];
			var i:int=0;
			btns=new Vector.<MovieClip>;
			classes=new Vector.<Class>;
			classes.push(Desin);
			classes.push(Collection);
			classes.push(Upload);
			classes.push(Changepassword);
			classes.push(Address);
			for(i=0;i<arr.length;i++){
				btns[i]=Dll.getInstance().getDisplayObjectByName("btnmy") as MovieClip;
				with(addChild(btns[i])){
					x=30;
					y=30+i*40;
					txt.text=arr[i];
					buttonMode=true;
					mouseChildren=false;
					tabEnabled=false;
				}
			}
			container=new Sprite();
			container.x=170;
			container.y=35;
			addChild(container);
			addEvent();
		}
		public function addEvent():void{
			addEventListener(MouseEvent.CLICK,clickHandler);
			addEventListener(Event.CHANGE,changeHandler);
			addEventListener(FocusEvent.FOCUS_OUT,focusHandler);
			addEventListener(FocusEvent.FOCUS_IN,focusHandler);
		} 
		
		public function removeEvent():void{
			removeEventListener(MouseEvent.CLICK,clickHandler);
			removeEventListener(Event.CHANGE,changeHandler);
			removeEventListener(FocusEvent.FOCUS_IN,focusHandler);
		}
		
		protected function focusHandler(event:FocusEvent):void
		{
			classes[currentpage].handler(event);
		}
		protected function changeHandler(event:Event):void
		{
			classes[currentpage].handler(event);
		}
		private function clickHandler(event:MouseEvent):void{
			var tab:int=btns.indexOf(event.target);
			if(tab>=0){
				showPageBtn(tab);
			}else{
				classes[currentpage].handler(event);
			}
		}
		public function showPageBtn(page:int):void{
			if(currentpage==page||page<0){return;}
			if(currentpage>=0){
				btns[currentpage].gotoAndStop(1);
			}
			while(container.numChildren){
				container.removeChildAt(0);
			}
			currentpage=page;
			btns[currentpage].gotoAndStop(2);
			classes[page].show(container);
		}
	}
}