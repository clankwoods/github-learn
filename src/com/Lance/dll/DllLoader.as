package com.Lance.dll
{

	
	import com.Lance.analyze.AnalyzeBase;
	import com.Lance.analyze.AnalyzeDictionary;
	import com.Lance.analyze.LibAnalyze;
	import com.Lance.utils.CRC32;
	import com.Lance.utils.SharedObjectUtil;
	
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class DllLoader extends MultiLoader
	{
		private var libAnalyze:LibAnalyze;
		private var _reload:int;
		
		public function DllLoader()
		{
			this._reload = 0;
			return;
		}// end function
		
		override protected function currentComplete($index:int, $result:Object) : void
		{
			var time:String = null;
			var _loc_11:int = 0;
			var strCrC:String = null;
			var crc32:CRC32 = null;
			var tmpDFObj:DLLFileObject = fileArr[$index] as DLLFileObject;
			var url:Array = tmpDFObj.url.split("/");
			var url1:Array = String(url[(url.length - 1)]).split("__");
			var url2:String = String(url1[(url1.length - 1)]).split(".")[0];
			if (url1.length == 1)
			{
				strCrC = url2;
			}
			else
			{
				crc32 = new CRC32();
				crc32.update($result as ByteArray);
				strCrC = crc32.getValue().toString(16);
			}
			if (url2 != strCrC)
			{
				if (this._reload < 2)
				{
					time = new Date().getTime().toString();
					SharedObjectUtil.fmWriteSharedObject(tmpDFObj.url, time);
					this.loadItem();
					_loc_11 = this._reload + 1;
					return;
				}
			}
			this._reload = 0;
			var ab:AnalyzeBase = AnalyzeDictionary.getInstance().getAnalyze(tmpDFObj.type) as AnalyzeBase;
			if (!ab)
			{
				tmpDFObj.result = {};
				this.compFn();
				return;
			}
			ab.analyze($result as ByteArray, tmpDFObj, this.compFn);
			return;
		}// end function
		
		override protected function loadItem() : void
		{
			var url:String = null;
			if (fileArr.length == 0)
			{
				this.compFn();
				return;
			}
			var urlRequest:URLRequest = null;
			var tmpFileObj:DLLFileObject = fileArr[_index] as DLLFileObject;
			if (tmpFileObj.status == DLLFileObject.NO_LOADER)
			{
				url = SharedObjectUtil.fmReadSharedObject(tmpFileObj.url);
				if (url != "")
				{
					urlRequest = new URLRequest(tmpFileObj.url + "?" + url);
				}
				else
				{
					urlRequest = tmpFileObj.urlRequest;
				}
				_loader.load(urlRequest);
				tmpFileObj.startTime = getTimer();
				(fileArr[_index] as DLLFileObject).status = DLLFileObject.LOADING;
			}
			else
			{
				next();
			}
			return;
		}// end function
		
		private function compFn(dllFO:DLLFileObject = null) : void
		{
//			var tmpUUC:UUCAnalyze = null;
//			if (dllFO)
//			{
//				tmpUUC = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_UUC) as UUCAnalyze;
//				if (tmpUUC)
//				{
//					tmpUUC.addMatList(dllFO.result as Array, dllFO.name);
//				}
//			}
			if (!pause)
			{
				next();
			}
			return;
		}// end function
		
		public function addLoaderList(list:Array) : void
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			var _loc_4:* = fileArr.length;
			var _loc_5:* = list.length;
			while (_loc_3 < _loc_4)
			{
				
				if (fileArr[_loc_3].status == DLLFileObject.LOADING)
				{
					_loc_2 = 0;
					while (_loc_2 < _loc_5)
					{
						
						fileArr.splice(_loc_3 + _loc_2 + 1, 0, list[_loc_2]);
						_loc_2 = _loc_2 + 1;
					}
					break;
				}
				_loc_3 = _loc_3 + 1;
			}
			return;
		}// end function

	}
}