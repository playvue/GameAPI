package pv.api.events
{
	import flash.events.DataEvent;

	public class PlayerDataEvent
	{
		private var _type:String = "";
		private var _data:Object = new Object();
		public function PlayerDataEvent(type:String,data:Object=null){ _type = type; _data = data; }
		public static function fromDataEvent(e:DataEvent):PlayerDataEvent {
			var data:* = JSON.parse(e.data);
			var type:String = data.hasOwnProperty('type') ? data.type : "";
			var data:Object = data.hasOwnProperty('data') ? data.data : null;
			var pde:PlayerDataEvent = new PlayerDataEvent(type,data);
			return pde;
		}
		
		public function get type():String { return _type; }
		public function get data():Object { return _data; }
	}
}