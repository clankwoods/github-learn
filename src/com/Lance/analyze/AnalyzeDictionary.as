package com.Lance.analyze
{
	import com.Lance.dll.DLLFileObject;
	import flash.utils.Dictionary;

    public class AnalyzeDictionary 
    {
        private var analyzeDic:Dictionary;
        private static var instance:AnalyzeDictionary;

        public function AnalyzeDictionary()
        {
            if (instance == null)
            {
                this.analyzeDic = new Dictionary();
				this.analyzeDic[DLLFileObject.TYPE_LIB] = LibAnalyze;
				this.analyzeDic[DLLFileObject.TYPE_MAIN] = MainAnalyze;
				this.analyzeDic[DLLFileObject.XML_TYPE] = XMLAnalyze;
				this.analyzeDic[DLLFileObject.TYPE_BIN] = BinAnalyze;
            }
            else
            {
                throw new Error("???AnalyzeDictionary????");
            }
            return;
        }// end function

        public function registerAnalyze(name:String, classname:Class) : void
        {
            if (!this.analyzeDic[name])
            {
                this.analyzeDic[name] = classname;
            }
            return;
        }// end function

        public function getAnalyze(name:String) : AnalyzeBase
        {
            if (this.analyzeDic[name] is Class)
            {
                this.analyzeDic[name] = new (this.analyzeDic[name] as Class)();
            }
            return this.analyzeDic[name];
        }// end function

        public static function getInstance() : AnalyzeDictionary
        {
            if (!instance)
            {
                instance = new AnalyzeDictionary;
            }
            return instance;
        }// end function

    }
}
