package com.Lance.analyze
{
	import com.Lance.dll.DLLFileObject;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

    public class BinAnalyze extends AnalyzeBase
    {
        private var _binDataDic:Dictionary;
        private var _binFuncDic:Dictionary;
        private var _listDllFileObject:Dictionary;

        public function BinAnalyze()
        {
            this._binDataDic = new Dictionary();
            this._binFuncDic = new Dictionary();
            this._listDllFileObject = new Dictionary();
            return;
        }// end function

        override public function analyze(btyArr:ByteArray, dllFileObject:DLLFileObject, Fun:Function) : void
        {
            if (btyArr)
            {
                this._binDataDic[dllFileObject.name] = btyArr;
                dllFileObject.result = btyArr;
                dllFileObject.status = DLLFileObject.LOADED;
            }
            if (Fun != null)
            {
                Fun();
            }
            return;
        }// end function

        public function getBinDataByName(key:String) : ByteArray
        {
            var _loc_2:ByteArray = null;
            var _loc_3:* = this._binDataDic[key];
            if (_loc_3)
            {
                _loc_2 = new ByteArray();
                _loc_3.position = 0;
                _loc_3.readBytes(_loc_2, 0, _loc_3.bytesAvailable);
                return _loc_2;
            }
            return null;
        }// end function

        public function registerBinFuncDic(param1:String, param2:Function, param3:String = "") : void
        {
            if (this._binFuncDic[param1 + param3])
            {
                this._binFuncDic[param1 + param3].push({serverId:param1, completeFunc:param2, subClass:param3});
            }
            else
            {
                this._binFuncDic[param1 + param3] = [{serverId:param1, completeFunc:param2, subClass:param3}];
            }
            return;
        }// end function

        public function get binFuncDic() : Dictionary
        {
            return this._binFuncDic;
        }// end function

        public function get listDllFileObject() : Dictionary
        {
            return this._listDllFileObject;
        }// end function

        public function set listDllFileObject(param1:Dictionary) : void
        {
            this._listDllFileObject = param1;
            return;
        }// end function

    }
}
