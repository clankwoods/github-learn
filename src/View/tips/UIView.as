package View
{
	import Model.ModelList;
	
	import View.Module.Chart;
	import View.popup.BankPanel;
	import View.popup.BankView;
	import View.popup.MyCompanyPanel;
	import View.popup.Popup;
	import View.tips.MycompanyTip;
	
	import com.Lance.base.App;
	import com.Lance.dll.Dll;
	import com.Lance.net.NetProxy;
	import com.Lance.net.old.DataSet;
	import com.Lance.ui.manager.UIManager;
	import com.adobe.serialization.json.JSON;
	import com.riaidea.text.RichTextField;
	import com.ui.ButtonStyle;
	
	import controller.CustomerController;
	import controller.Method;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	public final class UIView extends Sprite
	{
		private var coutomerBtn:Sprite;
		private var myCompanyBtn:Sprite;
		private var bankBtn:Sprite;
		private var powerBtn:Sprite;
		private var warehouseBtn:Sprite;
		private var financeBtn:Sprite;
		private var groupBtn:Sprite;
		private var playerBtn:Sprite;
		private var personalInfoBtn:Sprite;
		private var macrosBtn:Sprite;
		private var rankBtn:Sprite;
		private var emailBtn:Sprite;
		private var tradingCenterBtn:Sprite;
		private var myInsuranceBtn:Sprite;
		private var statisticsBtn:Sprite;
		public function UIView()
		{
			init();
		}
		
		private var chart:Chart = new Chart();
		private function init():void
		{
			if(!statisticsBtn) statisticsBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var statistics:ButtonStyle=new ButtonStyle();
			statistics.buttonStyleFn(statisticsBtn,"事故统计");
			addChild(statisticsBtn);
			statisticsBtn.x=1190;
			statisticsBtn.y=180;
			statisticsBtn.addEventListener(MouseEvent.CLICK,statisticsBtnhandler);
			
			if(!myInsuranceBtn) myInsuranceBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var myInsurance:ButtonStyle=new ButtonStyle();
			myInsurance.buttonStyleFn(myInsuranceBtn,"我的保险");
			addChild(myInsuranceBtn);
			myInsuranceBtn.x=1190;
			myInsuranceBtn.y=210;
			myInsuranceBtn.addEventListener(MouseEvent.CLICK,myInsuranceBtnhandler);
			
			
			if(!tradingCenterBtn) tradingCenterBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var tradingCenter:ButtonStyle=new ButtonStyle();
			tradingCenter.buttonStyleFn(tradingCenterBtn,"交易中心");
			addChild(tradingCenterBtn);
			tradingCenterBtn.x=1190;
			tradingCenterBtn.y=240;
			tradingCenterBtn.addEventListener(MouseEvent.CLICK,tradingCenterBtnhandler);
			
			if(!emailBtn) emailBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var email:ButtonStyle=new ButtonStyle();
			email.buttonStyleFn(emailBtn,"排 名");
			addChild(emailBtn);
			emailBtn.x=150;
			emailBtn.y=130;
			emailBtn.addEventListener(MouseEvent.CLICK,emailBtnhandler);
			
			if(!rankBtn) rankBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var rank:ButtonStyle=new ButtonStyle();
			rank.buttonStyleFn(rankBtn,"排 名");
			addChild(rankBtn);
			rankBtn.x=80;
			rankBtn.y=130;
			rankBtn.addEventListener(MouseEvent.CLICK,rankBtnhandler);
			
			if(!macrosBtn) macrosBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var macros:ButtonStyle=new ButtonStyle();
			macros.buttonStyleFn(macrosBtn,"宏 观");
			addChild(macrosBtn);
			macrosBtn.x=10;
			macrosBtn.y=130;
			macrosBtn.addEventListener(MouseEvent.CLICK,macrosBtnhandler);
			
			if(!personalInfoBtn) personalInfoBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var personalInfo:ButtonStyle=new ButtonStyle();
			personalInfo.buttonStyleFn(personalInfoBtn,"个人信息");
			addChild(personalInfoBtn);
			personalInfoBtn.x=220;
			personalInfoBtn.y=130;
			personalInfoBtn.addEventListener(MouseEvent.CLICK,personalInfoBtnhandler);
			
			
			
			if(!playerBtn) playerBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var player:ButtonStyle=new ButtonStyle();
			player.buttonStyleFn(playerBtn,"玩家信息");
			addChild(playerBtn);
			playerBtn.x=670;
			playerBtn.y=570;
			playerBtn.addEventListener(MouseEvent.CLICK,playerBtnhandler);
			
			if(!groupBtn) groupBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var group:ButtonStyle=new ButtonStyle();
			group.buttonStyleFn(groupBtn,"团 体");
			addChild(groupBtn);
			groupBtn.x=750;
			groupBtn.y=570;
			groupBtn.addEventListener(MouseEvent.CLICK,groupBtnhandler);
			
			if(!financeBtn) financeBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var finance:ButtonStyle=new ButtonStyle();
			finance.buttonStyleFn(financeBtn,"财 务");
			addChild(financeBtn);
			financeBtn.x=830;
			financeBtn.y=570;
			financeBtn.addEventListener(MouseEvent.CLICK,financeBtnhandler);
			
			if(!warehouseBtn) warehouseBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var warehouse:ButtonStyle=new ButtonStyle();
			warehouse.buttonStyleFn(warehouseBtn,"仓 库");
			addChild(warehouseBtn);
			warehouseBtn.x=910;
			warehouseBtn.y=570;
			warehouseBtn.addEventListener(MouseEvent.CLICK,warehouseBtnhandler);

			var btnStyle:ButtonStyle=new ButtonStyle();
			var myCompany:ButtonStyle=new ButtonStyle();
			if(!powerBtn) powerBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			var btnpower:ButtonStyle=new ButtonStyle();
			btnpower.buttonStyleFn(powerBtn,"人 力");
			addChild(powerBtn);
			powerBtn.x=990;
			powerBtn.y=570;
			powerBtn.addEventListener(MouseEvent.CLICK,powerBtnhandler);
			
			if(!coutomerBtn) coutomerBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			btnStyle.buttonStyleFn(coutomerBtn,"客 户");
			addChild(btnStyle);
			btnStyle.x=1070;
			btnStyle.y=570;
			coutomerBtn.addEventListener(MouseEvent.CLICK,coutomerBtnhandler);
			
			if(!myCompanyBtn) myCompanyBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			myCompany.buttonStyleFn(myCompanyBtn,"我的公司");
			addChild(myCompanyBtn);
			myCompanyBtn.x=1150;
			myCompanyBtn.y=570;
			myCompanyBtn.addEventListener(MouseEvent.CLICK,myCompanyhandler);
			
			var bankStyle:ButtonStyle=new ButtonStyle();
			if(!bankBtn) bankBtn=Dll.getInstance().getDisplayObjectByName("BankBut") as Sprite;
			bankStyle.buttonStyleFn(bankBtn,"银行");
			addChild(bankBtn);
			bankBtn.x=1190;
			bankBtn.y=270;
			bankBtn.addEventListener(MouseEvent.CLICK,bankhandler);
			
//			initChart();
			
			with(addChild(chart))
			{
				x = 10;
				y = App.baseHeight-height;
			}
				
		}
		
		protected function statisticsBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function myInsuranceBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function tradingCenterBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function emailBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function rankBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function macrosBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function personalInfoBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function playerBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function groupBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function financeBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function warehouseBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function powerBtnhandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function bankhandler(event:MouseEvent):void
		{
			UIManager.getPopupManager().createPopUp(BankPanel,false);
			
		}
		protected function myCompanyhandler(event:MouseEvent):void
		{
			NetProxy.getInstance().sendMSG(Method.MYCOM_INIT,function(str:String):void{
				var obj:Object= new DataSet(str).data;
				if( obj.actinfo[0].pageID == "10001" && obj.actinfo[0].buttonID == "100")
				{
					ModelList.getInstance().mycompanyModel.data(obj.CompanyInformation);
					UIManager.getPopupManager().createPopUp(MyCompanyPanel,false);
				}
				
			});
			
		}
		private function coutomerBtnhandler(event:MouseEvent):void
		{
			NetProxy.getInstance().sendMSG(Method.CUSTRLT_INIT,function(str:String):void{
				var obj:Object= new DataSet(str).data;
				if( obj.actinfo[0].pageID == "10006" && obj.actinfo[0].buttonID == "100")
				{
					ModelList.getInstance().customerModel.objFn(obj,"TradeOrder1");
					UIManager.getPopupManager().createPopUp(BankView,false);
					NetProxy.getInstance().delSocketComFun(Method.CUSTRLT_INIT);
				}
			});
		}
	}
}