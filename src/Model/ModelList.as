package Model
{


	public final class ModelList
	{
		private static var instance:ModelList;
		
		public var userModel:UserModel;
		public var cityModel:CityModel;
		public var companyModel:CompanyModel;
		
		public var customerModel:CustomerModel;
		public var mycompanyModel:MyCompanyModel;
		public var createModel:CreateModel;
		public var bankModel:BankModel;
		public var loanModel:LoanModel;
		
		public var landModel:LandModel;
		public var tradeCenterModel:TradeCenterModel;
		public var rankModel:RankModel;
		public var warehouseModel:WarehouseModel;
		
		public var buildModel:BuildModel;
		public function ModelList()
		{
			userModel = new UserModel();
			cityModel = new CityModel();
			companyModel = new CompanyModel();
			customerModel=new CustomerModel();
			mycompanyModel=new MyCompanyModel();
			createModel=new CreateModel();
			landModel = new LandModel();
			buildModel = new BuildModel();
			bankModel=new BankModel();
			loanModel=new LoanModel();
			tradeCenterModel=new TradeCenterModel();
			rankModel = new RankModel();
			warehouseModel = new WarehouseModel();
		}
		public static function getInstance():ModelList
		{
			return instance ||= new ModelList();
		}
	}
}