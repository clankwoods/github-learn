package View
{
	import com.Lance.dll.Dll;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import Model.AppData;
	
	import View.popup.LoginBox;
	
	import controller.ControllerList;
	
	public final class UIView extends Sprite
	{
		private var coutomerBtn:Sprite;
		private var myCompanyBtn:Sprite;
		private var bankBtn:Sprite;
		private var powerBtn:Sprite;
		private var warehouseBtn:Sprite;
		private var financeBtn:Sprite;
		private var groupBtn:Sprite;
		private var playerBtn:Sprite;
		private var personalInfoBtn:Sprite;
		private var macrosBtn:Sprite;
		private var rankBtn:Sprite;
		private var emailBtn:Sprite;
		private var tradingCenterBtn:Sprite;
		private var myInsuranceBtn:Sprite;
		private var statisticsBtn:Sprite;
		
		
		private var loginBox:LoginBox; 
		private var registerBox:LoginBox;
		private var login_register:MovieClip;
		private var signout:MovieClip;
		public function UIView()
		{
			init();
		}
		
		private function init():void
		{
			this.mouseEnabled=false;
			graphics.lineStyle(0,0,0);
			graphics.drawRect(0,0,960,700);
			graphics.endFill();
			loginBox=new LoginBox();
			registerBox=new LoginBox(true);
			var logo:Bitmap=new Bitmap(Dll.getInstance().getDisplayObjectByName("logo.png") as BitmapData);
			var logoSp:Sprite=new Sprite();
			
			var sounds:MovieClip=Dll.getInstance().getDisplayObjectByName("sounds") as MovieClip;
			var fullscreen:MovieClip=Dll.getInstance().getDisplayObjectByName("fullScreen") as MovieClip;
			login_register=Dll.getInstance().getDisplayObjectByName("login_register") as MovieClip;
			login_register.login.mouseChildren=false;
			login_register.register.mouseChildren=false;
			addChild(login_register);
			logoSp.addChild(logo);
			logoSp.name="logo";
			logoSp.buttonMode=true;
			addChild(logoSp);
			login_register.y=logoSp.x=logoSp.y=30;
			login_register.x=width-login_register.width-30;
			MovieClip(login_register.getChildByName("login")).buttonMode=MovieClip(login_register.getChildByName("register")).buttonMode=true;
			addChild(sounds).name="sounds";
			addChild(fullscreen).name="fullscreen";
			sounds.buttonMode=fullscreen.buttonMode=true;
			sounds.x=width-sounds.width-60;
			sounds.y=height-sounds.height-30;
			fullscreen.x=width-fullscreen.width-30;
			fullscreen.y=height-fullscreen.height-30;
			addEventListener(MouseEvent.CLICK,clickHandler);
			addEventListener(MouseEvent.MOUSE_OVER,focusHandler);
			addEventListener(MouseEvent.MOUSE_OUT,focusHandler);
		}
		public function loginShow():void{
			loginBox.show(success);
			
		}
		private function focusHandler(event:MouseEvent):void{
			var tf:TextFormat;
			if(event.type==MouseEvent.MOUSE_OVER){
				if(event.target.hasOwnProperty("txt")){
					tf=new TextFormat();
					tf.color=event.target.name=="login"||event.target.name=="register"?0x3271b8:0x28A0D5;
					event.target.txt.setTextFormat(tf);
				}
				
			}else if(event.type==MouseEvent.MOUSE_OUT){
				if(event.target.hasOwnProperty("txt")){
					tf=new TextFormat();
					tf.color=event.target.name=="login"||event.target.name=="register"?0x434343:0xffffff;
					event.target.txt.setTextFormat(tf);
					
				}
			}else if(event.type==MouseEvent.ROLL_OVER){
				showInfoList();
			}else if(event.type==MouseEvent.ROLL_OUT){
				closeInfoList();
			}
		}
		
		private function closeInfoList():void
		{
			TweenMax.to(signout.list,.1,{height:0,alpha:0});
		}
		
		private function showInfoList():void
		{
			TweenMax.to(signout.list,.1,{height:140,alpha:1});
		}
		private function clickHandler(event:MouseEvent):void{
			switch(event.target.name)
			{
				case "sounds":
					if(SoundMixer.soundTransform.volume>0){
						SoundMixer.soundTransform=new SoundTransform(0);
						event.target.gotoAndStop(2);
					}else{
						SoundMixer.soundTransform=new SoundTransform(1);
						event.target.gotoAndStop(1);
					}
					break;
				case "fullscreen":
					if(stage.displayState==StageDisplayState.FULL_SCREEN){
						stage.displayState=StageDisplayState.NORMAL;
					}else{
						stage.displayState=StageDisplayState.FULL_SCREEN;
					}
					break;
				case "login":
					loginBox.show(success);
					break;
				case "register":
					registerBox.show(success);
					break;
				case "btn_mydesins":
					closeInfoList();
					if(ControllerList.getInstance().sceneController.isAnimationing){
						return;
					}
					ControllerList.getInstance().sceneController.showMyInfo(0);
					break;
				case "btn_mycollections":
					closeInfoList();
					if(ControllerList.getInstance().sceneController.isAnimationing){
						return;
					}
					ControllerList.getInstance().sceneController.showMyInfo(1);
					break;
				case "btn_upload":
					closeInfoList();
					if(ControllerList.getInstance().sceneController.isAnimationing){
						return;
					}
					ControllerList.getInstance().sceneController.showMyInfo(2);
					break;
				case "btn_changepassword":
					closeInfoList();
					if(ControllerList.getInstance().sceneController.isAnimationing){
						return;
					}
					ControllerList.getInstance().sceneController.showMyInfo(3);
					break;
				case "btn_address":
					closeInfoList();
					if(ControllerList.getInstance().sceneController.isAnimationing){
						return;
					}
					ControllerList.getInstance().sceneController.showMyInfo(4);
					break;
				case "btn_signout":
					closeInfoList();
					if(ControllerList.getInstance().sceneController.isAnimationing){
						return;
					}
					if(signout){
						signout.parent.removeChild(signout);
					}
					if(login_register){
						addChild(login_register);
					}
					AppData.getInstance().data=null;
					dispatchEvent(new Event("signout_Success"));
					break;
				case "logo":
					ControllerList.getInstance().sceneController.clear();
					break;
			}
			var tf:TextFormat;
			if(event.target.hasOwnProperty("txt")){
				tf=new TextFormat();
				tf.color=0x434343;
				event.target.txt.setTextFormat(tf);
				
			}
		}
		private var btns:Array;
		private function success():void{
			if(login_register.parent){
				login_register.parent.removeChild(login_register);
			}
			
			if(!signout){
				btns=[];
				signout=Dll.getInstance().getDisplayObjectByName("signout") as MovieClip;
				signout.addEventListener(MouseEvent.ROLL_OVER,focusHandler);
				signout.addEventListener(MouseEvent.ROLL_OUT,focusHandler);
				for(var i:int=1;i<signout.list.numChildren;i++){
					var btn:MovieClip=signout.list.getChildAt(i) as MovieClip;
					if(btn){
						btn.buttonMode=true;
						btn.mouseChildren=false;
						btns.push(btn);
					}
				}
				closeInfoList();
			}
			TextField(signout.txtname).autoSize=TextFieldAutoSize.RIGHT;
			signout.txtname.text=AppData.getInstance().data.user_name;
			addChild(signout);
			signout.y=30;
			signout.x=960-30;
			dispatchEvent(new Event("login_Success"));
		}
	}
}