package com.Lance.dll
{
	public class FileList
	{
		private var _fileList:Array;
		public var fileListState:Boolean = false;
		
		public function FileList()
		{
			this._fileList = [];
			return;
		}// end function
		
		public function get fileList() : Array
		{
			return this._fileList;
		}// end function
		
		public function set fileList(param1:Array) : void
		{
			this._fileList = param1;
			return;
		}// end function
		
		public function get loadingList() : Array
		{
			var tmpDFObj:DLLFileObject = null;
			var tmpList:Array = [];
			var index:int = 0;
			while (index < this.fileList.length)
			{
				
				tmpDFObj = this.fileList[index] as DLLFileObject;
				if (tmpDFObj.weight == -1)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADED)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADING)
				{
					tmpList.push(tmpDFObj);
				}
				index = index + 1;
			}
			return tmpList;
		}// end function
		
		public function get mainList() : Array
		{
			var tmpDFObj:DLLFileObject = null;
			var tmpList:Array = [];
			var index:int = 0;
			while (index < this.fileList.length)
			{
				
				tmpDFObj = this.fileList[index] as DLLFileObject;
				if (tmpDFObj.weight != -1)
				{
				}
				if (tmpDFObj.weight == 0)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADED)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADING)
				{
					tmpList.push(tmpDFObj);
				}
				index = index + 1;
			}
			return tmpList;
		}// end function
		
		public function get delayedList() : Array
		{
			var tmpDFObj:DLLFileObject = null;
			var tmpList:Array = [];
			var index:int = 0;
			while (index < this.fileList.length)
			{
				
				tmpDFObj = this.fileList[index] as DLLFileObject;
				if (tmpDFObj.weight != -1)
				{
				}
				if (tmpDFObj.weight != 0)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADED)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADING)
				{
					tmpList.push(tmpDFObj);
				}
				index = index + 1;
			}
			tmpList.sortOn("weight", Array.NUMERIC);
			return tmpList;
		}// end function
		
		public function getgroupList(groupName:String) : Array
		{
			var tmpDFObj:DLLFileObject = null;
			var tmpList:Array = [];
			var index:int = 0;
			while (index < this.fileList.length)
			{
				
				tmpDFObj = this.fileList[index] as DLLFileObject;
				if (tmpDFObj.groupName == groupName)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADED)
				{
				}
				if (tmpDFObj.status != DLLFileObject.LOADING)
				{
					tmpList.push(tmpDFObj);
				}
				index = index + 1;
			}
			tmpList.sortOn("weight", Array.NUMERIC);
			return tmpList;
		}// end function
	}
}