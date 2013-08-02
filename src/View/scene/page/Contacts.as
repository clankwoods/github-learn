package View.scene.page
{
	import com.Lance.dll.Dll;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.utils.StringUtil;
	
	public class Contacts extends Sprite
	{
		private var contacts:Sprite;
		public static var GRAY:ColorMatrixFilter=new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0,0.3086, 0.6094, 0.082, 0, 0,0.3086, 0.6094, 0.082, 0, 0,0, 0, 0, 1, 0]);
		public function Contacts()
		{
			super();
			contacts=Dll.getInstance().getDisplayObjectByName("Contacts") as Sprite;
			addChild(contacts);mouseEnabled=false;
			Sprite(contacts.getChildByName("btnSend")).mouseChildren=Sprite(contacts.getChildByName("btnReset")).mouseChildren=false;
			Sprite(contacts.getChildByName("btnSend")).buttonMode=Sprite(contacts.getChildByName("btnReset")).buttonMode=true;
			TextField(Sprite(contacts.getChildByName("btnSend")).getChildByName("txt")).text="send";
			TextField(Sprite(contacts.getChildByName("btnReset")).getChildByName("txt")).text="reset";
			addEventListener(MouseEvent.CLICK,clickHandler);
			addEventListener(FocusEvent.FOCUS_IN,focusHandler);
			addEventListener(FocusEvent.FOCUS_OUT,focusHandler);
			addEventListener(Event.ADDED,addHandler);
			addEventListener(Event.CHANGE,chnageHandler);
		}
		private function chnageHandler(event:Event):void{
			if(StringUtil.trim(TextField(contacts.getChildByName("txtMessage")).text).length>0&&TextField(contacts.getChildByName("txtMessage")).defaultTextFormat.color==0x000000){
				Sprite(contacts.getChildByName("btnSend")).mouseEnabled=true;
				Sprite(contacts.getChildByName("btnSend")).filters=[];
				Sprite(contacts.getChildByName("btnReset")).mouseEnabled=true;
				Sprite(contacts.getChildByName("btnReset")).filters=[];
			}else{
				Sprite(contacts.getChildByName("btnSend")).mouseEnabled=false;
				Sprite(contacts.getChildByName("btnSend")).filters=[GRAY];
				Sprite(contacts.getChildByName("btnReset")).mouseEnabled=false;
				Sprite(contacts.getChildByName("btnReset")).filters=[GRAY];
			}
		}
		private function addHandler(event:Event):void{
			chnageHandler(null);
			var tf:TextFormat=new TextFormat(null,14,0xcccccc);
			with(TextField(contacts.getChildByName("txtTitle"))){
				defaultTextFormat=tf;
				text="title";
				border=false;
			}
			with(TextField(contacts.getChildByName("txtContact"))){
				defaultTextFormat=tf;
				text="contacts";
				border=false;
			}
			with(TextField(contacts.getChildByName("txtMessage"))){
				defaultTextFormat=tf;
				text="message...";
				border=false;
			}
		}
		protected function focusHandler(event:FocusEvent):void
		{
			if(event.type==FocusEvent.FOCUS_IN){
				if(event.target.hasOwnProperty("text")){
					if(TextField(event.target).defaultTextFormat.color!=0x000000){
						TextField(event.target).defaultTextFormat=new TextFormat(null,14,0x000000);
						TextField(event.target).text="";
					}
					TextField(event.target).borderColor=0x28A0D5;
					TextField(event.target).border=true;
				}
			}else{
				if(event.target.hasOwnProperty("text")){
					TextField(event.target).border=false;
				}
			}
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			trace(event.target.name);
//			btnReset
//			btnSend
			switch(event.target.name){
				case "btnReset":
					addHandler(null);
					break;
				case "btnSend":
					if(StringUtil.trim(TextField(contacts.getChildByName("txtMessage")).text).length>0&&TextField(contacts.getChildByName("txtMessage")).defaultTextFormat.color==0x000000){
						//send
					}
					break;
			}
		}
	}
}