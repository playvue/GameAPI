package pv.api.data
{
	public class PlayerData
	{
		private var _type:String;
		private var _username:String;
		private var _isMe:Boolean;
		private var _dataInt:int;
		private var _dataText:String;
		private var _returnCall:Boolean;
		public function PlayerData(type:String,u:String,me:Boolean,dataInt:int,dataText:String, returnCall:Boolean=false){
			_type = type; _username = u; _isMe = me; 
			_dataInt = dataInt; _dataText = dataText;
			_returnCall = returnCall; }
		public static function fromJSONObject(j:Object):PlayerData {
			if (j.hasOwnProperty("type") && j.hasOwnProperty("username") && j.hasOwnProperty("isMe") && (j.hasOwnProperty("dataInt") || j.hasOwnProperty("dataText"))) {
				return new PlayerData(j.type,j.username,j.isMe,
					j.hasOwnProperty("dataInt") ? j.dataInt : -1, j.hasOwnProperty("dataText") ? j.dataText : "",
					j.hasOwnProperty("returnCall") ? j.returnCall : false);
			} else return null;
		}
		public function get type():String { return _type; }
		public function get username():String { return _username; }
		public function get isMe():Boolean { return _isMe; }
		public function get dataInt():int { return _dataInt; }
		public function get dataText():String { return _dataText; }
		public function get returnCall():Boolean { return _returnCall; }
		
	}
}