package View.popup
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**冷却时间遮罩类
	 * */
	public class CDMask extends Sprite
	{
		public var icon :DisplayObjectContainer;     //图标
		private var cdMask :Sprite;     //冷却时间遮罩   
		private var currentAngle :Number;   //当前的角度
		private var speed :Number;     //CD时间速度
		private var radius :Number;     //遮罩半径
		private var background :Bitmap;    //背景图
		private var startTime :Number;    //开始时间
		private var totalTime :Number = 300;  //CD冷却时间，1秒
		private var complete:Function;
		public function CDMask(BMD:*,_complete:Function=null)
		{
			super();
			this.complete=_complete;
			this.icon=BMD;
//			this.icon = new Bitmap(BMD);
//			this.background = new Bitmap(BMD);
//			this.background.filters = [new ColorMatrixFilter([1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0])]; //灰色滤镜数组
//			addChild(background);
			addChild(icon);
		}
		public function play():void 
		{
			startTime = getTimer();    //开始获取时间
			cdMask = new Sprite();
			this.addChild(cdMask);
			icon.mask = cdMask;
			currentAngle = 0;
			speed = 1;
			radius = Math.sqrt(this.width/2 * this.width/2 + this.height/2 * this.height/2);  //遮罩半径，勾股定理，你们都懂的
			cdMask.x = this.width/2;
			cdMask.y = this.height/2;
			
			cdMask.graphics.beginFill(0);
			cdMask.graphics.lineTo(radius,0);
			cdMask.addEventListener(Event.ENTER_FRAME , efHandler);
		}
		private function efHandler(e:Event):void 
		{	
			var postTime :Number = getTimer() - startTime;  //程序运行到这里的时间-开始的时间
			currentAngle += speed;
			if(postTime <= totalTime)
			{
				var currAngle:Number = 2 * Math.PI * ( postTime / totalTime );//根据经过时间算出弧度
				var toX :Number = radius * Math.cos(currAngle);
				var toY :Number = radius * Math.sin(currAngle);
				cdMask.graphics.lineTo(toX,toY);
			}else
			{
				if (this.contains(cdMask)) 
				{
					this.removeChild(cdMask);
					icon.mask = null;
					removeEventListener(Event.ENTER_FRAME, efHandler);
					dispatchEvent(new Event("loginBoxstoped"));
					if(complete!=null){
						complete();
					}
				}
			}
		}
	}
}