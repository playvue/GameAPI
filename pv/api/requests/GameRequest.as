package pv.api.requests
{
	import pv.api.data.GameData;
	import pv.api.data.PlayerData;

	public class GameRequest
	{
		private var _gameid:String;
		private var _type:String;
		private var _data:GameData;
		public function GameRequest(gameid:String,type:String,data:GameData)
		{
			_gameid = gameid;
			_type = type;
			_data = data;
		}
		public static function fromJSONString(json:String):GameRequest {
			var data:* = JSON.parse(json);
			if (data.hasOwnProperty('GameID') && data.hasOwnProperty('Type')){
				return new GameRequest(data.GameID,data.Type, 
					data.hasOwnProperty("Data") ? data.Data ? GameData.fromJSONObject(data.Data) : null : null);
			} else return new GameRequest("","",null);
		}
		public function get GameID():String { return _gameid; }
		public function get Type():String { return _type; }
		public function get Data():GameData { return _data; }
	}
}