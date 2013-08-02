package View.scene
{
	import com.Lance.dll.Dll;
	import com.Lance.net.NetProxy;
	import com.adobe.serialization.json.JSON;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import View.Module.WatchItem;
	import View.interfaces.IScene;
	
	import controller.Method;
	
	public final class WatchListScene extends Sprite implements IScene
	{
		
		private var bg:Sprite;
		
		private var left:Sprite;
		private var right:Sprite;
		private var arItem:Vector.<WatchItem> = new Vector.<WatchItem>(8);
		private var timeUp:MovieClip;
		private var popularityUp:MovieClip;
		private var priceUp:MovieClip;
		
		public function WatchListScene()
		{
			
		}
		
		
		private function initGraphics():void
		{
			bg = Dll.getInstance().getDisplayObjectByName("Bg") as Sprite;
			addChild(bg);
			left = bg.getChildByName("left") as Sprite;
			right = bg.getChildByName("right")  as Sprite;
			timeUp = bg.getChildByName("up1") as MovieClip;
			popularityUp = bg.getChildByName("up2") as MovieClip;
			priceUp = bg.getChildByName("up3") as MovieClip;
			
			left.buttonMode = true;
			right.buttonMode = true;
			timeUp.buttonMode = true;
			popularityUp.buttonMode = true;
			priceUp.buttonMode = true;
			left.mouseChildren = false;
			right.mouseChildren = false;
			timeUp.mouseChildren = false;
			popularityUp.mouseChildren = false;
			priceUp.mouseChildren = false;
			
			for (var j:int = 0; j < arItem.length; j++) 
			{
				var rect:Rectangle = bg.getChildByName("w"+(j+1)).getRect(bg);
				arItem[j] = new WatchItem();
				with( arItem[j])
				{
					if( j>=datas.length) 
					{
						visible = false;
					}
					else
					{
						x = rect.x;
						y = rect.y;
						show({"pic":["wListItem"],"data":{"name":datas[j].wt_name,"author":datas[j].u_id,"popularity":datas[j].wt_popularity
							,"price":datas[j].price}});
						buttonMode = true;
						mouseChildren = false;
						visible = true;
					}
				}
				arItem[j].name = "w"+(j+1);
				bg.removeChild(bg.getChildByName("w"+(j+1)));
				bg.addChild(arItem[j]);
			}
			
		}
			
		
		
		public function onEnter():void
		{
			Method.initDiyList(function (param:Object):void
			{
				initdata(param);
			});
		}
		
		private var datas:Array =[];
		
		private function initdata(param):void
		{
			
				if( param.Status == 101)
				{
					datas = [];
					for each (var i:Object in param.value) 
					{
						datas.push(i);
					}
					
				}
				trace( "data", datas.length);
				if( datas.length>0)
				{
					initGraphics();
					initEvent();
				}
				else
				{
					
				}
			
		}
		
		
		private function initEvent():void
		{
			if( bg)
			{
				bg.addEventListener(MouseEvent.CLICK, onClick);
				bg.addEventListener(MouseEvent.MOUSE_OVER, onMouse);
				bg.addEventListener(MouseEvent.MOUSE_OUT, onMouse);
				bg.addEventListener(MouseEvent.MOUSE_MOVE,onMouse);
			}
		}
		
		protected function onMouse(event:MouseEvent):void
		{
			switch(event.target.name)
			{
				case "w1":
				case "w2":
				case "w3":
				case "w4":
				case "w5":
				case "w6":
				case "w7":
				case "w8":
				case "tip":
				{
					(event.target as WatchItem).onMouse(event);
					break;
				}
			}
		}
		private var current:int = 0;
		
		private var timeFilter:int= 1;
		private var popFilter:int= 1;
		private var priceFilter:int= 1;
		
		protected function onClick(event:MouseEvent):void
		{
			switch(event.target.name)
			{
				case "left":
				{
					Method.nextPage(--current<=0?0:current,function (param:Object):void
					{
						initdata(param);
					});
					break;
				}
				case "right":
				{
					Method.nextPage(++current<=0?0:current,function (param:Object):void
					{
						initdata(param);
					});
					
					break;
				}
				case "up1":
				{
					timeFilter= timeFilter==1?2:1;
					Method.orderByTime(timeFilter,function (param:Object):void
					{
						initdata(param);
					});
					break;
				}
				case "up2":
				{
					popFilter= popFilter==1?2:1;
					Method.orderBypop(timeFilter,function (param:Object):void
					{
						initdata(param);
					});
					break;
				}
				case "up3":
				{
					priceFilter= priceFilter==1?2:1;
					Method.orderByPrice(timeFilter,function (param:Object):void
					{
						initdata(param);
					});
					break;
				}
				case "tip":
				{
					
					break;
				}
			}
		}
		
		public function showAs(parent:DisplayObjectContainer):void{}
		public function removeFrom(parent:DisplayObjectContainer):void{}
		/**获取场景大小*/
		public function getSceneSize():Point{return null;}
		/**进入场景动画前*/
//		public function onEnter():void{}
		/**进入场景动画后*/
		public function onEnterTransformDie():void{}
		/**退出场景动画前*/
		public function onExit():void{}
		/**退出场景动画后*/
		public function onExitTransformDie():void{}
	}
}