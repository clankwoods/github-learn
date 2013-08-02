package com.module.control
{
	import com.Lance.dll.Dll;
	
	import fl.controls.CheckBox;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class LineChart extends MovieClip 
	{		
		private	var _chartWidth:int=530;
		private var _chartHeight:int=200;
		private var _dataArray:Array;
		private var _markArray:Array;
		private var _linename:Array;
		private var _colorArray:Array;
		private var _chartTitle:String="折线图";
		
		private var _maxmark:Number=0;
		private var _minmark:Number=0;
		private var _marknum:int=0;
		private var _linenum:int=0;
		
		private var _chart:Sprite=new Sprite();
		private var _valueBar:Sprite;
		private var _linemc:Sprite;

		//构造函数
		public function LineChart(Width:Number,Height:Number)
		{
			_chartWidth=Width;
			_chartHeight=Height;

			//画图表轮廓
			_chart=drawRect(0, 0, _chartWidth, _chartHeight,1,0xCCCCCC,0xFFFFFF);
			_chart.graphics.lineStyle(1,0xCCCCCC);
			_chart.name="chartrec";
			addChild(_chart);
		}
		
		//清除已有图表数据
		private function clearAll():void
		{
			return;
		}
		
		//根据指定数据画图表
		public function DrawChart(inputDataArray:Array,inputMarkArray:Array,nameArray:Array,colorlist:Array,Title:String = "LineChart"):void
		{
			var i:int;
			var linepart:Sprite;

			//保存传入的参数，添加到属性里面
			_dataArray=inputDataArray;
			_markArray=inputMarkArray;
			_linename=nameArray;
			_colorArray=colorlist;
			_chartTitle=Title;

			//清除旧的数据线
			clearAll();

			//取得最大刻度
			_maxmark=getMaxMark(inputDataArray);
			_minmark=getMinMark(inputDataArray);
			_marknum=_markArray.length;
			if(_marknum<=0) return;
			
			_linenum=_dataArray.length/_marknum;
			
			//分配各自的大小
			var tempstr:String=_maxmark.toString();
			var markspace:Number=tempstr.length*12;
			var sell:Number=10;
			var titlespace:Number=14;
			var charth:Number=_chartHeight+50-titlespace-markspace-sell*6;
			var chartw:Number=_chartWidth-markspace-25*2;

			//画图像区域
			var chartbody:Sprite=drawRect(0, 0, chartw, charth,2,0x999999,0xFFFFFF);
			chartbody.addEventListener(Event.ENTER_FRAME,backEnterFrame);
			chartbody.buttonMode=true;
			chartbody.x=markspace+sell;
			chartbody.y=titlespace+sell*3;
			chartbody.name="chartbody";
			_chart.addChild(chartbody);									
			
			//标题
			var titlesp:TextField=getTextField(_chartTitle,16,0x000000,"left");
			titlesp.x=(_chartWidth-titlesp.width)/2;
			titlesp.y=sell;
			_chart.addChild(titlesp);

			//刻度
			drawLeftMark(_chart,chartbody);

			//数据标记
			drawBottomMark(_chart,chartbody);

			//折线
			var markmc:MovieClip = Dll.getInstance().getDisplayObjectByName("lineselect") as MovieClip;
			_linemc=new Sprite();
			var linedata:Array;
			_linemc.name="linemc";
			var tempArray:Array=new Array;
			for (i=0; i<_dataArray.length; i++) 
			{
				tempArray[i]=_dataArray[i];
			}
			
			for (i=0; i<_linenum; i++)
			{
				linedata=tempArray.splice(0,_marknum);
				linepart=drawMoveLine(chartbody,linedata,i);
				linepart.name="line"+i;
				linepart.x=chartbody.x-1;
				linepart.buttonMode=true;
				_linemc.addChild(linepart);
			}
			_chart.addChild(_linemc);

			//图例
			var x0:Number=0;
			var chartmark:Sprite=new Sprite();
			chartmark.name="tuli";
			for (i=0; i<_linenum; i++)
			{
				markmc=getlinename(_colorArray[i],_linename[i]);
				markmc.x=x0;
				markmc.name="mark"+i;
				markmc.lineobj=_linemc.getChildAt(i) as Sprite;
				markmc.line=_linemc;
				x0+=markmc.width+20;
				chartmark.addChild(markmc);
			}
			
			chartmark.x=(_chartWidth-chartmark.width)/2;			
			chartmark.y=_chartHeight-chartmark.height-sell;
			_chart.addChild(chartmark);

			//数据显示
			_valueBar=getValueShowBar(chartbody,_linenum);
			_valueBar.name="valueShowBar";
			_chart.addChild(_valueBar);
			var rec:Rectangle=new Rectangle();
			rec.top=chartbody.y;
			rec.bottom=chartbody.y;
			rec.left=chartbody.x;
			rec.right=chartbody.x+chartbody.width;
			_valueBar.startDrag(true,rec);
		}
		//背景图片鼠标经过响应
		private function backEnterFrame(e:Event):void
		{
			var obj:Sprite=e.target as Sprite;
			var space:Number=obj.width/(_marknum-1);
			var currentIndex:int=Math.round(obj.mouseX/space);
			var pp:Point=new Point();

			pp.x=this.mouseX;
			pp.y=this.mouseY;
			pp=this.localToGlobal(pp);

			if (obj.hitTestPoint(pp.x,pp.y,false))
			{
				showValue(obj,currentIndex);
				_valueBar.visible=true;
			} 
			else
			{
				_valueBar.visible=false;
			}
		}
		
		//显示折线数据
		private function showValue(body:Sprite,index:int):void
		{
			var mark:TextField=_valueBar.getChildByName("mark") as TextField;
			var valuedata:MovieClip = Dll.getInstance().getDisplayObjectByName("valuemc") as MovieClip;
			var num:int;
			var h:Number=body.height;
			mark.text=_markArray[index];
			for (var i:int=0; i<_linenum; i++) 
			{
				num=i*_marknum+index;
				valuedata=_valueBar.getChildByName("value"+i) as MovieClip;
				valuedata.visible=valuedata.objline.visible;
				valuedata.y=h-_dataArray[num]/_maxmark*h;
				valuedata.valuedata.text=_dataArray[num];
				valuedata.back.alpha=0.5;
			}
		}
		
		//生成数据显示的MC
		private function getValueShowBar(body:Sprite,linenum:int):Sprite
		{
			var mc:Sprite=new Sprite();
			var mark:TextField;
			var valuedata:MovieClip = Dll.getInstance().getDisplayObjectByName("valuemc") as MovieClip;
			var colortrans:ColorTransform=new ColorTransform();
			mc.graphics.lineStyle(1,0x999999);
			mc.graphics.moveTo(0,0);
			mc.graphics.lineTo(0,body.height);

			mark=getTextField("2009年12月31日",12,0x000000,"center");
			mark.border=true;
			mark.background=true;
			mark.backgroundColor=0xFFFF00;
			mark.borderColor=0xFF0000;
			mark.x=-mark.width/2;
			mark.y=body.height;
			mark.name="mark";
			mc.addChild(mark);

			for (var i:int=0; i<_linenum; i++) 
			{
				valuedata= Dll.getInstance().getDisplayObjectByName("valuemc") as MovieClip;
				colortrans.color=_colorArray[i];

				var trans:Transform=new Transform(valuedata.back);
				trans.colorTransform=colortrans;
				valuedata.name="value"+i;
				valuedata.objline=_linemc.getChildAt(i) as Sprite;
				mc.addChild(valuedata);
			}
			mc.y=body.y;
			return mc;
		}
		
		//写刻度
		private function drawLeftMark(mainobj:Sprite,body:Sprite):void
		{
			var space:int=_maxmark/10;
			var mark:TextField;
			var y0:Number=body.height-2;
			var h1:Number=(body.height-2)/10;
			var w:Number=body.width;
			var sl:Sprite=new Sprite();
			sl.y=body.y;
			sl.x=body.x;
			mainobj.addChild(sl);
			for (var i:int=0; i<=10; i++)
			{
				//标记
				mark=getTextField(i*space,14,0x999999,"right");
				sl.graphics.lineStyle(1,0x999999);
				sl.graphics.moveTo(-5,y0);
				sl.graphics.lineTo(0,y0);
				mark.y=y0-mark.height/2;
				mark.x=-5-mark.width;
				sl.addChild(mark);

				//背景横线
				body.graphics.lineStyle(1,0xCCCCCC);
				body.graphics.moveTo(0,y0);
				body.graphics.lineTo(w,y0);

				y0-=h1;
			}
		}
		
		//写数据标记
		private function drawBottomMark(mainobj:Sprite,body:Sprite):void
		{
			var space:Number=(body.width-2)/(_marknum-1);
			var y0:Number=body.y+body.height;
			var markSpace:int=Math.round(_marknum/6);
			var x0:Number=0;
			var h:Number=body.height;
			var mark:TextField;

			body.graphics.lineStyle(1,0xCCCCCC);

			for (var i:int=0; i<_marknum; i++) 
			{
				if (i%markSpace==0) 
				{
					mark=getTextField(_markArray[i],12,0x000000,"right");
					mainobj.addChild(mark);
					mark.x=x0+80;
					mark.y=y0;
				}
				if (i<_marknum-1)
				{
					body.graphics.moveTo(x0,0);
					body.graphics.lineTo(x0,h);
				}
				x0+=space;
			}
		}
		
		//得到一个图例
		private function getlinename(color:uint,markText:String):MovieClip
		{
			var mc:MovieClip = Dll.getInstance().getDisplayObjectByName("lineselect") as MovieClip;
			var mark:TextField=getTextField(markText,12,0x000000,"left");
			var colortrans:ColorTransform=new ColorTransform();

			colortrans.color=color;
			var trans:Transform=new Transform(mc.back);
			trans.colorTransform=colortrans;

			colortrans.color=getDarkColor(color);
			trans=new Transform(mc.chiosed);
			trans.colorTransform=colortrans;

			mc.addChild(mark);
			mark.x=20;
			mc.markcolor=color;
			mc.mouseChildren=false;
			mc.buttonMode=true;
			mc.addEventListener(MouseEvent.CLICK,selectLine);
			mc.addEventListener(MouseEvent.MOUSE_OVER,markOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT,markOut);
			return mc;
		}
		
		//图例鼠标经过事件响应
		private function markOver(e:Event):void
		{
			var obj:MovieClip=e.target as MovieClip;
			var child:Sprite;
			var line:Sprite=obj.getChildByName("line") as Sprite;
			var lineobj:Sprite=obj.getChildByName("lineobj")as Sprite;
			var drak:Number=getDarkColor(obj.markcolor);
			var sd:DropShadowFilter=new DropShadowFilter(1,1,0x000000,1);
			lineobj.filters=[sd];
		}
		
		//图例鼠标移出响应
		private function markOut(e:Event):void
		{
			var obj:MovieClip=e.target as MovieClip;
			var child:Sprite;
			var line:Sprite=obj.getChildByName("line")as Sprite;
			var lineobj:Sprite=obj.getChildByName("lineobj")as Sprite;
			lineobj.filters=null;
			line.swapChildren(lineobj,line.getChildAt(line.numChildren-1));
		}
		
		//图例选择响应
		private function selectLine(e:Event):void
		{
			var obj:MovieClip=e.target as MovieClip;
			obj.getChildByName("chiosed").visible=!obj.getChildByName("chiosed").visible;
			obj.getChildByName("lineobj").visible=obj.getChildByName("lineobj").visible;
		}
		
		//得到一个文字域
		private function getTextField(markdata:*,textsize:int,textcolor:uint,textalign:String):TextField
		{
			var tf:TextField=new TextField();
			var textformat:TextFormat=new TextFormat();

			textformat=new TextFormat();
			textformat.size=textsize;
			textformat.color=textcolor;

			tf.autoSize=textalign;
			tf.selectable=false;
			tf.text=markdata.toString();
			tf.setTextFormat(textformat);
			return tf;
		}
		
		//画方框
		private function drawRect(x0:Number,y0:Number,h:Number,w:Number,linestyle:Number,linecolor:uint,fillcolor:uint):Sprite 
		{
			var sp:Sprite=new Sprite();
			sp.graphics.lineStyle(linestyle,linecolor);
			sp.graphics.beginFill(fillcolor);
			sp.graphics.drawRect(x0,y0,h,w);
			sp.graphics.endFill();
			return sp;
		}
		
		//画一条动画折线
		private function drawMoveLine(body:Sprite,currentLineData:Array,linecolor:int):Sprite
		{
			var len:Number=currentLineData.length;
			var space:Number=(body.width-2)/(len-1);
			var linepart:Sprite=new Sprite();
			var bili:Number=(body.height-2)/_maxmark;
			var bottom:Number=body.y+body.height;
			var x0:Number=0;
			var y0:Number=bottom-currentLineData[0]*bili;
			var x1:Number=0;
			var y1:Number=0;
			var i:int;

			var mark:MovieClip=getmarkPiont(_colorArray[linecolor]);
			mark.x=x0;
			mark.y=body.height;
			mark.y0=y0;
			mark.colordata=_colorArray[linecolor];
			linepart.addChild(mark);
			linepart.graphics.lineStyle(1,_colorArray[linecolor]);
			for (i=1; i<len; i++)
			{
				y1=bottom-currentLineData[i]*bili;
				x1=x0+space;
				mark=getmarkPiont(_colorArray[linecolor]);
				mark.x=x1;
				mark.y=body.height;
				mark.y0=y1;
				linepart.addChild(mark);
				x0=x1;
				y0=y1;
			}
			linepart.mouseChildren=false;
			linepart.addEventListener(Event.ENTER_FRAME,movePiont);
			linepart.addEventListener(MouseEvent.MOUSE_OVER,lineOver);
			linepart.addEventListener(MouseEvent.MOUSE_OUT,lineOut);
			return linepart;
		}
		
		//折线图的动态显示
		private function movePiont(e:Event):void
		{
			var obj:Sprite=e.target as Sprite;
			var chilsobj:MovieClip;
			var speed:Number=0.3;
			obj.graphics.clear();
			chilsobj=obj.getChildAt(0) as MovieClip;
			var color:Number=chilsobj.colordata;
			obj.graphics.lineStyle(1,color);
			chilsobj.y=chilsobj.y-(chilsobj.y-chilsobj.y0)*speed;
			obj.graphics.moveTo(chilsobj.x,chilsobj.y);

			var x0:Number=chilsobj.x;
			var y0:Number=chilsobj.y;

			for (var i:int=1; i<obj.numChildren; i++)
			{
				chilsobj=obj.getChildAt(i) as MovieClip;
				chilsobj.y=chilsobj.y-(chilsobj.y-chilsobj.y0)*speed;
				obj.graphics.moveTo(x0,y0);
				obj.graphics.lineTo(chilsobj.x,chilsobj.y);
				x0=chilsobj.x;
				y0=chilsobj.y;
			}
		}
		
		//折线图鼠标经过事件响应
		private function lineOver(event:MouseEvent):void
		{
			var obj:Sprite=event.target as Sprite;
			var objname:String;
			var child:Sprite;
			var valuemc:MovieClip;
			var sd:DropShadowFilter=new DropShadowFilter(2,2,0x000000);
			obj.filters=[sd];
			for (var i:int=0; i<obj.parent.numChildren; i++) 
			{
				child=obj.parent.getChildAt(i) as Sprite;
				valuemc=_valueBar.getChildByName("value"+i) as MovieClip;
//				if (child!=obj) {
//					new Tween(child,"alpha",Strong.easeInOut,1,0.2,1,true);
//				}
//				if (valuemc.objline!=obj) {
//					new Tween(valuemc,"alpha",Strong.easeInOut,1,0,1,true);
//				}
			}
		}
		
		//折线图鼠标移出事件响应
		private function lineOut(e:MouseEvent) :void
		{
			var obj:Sprite=e.target as Sprite;
			var valuemc:MovieClip;
			obj.filters=null;
			var child:Sprite;
			for (var i:int=0; i<obj.parent.numChildren; i++) 
			{
				child=obj.parent.getChildAt(i) as Sprite;
				valuemc=_valueBar.getChildByName("value"+i) as MovieClip;
//				new Tween(child,"alpha",Strong.easeInOut,child.alpha,1,1,true);
//				new Tween(valuemc,"alpha",Strong.easeInOut,valuemc.alpha,1,1,true);
			}
		}
		
		//得到水晶节点
		private function getPiont(color:uint):MovieClip
		{
			var mc:MovieClip=Dll.getInstance().getDisplayObjectByName("linemark") as MovieClip;
			var colortrans:ColorTransform=new ColorTransform();
			colortrans.color=color;
			var trans:Transform=new Transform(mc.backmc);
			trans.colorTransform=colortrans;
			return mc;
		}
		
		//得到节点
		private function getmarkPiont(color:uint):MovieClip
		{
			var mc:MovieClip=Dll.getInstance().getDisplayObjectByName("emptymark")as MovieClip;
			var r1:Number=3;
			var r2:Number=1.5;
			mc.graphics.beginFill(color);
			mc.graphics.drawCircle(0,0,r1);
			mc.graphics.endFill();
			mc.graphics.beginFill(0xFFFFFF);
			mc.graphics.drawCircle(0,0,r2);
			mc.graphics.endFill();
			return mc;
		}
		
		//取得阴影颜色
		private function getDarkColor(color:uint):uint 
		{
			var r:uint=color >> 16 & 0xFF / 1.43;
			var g:uint=color >> 8 & 0xFF / 1.43;
			var b:uint=color & 0xFF /1.43;
			return r << 16 | g << 8 | b;
		}		
		
		//根据数据数组得到图表的坐标轴刻度最大值
		private function getMaxMark(objArray:Array):Number
		{			
			var i:int;
			var len:int=objArray.length;			
			var maxdata:Number=0;
			var mark:int=0;
			for(i=0;i<len;i++)
			{
				if(objArray[i]>maxdata) maxdata=objArray[i];
			}
			maxdata=Math.round(maxdata);
			var ss:String=maxdata.toString();
			len=ss.length-1;
			len=Math.pow(10,len);
			while (mark<maxdata)
			{
				mark+=len;
			}			
			return mark;
		}
		
		//根据数据数组得到图表的坐标轴刻度最小值
		private function getMinMark(objArray:Array):Number
		{			
			var i:int;
			var len:int=objArray.length;
			var mindata:Number=objArray[0];
			var mark:int=-0xffffff;
			for(i=0;i<len;i++)
			{
				if(objArray[i]<mindata) mindata=objArray[i];
			}
			mindata=Math.round(mindata);
			var ss:String=mindata.toString();
			len=ss.length-1;
			len=Math.pow(10,len);
			while (mark+len<mindata)
			{
				mark+=len;
			}
			return mark;
		}		
	}
}