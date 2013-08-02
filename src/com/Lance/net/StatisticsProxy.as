package com.Lance.net
{
	import flash.events.TimerEvent;
	import flash.utils.getTimer;

    public class StatisticsProxy extends Statistics
    {
        private var acitonStatisticsList:Array;
        private var userStatisticsList:Array;
        private var __stepRecords:Array;
        private var atIntervalPoint:Boolean = false;
        private var startGameTime:int;
        private static var _instance:StatisticsProxy;
        public static const STATISTICS_STAT:String = "&act=statistics";
        public static const STATISTICS_ACTIONS:String = "&act=action";
        public static const STATISTICS_UERS:String = "&act=user";
        public static var statLoadInGame:Object = {action:101, object:0, attribute:0, attributeValue:0, incrementCount:1};
        public static var statLoading:Object = {action:202, object:0, attribute:0, attributeValue:0, incrementCount:1};
        public static var loadingComplete:Object = {action:203, object:0, attribute:0, attributeValue:0, incrementCount:1};
        public static var enterScene:Object = {action:204, object:0, attribute:0, attributeValue:0, incrementCount:1};
        public static const GUIDE_INFO:Object = {action:307, object:0, attribute:0, attributeValue:0, incrementCount:1};

        public function StatisticsProxy()
        {
            this.__stepRecords = [];
            return;
        }// end function

        public function setStartGameLoadingTime() : void
        {
            this.startGameTime = getTimer();
            return;
        }// end function

        public function finishGameLoadingTime() : void
        {
            this.sendActionStatistics(StatisticsProxy.statLoadInGame, 0, Math.floor((getTimer() - this.startGameTime) / 1000));
            return;
        }// end function

        public function sendStatistics(param1:Array = null, param2:Array = null) : void
        {
            var _loc_6:* = undefined;
            var _loc_7:String = null;
            var _loc_8:* = undefined;
            var _loc_3:Boolean = false;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            if (clocking)
            {
            }
            if (!this.atIntervalPoint)
            {
                if (param2 != null)
                {
                    _loc_3 = false;
                    _loc_4 = 0;
                    while (_loc_4 < this.userStatisticsList.length)
                    {
                        
                        _loc_5 = 0;
                        while (_loc_5 < param2.length)
                        {
                            
                            if (this.userStatisticsList[_loc_4]["key"] == param2[_loc_5]["key"])
                            {
                                param2.splice(_loc_5, 1);
                                _loc_3 = true;
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    if (!_loc_3)
                    {
                        this.userStatisticsList.concat(param2);
                    }
                }
                if (param1 != null)
                {
                    _loc_3 = false;
                    _loc_4 = 0;
                    while (_loc_4 < this.acitonStatisticsList.length)
                    {
                        
                        _loc_5 = 0;
                        while (_loc_5 < param1.length)
                        {
                            
                            if (this.acitonStatisticsList[_loc_4]["action"] == param1[_loc_5]["action"])
                            {
                                _loc_6 = this.acitonStatisticsList[_loc_4];
                                _loc_7 = "incrementCount";
                                _loc_8 = this.acitonStatisticsList[_loc_4]["incrementCount"] + 1;
                                _loc_6[_loc_7] = _loc_8;
                                param1.splice(_loc_5, 1);
                                _loc_3 = true;
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    if (!_loc_3)
                    {
                        this.acitonStatisticsList.concat(param1);
                    }
                }
            }
            else
            {
                if (param1.length > 0)
                {
                }
                if (param2.length > 0)
                {
                    sendStat(STATISTICS_ACTIONS, {actions:param1});
                    sendStat(STATISTICS_UERS, {users:param2});
                }
                else if (param1.length > 0)
                {
                    sendStat(STATISTICS_ACTIONS, {actions:param1});
                }
                else if (param2.length > 0)
                {
                    sendStat(STATISTICS_UERS, {users:param2});
                }
            }
            return;
        }// end function

        public function sendUserStatistics(param1:Array) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            if (clocking)
            {
                _loc_2 = false;
                _loc_3 = 0;
                while (_loc_3 < this.userStatisticsList.length)
                {
                    
                    _loc_4 = 0;
                    while (_loc_4 < param1.length)
                    {
                        
                        if (this.userStatisticsList[_loc_3]["key"] == param1[_loc_4]["key"])
                        {
                            param1.splice(_loc_4, 1);
                            _loc_2 = true;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (!_loc_2)
                {
                    this.userStatisticsList = this.userStatisticsList.concat(param1);
                }
            }
            else
            {
                sendStat(STATISTICS_UERS, {users:param1});
            }
            return;
        }// end function

        public function sendActionStatistics(param1:Object, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 1) : void
        {
            var _loc_10:* = undefined;
            var _loc_11:String = null;
            var _loc_12:* = undefined;
            var _loc_6:Boolean = false;
            var _loc_7:int = 0;
            var _loc_8:Array = null;
            if (param1 == GUIDE_INFO)
            {
                if (this.__stepRecords.indexOf(param2) == -1)
                {
                    this.__stepRecords.push(param2);
                }
                else
                {
                    return;
                }
            }
            var _loc_9:* = new Object();
            new Object()["action"] = param1["action"];
            _loc_9["object"] = param2;
            _loc_9["attribute"] = param3;
            _loc_9["attributeValue"] = param4;
            _loc_9["incrementCount"] = param5;
            if (clocking)
            {
                _loc_6 = false;
                _loc_7 = 0;
                while (_loc_7 < this.acitonStatisticsList.length)
                {
                    
                    if (this.acitonStatisticsList[_loc_7]["action"] == _loc_9["action"])
                    {
                    }
                    if (this.acitonStatisticsList[_loc_7]["object"] == _loc_9["object"])
                    {
                        _loc_10 = this.acitonStatisticsList[_loc_7];
                        _loc_11 = "incrementCount";
                        _loc_12 = this.acitonStatisticsList[_loc_7]["incrementCount"] + 1;
                        _loc_10[_loc_11] = _loc_12;
                        _loc_6 = true;
                    }
                    _loc_7 = _loc_7 + 1;
                }
                if (!_loc_6)
                {
                    this.acitonStatisticsList.push(_loc_9);
                }
            }
            else
            {
                _loc_8 = [];
                _loc_8.push(_loc_9);
                sendStat(STATISTICS_ACTIONS, {actions:_loc_8});
            }
            return;
        }// end function

        override protected function clockStart() : void
        {
            this.atIntervalPoint = false;
            this.acitonStatisticsList = [];
            this.userStatisticsList = [];
            return;
        }// end function

        override protected function clockIntervalHandler(event:TimerEvent) : void
        {
            this.atIntervalPoint = true;
            this.sendStatistics(this.acitonStatisticsList, this.userStatisticsList);
            this.clockStart();
            return;
        }// end function

        public static function getInstance() : StatisticsProxy
        {
            if (_instance == null)
            {
                _instance = new StatisticsProxy;
            }
            return _instance;
        }// end function

    }
}
