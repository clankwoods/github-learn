package com.module.control
{
	import com.Lance.base.App;
	import com.Lance.dll.Dll;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public final class Button extends Sprite
	{
		private var up:Sprite;
		private var down:Sprite;
		private var click:Sprite;
		private var over:Sprite;
		
		private var fun:Function;
		private var label:Label;
		
		public function Button(name:String,onClick:Function)
		{
			this.name = name;
			fun = onClick;
		}
		private function initView():void
		{
			if( !up) up = Dll.getInstance().getDisplayObjectByName(name+"up") as Sprite;
			if( !down) down = Dll.getInstance().getDisplayObjectByName(name+"down") as Sprite;
			if( !click) click = Dll.getInstance().getDisplayObjectByName(name+"click") as Sprite;
			if( !over) over = Dll.getInstance().getDisplayObjectByName(name+"over") as Sprite;
			addChild(up);
			addChild(down);down.visible = false;
			addChild(click);click.visible = false;
			addChild(over);over.visible = false;
			
			if(!label) label = new TextField();
			with( addChild( label))
			{
				mouseEnabled = false;
				mouseChildren = false;
			}
		}
		
		public function showAs(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
			initEvent();
		}
		
		public function removeFrom():void
		{
			if( this.parent) this.parent.removeChild(this);
			removeEvent();
		}
		
		private function initEvent():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN,mouseHandler);
			addEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			addEventListener(MouseEvent.ROLL_OVER,mouseHandler);
			addEventListener(MouseEvent.MOUSE_OUT,mouseHandler);
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			if( event.type == MouseEvent.MOUSE_DOWN)
			{
				up.visible = false;
				down.visible = true;
				click.visible = false;
				over.visible = false;
			}
			else if( event.type == MouseEvent.MOUSE_UP)
			{
				up.visible = true;
				down.visible = false;
				click.visible = false;
				over.visible = false;
				if( fun) fun();
			}
			else if( event.type == MouseEvent.ROLL_OVER)
			{
				up.visible = false;
				down.visible = false;
				click.visible = false;
				over.visible = true;
			}
			else if( event.type == MouseEvent.MOUSE_OUT)
			{
				up.visible = true;
				down.visible = false;
				click.visible = false;
				over.visible = false;
			}
		}
		
		public function set isUsed(value:Boolean):void
		{
			this.mouseEnabled = value;
			this.mouseChildren = value;
			if( value ) filters = [];
			else filters = [App.GRAY];
		}
		
		public function set text(txt:String):void
		{
			label.text = txt;
			label.x = (this.width-label.width)/2;
			label.y = (this.height - label.height)/2;
			
		}
		
		public function set format(tFormat:TextFormat):void
		{
			label.defaultTextFormat = format;
		}
		
		private function removeEvent():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,mouseHandler);
			removeEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			removeEventListener(MouseEvent.ROLL_OVER,mouseHandler);
			removeEventListener(MouseEvent.MOUSE_OUT,mouseHandler);
		}
	}
}