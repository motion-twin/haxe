package sys.ssl;
import cpp.NativeSsl;

@:enum
abstract DigestAlgorithm(String) to String {
	var MD5 = "MD5";
	var SHA1 = "SHA1";
	var SHA224 = "SHA224";
	var SHA256 = "SHA256";
	var SHA384 = "SHA384";
	var SHA512 = "SHA512";
	var RIPEMD160 = "RIPEMD160";
}

@:coreApi
class Digest {

	public static function make( data : haxe.io.Bytes, alg : DigestAlgorithm ) : haxe.io.Bytes {
		return haxe.io.Bytes.ofData( NativeSsl.dgst_make( data.getData(), alg ) );
	}
	
	public static function sign( data : haxe.io.Bytes, privKey : Key, alg : DigestAlgorithm ) : haxe.io.Bytes {
		return haxe.io.Bytes.ofData( NativeSsl.dgst_sign( data.getData(), @:privateAccess privKey.__k, alg ) );
	}
	
	public static function verify( data : haxe.io.Bytes, signature : haxe.io.Bytes, pubKey : Key, alg : DigestAlgorithm ) : Bool{
		return NativeSsl.dgst_verify( data.getData(), signature.getData(), @:privateAccess pubKey.__k, alg );
	}

}
