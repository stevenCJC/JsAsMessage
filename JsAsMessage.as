// ActionScript Document


package 
{
	 import flash.external.ExternalInterface;
	 import flash.utils.*;
	 import flash.display.Sprite;  
     import flash.events.*;  
	//单例类 JsAsMessage.getInstance()
	public class JsAsMessage extends Sprite
	{

		var flashId:String;
		var handles:Object = {};

		private static var _instance:JsAsMessage;


		public static function getInstance(flashId:String):JsAsMessage
		{
			trace('tt');
			if (_instance == null)
			{
				_instance = new JsAsMessage(flashId,new SingletonEnforcer());
			}
			return _instance;
		}


		public function JsAsMessage(_flashId:String,singletonEnforcer:SingletonEnforcer):void
		{
			if (singletonEnforcer == null)
			{
				console.error('Singleton Error');
				throw new Error("Singleton Error");
			}

			flashId = _flashId;
			console.log('flashId:'+flashId);
			if (ExternalInterface.available)
			{
				console.log('ExternalInterface.available');
				try
				{
					console.log('addCallback JsAsMessage_as_trigger');
					ExternalInterface.addCallback("JsAsMessage_as_trigger", _trigger);

				}
				catch (error:SecurityError)
				{
					console.error(error.toString());
				}


			}

			var timer=setInterval(function(){
			console.log('JsAsMessage_js_checkReady?');
			if(checkReady()){
				console.log('Ready!!');
				ExternalInterface.call('JsAsMessage_js_trigger',flashId,'allReady','');
				console.log('call:JsAsMessage_js_trigger');
				_trigger('allReady','');
				console.log('_trigger:allReady');
				clearInterval(timer);
			};
			},10);

		}

		public function bind(ev:String,handle:Function):void
		{

			if (ev)
			{
				handles[ev] = handles[ev] || [];
				handles[ev].push(handle);
			}
			else
			{
				throw 'wrong args in method bind';
			}
		}

		public function postMessage(msg:String):void
		{

			ExternalInterface.call('JsAsMessage_js_trigger',flashId,'message',msg);

		}
		
		function checkReady():Boolean{
			var isReady:Boolean=ExternalInterface.call('JsAsMessage_js_checkReady');
			return isReady;
		}

		function _trigger(ev:String,msg:String):void
		{
			if (ev&&handles[ev])
			{
				for (var i=0,l=handles[ev].length; i<l; i++)
				{
					handles[ev][i](msg);
				}
			}
		}


function log(text:String):void{}


	}

}

class SingletonEnforcer
{
}