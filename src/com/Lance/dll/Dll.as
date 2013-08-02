package com.Lance.dll
{

	import com.Lance.analyze.AnalyzeDictionary;
	import com.Lance.analyze.LibAnalyze;
	import com.Lance.analyze.MainAnalyze;
	import com.Lance.base.App;
	import com.Lance.net.LoginStatistics;
	import com.Lance.net.StatisticsErrorConst;
	import com.Lance.net.StatisticsObject;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	public class Dll extends EventDispatcher
	{
		public var mainAppDomain:ApplicationDomain;
		public var floder:String;
		public var outFloder:String;
		public var version:String = "v1.0.0";
		public var vertime:String = "10/26/2012 00:00";
		public var lang:String = "cn";
		public var status:String = "all";
		public var fileList:FileList;
		private var loadingLoader:DllLoader;
		private var mainLoader:DllLoader;
		private var listTimer:Timer;
		private var delayLoader:DllLoader;
		private var delayFuncDic:Dictionary;
		private var currentDllLoader:DllLoader;
		private var dllFileLoader:DllLoader;
		private var lisLoader:DllLoader;
		private var dllRequestDic:Array;
		private var appDomain:ApplicationDomain;
		private var _imgDic:Dictionary;
		private var _binLoadList:Array;
		private var _darLoadList:Array;
		private var _urlStream:URLStream;
		private var _loadingUrl:String;
		private var _loaderDic:Dictionary;
		private var _requestStreamList:Array;
		private var _streamByte:ByteArray;
		private var _tempDisplayObjectContainer:DisplayObjectContainer;
		private var substepDic:Dictionary;
		private var _loadedArray:Array;
		private var libAnalyze:LibAnalyze;
		private static var instance:Dll;
		
		public function Dll()
		{
			this.listTimer = new Timer(10);
			this.delayFuncDic = new Dictionary();
			this.substepDic = new Dictionary();
//			this.uucAnalyze = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_UUC) as UUCAnalyze;
			this.libAnalyze = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIB) as LibAnalyze;
//			this.darAnalyze = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_DAR) as DarAnalyze;
			this.dllRequestDic = [];
//			this._imgAnalyze = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.IMG_TYPE) as ImgAnalyze;
			this._imgDic = new Dictionary();
			this._binLoadList = [];
			this._darLoadList = [];
			this._loadedArray = [];
			if (instance == null)
			{
				instance = this;
			}
			else
			{
				throw new Error("Dll instance error");
			}
			return;
		}// end function
		
		public function loadINIXML(list:Array, platformIniUrl:String = "", platformOutUrl:String = "") : void
		{
			var inToList:IniToFlieList = new IniToFlieList();
			inToList.analyzeXml(list, this.lang, this.status, this.loadINIXMLComp, platformIniUrl, platformOutUrl);
			return;
		}// end function
		
		private function loadINIXMLComp(fileList:FileList) : void
		{
//			trace("loadINIXMLComp", JSON.encode( fileList));
			this.fileList = fileList;
			this.startLoad();
			return;
		}// end function
		
		private function startLoad() : void
		{
			this.loadLoadingList();
			return;
		}// end function
		
		public function loadLoadingList() : void
		{
			this.loadingLoader = new DllLoader();
			this.currentDllLoader = this.loadingLoader;
			this.loadingLoader.addEventListener(MultiLoaderEvent.COMPLETE, this.loadingComplete);
			this.loadingLoader.addEventListener(MultiLoaderEvent.PROGRESS, this.loadingProgress);
			this.loadingLoader.addEventListener(MultiLoaderEvent.IO_ERROR, this.onIOError);
			this.loadingLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
			this.loadingLoader.load(this.fileList.loadingList);
			return;
		}// end function
		
		private function onSecurityError(event:SecurityErrorEvent) : void
		{
			var so:StatisticsObject = new StatisticsObject();
			so.statisErrorCode = StatisticsErrorConst.SECURITY_ERROR;
			LoginStatistics.instance.sendLoginStatistics(so);
			return;
		}// end function
		
		private function onIOError(event:MultiLoaderEvent) : void
		{
			var so:StatisticsObject = new StatisticsObject();
			so.statisErrorCode = StatisticsErrorConst.LOADING_FILE_TIME_OUT_ERROR;
			LoginStatistics.instance.sendLoginStatistics(so);
			return;
		}// end function
		
		private function matOnIOError(event:MultiLoaderEvent) : void
		{
			var so:StatisticsObject = new StatisticsObject();
			so.statisErrorCode = StatisticsErrorConst.MAT_FILE_ERROR;
			LoginStatistics.instance.sendLoginStatistics(so);
			return;
		}// end function
		
		private function loadingProgress(event:MultiLoaderEvent) : void
		{
			var dllEvent:DLLEvent = new DLLEvent(DLLEvent.PROGRESS, event.data);
			dispatchEvent(dllEvent);
			return;
		}// end function
		
		private function loadingComplete(event:MultiLoaderEvent) : void
		{
			Dll.getInstance().dispatchEvent(new DLLEvent(DLLEvent.LOADING_COMPLETE));
			this.loadMainList();
			this.loadingLoader.removeEventListener(MultiLoaderEvent.COMPLETE, this.loadingComplete);
			this.loadingLoader.removeEventListener(MultiLoaderEvent.PROGRESS, this.loadingProgress);
			this.loadingLoader = null;
			return;
		}// end function
		
		public function loadMainList() : void
		{
			this.mainLoader = new DllLoader();
			this.currentDllLoader = this.mainLoader;
			this.mainLoader.addEventListener(MultiLoaderEvent.COMPLETE, this.mainComplete);
			this.mainLoader.addEventListener(MultiLoaderEvent.IO_ERROR, this.matOnIOError);
			this.mainLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
			this.mainLoader.addEventListener(MultiLoaderEvent.PROGRESS, this.mainProgress);
			this.mainLoader.load(this.fileList.mainList);
			return;
		}// end function
		
		private function mainProgress(event:MultiLoaderEvent) : void
		{
			dispatchEvent(new DLLEvent(DLLEvent.PROGRESS, event.data));
			return;
		}// end function
		
		private function mainComplete(event:MultiLoaderEvent) : void
		{
			Dll.getInstance().dispatchEvent(new DLLEvent(DLLEvent.COMPLETE));
			this.loadDelayedList();
			this.mainLoader.removeEventListener(MultiLoaderEvent.COMPLETE, this.mainComplete);
			this.mainLoader = null;
			this.listTimer.addEventListener(TimerEvent.TIMER, this.onEnterFrameHandler);
			this.listTimer.start();
			return;
		}// end function
		
		public function loadDelayedList() : void
		{
			if (!this.fileList.delayedList.length)
			{
				return;
			}
			this.delayLoader = new DllLoader();
			this.currentDllLoader = this.delayLoader;
			this.delayLoader.load(this.fileList.delayedList);
//			this.delayLoader.addEventListener(MultiLoaderEvent.COMPLETE, this.delayLoaderComplete);
			return;
		}// end function
		
//		private function delayLoaderComplete(event:MultiLoaderEvent) : void
//		{
//			var clsName:String = null;
//			var dpo:DisplayObject = null;
//			var analyze:LibAnalyze = null;
//			var fun:Function = null;
//			for (clsName in this.delayFuncDic)
//			{
//				
//				analyze = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIB) as LibAnalyze;
//				dpo = analyze.getDisplayObjectByName(clsName) as DisplayObject;
//				if (dpo)
//				{
//					fun = this.delayFuncDic[clsName];
//					fun(dpo);
//					delete this.delayFuncDic[clsName];
//				}
//			}
//			return;
//		}// end function
//		
//		public function getDelayMaterialByClassName(clsName:String, fun:Function) : void
//		{
//			var dpo:DisplayObject = null;
//			this.delayFuncDic[clsName] = fun;
//			dpo = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIB) as LibAnalyze).getDisplayObjectByName(clsName) as DisplayObject;
//			if (dpo)
//			{
//				fun(dpo);
//				delete this.delayFuncDic[clsName];
//			}
//			return;
//		}// end function
		
		public function loadGroupList(param1:String) : void
		{
			return;
		}// end function
		
		public function addLoaderList(list:Array) : void
		{
			var dfObj:DLLFileObject = null;
			var tmpList:Array = [];
			var index:int = 0;
			while (index < list.length)
			{
				
				dfObj = new DLLFileObject(list[index].url, list[index].name, 0, "", list[index].type);
				tmpList.push(dfObj);
				index = index + 1;
			}
			this.currentDllLoader.addLoaderList(tmpList);
			return;
		}// end function
		
		public function loadDLLFileObject(param1:Array) : void
		{
			this.dllFileLoader = new DllLoader();
			this.dllFileLoader.load(param1);
			return;
		}// end function
		
		public function loadLisFiles(param1:Array) : void
		{
			this.lisLoader = new DllLoader();
			this.lisLoader.load(param1);
			return;
		}// end function
		
		public function loadFiles(param:Array, $ignoreIOerror:Boolean = false, fun:Function = null, failFun:Function = null) : void
		{
			var dllLoader:DllLoader;
			var arTmp:Array;
			var obj:Object;
			var dllFO:DLLFileObject;
			var event:MultiLoaderEvent;
			var param:Array = param;
			var $ignoreIOerror:Boolean = $ignoreIOerror;
			var fun:Function = fun;
			var failFun:Function = failFun;
			var ar:Array;
			var _loc_6:int = 0;
			var _loc_7:Array = param;
			while (_loc_7 in _loc_6)
			{
				
				obj = _loc_7[_loc_6];
				if (this.substepDic[this.outFloder + obj.swfurl])
				{
					arTmp.push(this.substepDic[this.outFloder + obj.swfurl]);
					continue;
				}
				dllFO = new DLLFileObject(this.outFloder + obj.swfurl, obj.name, 0, "", obj.type);
				ar.push(dllFO);
			}
			if (ar.length > 0)
			{
				dllLoader = new DllLoader();
				dllLoader.load(ar, false, $ignoreIOerror);
				dllLoader.addEventListener(MultiLoaderEvent.COMPLETE, function (event:MultiLoaderEvent) : void
				{
					var _loc_2:DLLFileObject = null;
					for each (_loc_2 in event.data)
					{
						
						substepDic[_loc_2.url] = _loc_2;
					}
					if (fun != null)
					{
						event.data = event.data.concat(arTmp);
						fun(event);
					}
					return;
				}// end function
				);
				if (failFun != null)
				{
					dllLoader.addEventListener(MultiLoaderEvent.IO_ERROR, failFun);
				}
			}
			else if (fun != null)
			{
				event = new MultiLoaderEvent(MultiLoaderEvent.COMPLETE, arTmp);
				fun(event);
			}
			return;
		}// end function
		
//		public function loadFilesByServerId(param1:Array, fun:Function = null) : void
//		{
//			var _loc_3:DLLFileObject = null;
//			var _loc_4:DllLoader = null;
//			var _loc_5:* = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_UUC) as UUCAnalyze;
//			var _loc_6:Array = [];
//			var _loc_7:Array = [];
//			var _loc_8:int = 0;
//			while (_loc_8 < param1.length)
//			{
//				
//				_loc_6 = _loc_6.concat(_loc_5.getDataByServerId(param1[_loc_8]));
//				_loc_8 = _loc_8 + 1;
//			}
//			var _loc_9:* = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIS) as LisAnalyze;
//			var _loc_10:int = 0;
//			while (_loc_10 < _loc_6.length)
//			{
//				
//				if (!_loc_9.getLisDataByMid(_loc_6[_loc_10].mid))
//				{
//					_loc_3 = new DLLFileObject(this.outFloder + _loc_6[_loc_10].swfurl, _loc_6[_loc_10].typeName, 0, "", DLLFileObject.TYPE_LIS);
//					_loc_7.push(_loc_3);
//				}
//				_loc_10 = _loc_10 + 1;
//			}
//			if (_loc_7.length)
//			{
//				_loc_4 = new DllLoader();
//				_loc_4.load(_loc_7);
//				if (fun != null)
//				{
//					_loc_4.addEventListener(MultiLoaderEvent.PROGRESS, fun);
//				}
//			}
//			return;
//		}// end function
//		
//		public function getMaterialClassByServerId(serverId:String, className:String, comFun:Function, typeFlag:Boolean = false, comFunParams:Array = null, loadFlag:Boolean = false, subClass:String = "") : void
//		{
//			var _loc_8:* = new Object();
//			_loc_8["serverId"] = serverId;
//			_loc_8["materialClassName"] = className;
//			_loc_8["completeFunc"] = comFun;
//			_loc_8["completeFuncParams"] = comFunParams;
//			_loc_8["typeFlag"] = typeFlag;
//			_loc_8["loadFlag"] = loadFlag;
//			_loc_8["subClass"] = subClass;
//			this.dllRequestDic.push(_loc_8);
//			return;
//		}// end function
		
		private function onEnterFrameHandler(event:TimerEvent) : void
		{
			var _loc_2:Array = null;
			var _loc_3:Array = null;
			var _loc_4:Array = null;
			if (this.dllRequestDic.length == 0)
			{
			}
			if (this._binLoadList.length == 0)
			{
			}
			if (this._darLoadList.length == 0)
			{
				return;
			}
			if (this.dllRequestDic.length != 0)
			{
				_loc_2 = this.dllRequestDic.concat();
				this.dllRequestDic.length = 0;
				this.dealLoadList(_loc_2);
			}
			if (this._binLoadList.length != 0)
			{
				_loc_3 = this._binLoadList.concat();
				this._binLoadList.length = 0;
				this.dealLoadList(_loc_3, 1);
			}
			if (this._darLoadList.length != 0)
			{
				_loc_4 = this._darLoadList.concat();
				this._darLoadList.length = 0;
				this.dealLoadList(_loc_4, 2);
			}
			return;
		}// end function
		
		private function dealLoadList(arList:Array, type:int = 0) : void
		{
			var _loc_3:int = 0;
			var _loc_4:* = arList.length;
			switch(type)
			{
				case 0:
				{
					_loc_3 = 0;
					while (_loc_3 < _loc_4)
					{
						
						this.startLoadList(arList[_loc_3]);
						_loc_3 = _loc_3 + 1;
					}
					break;
				}
//				case 1:
//				{
//					_loc_3 = 0;
//					while (_loc_3 < _loc_4)
//					{
//						
//						this.startLoadBinList(arList[_loc_3]);
//						_loc_3 = _loc_3 + 1;
//					}
//					break;
//				}
//				case 2:
//				{
//					_loc_3 = 0;
//					while (_loc_3 < _loc_4)
//					{
//						
//						this.startLoadDarList(arList[_loc_3]);
//						_loc_3 = _loc_3 + 1;
//					}
//					break;
//				}
				default:
				{
					break;
					break;
				}
			}
			return;
		}// end function
		
//		private function startLoadDarList(param1:Object) : void
//		{
//			var _loc_2:Object = null;
//			var _loc_3:DllLoader = null;
//			var _loc_4:* = param1["serverId"];
//			var _loc_5:* = param1["materialClassName"];
//			var _loc_6:Function = param1["completeFunc"];
//			var _loc_7:* = param1["weight"];
//			var _loc_8:* = param1["subClass"];
//			var _loc_9:* = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_DAR) as DarAnalyze;
//			var _loc_10:* = _loc_9.getDarwinBitmapDataByName(_loc_5);
//			if (_loc_10)
//			{
//				_loc_6(_loc_10);
//				return;
//			}
//			if (_loc_8 == "")
//			{
//				_loc_2 = this.uucAnalyze.getMaterialDataByServerId(String(_loc_4));
//			}
//			else
//			{
//				_loc_2 = this.uucAnalyze.getMaterialDataByServerIdAndSunClass(String(_loc_4), _loc_8);
//			}
//			var _loc_11:* = new DLLFileObject(this.outFloder + _loc_2["swfurl"], _loc_2["swfurl"], 0, "", DLLFileObject.TYPE_DAR);
//			_loc_11.subClass = _loc_8;
//			_loc_11.serverid = _loc_4.toString();
//			var _loc_12:* = "" + _loc_4 + _loc_8;
//			_loc_11.name = _loc_12;
//			_loc_11.materialClassName = _loc_5;
//			_loc_9.registerDarFuncDic(_loc_4, _loc_6, _loc_8);
//			if (!_loc_9.listDllFileObject[_loc_12])
//			{
//				_loc_9.listDllFileObject[_loc_12] = _loc_11;
//				_loc_11.status = DLLFileObject.LOADING;
//				_loc_3 = new DllLoader();
//				_loc_3.addEventListener(MultiLoaderEvent.COMPLETE, this.onDarLoaderComplete);
//				_loc_3.addEventListener(MultiLoaderEvent.IO_ERROR, this.matOnIOError);
//				_loc_3.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
//				_loc_3.load([_loc_11]);
//			}
//			return;
//		}// end function
//		
//		private function onDarLoaderComplete(event:MultiLoaderEvent) : void
//		{
//			var _loc_2:Array = null;
//			var _loc_3:DarBitmapData = null;
//			var _loc_4:int = 0;
//			var _loc_5:* = event.data[0] as DLLFileObject;
//			if (_loc_5)
//			{
//				_loc_2 = this.darAnalyze.darwinFuncDic[_loc_5.name];
//				_loc_3 = this.darAnalyze.getDarwinBitmapDataByName(_loc_5.materialClassName);
//				if (_loc_2.length)
//				{
//					_loc_4 = 0;
//					while (_loc_4 < _loc_2.length)
//					{
//						
//						var _loc_6:* = _loc_2[_loc_4];
//						_loc_6._loc_2[_loc_4]["completeFunc"](_loc_3);
//						_loc_4 = _loc_4 + 1;
//					}
//					_loc_2.length = 0;
//				}
//			}
//			return;
//		}// end function
//		
//		private function startLoadBinList(param1:Object) : void
//		{
//			var _loc_2:Object = null;
//			var _loc_3:DllLoader = null;
//			var _loc_4:* = param1["serverId"];
//			var _loc_5:* = param1["subClass"];
//			var _loc_6:Function = param1["completeFunc"];
//			var _loc_7:* = "" + _loc_4 + _loc_5;
//			var _loc_8:* = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_BIN) as BinAnalyze;
//			var _loc_9:* = _loc_8.getBinDataByName(_loc_7);
//			if (_loc_9)
//			{
//				_loc_6(_loc_9);
//				return;
//			}
//			if (_loc_5 == "")
//			{
//				_loc_2 = this.uucAnalyze.getMaterialDataByServerId(String(_loc_4));
//			}
//			else
//			{
//				_loc_2 = this.uucAnalyze.getMaterialDataByServerIdAndSunClass(String(_loc_4), _loc_5);
//			}
//			var _loc_10:* = new DLLFileObject(this.outFloder + _loc_2["swfurl"], _loc_2["swfurl"], 0, "", DLLFileObject.TYPE_BIN);
//			_loc_10.subClass = _loc_5;
//			_loc_10.serverid = _loc_4.toString();
//			_loc_10.name = _loc_7;
//			_loc_8.registerBinFuncDic(String(_loc_4), _loc_6, _loc_5);
//			if (!_loc_8.listDllFileObject[_loc_7])
//			{
//				_loc_8.listDllFileObject[_loc_7] = _loc_10;
//				_loc_10.status = DLLFileObject.LOADING;
//				_loc_3 = new DllLoader();
//				_loc_3.addEventListener(MultiLoaderEvent.COMPLETE, this.onBinLoaderComplete);
//				_loc_3.addEventListener(MultiLoaderEvent.IO_ERROR, this.matOnIOError);
//				_loc_3.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
//				_loc_3.load([_loc_10]);
//			}
//			return;
//		}// end function
//		
//		private function onBinLoaderComplete(event:MultiLoaderEvent) : void
//		{
//			var _loc_2:BinAnalyze = null;
//			var _loc_3:Array = null;
//			var _loc_4:ByteArray = null;
//			var _loc_5:int = 0;
//			var _loc_6:Function = null;
//			var _loc_7:ByteArray = null;
//			var _loc_8:* = event.data[0] as DLLFileObject;
//			if (_loc_8)
//			{
//				_loc_2 = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_BIN) as BinAnalyze;
//				_loc_3 = _loc_2.binFuncDic[_loc_8.name];
//				_loc_4 = _loc_2.getBinDataByName(_loc_8.name);
//				if (_loc_3.length)
//				{
//					_loc_5 = 0;
//					while (_loc_5 < _loc_3.length)
//					{
//						
//						_loc_6 = _loc_3[_loc_5]["completeFunc"];
//						_loc_7 = new ByteArray();
//						_loc_4.readBytes(_loc_7, 0, _loc_4.bytesAvailable);
//						_loc_6(_loc_7);
//						_loc_4.position = 0;
//						_loc_5 = _loc_5 + 1;
//					}
//					_loc_3.length = 0;
//				}
//			}
//			return;
//		}// end function
		
		private function startLoadList(param1:Object) : void
		{
			var _loc_2:Object = null;
			var _loc_3:Boolean = false;
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_6:DisplayObject = null;
			var _loc_7:DLLFileObject = null;
			var _loc_8:DLLFileObject = null;
			var _loc_9:DllLoader = null;
			var _loc_10:* = param1["serverId"];
			var _loc_11:* = param1["materialClassName"];
			var _loc_12:* = param1["completeFunc"];
			var _loc_13:* = param1["completeFuncParams"] ? (param1["completeFuncParams"]) : ([]);
			var _loc_14:* = param1["typeFlag"];
			var _loc_15:* = param1["loadFlag"];
			var _loc_16:* = param1["subClass"];
			var _loc_17:* = this.libAnalyze.getClassByName(_loc_11);
			if (_loc_17)
			{
				if (_loc_14)
				{
					_loc_13.unshift(_loc_17);
					_loc_12.apply(null, _loc_13);
				}
				else
				{
					_loc_6 = new _loc_17;
					_loc_6["materialClassName"] = _loc_11;
					_loc_13.unshift(_loc_6);
					_loc_12.apply(null, _loc_13);
				}
				return;
			}
//			if (_loc_16 == "")
//			{
//				_loc_2 = this.uucAnalyze.getMaterialDataByServerId(String(_loc_10));
//			}
//			else
//			{
//				_loc_2 = this.uucAnalyze.getMaterialDataByServerIdAndSunClass(String(_loc_10), _loc_16);
//			}
			if (!_loc_2)
			{
				trace(_loc_10 + "��Ӧ���زĲ�����");
				_loc_17 = this.libAnalyze.getClassByName("NoneMaterial");
				if (_loc_14)
				{
					if (_loc_12 != null)
					{
						_loc_13.unshift(_loc_17);
						_loc_12.apply(null, _loc_13);
					}
				}
				else if (_loc_12 != null)
				{
					_loc_6 = new _loc_17;
					_loc_6["materialClassName"] = _loc_11;
					_loc_13.unshift(_loc_6);
					_loc_12.apply(null, _loc_13);
				}
				return;
			}
			var _loc_18:* = new DLLFileObject(this.outFloder + _loc_2["swfurl"], _loc_2["swfurl"], 0, "", DLLFileObject.TYPE_LIB);
			_loc_18.subClass = _loc_16;
			_loc_18.serverid = _loc_10;
			LisDictionary.getInstance().registerMaterialClassDic(_loc_10, _loc_11, _loc_12, _loc_14, _loc_13, _loc_16);
			var _loc_19:* = LisDictionary.getInstance().lisDllFileObjct;
			if (_loc_19.length == 0)
			{
				_loc_19.push(_loc_18);
			}
			_loc_4 = 0;
			_loc_5 = _loc_19.length;
			while (_loc_4 < _loc_5)
			{
				
				_loc_7 = _loc_19[_loc_4];
				if (_loc_7.serverid == _loc_18.serverid)
				{
					if (_loc_16 == "")
					{
						_loc_3 = true;
					}
					break;
				}
				_loc_4 = _loc_4 + 1;
			}
			if (!_loc_3)
			{
				_loc_19.push(_loc_18);
			}
			_loc_4 = 0;
			_loc_5 = _loc_19.length;
			while (_loc_4 < _loc_5)
			{
				
				_loc_8 = _loc_19[_loc_4];
				if (int(_loc_8.serverid) == int(_loc_10))
				{
					if (_loc_8.subClass == _loc_16)
					{
					}
					if (_loc_8.status == DLLFileObject.NO_LOADER)
					{
						_loc_8.status = DLLFileObject.LOADING;
						_loc_9 = new DllLoader();
						_loc_9.addEventListener(MultiLoaderEvent.COMPLETE, this.onComplete);
						_loc_9.addEventListener(MultiLoaderEvent.IO_ERROR, this.matOnIOError);
						_loc_9.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
						_loc_9.load([_loc_8]);
						break;
					}
				}
				_loc_4 = _loc_4 + 1;
			}
			return;
		}// end function
		
		public function openLoad() : void
		{
			var _loc_1:DLLFileObject = null;
			var _loc_2:DllLoader = null;
			var _loc_3:* = LisDictionary.getInstance().lisDllFileObjct;
			var _loc_4:int = 0;
			var _loc_5:* = _loc_3.length;
			while (_loc_4 < _loc_5)
			{
				
				_loc_1 = _loc_3[_loc_4];
				if (_loc_1.status == DLLFileObject.NO_LOADER)
				{
					_loc_1.status = DLLFileObject.LOADING;
					_loc_2 = new DllLoader();
					_loc_2.load([_loc_1]);
					_loc_2.addEventListener(MultiLoaderEvent.COMPLETE, this.onComplete);
					break;
				}
				_loc_4 = _loc_4 + 1;
			}
			return;
		}// end function
		
		private function onComplete(event:MultiLoaderEvent) : void
		{
			var _loc_5:Array = null;
			var _loc_2:Class = null;
			var _loc_3:String = null;
			var _loc_4:Function = null;
			var _loc_6:Boolean = false;
			var _loc_7:DisplayObject = null;
			var _loc_8:Function = null;
			event.target.removeEventListener(MultiLoaderEvent.COMPLETE, this.onComplete);
			var _loc_9:* = event.data[0].serverid;
			var _loc_10:* = event.data[0].subClass;
			var _loc_11:* = LisDictionary.getInstance().classListDic[_loc_9 + _loc_10];
			if (!_loc_11)
			{
				return;
			}
			var _loc_12:int = 0;
			while (_loc_12 < _loc_11.length)
			{
				
				_loc_3 = _loc_11[_loc_12]["className"];
				if (App.appDomain.hasDefinition(_loc_3))
				{
					_loc_2 = getDefinitionByName(_loc_3) as Class;
				}
				else
				{
					_loc_2 = getDefinitionByName("NoneMaterial") as Class;
				}
				if (_loc_2)
				{
					_loc_4 = _loc_11[_loc_12]["completeFunc"];
					_loc_6 = _loc_11[_loc_12]["typeFlag"];
					_loc_5 = _loc_11[_loc_12]["completeFuncParams"] ? (_loc_11[_loc_12]["completeFuncParams"]) : ([]);
					if (_loc_6)
					{
						if (_loc_4 != null)
						{
							_loc_5.unshift(_loc_2);
							_loc_4.apply(null, _loc_5);
						}
					}
					else if (_loc_4 != null)
					{
						_loc_7 = new _loc_2;
						_loc_7["materialClassName"] = _loc_3;
						_loc_5.unshift(_loc_7);
						_loc_4.apply(null, _loc_5);
					}
					_loc_11[_loc_12]["completeFunc"] = null;
					_loc_11[_loc_12]["completeFuncParams"] = null;
				}
				_loc_12 = _loc_12 + 1;
			}
			var _loc_13:int = 0;
			while (_loc_13 < _loc_11.length)
			{
				
				_loc_8 = _loc_11[_loc_13]["completeFunc"];
				if (_loc_8 == null)
				{
					_loc_11.splice(_loc_13, 1);
					break;
				}
				_loc_13 = _loc_13 + 1;
			}
			return;
		}// end function
		
//		public function getImgMaterialByUrl(url:String, fun:Function) : void
//		{
//			var _loc_3:* = new Object();
//			var _loc_4:* = this._imgAnalyze.getBitmapByUrl(url);
//			_loc_3["bitmap"] = _loc_4;
//			_loc_3["url"] = url;
//			if (_loc_4)
//			{
//				fun(_loc_3);
//				return;
//			}
//			var _loc_5:* = new DLLFileObject(this.outFloder + url, url, 0, "", DLLFileObject.IMG_TYPE);
//			this._imgDic[url] = fun;
//			var _loc_6:* = new DllLoader();
//			_loc_6.load([_loc_5]);
//			_loc_6.addEventListener(MultiLoaderEvent.COMPLETE, this.imgOnComplete);
//			return;
//		}// end function
//		
//		private function imgOnComplete(event:MultiLoaderEvent) : void
//		{
//			var _loc_2:* = event.data[0];
//			var _loc_3:Function = this._imgDic[_loc_2.name];
//			var _loc_4:* = Bitmap(_loc_2.result);
//			var _loc_5:* = new Object();
//			_loc_5["bitmap"] = _loc_4;
//			_loc_5["url"] = _loc_2.name;
//			if (_loc_3 != null)
//			{
//				_loc_3(_loc_5);
//				delete this._imgDic[_loc_2.name];
//			}
//			return;
//		}// end function
//		
//		public function cancleGetMaterial(key:int, fun:Function) : void
//		{
//			var _loc_3:Function = null;
//			var _loc_4:* = LisDictionary.getInstance().classListDic[String(key)];
//			if (!_loc_4)
//			{
//				return;
//			}
//			var _loc_5:int = 0;
//			while (_loc_5 < _loc_4.length)
//			{
//				
//				_loc_3 = _loc_4[_loc_5]["completeFunc"];
//				if (_loc_3 == fun)
//				{
//					_loc_4[_loc_5]["completeFunc"] = null;
//					break;
//				}
//				_loc_5 = _loc_5 + 1;
//			}
//			return;
//		}// end function
//		
//		public function getDataByServerId($serverId:String, fun:Function) : void
//		{
//			var completeArray:Array;
//			var loadArray:Array;
//			var lisComplete:Function;
//			var lisLoaded:Function;
//			var lisData:Array;
//			var dllFileObject:DLLFileObject;
//			var lis:int;
//			var tempDLLFileObject:DLLFileObject;
//			var dicFuncArray:Array;
//			var dic:int;
//			var dllLoader:DllLoader;
//			var serverId:String;
//			var delayLoadArray:Array;
//			var i:int;
//			var artmp:Array;
//			var $serverId:* = $serverId;
//			var fun:* = fun;
//			serverId = $serverId;
//			var completeFunc:* = fun;
//			lisComplete = function (event:MultiLoaderEvent) : void
//			{
//				var _loc_4:int = 0;
//				var _loc_2:int = 0;
//				var _loc_3:int = 0;
//				while (_loc_2 < event.data.length)
//				{
//					
//					completeArray = completeArray.concat(event.data[_loc_2].result);
//					_loc_2 = _loc_2 + 1;
//				}
//				if (completeArray.length != loadArray.length)
//				{
//					return;
//				}
//				var _loc_5:* = LisDictionary.getInstance().listDic[serverId];
//				if (_loc_5)
//				{
//					_loc_3 = 0;
//					_loc_4 = _loc_5.length;
//					while (_loc_3 < _loc_4)
//					{
//						
//						var _loc_6:* = _loc_5;
//						_loc_6._loc_5[_loc_3](completeArray);
//						_loc_3 = _loc_3 + 1;
//					}
//					delete LisDictionary.getInstance().listDic[serverId];
//				}
//				return;
//			}// end function
//				;
//			lisLoaded = function (event:Event) : void
//			{
//				var _loc_2:int = 0;
//				var _loc_3:int = 0;
//				if (completeArray.length != loadArray.length)
//				{
//					return;
//				}
//				completeArray = completeArray.concat((event.target as DLLFileObject).result);
//				var _loc_4:* = LisDictionary.getInstance().listDic[serverId];
//				if (_loc_4)
//				{
//					_loc_2 = 0;
//					_loc_3 = _loc_4.length;
//					while (_loc_2 < _loc_3)
//					{
//						
//						var _loc_5:* = _loc_4;
//						_loc_5._loc_4[_loc_2](completeArray);
//						_loc_2 = _loc_2 + 1;
//					}
//					delete LisDictionary.getInstance().listDic[serverId];
//				}
//				return;
//			}// end function
//				;
//			LisDictionary.getInstance().registerDic(serverId, completeFunc);
//			var uucAnalyze:* = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.UUC_TYPE) as UUCAnalyze;
//			loadArray = uucAnalyze.getDataByServerId(serverId);
//			var lisAnalyze:* = AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIS) as LisAnalyze;
//			while (i < loadArray.length)
//			{
//				
//				lisData = lisAnalyze.getLisDataByMid(loadArray[i].mid);
//				if (lisData)
//				{
//					completeArray = completeArray.concat(lisData);
//				}
//				else
//				{
//					dllFileObject = new DLLFileObject(this.outFloder + loadArray[i].swfurl, loadArray[i].typeName, 0, "", DLLFileObject.TYPE_LIS);
//					if (LisDictionary.getInstance().lisDllFileObjct.length != 0)
//					{
//						while (lis < LisDictionary.getInstance().lisDllFileObjct.length)
//						{
//							
//							tempDLLFileObject = LisDictionary.getInstance().lisDllFileObjct[lis];
//							if (tempDLLFileObject)
//							{
//							}
//							if (tempDLLFileObject.url == dllFileObject.url)
//							{
//							}
//							if (tempDLLFileObject.status == DLLFileObject.LOADING)
//							{
//								tempDLLFileObject.addEventListener(DLLEvent.SWFURL_COMPLETE, lisLoaded);
//							}
//							else
//							{
//								delayLoadArray.push(dllFileObject);
//								LisDictionary.getInstance().lisDllFileObjct.push(dllFileObject);
//							}
//							lis = (lis + 1);
//						}
//					}
//					else
//					{
//						delayLoadArray.push(dllFileObject);
//						LisDictionary.getInstance().lisDllFileObjct.push(dllFileObject);
//					}
//				}
//				i = (i + 1);
//			}
//			if (completeArray.length == loadArray.length)
//			{
//				dicFuncArray = LisDictionary.getInstance().listDic[serverId];
//				while (dic < dicFuncArray.length)
//				{
//					
//					artmp = dicFuncArray;
//					artmp[dic](completeArray);
//					dic = (dic + 1);
//				}
//				delete LisDictionary.getInstance().listDic[serverId];
//				return;
//			}
//			if (delayLoadArray.length)
//			{
//				dllLoader = new DllLoader();
//				dllLoader.load(delayLoadArray);
//				dllLoader.addEventListener(MultiLoaderEvent.COMPLETE, lisComplete);
//			}
//			return;
//		}// end function
//		
//		public function getlisClassByName(ar:Array, name:String) : Class
//		{
//			var _loc_3:Class = null;
//			var _loc_4:ApplicationDomain = null;
//			var _loc_5:int = 0;
//			var _loc_6:* = ar.length;
//			while (_loc_5 < ar.length)
//			{
//				
//				_loc_4 = ar[_loc_5].appDomain;
//				if (_loc_4.hasDefinition(name))
//				{
//					_loc_3 = _loc_4.getDefinition(name) as Class;
//					return _loc_3;
//				}
//				_loc_5 = _loc_5 + 1;
//			}
//			return null;
//		}// end function
//		
//		public function disposeGetDataByServerId(serverId:String, fun:Function) : void
//		{
//			var _loc_3:int = 0;
//			var _loc_4:* = LisDictionary.getInstance().listDic[serverId];
//			if (_loc_4)
//			{
//				_loc_3 = _loc_4.indexOf(fun);
//				if (_loc_3 != -1)
//				{
//					_loc_4.splice(_loc_3, 1);
//				}
//			}
//			return;
//		}// end function
//		
//		public function getJsonDataByName(name:String) : Object
//		{
//			var _loc_2:* = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.JSON_TYPE) as JsonAnalyze).getJsonObjectByName(name);
//			return _loc_2;
//		}// end function
//		
//		public function getXMLDataByName(name:String) : XML
//		{
//			var _loc_2:* = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.XML_TYPE) as XMLAnalyze).getXMLByName(name);
//			return _loc_2;
//		}// end function
//		
//		public function getUUCByName(fileName:String, keyName:String = "") : Object
//		{
//			var _loc_3:* = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_UUC) as UUCAnalyze).getUUCDataByName(fileName, keyName);
//			return _loc_3;
//		}// end function
//		
//		public function getBinObjectByName(name:String) : ByteArray
//		{
//			var _loc_2:* = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIB) as LibAnalyze).getByteArrayByName(name) as ByteArray;
//			if (!_loc_2)
//			{
//				_loc_2 = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_BIN) as BinAnalyze).getBinDataByName(name);
//			}
//			return _loc_2;
//		}// end function
//		
//		public function getBinDataByServerId(serverId:int, compFun:Function, weight:int = 0, subClass:String = "") : void
//		{
//			var _loc_5:Object = {};
//			_loc_5["serverId"] = serverId;
//			_loc_5["subClass"] = subClass;
//			_loc_5["completeFunc"] = compFun;
//			_loc_5["weight"] = weight;
//			this._binLoadList.push(_loc_5);
//			return;
//		}// end function
//		
//		public function getDarDataByServerIdMaterialClassName(serverId:int, className:String, compFun:Function, weight:int = 0) : void
//		{
//			var _loc_5:Object = {};
//			_loc_5["serverId"] = serverId;
//			_loc_5["materialClassName"] = className;
//			_loc_5["completeFunc"] = compFun;
//			_loc_5["weight"] = weight;
//			_loc_5["subClass"] = className;
//			this._darLoadList.push(_loc_5);
//			return;
//		}// end function
//		
//		public function getByteArrayByName(name:String) : ByteArray
//		{
//			var _loc_2:* = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIB) as LibAnalyze).getByteArrayByName(name) as ByteArray;
//			return _loc_2;
//		}// end function
//		
//		public function getClassByName(name:String) : Class
//		{
//			var _loc_2:* = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIB) as LibAnalyze).getClassByName(name) as Class;
//			return _loc_2;
//		}// end function
		
		public function getDisplayObjectByName(name:String) : Object
		{
			var _loc_2:* = (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIB) as LibAnalyze).getDisplayObjectByName(name) as Object;
			return _loc_2;
		}// end function
		
		public function getLoaderByName(name:String) : Loader
		{
			return (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_MAIN) as MainAnalyze).getLoaderByName(name);
		}// end function
