package peerjs;
import js.html.EventTarget;
import js.html.rtc.MediaStream;

/**
 * 
 */
class MediaConnectionEventType
{
	/**
	 * Emitted when a remote peer adds a stream.
	 * 
	 * mediaConnection.on('stream', function(stream) { ... });
	 */
	static public var Stream : String = "stream";
	
	/**
	 * Emitted when either you or the remote peer closes the media connection.
	 * Firefox does not yet support this event.
	 * 
	 * mediaConnection.on('close', function() { ... });
	 */
	static public var Close : String = "close";
	
	/**
	 * mediaConnection.on('error', function(err) { ... } );
	 */
	static public var Error : String = "error";	
	
}

/**
 * Wraps WebRTC's media streams. To get one, use peer.call or listen for the call event.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class MediaConnection extends PeerJSConnection
{

	/**
	 * When recieving a call event on a peer, you can call .answer on the media connection provided by the callback to accept the call and optionally send your own media stream.
	 * @param	p_media
	 */
	@:overload(function():Void { } )	
	function answer(p_media : MediaStream):Void;
	
}