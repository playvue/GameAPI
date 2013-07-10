package pv.api.requests
{
	import pv.api.data.PlayerData;

	public class PlayerRequest
	{
		private var _gameid:String;
		private var _type:String;
		private var _username:String;
		private var _data:PlayerData;
		public function PlayerRequest(gameid:String,type:String,username:String,data:PlayerData)
		{
			_gameid = gameid;
			_type = type;
			_username = username;
			_data = data;
		}
		public static function fromJSONString(json:String):PlayerRequest {
			var data:* = JSON.parse(json);
			if (data.hasOwnProperty('GameID') && data.hasOwnProperty('Type') && data.hasOwnProperty('Username')){
				return new PlayerRequest(data.GameID,data.Type,data.Username, 
					data.hasOwnProperty("Data") ? data.Data ? PlayerData.fromJSONObject(data.Data) : null : null);
			} else return new PlayerRequest("","","",null);
		}
		public function get GameID():String { return _gameid; }
		public function get Type():String { return _type; }
		public function get Username():String { return _username; }
		public function get Data():PlayerData { return _data; }
	}
}