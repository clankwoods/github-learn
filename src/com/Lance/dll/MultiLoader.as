package com.Lance.dll
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class MultiLoader extends EventDispatcher
	{
		protected var _loader:URLLoader;
		public var _index:int = 0;
		private var _fileArr:Array;
		private var _preloadingList:Array;
		private var _pause:Boolean;
		private var _totalSize:int = 0;
		private var _realProgress:Boolean = false;
		private var _ignoreIOerror:Boolean = false;
		
		public function MultiLoader()
		{
			this._fileArr = [];
			this._preloadingList = [];
			this._loader = new URLLoader();
			this._loader.dataFormat = URLLoaderDataFormat.BINARY;
			this._loader.addEventListener(Event.COMPLETE, this.onComplete);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.ioErr);
			this._loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
			return;
		}// end function
		
		protected function ioErr(event:IOErrorEvent) : void
		{
			var file:FileObject = null;
			if (this._ignoreIOerror)
			{
				file = this.fileArr[this._index] as DLLFileObject;
				dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.IO_ERROR, file));
			}
			else
			{
				(this.fileArr[this._index] as DLLFileObject).result = null;
				trace(event.text);
				this.next();
			}
			return;
		}// end function
		
		public function load($fileArray:Array, $realProgress:Boolean = false, $ignoreIOerror:Boolean = false) : void
		{
			if (this._fileArr)
			{
			}
			if (this._fileArr.length == 0)
			{
				this._fileArr = $fileArray.concat();
			}
			else
			{
				this._preloadingList = this._preloadingList.concat($fileArray);
			}
			this._realProgress = $realProgress;
			this._ignoreIOerror = $ignoreIOerror;
			if ($realProgress)
			{
				this._totalSize = this.getTotalSize($fileArray);
			}
			this.loadItem();
			return;
		}// end function
		
		protected function loadItem() : void
		{
			var urlrequest:URLRequest = null;
			if (this._fileArr.length > 0)
			{
				urlrequest = this._fileArr[this._index].urlRequest;
				this._loader.load(urlrequest);
				this._fileArr[this._index].status = DLLFileObject.LOADING;
			}
			return;
		}// end function
		
		private function getTotalSize($fileArray:Array) : int
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			while (_loc_3 < $fileArray.length)
			{
				
				_loc_2 = _loc_2 + int($fileArray[_loc_3].size);
				_loc_3 = _loc_3 + 1;
			}
			return _loc_2;
		}// end function
		
		protected function onProgress(event:ProgressEvent) : void
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			if (this._realProgress)
			{
				_loc_2 = this.getTotalSize(this.fileArr) + event.bytesLoaded;
				_loc_3 = this._totalSize;
			}
			else
			{
				_loc_2 = (this._index / this.fileArr.length + event.bytesLoaded / event.bytesTotal * (1 / this.fileArr.length)) * 100;
				_loc_3 = 100;
			}
			var _loc_4:Object = {};
			_loc_4.progress = Math.round(_loc_2 / _loc_3 * 100);
			dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.PROGRESS, _loc_4));
			return;
		}// end function
		
		protected function onComplete(event:Event) : void
		{
			dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.SINGLECOMPLETE, this.fileArr[this._index].name));
			if (this._preloadingList.length > 0)
			{
				while (this._preloadingList.length)
				{
					
					this._fileArr.splice((this._index + 1), 0, this._preloadingList.splice(0, 1));
				}
			}
			trace("##", _index, _preloadingList.length);
			this.currentComplete(this._index, event.currentTarget.data);
			return;
		}// end function
		
		protected function currentComplete($index:int, $result:Object) : void
		{
			this.fileArr[$index].result = $result;
			this.next();
			return;
		}// end function
		
		protected function next() : void
		{
			var _loc_2:int = this._index + 1;
			_index = _loc_2;
			if (this._index >= this.fileArr.length)
			{
				this.allComplete();
			}
			else
			{
				this.loadItem();
			}
			return;
		}// end function
		
		private function allComplete() : void
		{
			dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.COMPLETE, this.fileArr));
			return;
		}// end function
		
		public function get pause() : Boolean
		{
			return this._pause;
		}// end function
		
		public function set pause(value:Boolean) : void
		{
			this._pause = value;
			return;
		}// end function
		
		public function get fileArr() : Array
		{
			return this._fileArr;
		}// end function

	}
}