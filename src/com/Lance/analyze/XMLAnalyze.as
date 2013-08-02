package com.Lance.analyze
{
	import com.Lance.dll.DLLFileObject;
	
	import flash.utils.ByteArray;

    public class XMLAnalyze extends AnalyzeBase
    {
        private var xmlList:Object;

        public function XMLAnalyze()
        {
            this.xmlList = {};
            return;
        }// end function

        override public function analyze(btyArr:ByteArray, dllfileObject:DLLFileObject, Fun:Function) : void
        {
            btyArr.position = 0;
            var _loc_4:* = btyArr.readUTFBytes(btyArr.length);
            dllfileObject.result = _loc_4;
            dllfileObject.status = DLLFileObject.LOADED;
            this.xmlList[dllfileObject.name] = XML(dllfileObject.result);
            Fun();
            return;
        }// end function

        public function getXMLByName(name:String) : XML
        {
            var _loc_2:XML = null;
            _loc_2 = this.xmlList[name] as XML;
            if (!_loc_2)
            {
                _loc_2 = new XML();
            }
            return _loc_2;
        }// end function

    }
}
