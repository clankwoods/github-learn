package com.Lance.analyze
{
    import com.Lance.analyze.AnalyzeBase;
    import com.Lance.dll.DLLFileObject;
    import com.Lance.dll.Dll;
    
    import flash.display.Loader;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    

    public class MainAnalyze extends AnalyzeBase
    {
        private var mainList:Array;
        private var _dataDic:Dictionary;
        private var _dllFileDic:Dictionary;
        private var _funcDic:Dictionary;

        public function MainAnalyze()
        {
            this.mainList = [];
            this._dataDic = new Dictionary();
            this._dllFileDic = new Dictionary();
            this._funcDic = new Dictionary();
            return;
        }// end function

        override public function analyze(param1:ByteArray, param2:DLLFileObject, param3:Function) : void
        {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            loader.loadBytes(param1);
            this._dataDic[loader] = param1;
            this._dllFileDic[loader] = param2;
            this._funcDic[loader] = param3;
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            var loader:Loader = event.target.loader;
            event.target.removeEventListener(Event.COMPLETE, this.onComplete);
            this._dllFileDic[loader].result = {data:this._dataDic[loader], appDomain:event.currentTarget.applicationDomain};
            if (this._dllFileDic[loader].name == "main")
            {
                Dll.getInstance().mainAppDomain = event.currentTarget.applicationDomain;
            }
            this._dllFileDic[loader].status = DLLFileObject.LOADED;
            this.mainList.push({fileObject:this._dllFileDic[loader], fileLoader:loader});
            _funcDic[loader]();
            delete this._dataDic[loader];
            delete this._dllFileDic[loader];
            delete this._funcDic[loader];
            return;
        }// end function

        public function getLoaderByName(name:String) : Loader
        {
            var _loc_2:DLLFileObject = null;
            var _loc_3:int = 0;
            while (_loc_3 < this.mainList.length)
            {
                
                _loc_2 = this.mainList[_loc_3]["fileObject"] as DLLFileObject;
                if (_loc_2.name == name)
                {
                    return this.mainList[_loc_3]["fileLoader"] as Loader;
                }
                _loc_3 = _loc_3 + 1;
            }
            return new Loader();
        }// end function

    }
}
