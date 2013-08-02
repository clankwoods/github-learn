package com.module.control
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import View.Module.Filters;
	
	public final class ListItem extends Sprite
	{
		private var _container:Sprite;
		private var txtContainer:Array = [];
		private var _data:Object;
		
		public function ListItem(param:Object = null)
		{
			init();
			if( _data) _data = param;
		}
		
		private function init():void
		{
			if( _container) addChildAt(_container,0);
			else
			{
				_container = new Sprite();
				with( addChild( _container))
				{
					graphics.beginFill(0,0.4);
					graphics.drawRect(0,0,550,24);
					graphics.endFill();
				}
			}
		}
		private function initEvent():void
		{
			addEventListener(MouseEvent.CLICK, onclick);
		}
		
		protected function onclick(event:MouseEvent):void
		{
			
		}			
		
		
		public static const SELECT:String = "select";
		public static const UNSELECT:String = "unselect";
		public function changeState(value:String):void
		{
			if( 	value == SELECT)
			{
				this.filters = [Filters.yellow];
				return;
			}
			
			this.filters = [];
		}
		
		public function reSize():void
		{
			
		}
		/**
		 * 
		 * @param obj [{Label:{width:999,data:"aaaaa"}},{Label:{width:999,data:"aaaaa"}}]
		 * 
		 */		
		public function set data(value:Array):void
		{
			_data = value;
			while(container.numChildren>1)
			{
				container.removeChildAt(1);
			}
			var index:int = 0
			for (var i:int = 0; i < value.length; i++) 
			{
				for (var name:String in value[i]) 
				{
					if( name == "Label")
					{
						var tmpLabel:Label = new Label(0,12,false);
						txtContainer.push(tmpLabel);
						with(container.addChild( tmpLabel))
						{
							width = value[i].Label.hasOwnProperty("width")?Number(value[i].Label.width):this.width/(value.length-1);
							x = value[i].Label.width*index;
//							border = true;
//							borderColor = 0;
							text = value[i].Label.data;
						}
						
					}
					else if ( name == "image")
					{
						
					}
					++index;
				}
			}
		}
		
		public function showAs(parent:DisplayObjectContainer):void
		{
			parent.addChild( this);
		}

		public function get container():Sprite
		{
			return _container;
		}

		public function set container(value:Sprite):void
		{
			removeChild(_container);
			_container = value;
			addChildAt(_container,0);
		}

	}
}