package com.Lance.analyze
{
    import com.Lance.analyze.AnalyzeBase;
    import com.Lance.base.App;
    import com.Lance.dll.DLLEvent;
    import com.Lance.dll.DLLFileObject;
    import com.Lance.dll.Dll;
    
    import flash.display.Loader;
    import flash.events.Event;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    

    public class LibAnalyze extends AnalyzeBase
    {
        private var libList:Array;
        private var _appDomainList:Array;
        private var dataDic:Dictionary;
        private var funcDic:Dictionary;
        private var dllDic:Dictionary;
        private var _returnClassDic:Dictionary;
        private var _ld:LoaderContext;

        public function LibAnalyze()
        {
            this.libList = [];
            this._appDomainList = [];
            this._returnClassDic = new Dictionary();
            this.dataDic = new Dictionary();
            this.funcDic = new Dictionary();
            this.dllDic = new Dictionary();
            this._ld = new LoaderContext(false, App.appDomain);
            return;
        }// end function

        override public function analyze(ba:ByteArray, dllFO:DLLFileObject, fun:Function) : void
        {
            var _loc_4:* = new Loader();
            this.dataDic[_loc_4] = ba;
            this.funcDic[_loc_4] = fun;
            this.dllDic[_loc_4] = dllFO;
            _loc_4.loadBytes(ba, this._ld);
            _loc_4.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onCompletefunc);
            return;
        }// end function

        private function onCompletefunc(event:Event) : void
        {
            var _loc_2:* = event.target.loader;
            event.target.removeEventListener(Event.COMPLETE, this.onCompletefunc);
            this.dllDic[_loc_2].result = {data:this.dataDic[_loc_2], appDomain:event.currentTarget.applicationDomain};
            this.dllDic[_loc_2].status = DLLFileObject.LOADED;
            this.libList.push(this.dllDic[_loc_2]);
            this._appDomainList.push(this.dllDic[_loc_2].result.appDomain);
            this.funcDic[_loc_2]();
            var _loc_4:* = new DLLEvent(DLLEvent.SINGLECOMPLETE, this.dllDic[_loc_2].name);
            delete this.dataDic[_loc_2];
            delete this.dllDic[_loc_2];
            delete this.funcDic[_loc_2];
            _loc_2 = null;
            Dll.getInstance().dispatchEvent(_loc_4);
            return;
        }// end function

        public function getByteArrayByName(param1:String) : ByteArray
        {
            var _loc_2:DLLFileObject = null;
            var _loc_3:int = 0;
            while (_loc_3 < this.libList.length)
            {
                
                _loc_2 = this.libList[_loc_3] as DLLFileObject;
                if (_loc_2.name == param1)
                {
                    return _loc_2.result["data"] as ByteArray;
                }
                _loc_3 = _loc_3 + 1;
            }
            return null;
        }// end function

        public function getDisplayObjectByName(name:String) : Object
        {
            var _loc_2:* = this.getClassByName(name);
            return _loc_2 ? (new _loc_2) : (null);
        }// end function

        public function getClassByName(name:String) : Class
        {
            var _loc_2:Class = null;
            if (this._returnClassDic[name])
            {
                return this._returnClassDic[name];
            }
            if (App.appDomain.hasDefinition(name))
            {
                _loc_2 = getDefinitionByName(name) as Class;
            }
            this._returnClassDic[name] = _loc_2;
            return _loc_2 ? (_loc_2) : (null);
        }// end function

        public function getClassByNameWithPriorityDomain(domainName:String, fileName:String) : Class
        {
            var _loc_3:Class = null;
            var _loc_4:DLLFileObject = null;
            var _loc_5:ApplicationDomain = null;
            for each (_loc_4 in this.libList)
            {
                
                if (fileName === _loc_4.name)
                {
                    _loc_5 = _loc_4["result"]["appDomain"] as ApplicationDomain;
                    if (_loc_5.hasDefinition(domainName))
                    {
                        _loc_3 = _loc_5.getDefinition(domainName) as Class;
                    }
                }
            }
            if (_loc_3)
            {
                return _loc_3;
            }
            return this.getClassByName(domainName);
        }// end function

    }
}
