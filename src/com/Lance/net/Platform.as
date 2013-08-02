package com.Lance.net
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.getTimer;

    public class Platform
    {
        private var _getFminutesSettings:Object;
        private var _platform:String;
        private var _features:String;
        private var _streamConfig:Object;
        private var _uId:String = "";
        private var _uName:String = "";
        private var _streamFolder:String = "";
        private var _imageFolder:String = "";
        private var _taskIconFolder:String = "";
        private var _achieveIconFolder:String = "";
        private var _exchangeIconFolder:String = "";
        private var _addictedTimer:Timer;
        private var _callTime:int = 1.8e+006;
        private var _preTime:int = 0;
        private var _keysFolder:String = "";
        private var _pveEventOptionIconFolder:String = "";
        private var _wonderIconsFolder:String = "";
        private var _groupShopFolder:String = "";
        private var _cdnIpPostUrl:String;
        private var _cndIp:String;
        private var _userId:String;
        private static var instance:Platform;

        public function Platform()
        {
            if (instance != null)
            {
                throw new Error("����Ҫ��new-Platform");
            }
            instance = this;
            return;
        }// end function

        private function getFminutesSettings() : Object
        {
            if (this._getFminutesSettings == null)
            {
                if (ExternalInterface.available)
                {
                    this._getFminutesSettings = ExternalInterface.call("Fminutes.settings");
                }
            }
            return this._getFminutesSettings;
        }// end function

        public function set platform(value:String) : void
        {
            this._platform = value;
            return;
        }// end function

        public function get platform() : String
        {
            if (this._platform)
            {
                return this._platform;
            }
            this._getFminutesSettings = this.getFminutesSettings();
            if (this._getFminutesSettings == null)
            {
                return "lw_xn";
            }
            return this._getFminutesSettings["namespace"];
        }// end function

        private function getValue(key:String) : Object
        {
            var _loc_2:Object = null;
            this._getFminutesSettings = this.getFminutesSettings();
            if (this._getFminutesSettings == null)
            {
                return null;
            }
            _loc_2 = this._getFminutesSettings["features"];
            return _loc_2[key];
        }// end function

        public function get features() : String
        {
            return this._features;
        }// end function

        public function set features(value:String) : void
        {
            this._features = value;
            return;
        }// end function

        public function get stream() : Boolean
        {
            if (this.features != null)
            {
                if (this.features.search("stream") >= 0)
                {
                    return true;
                }
                return false;
            }
            var _loc_1:* = this.getValue("stream");
            if (_loc_1 != 0)
            {
            }
            if (_loc_1 == "false")
            {
                return false;
            }
            if (!_loc_1)
            {
            }
            return false;
        }// end function

        public function get fanenable() : Boolean
        {
            if (this.features != null)
            {
                if (this.features.search("fanenable") >= 0)
                {
                    return true;
                }
                return false;
            }
            var _loc_1:* = this.getValue("fanenable");
            if (_loc_1 != 0)
            {
            }
            if (_loc_1 == "false")
            {
                return false;
            }
            if (!_loc_1)
            {
            }
            return false;
        }// end function

        public function get neighbourEnable() : Boolean
        {
            if (this.features != null)
            {
                if (this.features.search("neighbour") >= 0)
                {
                    return true;
                }
                return false;
            }
            var _loc_1:* = this.getValue("neighbour");
            if (_loc_1 != 0)
            {
            }
            if (_loc_1 == "false")
            {
                return false;
            }
            if (!_loc_1)
            {
            }
            return false;
        }// end function

        public function get creditEnable() : Boolean
        {
            if (this.features != null)
            {
                if (this.features.search("credits") >= 0)
                {
                    return true;
                }
                return false;
            }
            var _loc_1:* = this.getValue("credits");
            if (_loc_1 != 0)
            {
            }
            if (_loc_1 == "false")
            {
                return false;
            }
            return true;
        }// end function

        public function get freegiftEnable() : Boolean
        {
            if (this.features != null)
            {
                if (this.features.search("freegift") >= 0)
                {
                    return true;
                }
                return false;
            }
            var _loc_1:* = this.getValue("freegift");
            if (_loc_1 != 0)
            {
            }
            if (_loc_1 == "false")
            {
                return false;
            }
            return true;
        }// end function

        public function get autoStream() : int
        {
            if (this.features != null)
            {
                if (this.features.search("autoStream") >= 0)
                {
                    return 2;
                }
                return 0;
            }
            var _loc_1:* = this.getValue("autoStream");
            if (!_loc_1)
            {
                return 0;
            }
            return int(_loc_1);
        }// end function

        public function get hiddenStream() : int
        {
            if (this.features != null)
            {
                if (this.features.search("hiddenStream") >= 0)
                {
                    return 2;
                }
                return 0;
            }
            var _loc_1:* = this.getValue("hiddenStream");
            if (!_loc_1)
            {
                return 0;
            }
            return int(_loc_1);
        }// end function

        public function setStreamConfig(param1:Object) : void
        {
            this._streamConfig = param1;
            return;
        }// end function

        public function setUser(param1:String, param2:String) : void
        {
            this._uId = param1;
            this._uName = param2;
            return;
        }// end function

        public function isSetName() : Boolean
        {
            if (this._uId == "")
            {
                return false;
            }
            return true;
        }// end function

        public function setStreamFolder(param1:String) : void
        {
            this._streamFolder = param1;
            return;
        }// end function

        public function setImageFolder(param1:String) : void
        {
            this._imageFolder = param1;
            return;
        }// end function

        public function setTaskIconFolder(param1:String) : void
        {
            this._taskIconFolder = param1;
            return;
        }// end function

        public function getStreamText(param1:String) : String
        {
            var _loc_2:Object = null;
            if (this._streamConfig == null)
            {
                return null;
            }
            for each (_loc_2 in this._streamConfig)
            {
                
                if (_loc_2["ID"] == param1)
                {
                    return _loc_2["gameContent"];
                }
            }
            return null;
        }// end function

        public function getStreamImg(param1:String, param2:Array = null) : String
        {
            var _loc_3:Object = null;
            var _loc_4:String = null;
            if (this._streamConfig == null)
            {
                return null;
            }
            for each (_loc_3 in this._streamConfig)
            {
                
                if (_loc_3["ID"] == param1)
                {
                    _loc_4 = _loc_3["media"];
                    _loc_4 = this.replaceArg(_loc_4, param2);
                    return this._streamFolder + _loc_4;
                }
            }
            return null;
        }// end function

        public function getAchieveIcon(param1:String) : String
        {
            return this._achieveIconFolder + param1;
        }// end function

        public function getExchageIconFolder(param1:String) : String
        {
            return this._exchangeIconFolder + param1;
        }// end function

        public function publishStream(param1:String, param2:Array = null, param3:Boolean = false, param4:Object = null) : void
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:Array = null;
            var _loc_9:String = null;
            var _loc_10:Array = null;
            var _loc_11:int = 0;
            var _loc_12:String = null;
            if (this._streamConfig == null)
            {
                return;
            }
            for each (_loc_5 in this._streamConfig)
            {
                
                if (_loc_5["ID"] == param1)
                {
                    _loc_6 = {};
                    _loc_6["feedId"] = _loc_5["feedID"];
                    _loc_6["isShare"] = _loc_5["isShare"];
                    _loc_7 = {};
                    _loc_7["name"] = this.replaceArg(_loc_5["name"], param2);
                    _loc_7["description"] = this.replaceArg(_loc_5["description"], param2);
                    _loc_8 = [];
                    _loc_10 = (_loc_5["media"] as String).split(",");
                    _loc_11 = 0;
                    while (_loc_11 < _loc_10.length)
                    {
                        
                        _loc_9 = this.replaceArg(_loc_10[_loc_11], param2);
                        _loc_8.push({src:this._streamFolder + _loc_9, href:""});
                        _loc_11 = _loc_11 + 1;
                    }
                    _loc_7["media"] = _loc_8;
                    _loc_6["attachment"] = _loc_7;
                    _loc_6["action"] = [{text:_loc_5["action"], href:""}];
                    _loc_6["user_message_prompt"] = _loc_5["user_message_prompt"];
                    _loc_6["user_message"] = _loc_5["user_message"];
                    _loc_6["cumObj"] = param4;
                    if (param3)
                    {
                        _loc_6["isHidden"] = true;
                    }
                    _loc_12 = "Fminutes." + this.platform + ".publishStream";
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call(_loc_12, _loc_6);
                    }
                    return;
                }
            }
            return;
        }// end function

        private function replaceArg(param1:String, param2:Array = null) : String
        {
            var _loc_3:int = 0;
            var _loc_4:String = null;
            var _loc_5:RegExp = null;
            var _loc_6:* = param1.replace(/\{user\}/g, this._uName);
            if (param2 != null)
            {
                _loc_3 = 0;
                while (_loc_3 < param2.length)
                {
                    
                    _loc_4 = "\\{" + _loc_3 + "\\}";
                    _loc_5 = new RegExp(_loc_4, "g");
                    _loc_6 = _loc_6.replace(_loc_5, param2[_loc_3]);
                    _loc_3 = _loc_3 + 1;
                }
            }
            return _loc_6;
        }// end function

        public function addNeighbour(param1:String = null) : void
        {
            var _loc_2:String = ".addNeighbour";
            if (!this.neighbourEnable)
            {
                _loc_2 = ".sendInvitation";
            }
            var _loc_3:* = "Fminutes." + this.platform + _loc_2;
            if (ExternalInterface.available)
            {
                if (param1 == null)
                {
                    ExternalInterface.call(_loc_3);
                }
                else
                {
                    ExternalInterface.call(_loc_3, param1);
                }
            }
            return;
        }// end function

        public function gotoJS(param1:String = null) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_2:* = "Fminutes." + this.platform + param1;
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_2);
            }
            return;
        }// end function

        public function addCredits() : void
        {
            var _loc_1:* = "Fminutes." + this.platform + ".addCredits";
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_1);
            }
            return;
        }// end function

        public function sendFeed(feed:String) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("feed", feed);
            }
            return;
        }// end function

        public function sendRecharge() : void
        {
            return;
        }// end function

        public function inviteFriend() : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("showKxDialog");
            }
            return;
        }// end function

        public function gotoQQxyHome(param1:String) : void
        {
            var _loc_2:* = "Fminutes." + this.platform + ".toFriendHome";
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_2, param1);
            }
            return;
        }// end function

        public function startAddicted(param1:Stage) : void
        {
            if (this._addictedTimer == null)
            {
                this._addictedTimer = new Timer(60000);
                this._addictedTimer.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._addictedTimer.start();
                this._preTime = getTimer();
                param1.addEventListener(MouseEvent.CLICK, this.onClick);
            }
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            if (getTimer() - this._preTime >= this._callTime)
            {
                this.addicted();
                this._addictedTimer.stop();
            }
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            this._preTime = getTimer();
            return;
        }// end function

        public function addicted() : void
        {
            var _loc_1:* = "Fminutes." + this.platform + ".addicted";
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_1);
            }
            return;
        }// end function

        public function gotoFreeGift(param1:String = null) : void
        {
            var _loc_2:* = "Fminutes." + this.platform + ".sendFreeGift";
            if (ExternalInterface.available)
            {
                if (param1 == null)
                {
                    ExternalInterface.call(_loc_2);
                }
                else
                {
                    ExternalInterface.call(_loc_2, param1);
                }
            }
            return;
        }// end function

        public function joinFan() : void
        {
            var _loc_1:* = "Fminutes." + this.platform + ".popBecomeFan";
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_1);
            }
            return;
        }// end function

        public function buy(param1:String) : void
        {
            var _loc_2:String = "Fminutes.Payment.openPayment";
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_2, param1);
            }
            return;
        }// end function

        public function requertFriend() : void
        {
            var _loc_1:String = "Fminutes.Facebook.requertFriend";
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_1);
            }
            return;
        }// end function

        public function get taskIconFolder() : String
        {
            return this._taskIconFolder;
        }// end function

        public function get imageFolder() : String
        {
            return this._imageFolder;
        }// end function

        public function setAchieveIconFolder(param1:String) : void
        {
            this._achieveIconFolder = param1;
            return;
        }// end function

        public function setKeysFolder(param1:String) : void
        {
            this._keysFolder = param1;
            return;
        }// end function

        public function getkeySwfbyName(param1:String) : String
        {
            return this._keysFolder + param1 + ".swf";
        }// end function

        public function setPVEEventOptionIconFolder(param1:String) : void
        {
            this._pveEventOptionIconFolder = param1;
            return;
        }// end function

        public function get pveEventOptionIconFolder() : String
        {
            return this._pveEventOptionIconFolder;
        }// end function

        public function setWonderIconsFolder(param1:String) : void
        {
            this._wonderIconsFolder = param1;
            return;
        }// end function

        public function get wonderIconsFolder() : String
        {
            return this._wonderIconsFolder;
        }// end function

        public function setGroupShopFolder(param1:String) : void
        {
            this._groupShopFolder = param1;
            return;
        }// end function

        public function getGroupShopPicURL(param1:String) : String
        {
            return this._groupShopFolder + param1;
        }// end function

        public function setExchangeIconFolder(param1:String) : void
        {
            this._exchangeIconFolder = param1;
            return;
        }// end function

        public function getUserIp() : String
        {
            return "";
        }// end function

        public function getFileCDN() : String
        {
            var _loc_1:String = null;
            if (this._cndIp == "")
            {
                _loc_1 = "Fminutes." + this.platform + ".getCdnIp";
                if (ExternalInterface.available)
                {
                    this._cndIp = ExternalInterface.call(_loc_1);
                }
            }
            return this._cndIp;
        }// end function

        public function checkEntry() : void
        {
            var _loc_1:String = null;
            var _loc_2:* = "Fminutes." + this.platform + ".swfLoadEvent";
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_loc_2);
            }
            return;
        }// end function

        public function get userId() : String
        {
            return this._userId;
        }// end function

        public function set userId(param1:String) : void
        {
            this._userId = param1;
            return;
        }// end function

        public function get cdnIpPostUrl() : String
        {
            return this._cdnIpPostUrl;
        }// end function

        public function set cdnIpPostUrl(param1:String) : void
        {
            var _loc_2:URLRequest = null;
            var _loc_3:URLLoader = null;
            this._cdnIpPostUrl = param1;
            if (this._cdnIpPostUrl != "")
            {
                _loc_2 = new URLRequest(this._cdnIpPostUrl);
                _loc_3 = new URLLoader();
                _loc_3.addEventListener(Event.COMPLETE, this.onCdnIpComplete);
                _loc_3.load(_loc_2);
            }
            return;
        }// end function

        private function onCdnIpComplete(event:Event) : void
        {
            this._cndIp = String(event.target.data);
            return;
        }// end function

        public static function getInstance() : Platform
        {
            if (instance == null)
            {
                instance = new Platform;
            }
            return instance;
        }// end function

    }
}
