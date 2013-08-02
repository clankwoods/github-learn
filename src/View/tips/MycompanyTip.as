package View.tips
{
	import com.Lance.dll.Dll;
	import com.Lance.ui.base.ToolTip;
	import com.ui.PublicCls;
	import com.ui.TextInputCls;
	
	import flash.display.Sprite;
	
	public class MycompanyTip extends ToolTip
	{
		private var comapnyinformationSpr:Sprite;
		private var companyCode:TextInputCls;//公司代号
		private var companyAdress:TextInputCls;//公司地址
		private var companyType:TextInputCls;//公司类型
		private var industryType:TextInputCls;//行业类型
		private var registerTime:TextInputCls;//注册时间
		private var bankCertificate:TextInputCls;//银行资金证明书
		private var businessBureauNum:TextInputCls;//工商局注册编号
		private var	taxBureauNum:TextInputCls//"税务局注册账号
		private var	businessLicenseNum:TextInputCls//"经营许可证编号

		public function MycompanyTip()
		{
			offsetX =-40;
			offsetY =-40;
			if( !comapnyinformationSpr) comapnyinformationSpr = Dll.getInstance().getDisplayObjectByName("Companyinformation") as Sprite;
			//信息添加到弹出框
			companyCode= new TextInputCls("公司代号:", 65, 125, 20, 20,false,false);
			companyCode.x =10;
			companyCode.y =15;
			companyAdress= new TextInputCls("公司地址:", 65, 110, 20, 20, false, false);
			companyAdress.x =10;
			companyAdress.y = companyCode.y + 20;
			companyType= new TextInputCls("公司类型:", 65, 110, 20, 20, false, false);
			companyType.x =10;
			companyType.y = companyAdress.y + 20;
			industryType= new TextInputCls("行业类型:", 65, 110, 20, 20, false, false);
			industryType.x =10;
			industryType.y = companyType.y + 20;
			registerTime= new TextInputCls("注册时间:", 65, 110, 20, 20, false, false);
			registerTime.x =10;
			registerTime.y = industryType.y + 20;
			bankCertificate= new TextInputCls("银行资金证明书:",105, 110, 20, 20, false, false);
			bankCertificate.x =10;
			bankCertificate.y = registerTime.y + 20;
			businessBureauNum= new TextInputCls("工商局注册编号:",105, 110, 20, 20, false, false);
			businessBureauNum.x =10;
			businessBureauNum.y = bankCertificate.y + 20;
			taxBureauNum= new TextInputCls("税务局注册账号:",105, 110, 20, 20, false, false);
			taxBureauNum.x =10;
			taxBureauNum.y = businessBureauNum.y + 20;
			businessLicenseNum = new TextInputCls("经营许可证编号:",105, 110, 20, 20, false, false);
			businessLicenseNum.x =10;
			businessLicenseNum.y = taxBureauNum.y + 20;
			
			with(addChild(comapnyinformationSpr))
				 {
					 x =135;
					 y = 70;
					 alpha=0.7;
					 comapnyinformationSpr.addChild(companyCode);
					 comapnyinformationSpr.addChild(companyAdress);
					 comapnyinformationSpr.addChild(companyType);
					 comapnyinformationSpr.addChild(industryType);
					 comapnyinformationSpr.addChild(registerTime);
					 comapnyinformationSpr.addChild(bankCertificate);
					 comapnyinformationSpr.addChild(businessBureauNum);
					 comapnyinformationSpr.addChild(taxBureauNum);
					 comapnyinformationSpr.addChild(businessLicenseNum);
				 }
				
		}
		override protected function destory():void
		{
			
		}
		//数据 
		override protected function showToolTip(param1:Object):void
		{
			
			companyCode.strValue 		="";
			companyAdress.strValue 	    ="";
			companyType.strValue 		="";
			industryType.strValue 		="";
			registerTime.strValue 		="";
			bankCertificate.strValue 	="";
			businessBureauNum.strValue ="";
			taxBureauNum.strValue 		="";
			businessLicenseNum.strValue ="";
		    companyCode.strValue 		=param1.CompanyID;
			companyAdress.strValue 	=param1.Address;
		    companyType.strValue 		= PublicCls.companyTypeFn(param1.CompanyTypeID);
		    industryType.strValue 		= PublicCls.industryTypeFn(param1.IndustryTypeID);
		    registerTime.strValue 		= param1.RegisterTime;
			bankCertificate.strValue 	= param1.BankCapitalCertificateID;
			businessBureauNum.strValue =param1.BusinessRegisterReportID;
		    taxBureauNum.strValue 		=param1.TaxRegisterInformationID;
			businessLicenseNum.strValue =param1.CompanyObtainPermitID;
			super.showToolTip(param1);
		}
	}
}