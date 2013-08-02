package com.module.control
{
	import com.Lance.dll.Dll;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public final class PhotoItem extends Sprite
	{
		private var data:Object;
		private var photo:String;
		private var bgW:Number;
		private var bgH:Number;
		private var _type:String;
		private var _eclipse:Number;
		public var displayChild:Bitmap;
		
		public static const PHOTO_TYPE_RECT:String = "rect";
		public static const PHOTO_TYPE_ROUNDRECT:String = "round";
		public static const PHOTO_TYPE_CIRCLE:String = "circle";
		
		public function PhotoItem(_name:String = "",type:String = "rect",width:Number = 64, height:Number = 64,eclipse:Number = 5)
		{
			this.photo = _name;
			this.bgW = width;
			this.bgH = height;
			this._type = type;
			this._eclipse = eclipse;
			drawPhoto();
		}
		
		
		private function drawPhoto():void
		{
			with( this)
			{
				graphics.clear();
				
				graphics.beginFill(0,0.4);
				switch(this._type)
				{
					case "rect":
					{
						graphics.drawRect(0,0,bgW,bgH);
						break;
					}
					case "round":
					{
						graphics.drawRoundRect(0,0,bgW/2,bgH/2,_eclipse,_eclipse);
						break;
					}
					case "circle":
					{
						graphics.drawCircle(0,0,(bgW+bgH)/2);
						break;
					}
						
					default:
					{
						graphics.drawRect(0,0,bgW,bgH);
						break;
					}
				}
				graphics.endFill();
			}
			if( photo != "")
			{
				var tmp:DisplayObject = Dll.getInstance().getDisplayObjectByName(photo)as DisplayObject;
				if( !displayChild) displayChild = new Bitmap();
				displayChild.bitmapData = new BitmapData(tmp.width,tmp.height);
				displayChild.bitmapData.draw(tmp);
				with(addChild(displayChild))
				{
					scaleX = displayChild.width/bgW;
					scaleY = displayChild.height/bgH;
					x = (bgW-displayChild.width)/2;
					y = (bgH-displayChild.height)/2;
					if( _type == "circle")
					{
						x = -displayChild.width/2;
						y = -displayChild.height/2;
					}
					else if(_type == "round")
					{
						x = ((bgW-displayChild.width)/2)+_eclipse/2;
						y = ((bgH-displayChild.height)/2)+_eclipse/2;
					}
					
				}
			}
		}
	}
}