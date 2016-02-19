package sys.ssl;

@:coreApi
class Certificate {
	
	var __x : Dynamic;

	@:allow(sys.ssl.Socket)
	function new( x : Dynamic ){
		__x = x;
	}

	public static function loadFile( file : String ) : Certificate {
		return new Certificate( cert_load_file( file ) );
	}
	
	public static function loadPath( path : String ) : Certificate {
		return new Certificate( cert_load_path( path ) );
	}

	public var commonName(get,null) : Null<String>;
	public var altNames(get, null) : Array<String>;
	public var notBefore(get,null) : Date;
	public var notAfter(get,null) : Date;

	function get_commonName() : Null<String> {
		return subject("CN");
	}

	function get_altNames() : Array<String> {
		var l : Dynamic = cert_get_altnames(__x);
		var a = new Array<String>();
		while( l != null ){
			a.push(l[0]);
			l = l[1];
		}
		return a;
	}
	
	public function subject( field : String ) : Null<String> {
		return cert_get_subject(__x, field);
	}
	
	public function issuer( field : String ) : Null<String> {
		return cert_get_issuer(__x, field);
	}

	function get_notBefore() : Date {
		var a = cert_get_notbefore( __x );
		return new Date( a[0], a[1] - 1, a[2], a[3], a[4], a[5] );
	}

	function get_notAfter() : Date {
		var a = cert_get_notafter( __x );
		return new Date( a[0], a[1] - 1, a[2], a[3], a[4], a[5] );
	}
	
	public function next() : Null<Certificate> {
		var n = cert_get_next(__x);
		return n == null ? null : new Certificate( n );
	}

	private static var cert_load_file = cpp.Lib.load("ssl","cert_load_file",1);
	private static var cert_load_path = cpp.Lib.load("ssl","cert_load_path",1);
	private static var cert_get_subject = cpp.Lib.load("ssl", "cert_get_subject", 2);
	private static var cert_get_issuer = cpp.Lib.load("ssl","cert_get_issuer",2);
	private static var cert_get_altnames = cpp.Lib.load("ssl","cert_get_altnames",1);
	private static var cert_get_notbefore = cpp.Lib.load("ssl","cert_get_notbefore",1);
	private static var cert_get_notafter = cpp.Lib.load("ssl","cert_get_notafter",1);
	private static var cert_get_next = cpp.Lib.load("ssl","cert_get_next",1);

}
