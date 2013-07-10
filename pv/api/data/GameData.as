package pv.api.data
{
	public class GameData
	{
		private var _type:String;
		private var _dataInt:int;
		private var _dataText:String;
		private var _save:Boolean;
		private var _returnCall:Boolean;
		public function GameData(type:String,dataInt:int, dataText:String, saveData:Boolean = false, returnCall:Boolean = false){ 
			_type = type; 
			_dataInt = dataInt; _dataText = dataText; 
			_save = saveData; _returnCall = returnCall; }
		public static function fromJSONObject(j:Object):GameData {
			if (j.hasOwnProperty("type") && (j.hasOwnProperty("dataInt") || j.hasOwnProperty("dataText"))) {
				return new GameData(j.type,j.hasOwnProperty("dataInt") ? j.dataInt : -1, j.hasOwnProperty("dataText") ? j.dataText : "",
					j.hasOwnProperty("saveData") ? j.saveData : false, j.hasOwnProperty("returnCall") ? j.returnCall : false);
			} else return null;
		}
		public function get type():String { return _type; }
		public function get dataInt():int { return _dataInt; }
		public function get dataText():String { return _dataText; }
		public function get saveData():Boolean { return _save; }
		public function get returnCall():Boolean { return _returnCall; }
	}
}