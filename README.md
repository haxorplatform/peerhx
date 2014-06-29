![](http://i.imgur.com/XyE7VRo.png)


## Overview

This project is a port of the peerjs library [https://github.com/peers/peerjs].  

## Install

* Run the command `haxelib install peerhx`
* Make sure the `<script>` tag with the `peer.js` path is available on your page.
  * `<script src="http://cdn.peerjs.com/0.3/peer.js"></script>`
* Refer the page [http://peerjs.com/] for complete usage and troubleshoot.

## Usage

Using this lib is pretty much as the same as the javascript version.  

````
//Creation Options.
var opt : PeerOption = { };
opt.port = 80;             //Defaults to 80.
opt.key  = "your_api_key"; //Refer to [http://peerjs.com/peerserver]
		
// You can pick your own id or omit the id if you want to get a random one from the server.
var peer : Peer = new Peer("my_id", opt);
````

### Data Connection
````
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
````

### Media Connection
````
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

````
