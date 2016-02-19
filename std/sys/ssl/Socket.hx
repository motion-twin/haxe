package sys.ssl;

extern class Socket implements sys.net.ISocket {

	static var DEFAULT_VERIFY_CERT : Null<Bool>;

	static var DEFAULT_CA : Null<sys.ssl.Certificate>;
	
	var input(default,null) : haxe.io.Input;

	var output(default,null) : haxe.io.Output;

	var custom : Dynamic;

	var verifyCert : Null<Bool>;

	function new();

	function connect(host : sys.net.Host, port : Int) : Void;

	function handshake() : Void;
	
	function setCA( cert : sys.ssl.Certificate ) : Void;

	function setHostname( name : String ) : Void;

	function setCertificate( cert : Certificate, key : Key ) : Void;

	function read() : String;

	function write( content : String ) : Void;

	function close() : Void;

	function addSNICertificate( cbServernameMatch : String->Bool, cert : Certificate, key : Key ) : Void;

	function bind( host : sys.net.Host, port : Int ) : Void;

	function listen( connections : Int ) : Void;

	function accept() : Socket;

	function peer() : { host : sys.net.Host, port : Int };

	function peerCertificate() : sys.ssl.Certificate;

	function shutdown( read : Bool, write : Bool ) : Void;

	function host() : { host : sys.net.Host, port : Int };

	function setTimeout( timeout : Float ) : Void;

	function waitForRead() : Void;

	function setBlocking( b : Bool ) : Void;

	function setFastSend( b : Bool ) : Void;
	
}
