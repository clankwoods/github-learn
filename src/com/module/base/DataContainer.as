package com.module.base
{
	import com.Lance.dll.Dll;
	import com.module.control.ListItem;
	import com.module.interfaces.IDataView;
	
	import flash.display.Sprite;
	
	public class DataContainer extends Sprite implements IDataView
	{
		
		protected var list:Vector.<ListItem> = new Vector.<ListItem>();
		protected var _count:uint;
		protected var titleList:Array = [];
		
		
		public function DataContainer(count:uint = 1)
		{
			_count =  count;
			init();
		}
		
		
		protected function init():void
		{
			var title:ListItem  = new ListItem()
			with(addChild(title))
			{
				y = 0;
				container =  Dll.getInstance().getDisplayObjectByName("RankItemBG") as Sprite;
				data = titleList;
			}
			
			for (var i:int = 0; i < _count; i++) 
			{
				list.push( new ListItem());
				with(addChild(list[i]))
				{
					y = (i+1)*list[i].height;
					list[i].container = Dll.getInstance().getDisplayObjectByName("RankItemBG") as Sprite;
					visible = false;
				}
			}
			
		}
		
		public function showData(data:Array):void
		{
			
			
		}
	}
}