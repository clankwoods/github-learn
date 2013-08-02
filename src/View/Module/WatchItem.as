package View.Module
{
	import View.BaseWorld;
	
	import com.Lance.dll.Dll;
	import com.greensock.TweenMax;
	import com.module.control.Label;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public final class WatchItem extends Sprite
	{
		private var watchPic:Sprite;
		private var tip:Sprite;
		private var txt:Label;
		
		public var picHeight:Number;
		public var picWidth:Number;
		
		private var param:Object = {};
		
		public function WatchItem()
		{
			
		}
		
		
		/**{pic:[链接名1],data:{name:"",author:"",popularity:"",price:""} }*/
		public function show(value:Object = null):void
		{
			param = value;
			data = value;
		}
		
		public function onMouse(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_OVER:
				{
					if( tip)
					{
						TweenMax.to(tip,0.2,{alpha:1});
					}
					break;
				}
				case MouseEvent.MOUSE_OUT:
				{
					if( tip)
					{
						var rect:Rectangle = tip.getRect(this);
						trace( rect, mouseX, mouseY);
						if( ( mouseX <= (rect.x+rect.width) && mouseX >= rect.x) && (mouseY <= (rect.y+rect.height) && mouseY >= rect.y))
						{
						}
						else
						{
							TweenMax.to(tip,0.2,{alpha:0});
						}
					}
					break;
				}
				case MouseEvent.MOUSE_MOVE:
				{
					if( event.target.name.indexOf("w") != -1)
					{
						break;
					}
					if( tip && tip.alpha >= 1 )
					{
						var rect:Rectangle = tip.getRect(this);
						trace( rect, mouseX, mouseY);
						if( ( mouseX <= (rect.x+rect.width) && mouseX >= rect.x) && (mouseY <= (rect.y+rect.height) && mouseY >= rect.y))
						{
						}
						else
						{
							TweenMax.to(tip,0.2,{alpha:0});
						}
					}
					break;
				}
			}
		}			
		
		public function hide():void
		{
		}
		/**{pic:[链接名1],data:{name:"",author:"",popularity:"",price:""} }*/
		public function set data(value:Object):void
		{
			if( value == null)
			{
				if( watchPic )
				{
					
				}
				else			//如果图片为空的话就画个矩形代替
				{
					watchPic = new Sprite();
					with( watchPic)
					{
						graphics.beginFill(0,0.4);
						graphics.drawRect(0,0,115,115);
						graphics.endFill();
					}
					addChild(watchPic);
				}
			}
			else
			{
				watchPic = Dll.getInstance().getDisplayObjectByName(value.pic[0]) as Sprite;
				addChild( watchPic);
			}
			picHeight = watchPic.height;
			picWidth = watchPic.width;
			
			tip =  new Sprite();
			txt = new Label(0,12,false);
			txt.leading = 3;
			with( tip)
			{
				graphics.beginFill(0,0.3);
				graphics.drawRect(0,0,85,115);
				graphics.endFill();
				x = this.x + 115;
				y = this.y;
				alpha = 0;
				name = "tip";
				mouseChildren = false;
				with( addChild(txt))
				{
					name = "tip";
					text = "表名称: " + value.data.name +
						"\n所有者: " + value.data.author  +
						"\n人气: " + value.data.popularity  +
						"\n价格: " + value.data.price  ;
				}
				
			}
			BaseWorld.getInstance().tipsLayer.addChild(tip);
		}
		
	}
}