//		
//		public function getMaterialListByMid(param1:String) : Array
//		{
//			return (AnalyzeDictionary.getInstance().getAnalyze(DLLFileObject.TYPE_LIS) as LisAnalyze).getMaterialByMid(param1);
//		}// end function
//		
//		public function getStreamFileByUrl(url:String, fun:Function, weight:int = 0) : DisplayObject
//		{
//			var _loc_4:Object = null;
//			var _loc_5:Object = null;
//			if (!this._loaderDic)
//			{
//				this._loaderDic = new Dictionary();
//				this._requestStreamList = [];
//			}
//			if (url)
//			{
//				_loc_4 = new Object();
//				_loc_4.url = url;
//				_loc_4.weight = weight;
//				this._requestStreamList.push(_loc_4);
//				this._requestStreamList.sortOn("weight", Array.NUMERIC);
//				_loc_5 = new Object();
//				_loc_5.displayChild = new Sprite();
//				_loc_5.completeFunc = fun;
//				this._loaderDic[url] = _loc_5;
//			}
//			if (!this._urlStream)
//			{
//				this._loadingUrl = url;
//				this._urlStream = new URLStream();
//				this._urlStream.addEventListener(ProgressEvent.PROGRESS, this.streamLoaderOnProgress);
//				this._urlStream.addEventListener(Event.COMPLETE, this.streamLoaderComplete);
//				this.startStreamLoader();
//			}
//			return this._loaderDic[url]["displayChild"];
//		}// end function
//		
//		private function streamLoaderOnProgress(event:ProgressEvent) : void
//		{
//			this._urlStream.readBytes(this._streamByte, this._streamByte.length);
//			if (this._tempDisplayObjectContainer.numChildren)
//			{
//				this._tempDisplayObjectContainer.removeChildAt(0);
//			}
//			var _loc_2:* = new Loader();
//			this._tempDisplayObjectContainer.addChild(_loc_2);
//			_loc_2.loadBytes(this._streamByte);
//			return;
//		}// end function
//		
//		private function startStreamLoader() : void
//		{
//			this._loadingUrl = this._requestStreamList[0]["url"];
//			this._tempDisplayObjectContainer = this._loaderDic[this._loadingUrl]["displayChild"];
//			this._streamByte = new ByteArray();
//			this._urlStream.load(new URLRequest(this._loadingUrl));
//			return;
//		}// end function
//		
//		private function streamLoaderComplete(event:Event) : void
//		{
//			this._streamByte = null;
//			var _loc_2:* = this._loaderDic[this._loadingUrl];
//			var _loc_3:Function = _loc_2["completeFunc"];
//			var _loc_4:* = _loc_2["displayChild"];
//			if (_loc_3 != null)
//			{
//			}
//			if (_loc_4)
//			{
//				_loc_3(_loc_4);
//			}
//			delete this._loaderDic[this._loadingUrl];
//			this._requestStreamList.shift();
//			if (this._requestStreamList.length != 0)
//			{
//				this.startStreamLoader();
//			}
//			return;
//		}// end function
		
		public static function getInstance() : Dll
		{
			if (instance == null)
			{
				instance = new Dll;
			}
			return instance;
		}// end function
		
//		public static function getConfingXmlList() : Object
//		{
//			return IniToFlieList.CONFIG_XML_LIST;
//		}// end function
	}
}