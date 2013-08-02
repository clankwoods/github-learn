/**
 * 
 zheng
 DesinPage.as
 2013-7-26上午1:56:59
 **/
package View.scene
{
	import com.Lance.dll.Dll;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class DesinPage extends Sprite
	{
		
		private var bottombtn:MovieClip;
		private var btnman:MovieClip;
		private var btnwoman:MovieClip;
		
		private var txt:Vector.<TextField>;
		
		public function DesinPage()
		{
			super();
			setBackground();
			
		}
		private function setBackground():void{
			var back:Bitmap=new Bitmap(Dll.getInstance().getDisplayObjectByName("desinBackground.png") as BitmapData);
			back.bitmapData.draw(Dll.getInstance().getDisplayObjectByName("title.png") as BitmapData,new Matrix(1,0,0,1,7.5,5));
			addChild(back);
			txt=new Vector.<TextField>;
			var arr:Array=["watchband","watchcase","mechanism","plate","dial","indicator"];
			var tf:TextFormat=new TextFormat("Microsoft YaHei",20,0xffffff);
			for(var i:int=0;i<arr.length;i++){
				txt[i]=new TextField();
				with(addChild(txt[i])){
					width=150;
					x=10+i*150;
					y=5;
					text=arr[i];
					setTextFormat(tf);
					selectable=false;
					autoSize=TextFieldAutoSize.CENTER;
				}
			}
			setUI();
		}
		private function setUI():void{
			if(!bottombtn){
				bottombtn=Dll.getInstance().getDisplayObjectByName("bottombtn") as MovieClip;
				bottombtn.x=width>>1;
				bottombtn.y=height-11;
				for(var i:int=0;i<bottombtn.numChildren;i++){
					with(MovieClip(bottombtn.getChildAt(i))){
						buttonMode=true;
						mouseChildren=false;
					}
				}
			}
			addChild(bottombtn);
			
			
			if(!btnman){
				btnman=Dll.getInstance().getDisplayObjectByName("btnMan") as MovieClip;
				btnman.buttonMode=true;
				btnman.mouseChildren=false;
				btnman.x=28;
				btnman.y=498;
				
			}
			if(!btnwoman){
				btnwoman=Dll.getInstance().getDisplayObjectByName("btnWoman") as MovieClip;
				btnwoman.buttonMode=true;
				btnwoman.mouseChildren=false;
				btnwoman.x=75;
				btnwoman.y=498;
			}
			
			addChild(btnman);
			addChild(btnwoman);
		}
	}
}