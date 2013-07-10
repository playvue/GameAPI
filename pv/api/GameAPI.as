package pv.api
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	
	import pv.api.data.GameData;
	import pv.api.data.PlayerData;
	import pv.api.events.GameDataEvent;
	import pv.api.events.PlayerDataEvent;
	import pv.api.requests.GameRequest;
	import pv.api.requests.PlayerRequest;

	public class GameAPI extends flash.display.Sprite
	{
		private var _gameid:String = "";
		private var _isAdded:Boolean = false;
		private var _enableLog:Boolean = false;
		
		public var onGameDataEvent:Function; // (e:GameDataEvent)
		public var onPlayerDataEvent:Function; // (upd:GVPlayerData)
		
		public function GameAPI(gameid:String,enableLog:Boolean = false)
		{
			_gameid = gameid;
			_enableLog = enableLog;
			this.addEventListener(Event.ADDED,handleAdded);
		}
		public function init():void {
			log("[GameAPI] init()");
			if (!_isAdded){ log("[GameAPI] GameAPI must be added to the display list before calling init();"); return; }
			if (this.stage){
				log("[GameAPI] hooking up stage events");
				this.stage.addEventListener("gamedata",handleGameDataEvent);
				this.stage.addEventListener("playerdata",handlePlayerDataEvent);
			}
		}
		//## recordPlayerData(type:String,data:Object):void {
		//## Adds data to new PlayerData object with username blank and isMe = true. 
		//## JSON stringifies and submits it as PlayerRequest
		public function recordPlayerData(type:String,dataInt:int=-1,dataText:String=""):void {
			var pd:PlayerData = new PlayerData(type,"",true,dataInt,dataText);
			var req:PlayerRequest = new PlayerRequest(_gameid,type,"",pd);
			dispatchRequest("PLAYERREQ",pd);
		}
		//## recordPlayerAction(type:String,username:String, data:Object):void 
		//## Adds data to new PlayerData object with username set and isMe = false. 
		//## JSON stringifies and submits it as PlayerRequest
		public function recordPlayerAction(type:String,username:String, dataInt:int=-1, dataText:String=""):void {
			var pd:PlayerData = new PlayerData(type,"",true,dataInt,dataText);
			var req:PlayerRequest = new PlayerRequest(_gameid,type,"",pd);
			dispatchRequest("PLAYERREQ",pd);
		}
		
		//## recordGameData(type:String,data:Object):void
		//## Adds data to new GameData object with save property set. 
		//## JSON stringifies, submits as GameRequest and data is stored as persistent.
		public function recordGameData(type:String,dataInt:int=-1, dataText:String=""):void {
			var gd:GameData = new GameData(type,dataInt,dataText,true);
			var req:GameRequest = new GameRequest(_gameid,type,gd);
			dispatchRequest("GAMEREQ",req);
		}
			
		//## Adds data to new GameData object. 
		//## JSON stringifies, submits as GameRequest and data is returned as 
		//## GameDataEvent (to all players).
		public function	recordGameAction(type:String,dataInt:int,dataText:String):void {
			var gd:GameData = new GameData(type,dataInt,dataText);
			var req:GameRequest = new GameRequest(_gameid,type,gd);
			dispatchRequest("GAMEREQ",req);
		}
		
		//Records score as PlayerData via PlayerRequest.  
		//Optionally, returnsHighScores as PlayerDataEvent upon completion.
		public function recordPlayerScore(score:int, returnHighScores:Boolean):void {
			log("[GameAPI] recordPlayerScore()");
			var pd:PlayerData = new PlayerData("HIGHSCORE","",true,score,"",returnHighScores);
			var req:PlayerRequest = new PlayerRequest(_gameid,"HIGHSCORE","",pd);
			dispatchRequest("PLAYERREQ",req);
		}
		public function requestHighScores():void {
			log("[GameAPI] requestHighScores()");
			var req:GameRequest = new GameRequest(_gameid,"HIGHSCORES",null);
			dispatchRequest("GAMEREQ",req);
		}
		
		private function handleGameDataEvent(e:DataEvent):void {
			log("[GameAPI] GameDataEvent()");
			var gde:GameDataEvent = GameDataEvent.fromDataEvent(e);
			if (onGameDataEvent) onGameDataEvent(gde);
			else log("[GameAPI] onGameDataEvent not defined");
		}
		private function handlePlayerDataEvent(e:DataEvent):void {
			log("[GameAPI] PlayerDataEvent()");
			var upd:PlayerDataEvent = PlayerDataEvent.fromDataEvent(e);
			if (onPlayerDataEvent) onPlayerDataEvent(upd);
			else log("[GVAPI] onPlayerDataUpdate not defined");
		}
		private function dispatchRequest(type:String,req:*):void {
			log("[GameAPI] dispatchRequest()");
			var tmp:String = req.toString();
			root.dispatchEvent(new DataEvent(type,true,false,JSON.stringify(req)));
		}
		private function handleAdded(e:Event):void { 
			log("[GameAPI] added");
			_isAdded = true; 
		}
		private function log(txt:*):void { if (_enableLog) trace(txt.toString()); }
	}
}