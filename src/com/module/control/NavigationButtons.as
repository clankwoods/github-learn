package com.module.control
{
	import com.Lance.dll.Dll;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	public final class NavigationButtons extends Sprite
	{
		private var btnList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var _btnCount:uint;
		private var _btnLinkName:String;
		private var _containerLinkName:String
		private var _w:Number;
		private var _h:Number;
		private var current:ViewArea;
		
		public function NavigationButtons(btnNum:uint = 1,btnLinkName:String = "DisplayBut",containerLinkName:String = "",W:Number = 300,H:Number = 300)
		{
			_btnCount = btnNum;
			_btnLinkName = btnLinkName;
			_containerLinkName = containerLinkName;
			_w = W;
			_h = H;
			init();
			initEvent();
//			mouseEnabled = false;
		}
		
		private function initEvent():void
		{
			addEventListener(MouseEvent.CLICK, onClick);
		}
		private function removeEvent():void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var clickPos:Point = new Point( event.localX,event.localY);
			for each (var sp:MovieClip in btnList) 
			{
				if(inRect(clickPos,sp.getRect(this)))
				{
					sp.gotoAndStop(1);
					sp.container.visible = true;
					sp.container.y = sp.height;
					current = sp.container
				}
				else
				{
					sp.gotoAndStop(2);
					sp.container.visible = false;
				}
			}
			
		}
		private function inRect(pos:Point, rect:Rectangle):Boolean
		{
			if( pos.x > rect.x && pos.x <= (rect.x+rect.width))
			{
				if(  pos.y > rect.y && pos.y <= (rect.y+rect.height) )
				{
					return true;
				}
			}
			return false;
		}
		
		private function init():void
		{
			var h:Number ;
			for (var i:int = 0; i < _btnCount; i++) 
			{
				var tmp:MovieClip = Dll.getInstance().getDisplayObjectByName(_btnLinkName) as MovieClip;
				with(addChild(tmp))
				{
					x = width * i + 10;
					name = "btnNav"+ i;
					gotoAndStop(i==0?1:2);
					h = height;
					mouseChildren = false;
				}
				with(tmp.getChildByName("butName"))
				{
					mouseEnabled = false;
					mouseChildren = false;
				}
				initContainer(_containerLinkName,tmp);
				btnList.push( tmp );
			}
			btnList[0].container.visible = true;
			current = btnList[0].container;
			
		}
		public function set container(linkName:String):void
		{
			this._containerLinkName = linkName;
			for each (var i:MovieClip in btnList) 
			{
				initContainer(linkName,i);
			}
			
		}
		
		
		private function initContainer(linkName:String,btn:MovieClip):void
		{
			var _container:ViewArea = new ViewArea(_w,_h,linkName);
			with( addChild(_container))
			{
				y = btn.height -5;
				x = 0;
				visible = false;
			}
			btn.container =  _container;
		}
		
//		public function set btnSkin(linkName:String)void
//		{
//			for (var i:int = 0; i < _btnCount; i++) 
//			{
//				var tmp:Sprite = Dll.getInstance().getDisplayObjectByName(_btnLinkName) as MovieClip;
//				with(addChild(tmp))
//				{
//					x = width * i + 10;
//					name = "btnNav"+ i;
//					gotoAndStop(i==0?1:2);
//					h = height;
//				}
//				btnList.push( tmp );
//			}
//		}
//		
//		private function destoryBtn():void
//		{
//			for each (var i:int in btnList) 
//			{
//				
//			}
//			
//		}
		public function get length():Number
		{
			return btnList.length;
		}
		public function setBtnNameByIndex(index:uint, _text:String):void
		{
			(btnList[index].getChildByName("butName")as TextField).text = _text;
		}
		
		public function getView():ViewArea
		{
			return current;
		}
	}
}