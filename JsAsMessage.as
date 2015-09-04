// ActionScript Document


package 
{
	
	//单例类 JsAsMessage.getInstance()
	public class JsAsMessage
	{

		var flashId:String;
		var handles:Object = {};
		
		public static var _instance:JsAsMessage;
		
		
		public static function getInstance(flashId:String):JsAsMessage {
			  if(_instance == null) {
						_instance = new JsAsMessage(flashId,new SingletonEnforcer());
			   }
			   return _instance;
		 }
			 
			 
		public function JsAsMessage(_flashId:String,singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcr == null) throw new Error("Singleton Error");
			
			flashId = _flashId;
			if (ExternalInterface.available)
			{
				try
				{

					ExternalInterface.addCallback("JsAsMessage_as_trigger", _trigger);

				}
				catch (error:SecurityError)
				{
				}


			}

			var timer=setInterval(function(){
				if(ExternalInterface.call('JsAsMessage_js_checkReady')){
					ExternalInterface.call('JsAsMessage_js_trigger',flashId,'allReady');
					_trigger('allReady',function(){});
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





	}

}

class  SingletonEnforcer{};