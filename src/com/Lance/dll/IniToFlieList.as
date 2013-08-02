package com.Lance.dll
{
	import com.Lance.net.LoginStatistics;
	import com.Lance.net.StatisticsErrorConst;
	import com.Lance.net.StatisticsObject;
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

    public class IniToFlieList extends Object
    {
        private var outFloder:String;
        private var floder:String;
        private var listCounter:int = 0;
        private var listLength:int;
        private var lang:String;
        private var loadComp:Function;
        private var status:String;
        private var mainFileList:FileList;
        private var _platformIniUrl:String = "";
        private var _platformOutUrl:String = "";
        public static var CONFIG_XML_LIST:Object;
        public static var listDic:Dictionary;

        public function IniToFlieList()
        {
            CONFIG_XML_LIST = new Object();
            if (!listDic)
            {
                listDic = new Dictionary();
            }
            return;
        }// end function



        public function analyzeXml(list:Array, lang:String, status:String, Fun:Function, platformIniUrl:String = "", platformOutUrl:String = "") : void
        {
            if (!this.mainFileList)
            {
                this.mainFileList = new FileList();
            }
            this.listLength = list.length;
            this.lang = lang;
            this.status = status;
            this.loadComp = Fun;
            var index:int = 0;
            while (index < list.length)
            {
                
                this.loadXml(list[index]);
                index = index + 1;
            }
            return;
        }// end function

        private function loadXml(url:String) : void
        {
            var urlLoader:URLLoader = new URLLoader(new URLRequest(url));
            urlLoader.addEventListener(Event.COMPLETE, this.xmlComplete);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.xmlError);
            urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            return;
        }// end function

        private function onSecurityError(event:SecurityErrorEvent) : void
        {
            var so:StatisticsObject = new StatisticsObject();
            so.statisErrorCode = StatisticsErrorConst.SECURITY_ERROR;
            LoginStatistics.instance.sendLoginStatistics(so);
            return;
        }// end function

        private function xmlComplete(event:Event) : void
        {
            var index:String = "";
            var localName:String = null;
            var fileNodeChild:XMLList = null;
            var dllFO:DLLFileObject = null;
            var urlListItem:XMLList = null;
            var fileNode:XML = null;
            var name:String = null;
            var fileListXML:XML = XML(event.target.data);
            var fileList:XMLList = fileListXML.elements("*");
            (this.listCounter + 1);
			
			
            for each (fileNode in fileList)
            {
                localName = fileNode.localName();
                if (CONFIG_XML_LIST[localName])
                {
                    fileNodeChild = fileNode.children();
                    XML(CONFIG_XML_LIST[localName]).appendChild(fileNodeChild);
                    continue;
                }
                CONFIG_XML_LIST[localName] = fileNode;
            }
            if (this._platformIniUrl != "")
            {
                this.floder = this._platformIniUrl;
            }
            else
            {
                urlListItem = fileListXML.urlList.item;
                if (urlListItem.@type == "folder")
                {
                    this.floder = urlListItem.@url;
                }
            }
            if (this.floder != null)
            {
            }
            if (this.floder != "")
            {
                Dll.getInstance().floder = this.floder;
            }
            if (this._platformOutUrl != "")
            {
                this.outFloder = this._platformOutUrl;
            }
            else
            {
                urlListItem = fileListXML.urlList.item;
                if (urlListItem.@type == "outfolder")
                {
                    this.outFloder = urlListItem.@url;
                }
            }
            if (this.outFloder != null)
            {
            }
            if (this.outFloder != "")
            {
                Dll.getInstance().outFloder = this.outFloder;
            }
			var tmpList:XMLList = fileListXML.dllList.children();
            for (index in tmpList)				
            {
                if ( tmpList[index].@status != "all")
                {
                }
                if (tmpList[index].@status == status)
                {
                    if (tmpList[index].@language != "all")
                    {
                    }
                    if (tmpList[index].@language == Dll.getInstance().lang)
                    {
                        name = tmpList[index].@name;
                        if (!listDic[name])
                        {
                            dllFO = new DLLFileObject();
                            dllFO.name = tmpList[index].@name;
                            dllFO.groupName = tmpList[index].@groupName;
                            dllFO.type = tmpList[index].@type;
                            dllFO.size = tmpList[index].@size;
                            dllFO.weight = int(tmpList[index].@weight);
                            dllFO.module = tmpList[index].@module;
                            if (fileListXML.urlList.children()[0].@type == "folder")
                            {
                                dllFO.url = this.floder + tmpList[index].@url + "?s=" + Dll.getInstance().version;
                            }
                            else
                            {
                                dllFO.url = this.outFloder + tmpList[index].@url + "?s=" + Dll.getInstance().version;
                            }
                            dllFO.serverid = tmpList[index].@serverid ? (tmpList[index].@serverid) : ("0");
                            dllFO.status = DLLFileObject.NO_LOADER;
                            if (!listDic[name])
                            {
                                this.mainFileList.fileList.push(dllFO);
                                listDic[name] = dllFO;
                            }
                        }
                    }
                }
            }
			this.listCounter = this.listCounter + 1;
            if (this.listCounter == this.listLength)
            {
//				trace( JSON.encode(listDic));
                this.loadComp(this.mainFileList);
            }
            return;
        }// end function

        private function xmlError(event:IOErrorEvent) : void
        {
            var _loc_2:* = new StatisticsObject();
            _loc_2.statisErrorCode = StatisticsErrorConst.INI_FILE_ERROR;
            LoginStatistics.instance.sendLoginStatistics(_loc_2);
            return;
        }// end function

    }
}
