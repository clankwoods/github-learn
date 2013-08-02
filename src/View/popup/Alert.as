package View.popup
{
	import View.BaseWorld;
	
	import com.Lance.base.App;
	import com.Lance.dll.Dll;
	import com.module.control.Label;
	
	import controller.ControllerList;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public final class Alert
	{
		private static var bg:Sprite;
		private static var txtFeild:Label;
		private static var contrainer:Sprite;
		private static var btnOK:Sprite;
		private static var btnCancel:Sprite;
		
		public static const ALERT_OK:String = "alertOK";
		public static const ALERT_CANCEL:String = "alertCancel";
		public function Alert()
		{
			
		}
		
		private static function initEvent():void
		{
			contrainer.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected static function onClick(event:MouseEvent):void
		{
			switch(event.target.name)
			{
				case "btnOK":
				{
					ControllerList.getInstance().eventController.eventdispatcher.dispatchEvent(new Event(ALERT_OK));
					break;
				}
				case "btnCancel":
				{
					
					ControllerList.getInstance().eventController.eventdispatcher.dispatchEvent(new Event(ALERT_CANCEL));
					break;
				}
			}
			hide();
		}
		
		private static function removeEvent():void
		{
			contrainer.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private static function init():void
		{
			if( !contrainer) contrainer = new Sprite();
			contrainer.name = "alert";
			if (!bg) bg = Dll.getInstance().getDisplayObjectByName("PromptMcCls") as Sprite;
			with(contrainer.addChild( bg))
			{
				
			}
			if( !txtFeild) txtFeild = new Label(0,12,false);
			with( contrainer.addChild(txtFeild))
			{
				x = bg.width >> 1 - width >> 1;
				y = bg.height >> 1 - height >> 1;
				
			} 
			if(!btnOK) btnOK = Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			with(contrainer.addChild(btnOK))
			{
				x = 78;
				y = 124;
				name = "btnOK";
				mouseChildren = false;
				with( addChild(new Label(0,12,false)))
				{
					text = "确定";
					x = (parent.width  - width) / 2;
					y = (parent.height  - height)/2;
					mouseEnabled = false;
					mouseChildren = false;
				}
			}
			
			
			
			if(!btnCancel) btnCancel = Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			with(contrainer.addChild(btnCancel))
			{
				x = 216;
				y = 124;
				name = "btnCancel";
				mouseChildren = false;
				with( addChild(new Label(0,12,false)))
				{
					text = "取消";
					x = (parent.width  - width) / 2;
					y = (parent.height  - height)/2;
					mouseEnabled = false;
					mouseChildren = false;
				}
			}
		}
		
		public static function show(_text:String):void
		{
			if (!contrainer) 
			{
				init();
			}
			with(BaseWorld.getInstance().popLayer.addChild(contrainer))
			{
				x = (App.appStage.stageWidth - contrainer.width)/2;
				y = (App.appStage.stageHeight - contrainer.height)/2;
			}
			with(txtFeild)
			{
				text = _text;
				x = (bg.width >> 1) - (width >> 1);
				y = bg.height/3;
			}
			initEvent();
		}
		
		public static function hide():void
		{
			contrainer.parent.removeChild(contrainer);
			removeEvent();
		}
	}
}