package;
import haxe.Timer;
import js.Browser;
import js.Error;
import js.html.rtc.LocalMediaStream;
import js.html.rtc.MediaStream;
import peerjs.DataConnection;
import peerjs.MediaConnection;
import peerjs.Peer;
import peerjs.Util.PeerUtil;



/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class Main
{
	
	static function main():Void 
	{ 	
		
		//Creation Options.
		var opt : PeerOption = { };
		opt.port = 80;
		opt.key  = "your_api_key"; //Refer to [http://peerjs.com/peerserver]
		
		// You can pick your own id or omit the id if you want to get a random one from the server.
		var peer : Peer = new Peer("my-id", opt);
	
		//Data Connection
		
		//Connect
		var dc : DataConnection = peer.connect("target_id");
		dc.on(DataConnectionEventType.Open, function():Void
		{
			dc.send("Hi!");
		});
		
		//Receive
		peer.on(PeerEventType.Connection, function(p_connection:DataConnection):Void
		{
			p_connection.on(DataConnectionEventType.Data, function(p_data:Dynamic):Void
			{
				//Prints Hi!
				trace(p_data);
			});
		});
		
		
		//Media Connection
		
		//Call
		Browser.navigator.getUserMedia( {video: true,audio: true },
		function(stream : LocalMediaStream) 
		{
			var call : MediaConnection = peer.call("target_id", stream);
			call.on(MediaConnectionEventType.Stream, 
			function(remoteStream : MediaStream) 
			{
				//Show stream in some <video> element.
			});		  
		},
		function(err:Error) 
		{
			trace("Failed to get local stream" ,err);
		});

		//Answer		
		peer.on(PeerEventType.Call, 
		function(call : MediaConnection) 
		{			
			Browser.navigator.getUserMedia( { video: true, audio: true }, 
			function(stream : MediaStream) 
			{
				call.answer(stream); // Answer the call with an A/V stream.
				call.on(MediaConnectionEventType.Stream,
				function(remoteStream : MediaStream) 
				{
				// Show stream in some <video> element.
				});
			}, 
		  function(err:Error) 
		  {
			trace("Failed to get local stream" ,err);
		  });
		});
		
	}
	
	
	
	
	
	
	
	
}