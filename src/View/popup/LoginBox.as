/**
 zheng
 LoginBox.as
 2013-7-25下午8:06:42
 **/
package View.popup
{
	import com.Lance.base.App;
	import com.Lance.dll.Dll;
	import com.Lance.net.NetProxy;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.utils.StringUtil;
	
	import Model.AppData;
	
	import View.BaseWorld;
	
	
	public class LoginBox extends Sprite
	{
		private var loginBox:CDMask;
		private var txtid:TextField;
		private var txtpassword:TextField;
		private var btnLogin:MovieClip;
		private var success:Function;
		private var isregester:Boolean=false;
		private var policy:TextField;		
		public var GRAY:ColorMatrixFilter=new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0,0.3086, 0.6094, 0.082, 0, 0,0.3086, 0.6094, 0.082, 0, 0,0, 0, 0, 1, 0]);
		public function LoginBox(_isregester:Boolean=false)
		{
			super();
			isregester=_isregester;
			init();
		}
		private function init():void{
			loginBox=new CDMask(Dll.getInstance().getDisplayObjectByName("loginBox") as DisplayObject,complete);
			
			btnLogin=Dll.getInstance().getDisplayObjectByName(isregester?"BtnRegister":"BtnLogin") as MovieClip;
			mouseEnabled=loginBox.mouseEnabled=false;
			addChild(loginBox);
			loginBox.x=-loginBox.width>>1;
			loginBox.y=-loginBox.height>>1;
			txtid=loginBox.icon.getChildByName("txtid") as TextField;
			txtpassword=loginBox.icon.getChildByName("txtpassword") as TextField;
			txtpassword.displayAsPassword=true;
			addChild(btnLogin);
			btnLogin.name=isregester?"btnRegister":"btnLogin";
			btnLogin.x=isregester?63:77;
			btnLogin.y=38;
			enableBtn(false);
			if(isregester){
				policy=new TextField();
				policy.name="policy";
				policy.selectable=false;
				policy.autoSize=TextFieldAutoSize.LEFT;
				policy.htmlText="<b><font color='#ffffff'>I agree to the </font><font color='#4ABCF0'><i><a href='http://www.baidu.com'>Privacy Policy</a></i></font></b>";
				policy.y=38;
				policy.x=-100;
				addChild(policy);
				

			}
		}
		private function enableBtn(value:Boolean):void{
			if(value){
				btnLogin.buttonMode=true;
				btnLogin.filters=[];
			}else{
				btnLogin.buttonMode=false;
				btnLogin.filters=[GRAY];
			}
		}
		private function clickHandler(event:MouseEvent):void{
			switch(event.target.name){
				case "modeLayer":
						hide();
					break;
				case "btnRegister":
					if(btnLogin.buttonMode){
						regiester();
					}
					break;
				case "btnLogin":
					if(btnLogin.buttonMode){
						login();
					}
					break;
			}
		}
		private function regiester():void{
			removeEvent();
			txtid.tabEnabled=txtid.selectable=false;
			txtpassword.tabEnabled=txtpassword.selectable=false;
			enableBtn(false);
			NetProxy.getInstance().execute("User/register",[StringUtil.trim(txtid.text),StringUtil.trim(txtpassword.text)],function(result:Object):void{
				if(result.Status==101){
					if(success!=null){
						//									AppData.getInstance().data=result.value;
						//									success();
						login();
					}
					hide();
				}else{
					App.appStage.focus=txtpassword;
					txtpassword.border=true;
					txtpassword.borderColor=0x28A0D5;
					addEvent();
				}
				txtid.tabEnabled=txtid.selectable=true;
				txtpassword.tabEnabled=txtpassword.selectable=true;
				enableBtn(true);
			});
		}
		private function login():void{
			removeEvent();
			txtid.tabEnabled=txtid.selectable=false;
			txtpassword.tabEnabled=txtpassword.selectable=false;
			enableBtn(false);
			NetProxy.getInstance().execute("User/login",[StringUtil.trim(txtid.text),StringUtil.trim(txtpassword.text)],function(result:Object):void{
				//							trace("__________________");
				//							trace(JSON.encode(result));
				if(result.Status==101){
					if(success!=null){
						AppData.getInstance().data=result.value;
						success();
					}
					hide();
				}else{
					App.appStage.focus=txtpassword;
					txtpassword.border=true;
					txtpassword.borderColor=0x28A0D5;
					addEvent();
				}
				txtid.tabEnabled=txtid.selectable=true;
				txtpassword.tabEnabled=txtpassword.selectable=true;
				enableBtn(true);
			});
		}
		private function focusHandler(event:FocusEvent):void{
			if(event.target.name=="policy"){return;}
			if(event.type==FocusEvent.FOCUS_IN){
				event.target.border=true;
				event.target.borderColor=0x28A0D5;
			}else if(event.type==FocusEvent.FOCUS_OUT){
				event.target.border=false;
			}
		}
		private function changeHandler(event:Event):void{
			if(StringUtil.trim(txtid.text).length>0&&StringUtil.trim(txtpassword.text).length){
				enableBtn(true);
			}else{
				enableBtn(false);
			}
		}
		private function addEvent():void{
			addEventListener(MouseEvent.CLICK,clickHandler);
			addEventListener(FocusEvent.FOCUS_OUT,focusHandler);
			addEventListener(FocusEvent.FOCUS_IN,focusHandler);
			BaseWorld.getInstance().modeLayer.addEventListener(MouseEvent.CLICK,clickHandler);
			addEventListener(Event.CHANGE,changeHandler);
		}
		private function removeEvent():void{
			removeEventListener(MouseEvent.CLICK,clickHandler);
			removeEventListener(FocusEvent.FOCUS_OUT,focusHandler);
			removeEventListener(FocusEvent.FOCUS_IN,focusHandler);
			BaseWorld.getInstance().modeLayer.removeEventListener(MouseEvent.CLICK,clickHandler);
			removeEventListener(Event.CHANGE,changeHandler);
		}
		private var isShowing:Boolean=false;
		public function show(_success:Function):void{
			if(isShowing){
				return;
			}
			isShowing=true;
			success=_success;
			BaseWorld.getInstance().popLayer.addChild(this);
			loginBox.addEventListener("loginBoxstoped",loginBoxstopedHandler);
			function loginBoxstopedHandler(event:Event):void{
				loginBox.removeEventListener("loginBoxstoped",loginBoxstopedHandler);
				isShowing=false;
			}
			loginBox.play();
			stage.focus = txtid;
			txtid.border=true;
			txtid.borderColor=0x28A0D5;
			
			//test
			txtid.text="wuzheng";
			txtpassword.text="123456";
			enableBtn(true);
		}
		private function hide():void{
			if(parent){
				parent.removeChild(this);
				BaseWorld.getInstance().modeLayer.visible=false;
				removeEvent();
			}
		}
		private function complete():void{
			BaseWorld.getInstance().modeLayer.visible=true;
			addEvent();
		}
	}
}