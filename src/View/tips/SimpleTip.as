package View.tips
{
	import com.Lance.ui.base.ToolTip;
	import com.module.control.Label;
	
	public final class SimpleTip extends ToolTip
	{
		private var label:Label;
		
		//销毁事件
		override protected function destory():void
		{
			
		}
		//赋参数
		override protected function showToolTip(param1:Object):void
		{
//			if( param1 is String) label.text = String(param1);
//			width = 80;
//			height = 25;
			//处理信息
			super.showToolTip(param1);
		}
		
		
		public function SimpleTip()
		{
			offsetX = 20;
			offsetY = 20;
			if( !label) label = new Label(0,12,false);addChild(label);
		}
	}
}