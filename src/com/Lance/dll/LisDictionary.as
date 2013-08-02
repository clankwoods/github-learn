package com.Lance.dll
{
	import flash.utils.Dictionary;

	public class LisDictionary
	{
		public var listDic:Dictionary;
		public var lisDllFileObjct:Array;
		public var classListDic:Dictionary;
		private static var instance:LisDictionary;
		
		public function LisDictionary()
		{
			if (instance == null)
			{
				this.listDic = new Dictionary();
				this.classListDic = new Dictionary();
				this.lisDllFileObjct = [];
			}
			else
			{
				throw new Error("AnalyzeDictionary error");
			}
			return;
		}// end function
		
		public function registerDic(key:String, Fun:Function) : void
		{
			if (this.listDic[key])
			{
				this.listDic[key].push(Fun);
			}
			else
			{
				this.listDic[key] = [Fun];
			}
			return;
		}// end function
		
		public function registerMaterialClassDic(serverID:String, materialClassName:String, Fun:Function, typeFlag:Boolean, compFunParams:Array, subClass:String = "") : void
		{
			if (subClass != "")
			{
				if (this.classListDic[serverID + subClass])
				{
					this.classListDic[serverID + subClass].push({className:materialClassName, completeFunc:Fun, typeFlag:typeFlag, completeFuncParams:compFunParams});
				}
				else
				{
					this.classListDic[serverID + subClass] = [{className:materialClassName, completeFunc:Fun, typeFlag:typeFlag, completeFuncParams:compFunParams}];
				}
			}
			else if (this.classListDic[serverID])
			{
				this.classListDic[serverID].push({className:materialClassName, completeFunc:Fun, typeFlag:typeFlag, completeFuncParams:compFunParams});
			}
			else
			{
				this.classListDic[serverID] = [{className:materialClassName, completeFunc:Fun, typeFlag:typeFlag, completeFuncParams:compFunParams}];
			}
			return;
		}// end function
		
		public static function getInstance() : LisDictionary
		{
			if (!instance)
			{
			}
			var _loc_1:* = new LisDictionary;
			instance = new LisDictionary;
			return _loc_1;
		}// end function
	}
}