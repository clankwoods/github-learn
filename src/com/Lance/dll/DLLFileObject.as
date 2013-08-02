package com.Lance.dll
{
	public class DLLFileObject extends FileObject
	{
		public var serverid:String;
		public var startTime:int;
		public var materialClassName:String;
		public var type:String;
		public var weight:int;
		public var status:String;
		public var module:String;
		public var groupName:String;
		public var subClass:String = "";
		public static const UUC_TYPE:String = "uuc";
		public static const IMG_TYPE:String = "img";
		public static const JSON_TYPE:String = "json";
		public static const XML_TYPE:String = "xml";
		public static const SWF_TYPE:String = "swf";
		public static const TYPE_SOUND:String = "sound";
		public static const TYPE_MAIN:String = "main";
		public static const TYPE_LIB:String = "lib";
		public static const TYPE_MODULE:String = "module";
		public static const TYPE_LIS:String = "lis";
		public static const TYPE_UUC:String = "uuc";
		public static const TYPE_BIN:String = "bin";
		public static const TYPE_DAR:String = "dar";
		public static const LOADED:String = "loaded";
		public static const LOADING:String = "loading";
		public static const NO_LOADER:String = "no_loader";
		public static const STATISTICS_UI:int = 0;
		public static const STATISTICS_MAT:int = 1;
		
		public function DLLFileObject(url:String = "", name:String = "", size:int = 0, groupName:String = "", type:String = "swf", weight:int = 0, module:String = "")
		{
			this.url = url;
			this.name = name;
			this.groupName = groupName;
			this.type = type;
			this.size = size;
			this.weight = weight;
			this.module = module;
			this.status = DLLFileObject.NO_LOADER;
			return;
		}// end function
	}
}