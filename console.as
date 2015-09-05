package 
{
	import flash.external.ExternalInterface;
	import flash.utils.*;
	import flash.display.Sprite;
	import flash.events.*;
	//单例类 JsAsMessage.getInstance()
	public class console extends Sprite
	{
		public function console()
		{
		}
		public static function log(logBody:String)
		{
			if (ExternalInterface.available)
			{
				try
				{
					ExternalInterface.call("eval", 'console.log(\''+logBody+'\')');
				} catch (error:SecurityError) { }
			}
			else
			{
				setTimeout(function(){log(logBody);},1);
			}
		}
		
		public static function error(logBody:String)
		{
			if (ExternalInterface.available)
			{
				try
				{
					ExternalInterface.call("eval", 'console.error(\''+logBody+'\')');
				} catch (error:SecurityError) { }
			}
			else
			{
				setTimeout(function(){error(logBody);},1);
			}
		}
		
		public static function info(logBody:String)
		{
			if (ExternalInterface.available)
			{
				try
				{
					ExternalInterface.call("eval", 'console.info(\''+logBody+'\')');
				} catch (error:SecurityError) { }
			}
			else
			{
				setTimeout(function(){info(logBody);},1);
			}
		}
		
		
		
	}
}