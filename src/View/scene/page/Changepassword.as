package View.scene.page
{
	import com.Lance.base.App;
	import com.Lance.dll.Dll;
	import com.Lance.net.NetProxy;
	import com.adobe.serialization.json.JSON;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;
	
	import Model.AppData;
	
	public class Changepassword
	{
		private static var cp:Dictionary;
		public static var GRAY:ColorMatrixFilter=new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0,0.3086, 0.6094, 0.082, 0, 0,0.3086, 0.6094, 0.082, 0, 0,0, 0, 0, 1, 0]);
		public function Changepassword()
		{
		}
		public static function show(container:Sprite):void{
			if(!cp){
				cp=new Dictionary();
				var n:Number=300;
				var m:Number=n+10;
				var yy:Number=40;
				cp["oldP"]=getT(n,40+yy,"old password:",false);
				cp["newP"]=getT(n,80+yy,"new password:",false);
				cp["againP"]=getT(n,120+yy,"again password:",false);
				
				
				cp["oldPT"]=getT(m,40+yy,"",true);
				cp["newPT"]=getT(m,80+yy,"",true);
				cp["againPT"]=getT(m,120+yy,"",true);
				
				cp["btnsubmit"]=Dll.getInstance().getDisplayObjectByName("btnsubmit") as MovieClip;
				cp["btnsubmit"].buttonMode=true;
				cp["btnsubmit"].mouseChildren=false;
				cp["btnsubmit"].x=450;
				cp["btnsubmit"].y=215;
				cp["btnsubmit"].name="submit";
				function getT(_x:Number,_y:Number,text:String,_border:Boolean):TextField{
					var txt:TextField=new TextField();
					var tf:TextFormat=new TextFormat("Microsoft YaHei",18,0x666666);
					txt.defaultTextFormat=tf;
					txt.x=_x;
					txt.y=_y;
					txt.width=_border?200:0;
					txt.height=30;
					txt.border=_border;
					txt.borderColor=0xcccccc;
					txt.selectable=_border;
					txt.type=_border?TextFieldType.INPUT:TextFieldType.DYNAMIC;
					txt.displayAsPassword=_border;
					txt.autoSize=_border?TextFieldAutoSize.NONE:TextFieldAutoSize.RIGHT;
					txt.multiline=false;
					txt.text=text;
					return txt;
				}
			}
			for each(var dis:DisplayObject in cp){
				container.addChild(dis);
			}
			cp["oldPT"].text="";
			cp["newPT"].text="";
			cp["againPT"].text="";
			subminEnable(false);
			errorText(cp["againPT"],false);
			App.appStage.focus=cp["oldPT"];
			
		}
		public static function handler(event:Event):void{
			switch(event.type){
				case Event.CHANGE:
					errorText(cp["oldPT"],false);
					if(StringUtil.trim(cp["oldPT"].text).length>0&&StringUtil.trim(cp["newPT"].text).length>0&&StringUtil.trim(cp["againPT"].text).length>0){
						if(StringUtil.trim(cp["newPT"].text)==StringUtil.trim(cp["againPT"].text)){
							subminEnable(true);
							errorText(cp["againPT"],false);
						}
					}else{
						subminEnable(false);
					}
					break;
				case FocusEvent.FOCUS_OUT:
					focusOUT(event.target);
					if(StringUtil.trim(cp["oldPT"].text).length>0&&StringUtil.trim(cp["newPT"].text).length>0&&StringUtil.trim(cp["againPT"].text).length>0){
						if(StringUtil.trim(cp["newPT"].text)==StringUtil.trim(cp["againPT"].text)){
							subminEnable(true);
							errorText(cp["againPT"],false);
						}else{
							subminEnable(false);
							errorText(cp["againPT"],true);
						}
					}
					
					break;
				case FocusEvent.FOCUS_IN:
					focusIN(event.target);
					break;
				case MouseEvent.CLICK:
						if(event.target.name=="submit"){
							NetProxy.getInstance().execute("User/modifyPassword",[AppData.getInstance().data.user_id,StringUtil.trim(cp["oldPT"].text),StringUtil.trim(cp["newPT"].text)],function(result:Object):void{
								trace(JSON.encode(result));
								if(result.Status==101){
									cp["oldPT"].text="";
									cp["newPT"].text="";
									cp["againPT"].text="";
									subminEnable(false);
								}else if(result.Status==110){
									App.appStage.focus=cp["oldPT"];
									cp["oldPT"].text="";
									errorText(cp["oldPT"],true);
								}
							});
						}
					break;
			}
		}
		
		private static function focusOUT(target:Object):void
		{
			if(target.hasOwnProperty("text")){
				TextField(target).borderColor=0xcccccc;	
			}
		}
		
		private static function focusIN(target:Object):void
		{
			if(App.appStage.focus){
				if(App.appStage.focus.hasOwnProperty("text")){
					TextField(App.appStage.focus).borderColor=0x28A0D5;
				}
			}
		}
		private static function errorText(txt:TextField,value:Boolean):void{
			var color:uint=App.appStage.focus==txt?0x28A0D5:0xcccccc;
			txt.borderColor=value?0xff0000:color;
		}
		private static function subminEnable(value:Boolean):void{
			if(value){
				cp["btnsubmit"].mouseEnabled=true;
				cp["btnsubmit"].filters=[];
			}else{
				cp["btnsubmit"].mouseEnabled=false;
				cp["btnsubmit"].filters=[GRAY];
			}
		}
	}
}