package pv.api
{
	public class PVPlayerScore
	{
		private var _username:String = "Player";
		private var _score:int = 0;
		private var _isCurrentUser:Boolean = false;
		public function PVPlayerScore(u:String,s:int,isUser:Boolean=false) { this.username = u; this.score = s; this.isCurrentUser = isUser; }

		public function get username():String
		{
			return _username;
		}

		public function set username(value:String):void
		{
			_username = value;
		}

		public function get score():int
		{
			return _score;
		}

		public function set score(value:int):void
		{
			_score = value;
		}

		public function get isCurrentUser():Boolean
		{
			return _isCurrentUser;
		}

		public function set isCurrentUser(value:Boolean):void
		{
			_isCurrentUser = value;
		}
	}
}