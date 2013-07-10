Playvue.com GameAPI
=======
<p>
An API to access social features on the Playvue.com social casual game platform.
</p>
<p>
To initialize the API in your game, create a GameAPI() object and add it to the display list before calling GameAPI.init()
</p>
<pre>
import pv.api.GameAPI;

public class PVExample {

  private var api:GamePI;
  
  public function PVExample(){
    this.addEventListener(Event.ADDED_TO_STAGE, init);
  }
  private function init(e:Event):void {
    removeEventListener(Event.ADDED_TO_STAGE, init);
    
    //## GameAPI(gameid:String,enableLog:Boolean=false) ##
    api = new GameAPI("yourGameIDasString", true); 
    
</pre>
<p>
    Game ID's are provided by Playvue.com.  To obtain your gameid, submit your game via http://dev.playvue.com. 
</p>
<p>
    If enableLog is true, events will be logged via trace.
</p>    
<p>
    The GameAPI listens for two kinds of events from the game platform, GameDataEvent and PlayerDataEvent.  In order to handle these events, assign the corresponding function variables like so:
</p>
<pre>
    api.onGameDataEvent = function(gde:GameDataEvent)  { 
      //## handle GameDataEvent code here ##
      var data:Object = gde.data;
    }
    api.onPlayerDataEvent = function(pde:PlayerDataEvent) {
      //## handle PlayerDataEvent code here ##
      var data:Object = pde.data;
    }
</pre>
<p>
    PlayerDataEvents are player-specific events that communicate current player and player-to-player actions and updates.
</p>    
<p>
    GameDataEvents are more general, game-related events that communicate changes to the game, game state or game scores.
</p>
<p>
    After setting up the GameAPI object, add it to the local display list, and call GameAPI.init() to establish the hook with the parent platform.
</p>
<pre>
    this.addChild(api);
    api.init();
  }
}
</pre>
<p>
NOTE: The GameAPI must be added to the display list prior to calling GameAPI.init().
</p>
<p>
After initialized, api triggers can be called as needed.
</p>
<pre>
    //## recordPlayerScore(score:int, returnHighScores:Boolean) ##
    api.recordPlayerScore(10000,true); 
    
    api.requestHighScores();
    
</pre>
<p>
Some features (like recording a high score) may require users to be logged in. If they are not, a login window will appear allowing them to do so.
</p>
<p>
Also, some triggers include return options.  If enabled, a return value will be sent via the corresponding DataEvent.  The exception to this is recordPlayerScore which will return both a PlayerDataEvent containing the players recorded score as well as a GameDataEvent with the overall top high scores.
</p>
<p>
There are additional triggers for game and player actions with or without recording and return values which can be used as needed.  But, additional, feature-specific triggers will be added as this API is expanded.
</p>
