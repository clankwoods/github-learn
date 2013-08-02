package com.module.control
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

    public class Label extends TextField
    {

        public function Label(_color:uint = 0, _size:uint = 12, _embed:Boolean = true, _font:String = "微软雅黑", _iswordWarp:Boolean = false)
        {
            multiline = false;
            mouseEnabled = false;
            selectable = false;
            wordWrap = _iswordWarp;
            embedFonts = _embed;
            autoSize = TextFieldAutoSize.LEFT;
            var _format:TextFormat = new TextFormat();
            new TextFormat().color = _color;
			_format.size = _size;
            if (embedFonts)
            {
				_format.font = _font;
            }
            else if (_font != "")
            {
				_format.font = _font;
            }
            defaultTextFormat = _format;
            return;
        }

        override public function set text(txt:String) : void
        {
            super.text = txt;
            if (!wordWrap)
            {
                width = textWidth;
                height = textHeight;
            }
            return;
        }

        public function set fontSize(_size:uint) : void
        {
            var _format:TextFormat = defaultTextFormat;
            _format.size = _size;
            defaultTextFormat = _format;
            this.text = super.text;
            return;
        }

        public function set color(_color:uint) : void
        {
			var _format:TextFormat = defaultTextFormat;
			_format.color = _color;
            defaultTextFormat = _format;
            this.text = super.text;
            return;
        }

        public function set leading(_leading:Object) : void
        {
			var _format:TextFormat = defaultTextFormat;
			_format.leading = _leading;
            defaultTextFormat = _format;
            this.text = super.text;
            return;
        }

        public function set letterSpacing(value:Object) : void
        {
			var _format:TextFormat = defaultTextFormat;
			_format.letterSpacing = value;
            defaultTextFormat = _format;
            this.text = super.text;
            return;
        }

        public function set indent(value:Object) : void
        {
			var _format:TextFormat = defaultTextFormat;
			_format.indent = value;
            defaultTextFormat = _format;
            this.text = super.text;
            return;
        }

        public function set bold(value:Object) : void
        {
			var _format:TextFormat = defaultTextFormat;
			_format.bold = value;
            defaultTextFormat = _format;
            this.text = super.text;
            return;
        }

        public function set font(value:String) : void
        {
            if (!value || value == "")
            {
                return;
            }
			var _format:TextFormat = defaultTextFormat;
			_format.font = value;
            defaultTextFormat = _format;
            return;
        }

        public function set align(value:String) : void
        {
			var _format:TextFormat = defaultTextFormat;
			_format.align = value;
            defaultTextFormat = _format;
            this.text = super.text;
            return;
        }

    }
}
