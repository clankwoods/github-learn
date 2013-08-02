package com.Lance.utils
{
	import flash.net.SharedObject;

    public class SharedObjectUtil extends Object
    {
        private static var sharedObject:SharedObject;
        private static const FM_DIR:String = "fmDir";
        private static const FM_SHARE_OBJ:SharedObject = SharedObject.getLocal(FM_DIR);

        public function SharedObjectUtil()
        {
            return;
        }// end function

        public static function creatSharedObject(name:String) : SharedObject
        {
            return SharedObject.getLocal(name, "/");
        }// end function

        public static function getSharedObjectData(name:String) : Object
        {
            sharedObject = SharedObject.getLocal(name, "/");
            return sharedObject.data;
        }// end function

        public static function writeSharedObjectData(name:String, key:String, data:Object) : void
        {
            name = name;
            key = key;
            data = data;
            sharedObject = SharedObject.getLocal(name, "/");
            sharedObject.data[key] = data;
            try
            {
                sharedObject.flush(1000);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function readSharedObjectData(name:String, key:String) : Object
        {
            sharedObject = SharedObject.getLocal(name, "/");
            return sharedObject.data[key];
        }// end function

        public static function fmWriteSharedObject(key:String, url:String) : void
        {
            key = key;
            url = url;
            var _loc_3:* = SharedObject.getLocal(FM_DIR);
            _loc_3.data[key] = url;
            try
            {
                _loc_3.flush(1000);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function fmReadSharedObject(key:String) : String
        {
            var _loc_2:String = null;
            var _loc_3:* = FM_SHARE_OBJ.data;
            var _loc_4:String = "";
            for (_loc_2 in _loc_3)
            {
                
                if (_loc_2 == key)
                {
                    _loc_4 = _loc_3[key];
                }
            }
            return _loc_4;
        }// end function

    }
}
