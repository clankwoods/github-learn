package View.tips
{
	import com.Lance.dll.Dll;
	import com.Lance.ui.base.ToolTip;
	
	import flash.display.Sprite;
	
	public class CreateMyCompanyTip extends ToolTip
	{
		public var createMycompanyTipSpr:Sprite;
		
		public function CreateMyCompanyTip()
		{
			
			if( !createMycompanyTipSpr) createMycompanyTipSpr = Dll.getInstance().getDisplayObjectByName("YesNoMc") as Sprite;
			with(addChild(createMycompanyTipSpr))
			{
				x =135;
				y = 70;
				alpha=0.7;
			
			}
		}
		override protected function destory():void
		{
			// TODO Auto Generated method stub
			super.destory();
		}
		
		override protected function showToolTip(param1:Object):void
		{
			// TODO Auto Generated method stub
			super.showToolTip(param1);
		}
		
	}
}