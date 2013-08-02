package View.interfaces
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public interface IScene
	{
		function showAs(parent:DisplayObjectContainer):void;
		function removeFrom(parent:DisplayObjectContainer):void;
		/**获取场景大小*/
		function getSceneSize():Point;
		/**进入场景动画前*/
		function onEnter():void;
		/**进入场景动画后*/
		function onEnterTransformDie():void;
		/**退出场景动画前*/
		function onExit():void;
		/**退出场景动画后*/
		function onExitTransformDie():void;
	}
}