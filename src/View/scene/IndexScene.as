package View.scene
{
	import com.Lance.dll.Dll;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import View.BaseWorld;
	import View.interfaces.IScene;
	import View.scene.page.About;
	import View.scene.page.Contacts;
	import View.scene.page.WatchList;
	
	public class IndexScene extends Sprite implements IScene
	{
		/**
		 *存放当前item和itemicon 
		 */		
		private var items:Array;
		private var item:MovieClip;
		/**
		 *存放item按钮 
		 */		
		private var btns:Vector.<MovieClip>;
		
		/**
		 *背景 
		 */		
		private var background_textareas:Dictionary;
		/**
		 *当前使用中的背景 
		 */		
		private var currentbackground:MovieClip;
		/**
		 *设计模式开场动画 
		 */		
		private var desinshow:MovieClip;
		/**
		 *设计页面 
		 */		
		private var desinPage:DesinPage;
		/**
		 *个人信息页面 
		 */		
		private var infoPage:InfoPage;
		/**
		 *测试 
		 */		
		private var textarea:TextField;
		/**
		 *全局INDEX 
		 */		
		private var i:int=0;
		/**
		 *是否动画过程中 
		 */		
		public var isAnimationing:Boolean=false;
		/**
		 *是否关闭按钮图标 
		 */		
		private var isCloseIcon:Boolean=false;
		
		private var test:Boolean=false;
		/**
		 *一行几个 
		 */
		private const N:int=4;
		
		private const ITEM_WH:int=160;
		
		public var isDesin:Boolean=false;
		public var isShowMyInfo:Boolean=false;
		public var isIndex:Boolean=false;
		private var pages:Dictionary;
		
		public function IndexScene()
		{
			super();
		}
		
		public function showAs(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
		}
		
		public function removeFrom(parent:DisplayObjectContainer):void
		{
		}
		
		public function getSceneSize():Point
		{
			return null;
		}
		
		public function onEnter():void
		{
			initGraphics();
		}
		
		public function onEnterTransformDie():void
		{
		}
		
		public function onExit():void
		{
			removeEvent();
		}
		
		public function onExitTransformDie():void
		{
		}
		/**
		 * 初始化item 
		 */		
		private function initGraphics():void{
			if(!items){
				items=[];
				btns=new Vector.<MovieClip>;
				var strs:Array=["about.jpg","watchList_icon.jpg","design.jpg","contacts_icon.jpg","about_icon.jpg","watchList.jpg","design_icon.jpg","contacts.jpg"];
				var m:int=0;
				var item:Bitmap;
				var itemshow:MovieClip;
				for(var i:int=0;i<strs.length;i++){
					var str:String=strs[i];
					item=new Bitmap(Dll.getInstance().getDisplayObjectByName(str) as BitmapData);
					itemshow=Dll.getInstance().getDisplayObjectByName("itemshow") as MovieClip;
					itemshow.gotoAndStop(1);
					itemshow.mouseChildren=false;
					itemshow.img.addChildAt(item,0);
					itemshow.x=((i%N)-2)*ITEM_WH;
					itemshow.y=((i/N>>0)-1)*ITEM_WH;
					if(str.indexOf("icon")==-1){
						btns.push(itemshow);
						itemshow.buttonMode=true;
					}
					itemshow.name=strs[i];
					items.push(itemshow);
					itemshow.tabEnabled=false;
				}
			}
			showIndexItem([]);
		}
		/**
		 *显示动画item 
		 * 
		 */		
		public function showIndexItem(param:Array):void{
			if(isAnimationing)return;
			if(isIndex){return;}
			isIndex=true;
			isAnimationing=true;
			removeEvent();
			i=0;
			var uid:uint=setInterval(intervalHandler,100);
			function intervalHandler():void{
				if(i<items.length){
					item=items[i++];
					addChild(item) as MovieClip;
					item.alpha=1;
					item.filters=[];
					item.gotoAndPlay(1);
					if(i==items.length){//最后一个动画结尾
						item.addEventListener("showed",showed);
					}
				}else{
					clearInterval(uid);
					
				}
			}
			function showed(event:Event):void{
				event.currentTarget.removeEventListener("showed",showed);
				isAnimationing=false;
				addEvent();
			}
		}
		/**
		 *关闭item 
		 * @param showOther 关闭后执行的方法
		 * 
		 */		
		private function closeIndexItem(showOther:Function=null,...param):void{
			if(isAnimationing)return;
			isAnimationing=true;
			isIndex=false;
			removeEvent();
			i=0;
			var uid:uint=setInterval(intervalHandler,100);
			function intervalHandler():void{
				if(i<items.length){
					item=items[i++];
					//					addChild(item);
					item.filters=[];
					item.gotoAndPlay("startclose");
					if(i==items.length){//最后一个动画结尾
						item.addEventListener("closed",closed);
					}
				}else{
					clearInterval(uid);
					
				}
			}
			function closed(event:Event):void{
				event.currentTarget.removeEventListener("closed",closed);
				isAnimationing=false;
				for each(item in items){
					if(item.parent){
						item.parent.removeChild(item);
					}
				}
				if(showOther!=null){
					showOther(param);
				}
			}
		}
		/**
		 *添加事件 
		 * 
		 */		
		private function addEvent():void{
			addEventListener(MouseEvent.CLICK,clickHandler,true);
			addEventListener(MouseEvent.MOUSE_OVER,focusHandler,true);
			addEventListener(MouseEvent.MOUSE_OUT,focusHandler,true);
			BaseWorld.getInstance().uiLayer.addEventListener("signout_Success",signout_successHandler);
		}
		/**
		 *退出登录后 
		 * @param event
		 * 
		 */		
		private function signout_successHandler(event:Event):void{
			if(isShowMyInfo){
				closeMyInfo(showIndexItem,[]);
			}
		}
		private function removeEvent():void{
			removeEventListener(MouseEvent.CLICK,clickHandler,true);
			removeEventListener(MouseEvent.MOUSE_OVER,focusHandler,true);
			removeEventListener(MouseEvent.MOUSE_OUT,focusHandler,true);
			BaseWorld.getInstance().uiLayer.removeEventListener("signout_Success",signout_successHandler);
		}
		
		private function focusHandler(event:MouseEvent):void{
			if(isAnimationing){
				return;
			}
			if(btns.indexOf(event.target)==-1){
				return;
			}
			if(event.type==MouseEvent.MOUSE_OVER){
				var target:int=items.indexOf(event.target);
				for(var i:int;i<items.length;i++){
					if(target==i||target==-1){
						items[i].filters=[];
					}else{
						items[i].filters=[new ColorMatrixFilter([
							0,.5,0,0,0,
							0,0,.5,0,0,
							0,0,0,.5,0,
							0,0,0,1,0 
						])];
					}
				}
			}else{
				clearFilters();
			}
		}
		private function clickHandler(event:MouseEvent):void{
			if(isAnimationing){
				return;
			}
			if(btns.indexOf(event.target)==-1){
				return;
			}
			if(!pages){
				pages=new Dictionary();
				pages["Contacts"]=new Contacts();
				pages["About"]=new About();
				pages["watchList"]=new WatchList();
			}
			
//			with(m3.graphics){
//				beginFill(0x0000ff);
//				drawRect(0,0,580,300);
//				endFill();
//			}
			switch(event.target.name){
				case "about.jpg":
					closeIcon("background_textarea2",pages["About"]);
					break;
				case "watchList.jpg":
					closeIcon("background_textarea",pages["watchList"]);
					break;
				case "design.jpg":
					clearscreen(showDesin,[]);
					break;
				case "contacts.jpg":
					closeIcon("background_textarea2",pages["Contacts"]);
					break;
			}
		}
		public function showMyInfo(page:int):void{
			if(isShowMyInfo){
				infoPage.showPageBtn(page);
				return;
			}
			isShowMyInfo=true;
			isAnimationing=true;
			removeEvent();
			if(!desinshow){
				desinshow=Dll.getInstance().getDisplayObjectByName("pageshow") as MovieClip;
			}
			if(!infoPage){
				infoPage=new InfoPage();
			}
			addChild(desinshow);
			desinshow.addEventListener("stoped",stoped);
			desinshow.gotoAndPlay(1);
			desinshow.x=-desinshow.width>>1;
			desinshow.y=-desinshow.height>>1;
			function stoped(event:Event):void{
				desinshow.removeEventListener("stoped",stoped);
				infoPage.width=desinshow.width;
				infoPage.height=desinshow.height;
				infoPage.x=-infoPage.width>>1;
				infoPage.y=-infoPage.height>>1;
				addChild(infoPage);
				if(desinshow.parent){
					desinshow.parent.removeChild(desinshow);
				}
				infoPage.showPageBtn(page);
				infoPage.filters=[new BlurFilter(100)];
				TweenMax.to(infoPage,.5,{blurFilter:{blurX:0,blurY:0},x:-918>>1,y:-510>>1,width:918,height:510,onComplete:onComp});
			}
			function onComp():void{
				isAnimationing=false;
				addEvent();
			}
		}
		public function closeMyInfo(showOther:Function,param:Array):void{
			if(infoPage){
				TweenMax.to(infoPage,.5,{blurFilter:{blurX:100,blurY:0},x:desinshow.x,y:desinshow.y,width:desinshow.width,height:desinshow.height,onComplete:onComp});
			}
			function onComp():void{
				
				desinshow.addEventListener("closestoped",closestopedHandler);
				addChild(desinshow);
				desinshow.gotoAndPlay("closeDesin");
				if(infoPage.parent){
					infoPage.parent.removeChild(infoPage);	
				}
			}
			function closestopedHandler(event:Event):void{
				isShowMyInfo=false;
				desinshow.removeEventListener("closestoped",closestopedHandler);
				if(showOther!=null){
					showOther(param);
				}
			}
		}
		private function showDesin(param:Array):void{
			isDesin=true;
			isAnimationing=true;
			removeEvent();
			if(!desinshow){
				desinshow=Dll.getInstance().getDisplayObjectByName("pageshow") as MovieClip;
			}
			if(!desinPage){
				desinPage=new DesinPage();
			}
			addChild(desinshow);
			desinshow.addEventListener("stoped",stoped);
			desinshow.gotoAndPlay(1);
			desinshow.x=-desinshow.width>>1;
			desinshow.y=-desinshow.height>>1;
			function stoped(event:Event):void{
				desinshow.removeEventListener("stoped",stoped);
				desinPage.width=desinshow.width;
				desinPage.height=desinshow.height;
				desinPage.x=-desinPage.width>>1;
				desinPage.y=-desinPage.height>>1;
				addChild(desinPage);
				if(desinshow.parent){
					desinshow.parent.removeChild(desinshow);
				}
				desinPage.filters=[new BlurFilter(100)];
				TweenMax.to(desinPage,.5,{blurFilter:{blurX:0,blurY:0},x:-918>>1,y:-510>>1,width:918,height:510,onComplete:onComp});
			}
			function onComp():void{
				isAnimationing=false;
				addEvent();
			}
		}
		private function closeDesin(showOther:Function,param:Array):void{
			if(desinPage){
				TweenMax.to(desinPage,.5,{blurFilter:{blurX:100,blurY:0},x:desinshow.x,y:desinshow.y,width:desinshow.width,height:desinshow.height,onComplete:onComp});
			}
			function onComp():void{
				
				desinshow.addEventListener("closestoped",closestopedHandler);
				addChild(desinshow);
				desinshow.gotoAndPlay("closeDesin");
				if(desinPage.parent){
					desinPage.parent.removeChild(desinPage);	
				}
			}
			function closestopedHandler(event:Event):void{
				desinshow.removeEventListener("closestoped",closestopedHandler);
				isDesin=false;
				if(showOther!=null){
					showOther(param);
				}
			}
		}
		public function clearscreen(showother:Function,param:Array):void{
			if(isCloseIcon){
				closePage(openIcon,param);
			}else if(isDesin){
				closeDesin(showother,param);
			}else if(isShowMyInfo){
				closeMyInfo(showother,param);
			}else{
				closeIndexItem(showother,param);
			}
			function openIcon():void{
				if(!isCloseIcon){
					return;
				}
				isCloseIcon=false;
				clearFilters();
				isAnimationing=true;
				TweenMax.allTo(items,.5,{y:(-ITEM_WH),ease:Back.easeInOut},0,onComplete);
				function onComplete():void{
					TweenMax.allTo(items.slice(4,8),.5,{y:0,ease:Back.easeInOut},.1,function():void{
						isAnimationing=false;
						closeIndexItem(showother,param);
					});
				}
			}
		}
		/**
		 *关闭item的icon 
		 * @param show,执行的方法
		 * @param type
		 * @param content
		 * 
		 */		
		private function closeIcon(type:String="",content:DisplayObject=null):void{
			if(isAnimationing){
				return;
			}
			if(isCloseIcon){
				isAnimationing=false;
				showPage(type,content);
				return;
			}
			isAnimationing=true;
			isCloseIcon=true;
			if(getChildIndex(items[4])>getChildIndex(items[0])){swapChildren(items[4],items[0]);}
			if(getChildIndex(items[6])>getChildIndex(items[2])){swapChildren(items[6],items[2]);}
			clearFilters();
			TweenMax.allTo(items.slice(4,8),.5,{y:items[0].y,ease:Back.easeInOut},.1,onComplete);
			function onComplete():void{
				TweenMax.allTo(items,.5,{y:-ITEM_WH*1.5,ease:Back.easeInOut},0,_show);
			}
			function _show():void{
				isAnimationing=false;
				showPage(type,content);
			}
		}
		
		
		private function closePage(show:Function,param:Array):void{
			if(currentbackground){
				currentbackground.gotoAndPlay("closestart");
				if(!currentbackground.hasEventListener("closed")){
					currentbackground.addEventListener("closed",closeed);
				}
			}
			function closeed(event:Event):void{
				currentbackground.removeEventListener("closed",closeed);
				currentbackground.parent.removeChild(currentbackground);
				currentbackground=null;
				if(show!=null){
					if(param.length){
						show.call(param);
					}else{
						show.call();
					}
					
				}
			}
		}
		private function showPage(type:String,content:DisplayObject):void{
			if(isAnimationing){
				return;
			}
			clearFilters();
			isAnimationing=true;
			if(currentbackground){
				closePage(show,[]);
			}else{
				show();
			}
			function show(event:Event=null):void{
				if(event)event.currentTarget.removeEventListener("closed",show);
				if(!background_textareas){
					background_textareas=new Dictionary();
				}
				if(!background_textareas[type]){
					background_textareas[type]=Dll.getInstance().getDisplayObjectByName(type) as MovieClip;
					background_textareas[type].x=items[0].x;
					background_textareas[type].y=items[0].y+ITEM_WH;
				}
				if(currentbackground){
					currentbackground.parent.removeChild(currentbackground);
				}
				currentbackground=addChild(background_textareas[type]) as MovieClip;
				if(content){
					while(currentbackground.txt.numChildren){
						currentbackground.txt.removeChildAt(0);
					}
					currentbackground.txt.addChild(content);
				}
				currentbackground.gotoAndPlay(1);
				isAnimationing=false;
			}
		}
		private function clearFilters():void{
			for(i=0;i<items.length;i++){
				items[i].filters=[];
			}
		}
	}
}