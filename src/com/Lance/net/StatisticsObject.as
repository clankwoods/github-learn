package com.Lance.net
{

    public class StatisticsObject 
    {
        public var statisUserId:String = "";
        public var statisCdnIP:String = "";
        public var statisUserIP:String = "";
        public var statisLoadTime:String = "";
        public var statisFileCRC:String = "";
        public var statisErrorCode:int = 0;

        public function StatisticsObject()
        {
            return;
        }// end function

        public static function getStatisticsPostData(statisticsObject:StatisticsObject) : Object
        {
            var _loc_2:Object = {};
            _loc_2["userId"] = statisticsObject.statisUserId;
            _loc_2["cdnIP"] = statisticsObject.statisCdnIP;
            _loc_2["userIP"] = statisticsObject.statisUserIP;
            _loc_2["loadTime"] = statisticsObject.statisLoadTime;
            _loc_2["crc"] = statisticsObject.statisFileCRC;
            _loc_2["errorCode"] = statisticsObject.statisErrorCode;
            return _loc_2;
        }// end function

    }
}
