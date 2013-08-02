package com.module.control
{
	import com.Lance.dll.Dll;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public final class ViewArea extends Sprite 
	{
		private var _container:Sprite;
		private var _w:Number;
		private var _h:Number;
		
		public function ViewArea(w:Number, h:Number, name:String = "")
		{
			_w = w;
			_h = h;
			container = name;
		}
		
		public function set container(linkName:String):void
		{
			var oldContainer:Sprite = _container;
			_container = Dll.getInstance().getDisplayObjectByName(linkName) as Sprite;
			if( _container)
			{
				_container.graphics.clear();
				addChildAt(_container,0);
				while(oldContainer.numChildren)
				{
					_container.addChild(oldContainer.removeChildAt(0));
				}
				return;
			}
			_container = new Sprite();
			with( addChildAt(_container,0))
			{
				graphics.clear();
				graphics.beginFill(0,0.1);
				graphics.drawRect(0,0,_w,_h);
				graphics.endFill();
			}
				
		}
		
		
			
		public function showAs(parent:DisplayObjectContainer):void
		{
			parent.addChild(this);
		}
		
		public function removeFrom(parent:DisplayObjectContainer):void
		{
			parent.removeChild(this);
		}
		
		public function removeAll():void
		{
			while(numChildren)
			{
				removeChildAt(0);
			}
		}
	}
}